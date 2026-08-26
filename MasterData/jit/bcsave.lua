-- chunkname: @jit/bcsave.lua

local jit = require("jit")

assert(jit.version_num == 20100, "LuaJIT core/library version mismatch")

local bit = require("bit")
local LJBC_PREFIX = "luaJIT_BC_"

local function usage()
	io.stderr:write("Save LuaJIT bytecode: luajit -b[options] input output\n  -l            Only list bytecode.\n  -L            Only list bytecode with lineinfo.\n  -s            Strip debug info (default).\n  -g            Keep debug info.\n  -n name       Set module name (default: auto-detect from input name).\n  -t type       Set output file type (default: auto-detect from output name).\n  -a arch       Override architecture for object files (default: native).\n  -o os         Override OS for object files (default: native).\n  -e chunk      Use chunk string as input.\n  -f file ext   batch save bytecode. file: content the list of file path, ext: the output file extension.\n  --            Stop handling options.\n  -             Use stdin as input and/or stdout as output.\n\nFile types: c h obj o raw (default)\n")
	os.exit(1)
end

local function check(ok, ...)
	if ok then
		return ok, ...
	end

	io.stderr:write("luajit: ", ...)
	io.stderr:write("\n")
	os.exit(1)
end

local function readfile(input)
	if type(input) == "function" then
		return input
	end

	if input == "-" then
		input = nil
	end

	return check(loadfile(input))
end

local function savefile(name, mode)
	if name == "-" then
		return io.stdout
	end

	return check(io.open(name, mode))
end

local map_type = {
	raw = "raw",
	c = "c",
	h = "h",
	obj = "obj",
	o = "obj"
}
local map_arch = {
	x86 = true,
	arm = true,
	mips = true,
	arm64be = true,
	x64 = true,
	arm64 = true,
	ppc = true,
	mipsel = true
}
local map_os = {
	netbsd = true,
	dragonfly = true,
	openbsd = true,
	osx = true,
	freebsd = true,
	solaris = true,
	windows = true,
	linux = true
}

local function checkarg(str, map, err)
	str = string.lower(str)

	local s = check(map[str], "unknown ", err)

	return s == true and str or s
end

local function detecttype(str)
	local ext = string.match(string.lower(str), "%.(%a+)$")

	return map_type[ext] or "raw"
end

local function checkmodname(str)
	check(string.match(str, "^[%w_.%-]+$"), "bad module name")

	return string.gsub(str, "[%.%-]", "_")
end

local function detectmodname(str)
	if type(str) == "string" then
		local tail = string.match(str, "[^/\\]+$")

		if tail then
			str = tail
		end

		local head = string.match(str, "^(.*)%.[^.]*$")

		if head then
			str = head
		end

		str = string.match(str, "^[%w_.%-]+")
	else
		str = nil
	end

	check(str, "cannot derive module name, use -n name")

	return string.gsub(str, "[%.%-]", "_")
end

local function bcsave_tail(fp, output, s)
	local ok, err = fp:write(s)

	if ok and output ~= "-" then
		ok, err = fp:close()
	end

	check(ok, "cannot write ", output, ": ", err)
end

local function bcsave_raw(output, s)
	local fp = savefile(output, "wb")

	bcsave_tail(fp, output, s)
end

