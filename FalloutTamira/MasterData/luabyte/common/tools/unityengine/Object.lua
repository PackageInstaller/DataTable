-- xlua对UntyEngine的Object判空不能直接判nil
-- https://github.com/Tencent/xLua/blob/master/Assets/XLua/Doc/faq.md
function IsNull(unity_object)
	if unity_object == nil then
		return true
	end
	
	if type(unity_object) == "userdata" and unity_object.IsNull ~= nil then
		return unity_object:IsNull()
	end
	
	return false
end

function IsArrEmpty(object)
	if IsNull(object) then 
		return true 
	end	
	if type(object) == "userdata" then 
		if object.Length and object.Length == 0 then 
			return true 
		end
		if object.Count and object.Count == 0 then 
			return true 
		end
		return false 
	end
	return #object == 0 
end
