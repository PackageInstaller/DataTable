local UIModule = CS.Engine.UI.UIModule
local UIEventProxy = CS.Engine.UI.UIEventProxy
local GOODS_NUM_MAX = 1 --- 单个最大展示物品数量
local TotalShowNum = 10 --- 最多10个
---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
local uiSheets = UISheets

--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinBlendResultDialog.prefab > name: GachaponSkinBlendResultDialog
---@class GachaponSkinBlendResultDialog
---@field Env                           	GachaponSkinBlendResultDialog           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               	@ 0    
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 1    
---@field Container                     	UnityEngine.RectTransform               	@ 2    
---@field OneGroup                      	UnityEngine.RectTransform               	@ 3    
---@field TenGroup                      	UnityEngine.RectTransform               	@ 4    
---@field OneNode                       	UnityEngine.RectTransform               	@ 5    
---@field TenNode1                      	UnityEngine.RectTransform               	@ 6    
---@field TenNode2                      	UnityEngine.RectTransform               	@ 7    
---@field TenNode3                      	UnityEngine.RectTransform               	@ 8    
---@field TenNode4                      	UnityEngine.RectTransform               	@ 9    
---@field TenNode5                      	UnityEngine.RectTransform               	@ 10   
---@field TenNode6                      	UnityEngine.RectTransform               	@ 11   
---@field TenNode7                      	UnityEngine.RectTransform               	@ 12   
---@field TenNode8                      	UnityEngine.RectTransform               	@ 13   
---@field TenNode9                      	UnityEngine.RectTransform               	@ 14   
---@field TenNode10                     	UnityEngine.RectTransform               	@ 15   
local GachaponSkinBlendResultDialog = Class("GachaponSkinBlendResultDialog")
local NodePath = "Game.Activity.GachaponSkin.GachaponSkinBlendTreasureBoxNode"

function GachaponSkinBlendResultDialog:__init()
	---@type table[]
	self.goodsTable = nil  -- 奖励数据
	---@type integer
	self.goodsCount = 0  -- 奖励数量
	---@type fun():void
	self.closeCallback = nil
	self.isWait = false
	self.goodsMaxNum = GOODS_NUM_MAX
end

function GachaponSkinBlendResultDialog:__delete()
	self.goodsTable = nil
	self.goodsCount = nil
	self.closeCallback = nil
	self.isWait = false
	self.controller = nil
	
	self.orthographic = false
	self.fieldOfView = 12
	self.ignoreUICameraProjection = false
end

function GachaponSkinBlendResultDialog:Awake()
	---@type UnityEngine.Camera
	local cam = UIModule.RootCanvas.defaultCamera
	if  cam then
		self.orthographic = cam.orthographic
		self.fieldOfView = cam.fieldOfView
	end
	
	UIEventProxy.Create(self.BtnClose.gameObject).onPointerClick = Bind(self, self.OnCloseBtnClick)
end

function GachaponSkinBlendResultDialog:OnFocus(focus)
	if not focus then
		---@type UnityEngine.Camera
		local cam = UIModule.RootCanvas.defaultCamera
		if  cam then
			CfUtils.SetUICameraProjection(self.orthographic, self.fieldOfView)
		end
	end
end

function GachaponSkinBlendResultDialog:OnInitialize()
	return CoWaitDo(function()
		self:DoInitialize()
		if not self.ignoreUICameraProjection then
			CfUtils.SetUICameraProjection(true)
		end
	end)
end
function GachaponSkinBlendResultDialog:DoInitialize()
	local initParams = self.controller.Argument.parameters or {}
	self.closeCallback = initParams.cb or initParams.closeCb
	self.ignoreUICameraProjection = checkBool(initParams.ignoreUICameraProjection)
	if initParams.customSortingOrder then
		CfUtils.SetAddSortingOrder(self.controller, initParams.customSortingOrder)
	end
end

function GachaponSkinBlendResultDialog:OnFinalize()
	return CoWaitDo(function()
		self:DoFinalize()
	end)
end
function GachaponSkinBlendResultDialog:DoFinalize()
	if not IsNull(self.__mainCoroutine) then
		CoStop(self.__mainCoroutine)
		self.__mainCoroutine = nil
	end
	
	if self.closeCallback and type(self.closeCallback) == 'function' then
		self.closeCallback()
	end
	
	self.controller = nil --C#托管堆GC
	self:Delete()
	self = nil
end

function GachaponSkinBlendResultDialog:OnShow()
	return CoWaitDo(function()
		local initParams = self.controller.Argument.parameters or {}
		if isNull(initParams.rewards) then
			return
		end
		self:RefreshShow()
	end)
