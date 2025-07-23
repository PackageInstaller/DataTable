module('preFight.BaseItem', Class.impl('lib.component.BaseItemRender'))


function onInit(self, go)
    super.onInit(self, go)
    self:removeOnClick(self.UIObject.gameObject)
	self:addOnClick(self.UIObject.gameObject, self.onClickItemHandler)
	
	self:getManager():removeEventListener(self:getManager().UPDATE_LIST_ITEM, self.__onUpdateViewHandler, self)
	self:getManager():addEventListener(self:getManager().UPDATE_LIST_ITEM, self.__onUpdateViewHandler, self)
	
	self.text = self.m_childTrans['m_text']:GetComponent(ty.Text)
	self.selectImg = self.m_childTrans['m_imgSelect']
end

function setData(self, param)
    super.setData(self, param)
    if(self.data == nil) then
		return
	end
	self:__onUpdateViewHandler()
end

function onDelete(self)
	self:removeOnClick(self.UIObject.gameObject)
	self:getManager():removeEventListener(self:getManager().UPDATE_LIST_ITEM, self.__onUpdateViewHandler, self)
	super.onDelete(self)
end

function __onUpdateViewHandler(self, args)
	local heroVo = self.data
	if(args and args.heroVo and args.heroVo.id ~= heroVo.id) then
		return
	end
	
	self.text.text = heroVo.name
	self:__updateSelectImg()
end

-- 更新选中状态
function __updateSelectImg(self)
	local isSelect = false
	local heroVo = self.data
	local tempShowList = self:getManager():getTempShowList()
	for _, showVo in pairs(tempShowList) do
		if(showVo.heroVo and showVo.heroVo.id == heroVo.id) then
			isSelect = true
			break
		end
	end
	self:__setSelectState(isSelect)
end

function onClickItemHandler(self)
	local manager = self:getManager()
	local tempShowVo = nil
	local heroVo = self.data
	local selectState = self:__getSelectState()
	if(selectState) then 	--取消
		tempShowVo = self:__getShowVo(heroVo)
		-- self:__setSelectState(false)
		local delHeroVo = tempShowVo.heroVo
		tempShowVo.heroVo = nil
		-- 派发更新模型
		manager:dispatchEvent(manager.PREP_FIGHT_SELECT_TEMP_CHANGE, {isSelect = false, tempShowVo = tempShowVo, changeHeroVo = delHeroVo})
	else 					--选中
		tempShowVo = self:__getEmptyShowVo()
		if(tempShowVo) then
			-- self:__setSelectState(true)
			local addHeroVo = heroVo
			tempShowVo.heroVo = heroVo
			-- 派发更新模型
			manager:dispatchEvent(manager.PREP_FIGHT_SELECT_TEMP_CHANGE, {isSelect = true, tempShowVo = tempShowVo, changeHeroVo = addHeroVo})
		else
			gs.Message.Show("队伍人数已达上限")
		end
	end
end

function __getShowVo(self, heroVo)
	local tempShowList = self:getManager():getTempShowList()
	for _, showVo in pairs(tempShowList) do
		if(showVo.heroVo ~= nil and showVo.heroVo.id == heroVo.id) then
			return showVo
		end
	end
	return nil
end

function __getEmptyShowVo(self)
	local index = nil
	local tempShowVo = nil
	local isAttackerSetting = self:getManager():getIsAttackerSetting()
	local tempShowList = self:getManager():getTempShowList()
	for _, showVo in pairs(tempShowList) do
		if(showVo.isAttacker == isAttackerSetting and showVo.heroVo == nil) then
			if(index == nil) then
				index = showVo.index
				tempShowVo = showVo
			elseif(showVo.index <= index) then
				index = showVo.index
				tempShowVo = showVo
			end
		end
	end
	return tempShowVo
end

function __setSelectState(self, isSelect)
	if(self.isSelect == nil) then
		self.isSelect = false
	end
	if(self.isSelect ~= isSelect) then
		self.isSelect = isSelect
	end
	if(self.isSelect) then
		self.selectImg.gameObject:SetActive(true)
	else
		self.selectImg.gameObject:SetActive(false)
	end
end

function __getSelectState(self)
	if(self.isSelect == nil) then
		self.isSelect = false
	end
	return self.isSelect
end

------------------------------------------------------子类必须实现方法------------------------------------------------------
function getManager(self)
	return nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
