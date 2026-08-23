local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local var_0_1 = g.core.const.ConstMgr.WeddingConst
local var_0_2 = g.core.config.attribute_info
local var_0_3 = g.core.model.User.weddingData
local KnightWeddingDevAttrPop = class("KnightWeddingDevAttrPop", require("app.fairyGUI.knight.UI_KnightWeddingDevAttrPop"), function()
	return fgui.GComponent:create({
		resName = "KnightWeddingDevAttrPop",
		pkgName = "knight",
		isFullScreen = false,
		pkgPath = "ui/knight/knight"
	}, ...)
end)

function KnightWeddingDevAttrPop:ctor(arg_2_1)
	self._knightStruct = arg_2_1.knightStruct
	self._curInfo = var_0_3:getCurFavorInfo(self._knightStruct:getAdvanceId())

	if arg_2_1.nextInfo then
		if arg_2_1.nextInfo.talent_all_2 > 0 then
			self._addTalentId = arg_2_1.nextInfo.talent_all_2
			self._talentIsAll = false
		elseif arg_2_1.nextInfo.talent_all > 0 then
			self._addTalentId = 0
			self._talentIsAll = false
		end
	else
		self._addTalentId = 0
	end

	self._attrDataList = {}

	self:initView()
end

function KnightWeddingDevAttrPop:initView()
	self:showAtCenter()
	self.m_bgPanel:setTitle(g.core.lang:get(421217))
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderList))

	local var_3_0, var_3_1, var_3_2 = var_0_3:getKnightFavorAllAttrList(self._knightStruct:getAdvanceId())

	self._allHasAllAttrList2 = var_3_2
end

function KnightWeddingDevAttrPop:_onRenderList(arg_4_1, arg_4_2)
	local var_4_0 = self._attrDataList[arg_4_1 + 1]
	local var_4_1 = self._attrDataList[arg_4_1 + 1].info.id
	local var_4_2, var_4_3 = g.core.lang:getAttr(self._attrDataList[arg_4_1 + 1].info.id, self._attrDataList[arg_4_1 + 1].value)

	var_4_2 = var_4_0.target == var_0_1.ATTR_TARGET.ALL and g.core.lang:get(2071, {
		name = var_4_2
	}) or g.core.lang:get(412007, {
		knightName = self._knightStruct:getName(),
		attrName = var_4_2
	})

	arg_4_2:getChild("nameText"):setText(var_4_2)
	arg_4_2:getChild("valueText"):setText(var_4_3)

	local var_4_4 = arg_4_2:getChild("addText")
	local var_4_5 = var_4_0.addValue or 0

	if var_4_5 > 0 then
		local var_4_6, var_4_7 = g.core.lang:getAttr(var_4_1, var_4_5)

		var_4_4:setText(var_4_7)
	else
		var_4_4:setText("")
	end
end

function KnightWeddingDevAttrPop:onLoad()
	self:updateView()
end

function KnightWeddingDevAttrPop:updateView()
	self._attrDataList = {}

	local var_6_0, var_6_1, var_6_2 = var_0_3:getFavorAttrList(self._knightStruct:getAdvanceId())
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in pairs(self._allHasAllAttrList2) do
		iter_6_1 = var_6_2[iter_6_0] and var_6_2[iter_6_0] or 0

		table.insert(self._attrDataList, {
			info = var_0_2.get(iter_6_0),
			value = iter_6_1,
			target = var_0_1.ATTR_TARGET.ALL
		})

		var_6_3[iter_6_0] = #self._attrDataList
	end

	for iter_6_2, iter_6_3 in pairs((self._addTalentId and self._addTalentId > 0 or nil) and FightValueCalculation._getTalentAttrList(self._addTalentId)) do
		if var_6_3[iter_6_2] then
			self._attrDataList[var_6_3[iter_6_2]].addValue = iter_6_3
		else
			local var_6_5 = self._attrDataList
			local var_6_6 = {
				value = 0,
				info = var_0_2.get(iter_6_2),
				addValue = iter_6_3
			}

			if self._talentIsAll then
				var_6_6.target = var_0_1.ATTR_TARGET.ALL or var_0_1.ATTR_TARGET.KNIGHT
			end

			table.insert(var_6_5, var_6_6)
		end
	end

	table.sort(self._attrDataList, function(arg_7_0, arg_7_1)
		if arg_7_0.target ~= arg_7_1.target then
			return arg_7_0.target > arg_7_1.target
		end

		return arg_7_0.info.num < arg_7_1.info.num
	end)
	self.m_attrList:setNumItems(#self._attrDataList)
end

return KnightWeddingDevAttrPop
