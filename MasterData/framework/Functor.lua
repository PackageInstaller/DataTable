-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Framework\\Functor.lua

local logerror = logerror

local function slot(func, obj)
	if not func then
		return nil
	end

	return function(...)
		return func(obj, ...)
	end
end

if not IsGLDeclared("Slot") or not Slot then
	GLDeclare("Slot", slot)
end

local function functor(func, ...)
	local args = {
		...
	}
	local argsLen = select("#", ...)

	return function(...)
		local innerArgs = {
			...
		}
		local innerArgsLen = select("#", ...)
		local tempArgs = {}

		for i = 1, argsLen do
			table.insert(tempArgs, i, args[i])
		end

		for i = 1, innerArgsLen do
			table.insert(tempArgs, argsLen + i, innerArgs[i])
		end

		return func(unpack(tempArgs, 1, argsLen + innerArgsLen))
	end
end

if not IsGLDeclared("Functor") or not Functor then
	GLDeclare("Functor", functor)
end

return functor
