-- chunkname: @IQIGame\\UI\\Common\\Dialog\\LRHeadDialogElement.lua

local DialogItem = {
	contentProgress = 0
}

function DialogItem.New(view)
	local obj = Clone(DialogItem)

	obj:__Init(view)

	return obj
end

function DialogItem:__Init(view)
	self.gameObject = view

	self.gameObject:SetActive(false)
	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.contentTextBackgroundSource = self.textChatContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.npcNameTextBackgroundSource = self.textName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
end

function DialogItem:Dispose()
	if self.dialogShowTime ~= nil then
		self.dialogShowTime:Stop()

		self.dialogShowTime = nil
	end

	self.contentTextBackgroundSource = nil
	self.npcNameTextBackgroundSource = nil

	self.gameObject:SetActive(false)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DialogItem:Show(dialogCfg)
	local picture = dialogCfg.Picture[1]

	if #dialogCfg.Picture > 1 then
		picture = PlayerModule.GetSex() == 0 and dialogCfg.Picture[1] or dialogCfg.Picture[2]
	end

	if LuaUtility.StrIsNullOrEmpty(picture) then
		logError("战斗对话 {0} 配置错误，未正确配置 字段 Picture")
	end

	local path = BattleApi:GetBattleDialogPicture(picture)
	local pictureImage = self.SpineMountPoint:GetComponent("Image")

	AssetUtil.LoadImage(self, path, pictureImage, function(assetName, asset, duration, userData)
		pictureImage:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(self.SpineMountPoint.transform, pictureImage)
	end)

	self.contentProgress = 0

	UGUIUtil.SetText(self.textName, dialogCfg.Name)
	self.npcNameTextBackgroundSource:SetProgress(1)
	UGUIUtil.SetText(self.textChatContent, dialogCfg.Dialogue)
	self.contentTextBackgroundSource:SetProgress(self.contentProgress)

	self.dialogShowTime = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
		self.contentProgress = self.contentProgress + BattleUIApi:GetBattleDialogTextSpeed()

		if self.contentProgress >= 1 then
			self:OnContentShowComplete()
		else
			self.contentTextBackgroundSource:SetProgress(self.contentProgress)
		end
	end, BattleUIApi:GetBattleDialogTextDuration(), -1, BattleUIApi:GetBattleDialogTextUseTimeScale())

	self.dialogShowTime:Start()
	self.gameObject:SetActive(true)
end

function DialogItem:OnContentShowComplete()
	if self.dialogShowTime ~= nil then
		self.dialogShowTime:Stop()

		self.dialogShowTime = nil
	end

	self.contentProgress = 1

	self.contentTextBackgroundSource:SetProgress(self.contentProgress)
end

function DialogItem:Hide()
	self.gameObject:SetActive(false)

	if self.dialogShowTime ~= nil then
		self.dialogShowTime:Stop()

		self.dialogShowTime = nil
	end
end

local LRHeadDialogElement = {}

function LRHeadDialogElement.New(view)
	local obj = Clone(LRHeadDialogElement)

	obj:__Init(view)

	return obj
end

function LRHeadDialogElement:__Init(view)
	self.gameObject = view

	self.gameObject:SetActive(false)
	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.leftDialog = DialogItem.New(self.leftContent)

	self.leftDialog:Hide()

	self.rightDialog = DialogItem.New(self.rightContent)

	self.rightDialog:Hide()

	function self.__OnDialogBackgroundClickEventProxy()
		self:__OnDialogBackgroundClickEventHandler()
	end

	self:__AddListeners()
end

function LRHeadDialogElement:__AddListeners()
	self.closeBg:GetComponent("Button").onClick:AddListener(self.__OnDialogBackgroundClickEventProxy)
end

function LRHeadDialogElement:__RemoveListeners()
	self.closeBg:GetComponent("Button").onClick:RemoveListener(self.__OnDialogBackgroundClickEventProxy)
end

function LRHeadDialogElement:Hide()
	self.gameObject:SetActive(false)
end

function LRHeadDialogElement:Dispose()
	self.gameObject:SetActive(false)
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)

	self.curDialog = nil

	self.leftDialog:Dispose()
	self.rightDialog:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function LRHeadDialogElement:ShowDialog(dialogCid, callback)
	self.callBackFunc = callback

	self:__Show(dialogCid)
end

function LRHeadDialogElement:__Show(dialogCid)
	self.gameObject:SetActive(true)

	self.dialogCfg = CfgLRHeadDialogueTable[dialogCid]

	if self.dialogCfg.PicturePosition then
		self.rightDialog:Hide()

		self.curDialog = self.leftDialog
	else
		self.leftDialog:Hide()

		self.curDialog = self.rightDialog
	end

	self.curDialog:Show(self.dialogCfg)
end

function LRHeadDialogElement:__OnDialogBackgroundClickEventHandler()
	if self.curDialog.contentProgress ~= 1 then
		self.curDialog:OnContentShowComplete()
	else
		self:__ShowNext()
	end
end

function LRHeadDialogElement:__ShowNext()
	if self.dialogCfg.NextID == 0 then
		self:__OnDialogEnd()
	else
		self:__Show(self.dialogCfg.NextID)
	end
end

function LRHeadDialogElement:__OnDialogEnd()
	self.curDialog = nil

	self.gameObject:SetActive(false)

	if self.callBackFunc ~= nil then
		self.callBackFunc()
	end
end

return LRHeadDialogElement
