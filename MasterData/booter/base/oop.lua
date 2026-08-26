-- chunkname: @booter/base/oop.lua

module("booter.base.oop", package.seeall)

function class(classname, super)
	local superType = type(super)
	local cls

	if superType ~= "function" and superType ~= "table" then
		superType = nil
		super = nil
	end

	if superType == "function" or super and super.__ctype == 1 then
		cls = {}

		if superType == "table" then
			for k, v in pairs(super) do
				cls[k] = v
			end

			cls.__create = super.__create
			cls.super = super
		else
			cls.__create = super

			function cls.ctor()
				return
			end
		end

		cls.__cname = classname
		cls.__ctype = 1

		function cls.New(...)
			local instance = cls.__create(...)

			for k, v in pairs(cls) do
				instance[k] = v
			end

			instance.class = cls

			instance:ctor(...)

			return instance
		end
	else
		if super then
			cls = {}

			setmetatable(cls, {
				__index = super
			})

			cls.super = super
		else
			cls = {
				ctor = function()
					return
				end
			}
		end

		cls.__cname = classname
		cls.__ctype = 2
		cls.__index = cls

		function cls.New(...)
			local instance = setmetatable({}, cls)

			instance.class = cls

			instance:ctor(...)

			return instance
		end
	end

	return cls
end

function isTypeOf(luaObj, clsDefine)
	if clsDefine == nil then
		error("istypeof clsDefine can not be nil! ")
	end

	if luaObj == nil then
		return false
	end

	local clsName = clsDefine.__cname
	local tmp = luaObj

	while tmp ~= nil do
		if tmp.__cname == clsName then
			return true
		end

		tmp = tmp.super
	end

	return false
end

setGlobal("class", class)
setGlobal("isTypeOf", isTypeOf)
