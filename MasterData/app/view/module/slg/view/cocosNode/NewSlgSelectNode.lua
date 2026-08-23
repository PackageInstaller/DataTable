local NewSlgSelectNode = class("NewSlgSelectNode", require("app.core.tilemap.base.BaseNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")

function NewSlgSelectNode:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self, arg_1_1, arg_1_2)
end

function NewSlgSelectNode:onExit()
	if self._sprSelect then
		self._sprSelect:removeAllChildren()
	end
end

function NewSlgSelectNode:_initFGui()
	self._sprSelect = display.newSprite(g.core.common.Path:getGroupWarSelectImg(1))

	self._map._floorNode:addChild(self._sprSelect)
	self._sprSelect:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.7, 51), cc.FadeTo:create(0.7, 153))))
end

function NewSlgSelectNode:removeSelfAndClear()
	self._sprSelect:removeFromParent()

	self._sprSelect = nil

	self:removeFromParent()
end

function NewSlgSelectNode:setData(arg_5_1)
	self._data = arg_5_1

	self:setBaseData(arg_5_1)
	self:setCustomVisible(true)

	local var_5_0, var_5_1 = TileMapFunc.p2rc(self._data.posX, self._data.posY)
	local var_5_2 = g.core.model.User.newSlgData:getObjectDataByRC(var_5_0, var_5_1)

	self._sprSelect:stopAllActions()
	self._sprSelect:setPosition(self._data.posX, self._data.posY)
	self._sprSelect:setScale(1)

	if var_5_2 then
		local var_5_3, var_5_4 = require("app.core.tilemap.TileMapFunc").rc2p(var_5_2.centerRC.x, var_5_2.centerRC.y)

		self._sprSelect:setPosition(var_5_3, var_5_4)

		local var_5_5 = #var_5_2.includeRC == 5 and 6 or math.ceil(math.sqrt(#var_5_2.includeRC))

		self._sprSelect:setTexture(g.core.common.Path:getGroupWarSelectImg(var_5_5))
		self:playSpineEff(var_5_5)
	else
		self._sprSelect:setTexture(g.core.common.Path:getGroupWarSelectImg(1))
		self:playSpineEff(1)
	end
end

function NewSlgSelectNode:playSpineEff(arg_6_1)
	if self._spine and not tolua.isnull(self._spine) then
		self._spine:removeFromParent(true)
	end

	self._spine = nil

	self._sprSelect:addChild((require("app.view.common.SpineBase").new({
		resId = "eff_ui_newSlg_select",
		isLoop = true,
		path = g.core.common.Path:getEffSpine("eff_ui_newSlg_select"),
		anim = "play" .. arg_6_1
	})))

	local var_6_1 = self._sprSelect:getContentSize()

	self._spine:setPosition(var_6_1.width / 2, var_6_1.height / 2)
end

return NewSlgSelectNode
