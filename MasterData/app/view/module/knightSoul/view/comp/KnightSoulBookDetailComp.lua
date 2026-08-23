local var_0_0 = g.core.model.User.knightSoulData
local var_0_1 = g.core.const.ConstMgr.KnightSoulConst
local KnightSoulBookDetailComp = class("KnightSoulBookDetailComp", require("app.fairyGUI.knightSoul.UI_KnightSoulBookDetailComp"))

function KnightSoulBookDetailComp:ctor()
	self._bookId = 0
	self._chapterId = 0
	self._bookStruct = nil
	self._bookStatus = var_0_1.BOOK_STATUS.ACTIVATE_UNABLE

	self.m_starComp:initStar({
		index = 3,
		style = 2,
		num = 0,
		max = var_0_1.MAX_STAR_NUM
	})
end

function KnightSoulBookDetailComp:updateDetailComp(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._bookStruct = arg_2_1
	self._bookId = self._bookStruct:getId()
	self._chapterId = self._bookStruct:getChapter()
	self._bookStatus = self._bookStruct:getStatusIndex()

	self.m_honorNum:setText(arg_2_1:getActivateHonor())
	self.m_bookName:setText(self._bookStruct:getName())
	self.m_honorNum:setText(self._bookStruct:getActivateHonor())
	self.m_bookStatusController:setSelectedIndex(self._bookStatus)
	self.m_starComp:setStarNum((self._bookStruct:getStarNum()))

	local var_2_0 = arg_2_1:isActivate() and var_0_0:isOpenBookStarUp()

	self.m_starComp:setVisible(var_2_0)
	self.m_honorGroup:setVisible(not var_2_0)

	local var_2_1 = self._bookStruct:getBookAttrList()

	for iter_2_0 = 1, 4 do
		if var_2_1[iter_2_0] then
			self["m_attribute" .. iter_2_0]:setVisible(true)
			self["m_attribute" .. iter_2_0]:updateAttr({
				isAll = true,
				type = var_2_1[iter_2_0].attrType,
				value = var_2_1[iter_2_0].attrValue
			})
		else
			self["m_attribute" .. iter_2_0]:setVisible(false)
		end
	end
end

function KnightSoulBookDetailComp:_onConfirm()
	return
end

return KnightSoulBookDetailComp