end

function GachaponSkinBlendResultDialog:OnHide()

end

function GachaponSkinBlendResultDialog:RefreshShow()
	self:PlayShowSound()
	self.__mainCoroutine = CoStart(function()
		self:DoShow()
	end)
end

function GachaponSkinBlendResultDialog:PlayShowSound()
	CriWareUtils.PlaySe(uiSheets.UI_Menu.path, uiSheets.UI_Menu.ui_award_get)
end

function GachaponSkinBlendResultDialog:DoShow()
	local initParams = self.controller.Argument.parameters or {}
	if isNull(initParams.rewards) then
		return
	end
	self.goodsTable = checkTable(initParams.rewards)
	self.goodsCount = table.count(self.goodsTable)
	
	if self.goodsCount > self.goodsMaxNum then
		---列表的形式展示
		CfUtils.SetActive(self.TenGroup, true)
		CfUtils.SetActive(self.OneGroup, false)
		self:ShowTenGoods()
	else
		CfUtils.SetActive(self.TenGroup, false)
		CfUtils.SetActive(self.OneGroup, true)
		self:ShowOneGoods()
	end
end

function GachaponSkinBlendResultDialog:ShowTenGoods()
	for i = 1, TotalShowNum do
		local node = self["TenNode"..i]
		if node then
			local data = self.goodsTable[i]
			if data then
				local env = CfUtils.GetLuaScr(node,NodePath)
				if isNotNull(env) then
					env:RefreshShow(self.goodsTable[i])
					env:PlayBackAni()
				end
				CfUtils.SetActive(node.gameObject,true)
			else
				CfUtils.SetActive(node.gameObject,false)
			end
		end
	end
	CoYield(0.5)
	for i = 1, TotalShowNum do
		local node = self["TenNode"..i]
		if node then
			local data = self.goodsTable[i]
			if data then
				local env = CfUtils.GetLuaScr(node,NodePath)
				if isNotNull(env) then
					env:PlayBackToFrontAni()
				end
				local isNeedShowSkin = self:IsNeedShowSkin(self.goodsTable[i])
				if isNeedShowSkin then
					self.isWait = true
					local GachaponUtils = import('Game.Gachapon.GachaponUtils')
					coroutine.yield(GachaponUtils.OpenDialogAction(Constants.UITypeIds.CommonCardDisplayDialog, {
						cardInfo   = { { goodsId =  self.goodsTable[i].goodsId } },
						isSkin = true       ,
						isHideSkip = true,
						finishCb   = function()
						end,
						onCloseCb  = function()
							UIModule.CloseDialogById(Constants.UITypeIds.CommonCardDisplayDialog)
							self.isWait = false
						end
					}, nil))
				else
					CoYield(0.15)
				end
				
				while self.isWait do
					CoYield()
				end
			end
		end
	end
end

function GachaponSkinBlendResultDialog:IsNeedShowSkin(data)
	local IdType = GoodsUtils.GetIdType(data.goodsId)
	if IdType == Constants.IDType.CardSkin and not isSet(data,"convertGoods") then
		return true
	end
	return false
end

--[[
    展示 Goods
--]]
function GachaponSkinBlendResultDialog:ShowOneGoods()
	local goodsCount = self.goodsCount
	if goodsCount < 1 then
		printInfo("请检查参数Table")
		return
	end
	local oneNodeEnv = CfUtils.GetLuaScr(self.OneNode, NodePath)
	if isNotNull(oneNodeEnv) then
		oneNodeEnv:RefreshShow(self.goodsTable[1])
		oneNodeEnv:PlayBackAni()
		CoYield(0.5)
		oneNodeEnv:PlayBackToFrontAni()
	end
end

function GachaponSkinBlendResultDialog:OnCloseBtnClick()
	---因为该窗口对屏幕进行截屏，所以显示时底下的窗口都可以关闭显示，关闭该窗口时，需要让底下窗口重新显示
	-- GameUtils.ShowPreviousDialogs()
	
	if not IsNull(self.__mainCoroutine) then
		CoStop(self.__mainCoroutine)
		self.__mainCoroutine = nil
		---检测未完成展示Goods,立刻展示
		for i = 1, TotalShowNum do
			local node = self["TenNode"..i]
			if not isNull(node) then
				local env = CfUtils.GetLuaScr(node, NodePath)
				if isNotNull(env) then
					env:PlayFrontAni()
				end
			end
		end
	else
		UIModule.BackDialog()
	end
end

return GachaponSkinBlendResultDialog