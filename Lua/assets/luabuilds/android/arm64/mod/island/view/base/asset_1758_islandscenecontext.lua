local IslandSceneContext = class("IslandSceneContext")

function IslandSceneContext:Ctor(arg_1_1, ...)
	self.class = arg_1_1
	self.args = packEx(...)
	self.subpages = {}
	self.__visible = true
	self.__openPrevWhenClose = true
	self.__delRecordWhenClose = true
	self.level = -1

	return
end

function IslandSceneContext:DisabelOpenPrevWhenClose()
	self.__openPrevWhenClose = false

	return
end

function IslandSceneContext:DisabelDelRecordWhenClose()
	self.__delRecordWhenClose = false

	return
end

function IslandSceneContext:GetDelRecordWhenClose()
	self.__delRecordWhenClose = true

	return self.__delRecordWhenClose
end

function IslandSceneContext:GetOpenPrevWhenClose()
	self.__openPrevWhenClose = true

	return self.__openPrevWhenClose
end

function IslandSceneContext:AddSubPage(arg_6_1, arg_6_2, arg_6_3, ...)
	local var_6_0 = _.detect(self.subpages, function(arg_7_0)
		return arg_6_1.__cname == arg_7_0.class.__cname
	end)

	if var_6_0 then
		var_6_0.__visible = true

		return
	end

	local var_6_1 = IslandSceneContext.New(arg_6_1, ...)

	var_6_1:SetSubPageParentName(arg_6_3)
	var_6_1:SetLevel(arg_6_2)
	table.insert(self.subpages, var_6_1)

	return
end

function IslandSceneContext:SetSubPageParentName(arg_8_1)
	self.parentName = arg_8_1

	return
end

function IslandSceneContext:GetSubPageParentName()
	return self.parentName
end

function IslandSceneContext:SetLevel(arg_10_1)
	self.level = arg_10_1

	return
end

function IslandSceneContext:GetLevel()
	return self.level
end

function IslandSceneContext:GetSubPages()
	return self.subpages
end

function IslandSceneContext:GetData()
	return self.args
end

return IslandSceneContext
