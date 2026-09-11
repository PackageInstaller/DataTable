local DormUnLockRoomConfirmView = class("DormUnLockRoomConfirmView", ReduxView)

function DormUnLockRoomConfirmView:UIName()
	return "Widget/BackHouseUI/Dorm/DormUnlockPop"
end

function DormUnLockRoomConfirmView:UIParent()
	return manager.ui.uiPop.transform
end

function DormUnLockRoomConfirmView:OnCtor()
	return
end

function DormUnLockRoomConfirmView:Init()
	self:InitUI()

	self.roomScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DormRoomUnLockItem)
end

function DormUnLockRoomConfirmView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function DormUnLockRoomConfirmView:OnEnter()
	self.roomID = self.params_.roomID

	self:RefreshHeroList()
	self:RegisterEvents()
end

function DormUnLockRoomConfirmView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function DormUnLockRoomConfirmView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function DormUnLockRoomConfirmView:RegisterEvents()
	self:RegistEventListener(DORM_HERO_OCCUPY, function(arg_11_0)
		JumpTools.Back()
		JumpTools.OpenPageByJump("dormPrivateOccupySuccessView", {
			archiveID = arg_11_0[1]
		})
	end)
end

function DormUnLockRoomConfirmView:RefreshHeroList()
	self.archiveList = {}

	for iter_12_0, iter_12_1 in ipairs((DormHeroTools:GetCanUseHeroInDorm())) do
		if not DormRoomTools:GetDormIDViaArchive(iter_12_1) then
			if DormData:GetHeroInfo(iter_12_1):GetHeroFavorability() >= GameSetting.dorm_hero_set_level.value[1] then
				table.insert(self.archiveList, iter_12_1)
			end
		end
	end

	self.roomScroll:StartScroll(#self.archiveList)

	if #self.archiveList == 0 then
		self.textText_.text = GetTips("DORM_HERO_SET_NULL")
	end
end

function DormUnLockRoomConfirmView:indexItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.archiveList[arg_13_1])
	arg_13_2:PlaceHeroCallBack(function(arg_14_0)
		ShowMessageBox({
			content = string.format(GetTips("DORM_HERO_SET_CHECK"), (GetI18NText(HeroRecordCfg[arg_14_0].name))),
			OkCallback = function()
				local var_15_0 = DormData:GetHeroInfo(arg_14_0):GetCanUseHeroList()[1]

				if var_15_0 then
					DormAction:DeployHeroInRoom(self.roomID, {
						var_15_0
					}, DormEnum.DormDeployType.Occupy)
				else
					Debug.LogError("未找到可以使用的角色id")
				end
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function DormUnLockRoomConfirmView:Dispose()
	if self.roomScroll then
		self.roomScroll:Dispose()
	end

	DormUnLockRoomConfirmView.super.Dispose(self)
end

return DormUnLockRoomConfirmView
