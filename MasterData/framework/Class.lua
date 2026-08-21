-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Framework\\Class.lua

local GLDeclare = require("Framework/Global")
local __ClassTypeList = {}
local __InheritRelationship = {}
local print = print
local __classCounter = 0

local function __printSingleClass(cType, depth)
	local prefix = ""

	for i = 1, depth do
		prefix = prefix .. "    "
	end

	__classCounter = __classCounter + 1

	if __InheritRelationship[cType] and #__InheritRelationship[cType] > 0 then
		for temp, tempType in ipairs(__InheritRelationship[cType]) do
			__printSingleClass(tempType, depth + 1)
		end
	end
end

local function __printAllInherits()
	__classCounter = 0

	local noSuperNumber = 0

	for key, value in pairs(__InheritRelationship) do
		if key.superType == nil then
			noSuperNumber = noSuperNumber + 1

			__printSingleClass(key, 0)
		end
	end

	local count = 0

	for key, value in pairs(__ClassTypeList) do
		count = count + 1
	end
end

if not IsGLDeclared("PrintAllInherits") or not PrintAllInherits then
	GLDeclare("PrintAllInherits", __printAllInherits)
end

local function __getInheritChildren(classType, output)
	if output[classType] then
		return
	else
		output[classType] = true

		if __InheritRelationship[classType] then
			for index, childType in pairs(__InheritRelationship[classType]) do
				__getInheritChildren(childType, output)
			end
		end
	end
end

local function __HotfixClassFunction(classType, funcName, newFunc)
	local classVtbl = __ClassTypeList[classType]

	if classVtbl and funcName and newFunc then
		local preFunc = classVtbl[funcName]

		classVtbl[funcName] = newFunc

		local children = {}

		__getInheritChildren(classType, children)

		for replaceClass, value in pairs(children) do
			local vtbl = __ClassTypeList[replaceClass]

			if rawget(vtbl, funcName) == preFunc then
				vtbl[funcName] = newFunc
			end

			if replaceClass ~= classType then
				local super = replaceClass.super

				if rawget(super, funcName) == preFunc then
					super[funcName] = newFunc
				end
			end
		end
	elseif classVtbl == nil and classType and type(classType) == "table" then
		classType[funcName] = newFunc
	end
end

if not IsGLDeclared("HotfixClassFunction") or not HotfixClassFunction then
	GLDeclare("HotfixClassFunction", __HotfixClassFunction)
end

local function __createSingletonClass(cls, ...)
	if cls._instance == nil then
		cls._instance = cls.new(...)
	end

	return cls._instance
end

local TypeNames = {}

local function __Class(typeName, superType, isSingleton)
	local classType = {
		__IsClass = true
	}

	classType.typeName = typeName

	if TypeNames[typeName] ~= nil then
		-- block empty
	else
		TypeNames[typeName] = classType
	end

	classType.superType = superType
	classType._inheritsCount = 0

	if superType ~= nil then
		local cache = {}
		local counter = 1
		local curClass = superType

		while curClass do
			cache[counter] = curClass
			counter = counter + 1
			curClass = curClass.superType
		end

		classType._classInherits = cache
		classType._inheritsCount = counter
	end

	classType._IsSingleton = isSingleton or false

	if superType then
		if __InheritRelationship[superType] == nil then
			__InheritRelationship[superType] = {}
		end

		table.insert(__InheritRelationship[superType], classType)
	else
		__InheritRelationship[classType] = {}
	end

	classType.ctor = false
	classType.dtor = false

	local function objToString(self)
		if not self.__instanceName then
			local str = tostring(self)
			local _, _, addr = string.find(str, "table%s*:%s*(0?[xX]?%x+)")

			self.__instanceName = string.format("Class %s : %s", classType.typeName, addr)
		end

		return self.__instanceName
	end

	local function objGetClass(self)
		return classType
	end

	local function objGetType(self)
		return classType.typeName
	end

	function classType.new(...)
		local obj = {}

		obj.toString = objToString
		obj.getClass = objGetClass
		obj.getType = objGetType

		local function createObj(class, object, ...)
			if class.superType ~= nil then
				for i = class._inheritsCount - 1, 1, -1 do
					local curClass = class._classInherits[i]

					if curClass.ctor then
						curClass.ctor(object, ...)
					end
				end
			end

			if class.ctor then
				class.ctor(object, ...)
			end
		end

		setmetatable(obj, {
			__index = __ClassTypeList[classType]
		})
		createObj(classType, obj, ...)

		return obj
	end

	function classType:toString()
		return self.typeName
	end

	if classType._IsSingleton then
		function classType.GetInstance(...)
			return __createSingletonClass(classType, ...)
		end
	end

	if superType then
		classType.super = setmetatable({}, {
			__index = function(tbl, key)
				local func = __ClassTypeList[superType][key]

				if type(func) == "function" then
					tbl[key] = func

					return func
				else
					error("Accessing super class field are not allowed!")
				end
			end
		})
	end

	local vtbl = {}

	__ClassTypeList[classType] = vtbl

	setmetatable(classType, {
		__index = function(tbl, key)
			return vtbl[key]
		end,
		__newindex = function(tbl, key, value)
			vtbl[key] = value
		end,
		__call = function(self, ...)
			if classType._IsSingleton == true then
				return __createSingletonClass(classType, ...)
			else
				return classType.new(...)
			end
		end
	})

	if superType then
		setmetatable(vtbl, {
			__index = function(tbl, key)
				local ret = __ClassTypeList[superType][key]

				vtbl[key] = ret

				return ret
			end
		})
	end

	return classType
end

local function __isSubClassOf(cls, otherCls)
	return type(otherCls) == "table" and type(cls.superType) == "table" and (cls.superType == otherCls or __isSubClassOf(cls.superType, otherCls))
end

if not IsGLDeclared("isSubClassOf") or not isSubClassOf then
	GLDeclare("isSubClassOf", __isSubClassOf)
end

local function __isInstanceOf(obj, cls)
	local objClass = obj:getClass()

	return objClass ~= nil and type(cls) == "table" and (cls == objClass or __isSubClassOf(objClass, cls))
end

if not IsGLDeclared("isInstanceOf") or not isInstanceOf then
	GLDeclare("isInstanceOf", __isInstanceOf)
end

local function __MixinClass(cls, mixin, checkMeta)
	assert(type(mixin) == "table", "mixin must be a table")

	for name, attr in pairs(mixin) do
		if cls[name] == nil then
			cls[name] = attr
		end
	end

	if checkMeta then
		local metaTable = getmetatable(mixin)

		if metaTable and metaTable.__index then
			metaTable = metaTable.__index

			for name, attr in pairs(metaTable) do
				if cls[name] == nil then
					cls[name] = attr
				end
			end
		end
	end
end

if not IsGLDeclared("MixinClass") or not MixinClass then
	GLDeclare("MixinClass", __MixinClass)
end

if not IsGLDeclared("Class") or not Class then
	GLDeclare("Class", __Class)
end

return __Class