local function bcsave_c(ctx, output, s)
	local fp = savefile(output, "w")

	if ctx.type == "c" then
		fp:write(string.format("#ifdef _cplusplus\nextern \"C\"\n#endif\n#ifdef _WIN32\n__declspec(dllexport)\n#endif\nconst unsigned char %s%s[] = {\n", LJBC_PREFIX, ctx.modname))
	else
		fp:write(string.format("#define %s%s_SIZE %d\nstatic const unsigned char %s%s[] = {\n", LJBC_PREFIX, ctx.modname, #s, LJBC_PREFIX, ctx.modname))
	end

	local t, n, m = {}, 0, 0

	for i = 1, #s do
		local b = tostring(string.byte(s, i))

		m = m + #b + 1

		if m > 78 then
			fp:write(table.concat(t, ",", 1, n), ",\n")

			m = #b + 1
			n = 0
		end

		n = n + 1
		t[n] = b
	end

	bcsave_tail(fp, output, table.concat(t, ",", 1, n) .. "\n};\n")
end

local function bcsave_elfobj(ctx, output, s, ffi)
	ffi.cdef("typedef struct {\n  uint8_t emagic[4], eclass, eendian, eversion, eosabi, eabiversion, epad[7];\n  uint16_t type, machine;\n  uint32_t version;\n  uint32_t entry, phofs, shofs;\n  uint32_t flags;\n  uint16_t ehsize, phentsize, phnum, shentsize, shnum, shstridx;\n} ELF32header;\ntypedef struct {\n  uint8_t emagic[4], eclass, eendian, eversion, eosabi, eabiversion, epad[7];\n  uint16_t type, machine;\n  uint32_t version;\n  uint64_t entry, phofs, shofs;\n  uint32_t flags;\n  uint16_t ehsize, phentsize, phnum, shentsize, shnum, shstridx;\n} ELF64header;\ntypedef struct {\n  uint32_t name, type, flags, addr, ofs, size, link, info, align, entsize;\n} ELF32sectheader;\ntypedef struct {\n  uint32_t name, type;\n  uint64_t flags, addr, ofs, size;\n  uint32_t link, info;\n  uint64_t align, entsize;\n} ELF64sectheader;\ntypedef struct {\n  uint32_t name, value, size;\n  uint8_t info, other;\n  uint16_t sectidx;\n} ELF32symbol;\ntypedef struct {\n  uint32_t name;\n  uint8_t info, other;\n  uint16_t sectidx;\n  uint64_t value, size;\n} ELF64symbol;\ntypedef struct {\n  ELF32header hdr;\n  ELF32sectheader sect[6];\n  ELF32symbol sym[2];\n  uint8_t space[4096];\n} ELF32obj;\ntypedef struct {\n  ELF64header hdr;\n  ELF64sectheader sect[6];\n  ELF64symbol sym[2];\n  uint8_t space[4096];\n} ELF64obj;\n")

	local symname = LJBC_PREFIX .. ctx.modname
	local is64, isbe = false, false

	if ctx.arch == "x64" or ctx.arch == "arm64" or ctx.arch == "arm64be" then
		is64 = true
	elseif ctx.arch == "ppc" or ctx.arch == "mips" then
		isbe = true
	end

	local function f32(x)
		return x
	end

	local f16, fofs = f32, f32

	if ffi.abi("be") ~= isbe then
		f32 = bit.bswap

		function f16(x)
			return bit.rshift(bit.bswap(x), 16)
		end

		if is64 then
			local two32 = ffi.cast("int64_t", 4294967296)

			function fofs(x)
				return bit.bswap(x) * two32
			end
		else
			fofs = f32
		end
	end

	local o = ffi.new(is64 and "ELF64obj" or "ELF32obj")
	local hdr = o.hdr

	if ctx.os == "bsd" or ctx.os == "other" then
		local bf = assert(io.open("/bin/ls", "rb"))
		local bs = bf:read(9)

		bf:close()
		ffi.copy(o, bs, 9)
		check(hdr.emagic[0] == 127, "no support for writing native object files")
	else
		hdr.emagic = "\x7FELF"
		hdr.eosabi = ({
			freebsd = 9,
			solaris = 6,
			openbsd = 12,
			netbsd = 2
		})[ctx.os] or 0
	end

	hdr.eclass = is64 and 2 or 1
	hdr.eendian = isbe and 2 or 1
	hdr.eversion = 1
	hdr.type = f16(1)
	hdr.machine = f16(({
		x86 = 3,
		arm = 40,
		mips = 8,
		arm64be = 183,
		x64 = 62,
		arm64 = 183,
		ppc = 20,
		mipsel = 8
	})[ctx.arch])

	if ctx.arch == "mips" or ctx.arch == "mipsel" then
		hdr.flags = f32(1342181382)
	end

	hdr.version = f32(1)
	hdr.shofs = fofs(ffi.offsetof(o, "sect"))
	hdr.ehsize = f16(ffi.sizeof(hdr))
	hdr.shentsize = f16(ffi.sizeof(o.sect[0]))
	hdr.shnum = f16(6)
	hdr.shstridx = f16(2)

	local sofs, ofs = ffi.offsetof(o, "space"), 1

	for i, name in ipairs({
		".symtab",
		".shstrtab",
		".strtab",
		".rodata",
		".note.GNU-stack"
	}) do
		local sect = o.sect[i]

		sect.align = fofs(1)
		sect.name = f32(ofs)

		ffi.copy(o.space + ofs, name)

		ofs = ofs + #name + 1
	end

	o.sect[1].type = f32(2)
	o.sect[1].link = f32(3)
	o.sect[1].info = f32(1)
	o.sect[1].align = fofs(8)
	o.sect[1].ofs = fofs(ffi.offsetof(o, "sym"))
	o.sect[1].entsize = fofs(ffi.sizeof(o.sym[0]))
	o.sect[1].size = fofs(ffi.sizeof(o.sym))
	o.sym[1].name = f32(1)
	o.sym[1].sectidx = f16(4)
	o.sym[1].size = fofs(#s)
	o.sym[1].info = 17
	o.sect[2].type = f32(3)
	o.sect[2].ofs = fofs(sofs)
	o.sect[2].size = fofs(ofs)
	o.sect[3].type = f32(3)
	o.sect[3].ofs = fofs(sofs + ofs)
	o.sect[3].size = fofs(#symname + 2)

	ffi.copy(o.space + ofs + 1, symname)

	ofs = ofs + #symname + 2
	o.sect[4].type = f32(1)
	o.sect[4].flags = fofs(2)
	o.sect[4].ofs = fofs(sofs + ofs)
	o.sect[4].size = fofs(#s)
	o.sect[5].type = f32(1)
	o.sect[5].ofs = fofs(sofs + ofs + #s)

	local fp = savefile(output, "wb")

	fp:write(ffi.string(o, ffi.sizeof(o) - 4096 + ofs))
	bcsave_tail(fp, output, s)
end

local function bcsave_peobj(ctx, output, s, ffi)
	ffi.cdef("typedef struct {\n  uint16_t arch, nsects;\n  uint32_t time, symtabofs, nsyms;\n  uint16_t opthdrsz, flags;\n} PEheader;\ntypedef struct {\n  char name[8];\n  uint32_t vsize, vaddr, size, ofs, relocofs, lineofs;\n  uint16_t nreloc, nline;\n  uint32_t flags;\n} PEsection;\ntypedef struct __attribute((packed)) {\n  union {\n    char name[8];\n    uint32_t nameref[2];\n  };\n  uint32_t value;\n  int16_t sect;\n  uint16_t type;\n  uint8_t scl, naux;\n} PEsym;\ntypedef struct __attribute((packed)) {\n  uint32_t size;\n  uint16_t nreloc, nline;\n  uint32_t cksum;\n  uint16_t assoc;\n  uint8_t comdatsel, unused[3];\n} PEsymaux;\ntypedef struct {\n  PEheader hdr;\n  PEsection sect[2];\n  // Must be an even number of symbol structs.\n  PEsym sym0;\n  PEsymaux sym0aux;\n  PEsym sym1;\n  PEsymaux sym1aux;\n  PEsym sym2;\n  PEsym sym3;\n  uint32_t strtabsize;\n  uint8_t space[4096];\n} PEobj;\n")

	local symname = LJBC_PREFIX .. ctx.modname
	local is64 = false

	if ctx.arch == "x86" then
		symname = "_" .. symname
	elseif ctx.arch == "x64" then
		is64 = true
	end

	local symexport = "   /EXPORT:" .. symname .. ",DATA "

	local function f32(x)
		return x
	end

	local f16 = f32

	if ffi.abi("be") then
		f32 = bit.bswap

		function f16(x)
			return bit.rshift(bit.bswap(x), 16)
		end
	end

	local o = ffi.new("PEobj")
	local hdr = o.hdr

	hdr.arch = f16(({
		arm = 448,
		ppc = 498,
		mips = 870,
		mipsel = 870,
		x64 = 34404,
		x86 = 332
	})[ctx.arch])
	hdr.nsects = f16(2)
	hdr.symtabofs = f32(ffi.offsetof(o, "sym0"))
	hdr.nsyms = f32(6)
	o.sect[0].name = ".drectve"
	o.sect[0].size = f32(#symexport)
	o.sect[0].flags = f32(1051136)
	o.sym0.sect = f16(1)
	o.sym0.scl = 3
	o.sym0.name = ".drectve"
	o.sym0.naux = 1
	o.sym0aux.size = f32(#symexport)
	o.sect[1].name = ".rdata"
	o.sect[1].size = f32(#s)
	o.sect[1].flags = f32(1076887616)
	o.sym1.sect = f16(2)
	o.sym1.scl = 3
	o.sym1.name = ".rdata"
	o.sym1.naux = 1
	o.sym1aux.size = f32(#s)
	o.sym2.sect = f16(2)
	o.sym2.scl = 2
	o.sym2.nameref[1] = f32(4)
	o.sym3.sect = f16(-1)
	o.sym3.scl = 2
	o.sym3.value = f32(1)
	o.sym3.name = "@feat.00"

	ffi.copy(o.space, symname)

	local ofs = #symname + 1

	o.strtabsize = f32(ofs + 4)
	o.sect[0].ofs = f32(ffi.offsetof(o, "space") + ofs)

	ffi.copy(o.space + ofs, symexport)

	ofs = ofs + #symexport
	o.sect[1].ofs = f32(ffi.offsetof(o, "space") + ofs)

	local fp = savefile(output, "wb")

	fp:write(ffi.string(o, ffi.sizeof(o) - 4096 + ofs))
	bcsave_tail(fp, output, s)
end

local function bcsave_machobj(ctx, output, s, ffi)
	ffi.cdef("typedef struct\n{\n  uint32_t magic, cputype, cpusubtype, filetype, ncmds, sizeofcmds, flags;\n} mach_header;\ntypedef struct\n{\n  mach_header; uint32_t reserved;\n} mach_header_64;\ntypedef struct {\n  uint32_t cmd, cmdsize;\n  char segname[16];\n  uint32_t vmaddr, vmsize, fileoff, filesize;\n  uint32_t maxprot, initprot, nsects, flags;\n} mach_segment_command;\ntypedef struct {\n  uint32_t cmd, cmdsize;\n  char segname[16];\n  uint64_t vmaddr, vmsize, fileoff, filesize;\n  uint32_t maxprot, initprot, nsects, flags;\n} mach_segment_command_64;\ntypedef struct {\n  char sectname[16], segname[16];\n  uint32_t addr, size;\n  uint32_t offset, align, reloff, nreloc, flags;\n  uint32_t reserved1, reserved2;\n} mach_section;\ntypedef struct {\n  char sectname[16], segname[16];\n  uint64_t addr, size;\n  uint32_t offset, align, reloff, nreloc, flags;\n  uint32_t reserved1, reserved2, reserved3;\n} mach_section_64;\ntypedef struct {\n  uint32_t cmd, cmdsize, symoff, nsyms, stroff, strsize;\n} mach_symtab_command;\ntypedef struct {\n  int32_t strx;\n  uint8_t type, sect;\n  int16_t desc;\n  uint32_t value;\n} mach_nlist;\ntypedef struct {\n  uint32_t strx;\n  uint8_t type, sect;\n  uint16_t desc;\n  uint64_t value;\n} mach_nlist_64;\ntypedef struct\n{\n  uint32_t magic, nfat_arch;\n} mach_fat_header;\ntypedef struct\n{\n  uint32_t cputype, cpusubtype, offset, size, align;\n} mach_fat_arch;\ntypedef struct {\n  struct {\n    mach_header hdr;\n    mach_segment_command seg;\n    mach_section sec;\n    mach_symtab_command sym;\n  } arch[1];\n  mach_nlist sym_entry;\n  uint8_t space[4096];\n} mach_obj;\ntypedef struct {\n  struct {\n    mach_header_64 hdr;\n    mach_segment_command_64 seg;\n    mach_section_64 sec;\n    mach_symtab_command sym;\n  } arch[1];\n  mach_nlist_64 sym_entry;\n  uint8_t space[4096];\n} mach_obj_64;\ntypedef struct {\n  mach_fat_header fat;\n  mach_fat_arch fat_arch[2];\n  struct {\n    mach_header hdr;\n    mach_segment_command seg;\n    mach_section sec;\n    mach_symtab_command sym;\n  } arch[2];\n  mach_nlist sym_entry;\n  uint8_t space[4096];\n} mach_fat_obj;\n")

	local isfat, is64, align, mobj = false, false, 4, "mach_obj"

	if ctx.arch == "x64" then
		mobj = "mach_obj_64"
		align = 8
		is64 = true
	elseif ctx.arch == "arm" then
		mobj = "mach_fat_obj"
		isfat = true
	elseif ctx.arch == "arm64" then
		mobj = "mach_fat_obj"
		isfat = true
		align = 8
		is64 = true
	else
		check(ctx.arch == "x86", "unsupported architecture for OSX")
	end
end

local function bcsave_obj(ctx, output, s)
	local ok, ffi = pcall(require, "ffi")

	check(ok, "FFI library required to write this file type")

	if ctx.os == "windows" then
		return bcsave_peobj(ctx, output, s, ffi)
	elseif ctx.os == "osx" then
		return bcsave_machobj(ctx, output, s, ffi)
	else
		return bcsave_elfobj(ctx, output, s, ffi)
	end
end

local function bclist(input, output, lineinfo)
	local f = readfile(input)

	require("jit.bc"):dump(savefile(output, "w"), true, lineinfo)
end

local function bcsave(ctx, input, output)
	local f = readfile(input)
	local s = string.dump(f, ctx.strip)
	local t = ctx.type

	if not t then
		t = detecttype(output)
		ctx.type = t
	end

	if t == "raw" then
		bcsave_raw(output, s)
	else
		ctx.modname = ctx.modname or detectmodname(input)

		if t == "obj" then
			bcsave_obj(ctx, output, s)
		else
			bcsave_c(ctx, output, s)
		end
	end
end

local function bcsavebatch(ctx, file_list, ext)
	for line in io.lines(file_list) do
		bcsave(ctx, line, line .. ext)
	end
end

local function docmd(...)
	local arg = {
		...
	}
	local n = 1
	local list = false
	local lineinfo = false
	local batchmode = false
	local ctx = {
		modname = false,
		strip = true,
		type = false,
		arch = jit.arch,
		os = string.lower(jit.os)
	}

	while n <= #arg do
		local a = arg[n]

		if type(a) == "string" and string.sub(a, 1, 1) == "-" and a ~= "-" then
			table.remove(arg, n)

			if a == "--" then
				break
			end

			for m = 2, #a do
				local opt = string.sub(a, m, m)

				if opt == "l" then
					list = true
				elseif opt == "L" then
					list = true
					lineinfo = true
				elseif opt == "s" then
					ctx.strip = true
				elseif opt == "g" then
					ctx.strip = false
				else
					if arg[n] == nil or m ~= #a then
						usage()
					end

					if opt == "e" then
						if n ~= 1 then
							usage()
						end

						arg[1] = check(loadstring(arg[1]))
					elseif opt == "n" then
						ctx.modname = checkmodname(table.remove(arg, n))
					elseif opt == "t" then
						ctx.type = checkarg(table.remove(arg, n), map_type, "file type")
					elseif opt == "a" then
						ctx.arch = checkarg(table.remove(arg, n), map_arch, "architecture")
					elseif opt == "o" then
						ctx.os = checkarg(table.remove(arg, n), map_os, "OS name")
					elseif opt == "f" then
						batchmode = true
					else
						usage()
					end
				end
			end
		else
			n = n + 1
		end
	end

	if batchmode then
		if #arg ~= 2 then
			usage()
		end

		bcsavebatch(ctx, arg[1], arg[2])
	elseif list then
		if #arg == 0 or #arg > 2 then
			usage()
		end

		bclist(arg[1], arg[2] or "-", lineinfo)
	else
		if #arg ~= 2 then
			usage()
		end

		bcsave(ctx, arg[1], arg[2])
	end
end

return {
	start = docmd
}
