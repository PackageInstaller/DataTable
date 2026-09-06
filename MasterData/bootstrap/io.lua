-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/core/io.lua

module("bootstrap.core.io", package.seeall)

function io.exists(path)
	local file = io.open(path, "r")

	if file then
		io.close(file)

		return true
	end

	return false
end

function io.readfile(path)
	local file = io.open(path, "r")

	if file then
		local content = file:read("*a")

		io.close(file)

		return content
	end

	return nil
end

function io.writefile(path, content, mode)
	mode = mode or "w+b"

	local file = io.open(path, mode)

	if file then
		if file:write(content) == nil then
			return false
		end

		io.close(file)

		return true
	else
		return false
	end
end

function io.pathinfo(path)
	local pos = string.len(path)
	local extpos = pos + 1

	while pos > 0 do
		local b = string.byte(path, pos)

		if b == 46 then
			extpos = pos
		elseif b == 47 then
			break
		end

		pos = pos - 1
	end

	local dirname = string.sub(path, 1, pos)
	local filename = string.sub(path, pos + 1)

	extpos = extpos - pos

	local basename = string.sub(filename, 1, extpos - 1)
	local extname = string.sub(filename, extpos)

	return {
		dirname = dirname,
		filename = filename,
		basename = basename,
		extname = extname
	}
end

function io.filesize(path)
	local size = false
	local file = io.open(path, "r")

	if file then
		local current = file:seek()

		size = file:seek("end")

		file:seek("set", current)
		io.close(file)
	end

	return size
end
