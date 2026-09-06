-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/core/oop.lua

module("bootstrap.core.oop", package.seeall)

function checknumber(value, base)
	return tonumber(value, base) or 0
end

function checkint(value)
	return math.round(checknumber(value))
end

function checkbool(value)
	return value ~= nil and value ~= false
end

function checktable(value)
	if type(value) ~= "table" then
		value = {}
	end

	return value
end

function isset(hashtable, key)
	local t = type(hashtable)

	return (t == "table" or t == "userdata") and hashtable[key] ~= nil
end

local setmetatableindex_

function setmetatableindex_(t, index)
	if type(t) == "userdata" then
		local peer = tolua.getpeer(t)

		if not peer then
			peer = {}

			tolua.setpeer(t, peer)
		end

		setmetatableindex_(peer, index)
	else
		local mt = getmetatable(t)

		mt = mt or {}

		if not mt.__index then
			mt.__index = index

			setmetatable(t, mt)
		elseif mt.__index ~= index then
			setmetatableindex_(mt, index)
		end
	end
end

setmetatableindex = setmetatableindex_

function clone(object)
	local lookup_table = {}

	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local newObject = {}

		lookup_table[object] = newObject

		for key, value in pairs(object) do
			newObject[_copy(key)] = _copy(value)
		end

		return setmetatable(newObject, getmetatable(object))
	end

	return _copy(object)
end

function nclass(classname, nativesuper)
	local cls = class(classname, function()
		return nativesuper.New()
	end)

	cls.super = nativesuper

	setmetatable(cls, {
		__index = cls.super
	})

	return cls
end

function class(classname, ...)
	local cls = {
		__cname = classname
	}
	local supers = {
		...
	}

	for _, super in ipairs(supers) do
		local superType = type(super)

		assert(superType == "nil" or superType == "table" or superType == "function", string.format("class() - create class \"%s\" with invalid super class type \"%s\"", classname, superType))

		if superType == "function" then
			assert(cls.__create == nil, string.format("class() - create class \"%s\" with more than one creating function", classname))

			cls.__create = super
		elseif superType == "table" then
			if super[".isclass"] then
				assert(cls.__create == nil, string.format("class() - create class \"%s\" with more than one creating function or native class", classname))

				function cls.__create()
					return super:create()
				end
			else
				cls.__supers = cls.__supers or {}
				cls.__supers[#cls.__supers + 1] = super
				cls.super = cls.super or super
			end
		else
			error(string.format("class() - create class \"%s\" with invalid super type", classname), 0)
		end
	end

	cls.__index = cls

	if not cls.__supers or #cls.__supers == 1 then
		if cls.super then
			setmetatable(cls, {
				__index = cls.super
			})
		end
	else
		setmetatable(cls, {
			__index = function(_, key)
				local supers = cls.__supers

				for i = 1, #supers do
					local super = supers[i]

					if super[key] then
						return super[key]
					end
				end
			end
		})
	end

	function cls.New(...)
		local instance = cls.__create and cls.__create(...) or {}

		if type(instance) == "userdata" then
			local peer = tolua.getpeer(instance)

			if not peer then
				peer = {}

				tolua.setpeer(instance, peer)
			end

			for k, v in pairs(cls) do
				instance[k] = v
			end

			instance.class = cls
		else
			setmetatableindex(instance, cls)

			instance.class = cls
		end

		local objWithCtor = findNearestCtorObj(instance)

		if objWithCtor then
			objWithCtor.ctor(instance, ...)
		end

		return instance
	end

	function cls.create(_, ...)
		return cls.New(...)
	end

	return cls
end

function findNearestCtorObj(instance)
	local obj
	local temp = instance

	while temp do
		if temp.ctor then
			obj = temp

			break
		end

		temp = temp.super
	end

	return obj
end

local iskindof_

function iskindof_(cls, name)
	local __index = rawget(cls, "__index")

	if type(__index) == "table" and rawget(__index, "__cname") == name then
		return true
	end

	if rawget(cls, "__cname") == name then
		return true
	end

	local __supers = rawget(cls, "__supers")

	if not __supers then
		return false
	end

	for _, super in ipairs(__supers) do
		if iskindof_(super, name) then
			return true
		end
	end

	return false
end

function iskindof(obj, classname)
	local t = type(obj)

	if t ~= "table" and t ~= "userdata" then
		return false
	end

	local mt

	if t == "userdata" then
		if tolua.typename(obj) == classname then
			return true
		end

		mt = tolua.getpeer(obj)
	else
		mt = getmetatable(obj)
	end

	if mt then
		return iskindof_(mt, classname)
	end

	return false
end

setglobal("checknumber", checknumber)
setglobal("checkint", checkint)
setglobal("checkbool", checkbool)
setglobal("checktable", checktable)
setglobal("isset", isset)
setglobal("clone", clone)
setglobal("nclass", nclass)
setglobal("class", class)
setglobal("iskindof", iskindof)
