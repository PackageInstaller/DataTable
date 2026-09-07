local IslandUITplPoolSet = class("IslandUITplPoolSet", import(".IslandRootTplPool"))

function IslandUITplPoolSet:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.root = arg_1_1
	self.pool = IslandUIPool.New(self.root, arg_1_2, typeof(GameObject), arg_1_4, arg_1_5)

	return
end

return IslandUITplPoolSet
