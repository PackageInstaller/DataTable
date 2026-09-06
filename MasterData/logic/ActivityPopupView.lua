-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/ActivityPopupView.lua

module("logic.extensions.activitypopup.view.ActivityPopupView", package.seeall)

local ActivityPopupView = class("ActivityPopupView", ViewComponent)

function ActivityPopupView:ctor()
	ActivityPopupView.super.ctor(self)
end

function ActivityPopupView:buildUI()
	self._content = self:getGo("content")
	self._commonGo = self:getResInstance(ActivityPopupViewPresentor.HdCommonView)

	goutil.addChildToParent(self._commonGo, self._content)

	self._commonGo.name = "popupview"

	goutil.setActive(self._commonGo, false)

	self._btnClose = self:getBtn("content/popupview/btnClose")
	self._togTip = self:getToggle("content/popupview/togTip")
	self._icon = self:getGo("content/popupview/icon")
	self._timeBg = self:getGo("content/popupview/timeBg")
	self._txtTime = self:getTxt("content/popupview/timeBg/txtTime")
	self._txtTimeRectTrans = self._timeBg:GetComponent(goutil.Type_RectTransform)
	self._btnGo = self:getBtn("content/popupview/btnGo")
	self._iconBtnGo = self:getGo("content/popupview/btnGo")
	self._btnRect = self._iconBtnGo:GetComponent(goutil.Type_RectTransform)
	self._btnCloseRect = self:getGo("content/popupview/btnClose"):GetComponent(goutil.Type_RectTransform)
end

function ActivityPopupView:destroyUI()
	return
end

function ActivityPopupView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnGo:AddClickListener(self._onClickGo, self)
end

function ActivityPopupView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnGo:RemoveClickListener()
end

function ActivityPopupView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ActivityPopupClickClose, self._onActivityPopupClickClose, self)

	local id = ActivityPopupModel.instance:getNextActivityViewId()

	if id and id > 0 then
		self:_initShow(id)
		GlobalModel.instance:visibleMainCamera(true)
	else
		self:close()
	end
end

function ActivityPopupView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ActivityPopupClickClose, self._onActivityPopupClickClose, self)

	if self._togTip.gameObject.activeInHierarchy then
		GameUtil.saveUserDayData(ActivityPopupModel.instance:getSignString(), self._togTip.isOn)
	end

	self:_resetCommonGo()
end

function ActivityPopupView:_onClickClose()
	local id = ActivityPopupModel.instance:getNextActivityViewId()

	if id and id > 0 then
		if self._togTip.gameObject.activeInHierarchy then
			GameUtil.saveUserDayData(ActivityPopupModel.instance:getSignString(), self._togTip.isOn)
		end

		self:_initShow(id)

		return
	end

	self:close()
end

function ActivityPopupView:playAnimation(go)
	local cur = 1.1

	GameUtil.setLocalScale(go, cur, cur, 1)

	self.tween = TweenUtil.ValueTo(cur, 1, 0.2, function(val)
		GameUtil.setLocalScale(go, val, val, 1)
	end, function()
		self.tween = nil
	end, self)
end

function ActivityPopupView:_initShow(id)
	local cfg = ActivityPopupConfig.instance:getCfgById(id)

	self._curViewName = cfg.uiName

	if cfg.funcType == 1 then
		goutil.setActive(self._commonGo, false)
		self:showTabAt(self._content, self._curViewName, true, cfg)

		return
	else
		goutil.setActive(self._commonGo, true)
		self:showTabAt(self._content, "")

		self._curCfg = cfg

		self:_initCommonShow()
	end

	ActivityPopupModel.instance:saveTypeDone(id)
end

function ActivityPopupView:_onClickGo()
	if self._curCfg then
		if not ActivityPopupModel.instance:isHaveNextActivityViewId() then
			UIStateManager.instance:clear()
		end

		GotoMgr.gotoByString(self._curCfg.jumpTo)
	end
end

function ActivityPopupView:_initCommonShow()
	local go = self._commonGo

	self:playAnimation(go)

	self._togTip.isOn = GameUtil.getUserDayData(ActivityPopupModel.instance:getSignString())

	uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/activitypopup/%s.png", self._curCfg.iconName), function(width, height)
		if self._icon then
			local image = self._icon:GetComponent(goutil.Type_UIImage)

			if image then
				image:SetNativeSize()
			end
		end
	end)
	self:_setTxtTitle()
	self:_setBtnGo()
	self:_setCloseGo()
end

function ActivityPopupView:_resetCommonGo()
	if self._icon then
		local img = Framework.ImageBigBG.Get(self._icon)

		if img then
			img:ClearImage()
		end
	end

	if self._iconBtnGo then
		local icon = Framework.ImageBigBG.Get(self._iconBtnGo)

		if icon then
			icon:ClearImage()
		end
	end
end

function ActivityPopupView:_setTxtTitle()
	if not self._curCfg then
		return
	end

	local isShow = not string.nilorempty(self._curCfg.words)

	goutil.setActive(self._timeBg.gameObject, isShow)

	if isShow then
		self._txtTime.text = self._curCfg.words

		if self._curCfg.wordPos then
			if not self._curCfg.wordPos[1] then
				if not self._curCfg.wordPos[2] then
					local y = 0

					Framework.TransformUtil.SetAnchoredPos(self._txtTimeRectTrans, self._curCfg.wordPos[1], y)
				end
			end
		end
	end
end

function ActivityPopupView:_setBtnGo()
	if self._curCfg then
		goutil.setActive(self._btnGo.gameObject, not string.nilorempty(self._curCfg.jumpTo))

		if not string.nilorempty(self._curCfg.btnIcon) then
			uGuiUtil.setSpriteToImage(self._iconBtnGo, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/activitypopup/%s.png", self._curCfg.btnIcon))
		end

		if self._curCfg.btnPos then
			if not self._curCfg.btnPos[1] then
				if not self._curCfg.btnPos[2] then
					local y = 0

					Framework.TransformUtil.SetAnchoredPos(self._btnRect, self._curCfg.btnPos[1], y)
				end
			end
		end
	else
		goutil.setActive(self._btnGo.gameObject, false)
	end
end

function ActivityPopupView:_setCloseGo()
	if self._curCfg and self._curCfg.closePos then
		if not self._curCfg.closePos[1] then
			if not self._curCfg.closePos[2] then
				local y = 0

				Framework.TransformUtil.SetAnchoredPos(self._btnCloseRect, self._curCfg.closePos[1], y)
			end
		end
	end
end

function ActivityPopupView:_onActivityPopupClickClose()
	self:_onClickClose()
end

return ActivityPopupView
