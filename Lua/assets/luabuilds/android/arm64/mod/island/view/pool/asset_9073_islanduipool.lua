local IslandUIPool = class("IslandUIPool", import(".IslandObjectPool"))

function IslandUIPool:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	IslandUIPool.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	self.canDel = arg_1_5

	return
end

function IslandUIPool:CanDelete()
	return IslandUIPool.super.CanDelete(self) and self.canDel
end

function IslandUIPool:ActiveOrDisactiveItem(arg_3_1, arg_3_2)
	local var_3_0 = GetOrAddComponent(arg_3_1, typeof(CanvasGroup))

	var_3_0.alpha = arg_3_2 and 1 or 0
	var_3_0.blocksRaycasts = arg_3_2

	return
end

return IslandUIPool
