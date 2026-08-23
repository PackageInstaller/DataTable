local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.common.Color
local BattleEffect = require("app.view.battle.BattleEffect")
local BattleSuccubaEntranceComp = class("BattleSuccubaEntranceComp", require("app.fairyGUI.battle.UI_BattleSuccubaEntranceComp"))

function BattleSuccubaEntranceComp:ctor()
	return
end

function BattleSuccubaEntranceComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._callback = arg_2_1.callback
	self.succubaId = arg_2_1.succubaId

	local var_2_0 = g.core.config.succuba_info.get(self.succubaId)

	self._quality = g.core.config.skill_info.get(var_2_0.skill_id).skill_quality

	local var_2_1 = 1

	if arg_2_1.identity ~= 1 then
		var_2_1 = -1
	end

	local var_2_2 = self:_createSkillNameView(var_2_0.name, var_2_1)

	self._spineEff = BattleEffect.new({
		path = g.core.common.Path:getEffSpine("eff_ui_battleSuccuba_artifactcurtain"),
		listener = handler(self, self._onSpineEvent)
	})

	self._spineEff:addNodesAtSlots({
		{
			slotStr = "slot_icon",
			node = self:_createKnightImgView(self.succubaId, var_2_1)
		}
	})
	self._spineEff:addNodesAtSlots({
		{
			slotStr = "slot_txt",
			node = var_2_2
		}
	})
	self.m_effNode:addNode(self._spineEff)
end

function BattleSuccubaEntranceComp:_createSkillNameView(arg_3_1, arg_3_2)
	local var_3_0 = cc.Node:create()

	var_3_0:setCascadeOpacityEnabled(true)

	local var_3_1 = cc.Label:createWithTTF(arg_3_1, "font/SourceHanSerifCN-Heavy-4.otf", 34)

	var_3_1:setAnchorPoint(0.5, 0.5)
	var_3_1:setScaleX(arg_3_2)
	var_3_1:setTextColor(var_0_2.A6)

	if var_3_1 then
		var_3_0:addChild(var_3_1)
	end

	return var_3_0
end

function BattleSuccubaEntranceComp:_createKnightImgView(arg_4_1, arg_4_2)
	local var_4_0 = g.core.common.Path:getKnightPicById(arg_4_1)

	if not cc.FileUtils:getInstance():isFileExist(var_4_0) then
		var_4_0 = nil
	end

	local var_4_1 = display.newSprite(var_4_0)

	var_4_1:setScale(680 / var_4_1:getContentSize().height)
	var_4_1:setAnchorPoint(0.5, 0.5)

	return var_4_1
end

function BattleSuccubaEntranceComp:_createIconView(arg_5_1)
	local var_5_0 = var_0_1:getArtifactImg(g.core.config.artifact_info.get((arg_5_1:getArtifactId())).res_id)

	if not cc.FileUtils:getInstance():isFileExist(var_5_0) then
		var_5_0 = nil
	end

	local var_5_1 = display.newSprite(var_5_0)

	var_5_1:setAnchorPoint(0.5, 0.5)

	return var_5_1
end

function BattleSuccubaEntranceComp:_onSpineEvent(arg_6_1)
	if arg_6_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self:onDelete()
	end
end

function BattleSuccubaEntranceComp:onDelete()
	if self._callback then
		self._callback()

		self._callback = nil
	end

	if not tolua.isnull(self) then
		self:removeFromParent()
	end
end

return BattleSuccubaEntranceComp
