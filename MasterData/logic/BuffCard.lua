-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/BuffCard.lua

module("logic.extensions.expedition.view.BuffCard", package.seeall)

local BuffCard = class("BuffCard")

function BuffCard.AddOnce(go)
	return GameUtil.AddLuaOnce(go, BuffCard)
end

function BuffCard.Remove(go)
	local obj = GameUtil.GetLua(go, BuffCard)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, BuffCard)
end

function BuffCard:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
	self:initEvent()
end

function BuffCard:dispose()
	self:clearImage()
	self:removeEvent()
end

function BuffCard:removeEvent()
	self.btn:RemoveClickListener()
end

function BuffCard:initEvent()
	self.btn:AddClickListener(function()
		GameUtil.callBack(self.callBack)
	end)
end

function BuffCard:buildUI()
	self.txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self.txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self.btn = Framework.ButtonAdapter.GetFrom(self.mainGO, "btn")
	self.goSelect = goutil.findChild(self.mainGO, "imgSelect")
	self.bufIcon = Framework.ImageBigBG.GetFrom(self.mainGO, "BuffIcon")
	self.buffLv = goutil.findChildComponent(self.mainGO, "level", "UIImageSpriteChange")
	self.buffLvState = goutil.findChildComponent(self.mainGO, "icon", "UIImageSpriteChange")
	self.buffLvIcon = self.buffLv:GetComponent(typeof(UnityEngine.UI.Image))
end

function BuffCard:setClickCallBack(cb)
	self.callBack = cb
end

function BuffCard:setId(id, isSelect)
	local cfg = ExpeditionConfig.instance:getBuffCfg(id)

	if not cfg then
		printError("buff cfg not exist:" .. id)

		return
	end

	self.txtName.text = cfg.name
	self.txtDesc.text = cfg.desc

	self:_adjustFontSize(cfg)

	if self.goSelect then
		self.goSelect:SetActive(isSelect)
	end

	self.bufIcon:SetImage(GameUrl.getExpEventUrl(cfg.icon))
	self.buffLv:SetState(cfg.quality)
	self.buffLvState:SetState(cfg.nature)
	self.buffLvIcon:SetNativeSize()
end

function BuffCard:_adjustFontSize()
	local preferredWidth = self.txtName.preferredWidth
	local scale = 130 / preferredWidth

	if scale > 1 then
		scale = 1
	end

	Framework.TransformUtil.SetLocalScale(self.txtName.transform, scale, scale, scale)
end

function BuffCard:clearImage()
	self.bufIcon:ClearImage()
end

return BuffCard
