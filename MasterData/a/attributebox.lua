---@class AttributeBox : AttributeBox_Generate
---##################### 【AttributeBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AttributeBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AttributeBox = require "AttributeBox_Generate"

function AttributeBox:InitLogic(data)
    
end

---设置 mono 对象引用
---@param mono table 父节点对象
function AttributeBox:setMono(mono)
    self.mono = mono
end

---武器装备词条框通用逻辑
---@class BoxData
---@field boxType integer 词条框类型
---@field attrData table  词条数据
---@field boxIndex integer 词条框索引
---@field weaponConfig table?  武器配置
---@field weaponData table?  武器数据
---@field oldAttrList table?  目前装备中对应六维数据
---@param boxData BoxData
function AttributeBox:setAttrBoxData(boxData)
    local boxType = boxData.boxType
	local attrData = boxData.attrData
	local index = boxData.boxIndex
	if boxType == GE.ItemTypeIndex.weapon then--武器词条
		local weaponConfig = boxData.weaponConfig
		local weaponData = boxData.weaponData
		if attrData then
			self.attrTxt.text.text = attrData.name
			if attrData.valueType == GE.WeaponEntryAttrType.integer then--数值
				self.msgNumTxt.text.text = attrData.value
			elseif attrData.valueType == GE.WeaponEntryAttrType.percentage then--百分比
				self.msgNumTxt.text.text = attrData.value.."%"
			elseif attrData.valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
				self.gameObject:SetActive(false)
				return
			end
			self.mono:LoadSpriteAsync(string.format(Config.SpritePath.AttributeIcon, attrData.type), self.attrIcon.image)
			if attrData.isSpecial then
				self.msgNumTxt.text.color = Color.NewFromStr("FF8019")
			elseif attrData.isMax then
				self.msgNumTxt.text.color = Color.NewFromStr("1b8ae6")
			else
				self.msgNumTxt.text.color = Color.NewFromStr("494949")
			end
			self.icon:SetActive(false)
			if attrData.valueType ~= GE.WeaponEntryAttrType.specialSkill then
                self.icon:SetActive(attrData.compare == 1 or attrData.compare == 2)
                self.upIcon:SetActive(attrData.compare == 1)
                self.downIcon:SetActive(attrData.compare == 2)
            end
		else
			if index == #weaponConfig.entryUnlock then
				if weaponData.level == weaponConfig.levelMax then
					self.gameObject:SetActive(false)
				end
				self.unlockText.text.text = string.format("强化+%s时上限突破", weaponConfig.entryUnlock[index])
			else
				self.unlockText.text.text = string.format("强化+%s时解锁", weaponConfig.entryUnlock[index])
			end
		end
	
		self.showAttr:SetActive(attrData and true or false)
		self.lockedAttr:SetActive(not attrData and true or false)
	elseif boxType == GE.ItemTypeIndex.equip then--装备词条
		local oldAttrList = boxData.oldAttrList
		self.gameObject:SetActive(attrData.value ~= 0)
		self.attrTxt.text.text = LocalStrEnum["NatureType_"..attrData.type]
		self.msgNumTxt.text.text = math.ceil(attrData.value)
		
		-- 设置颜色
		if attrData.isMax then
			self.msgNumTxt.text.color = Color.NewFromStr("1b8ae6")
		else
			self.msgNumTxt.text.color = Color.NewFromStr("494949")
		end
		
		if oldAttrList and next(oldAttrList) then       --当前有装备数据
			self.icon:SetActive(oldAttrList[index].value ~= attrData.value)
			self.upIcon:SetActive(oldAttrList[index].value < attrData.value)
			self.downIcon:SetActive(oldAttrList[index].value > attrData.value)
			-- self.changeValueTxt:SetActive(oldAttrList[index].value ~= attrData.value)
			-- if oldAttrList[index].value > attrData.value then
			-- 	self.changeValueTxt.text.text = "<color=#D15151>"..math.ceil(oldAttrList[index].value - attrData.value).."</color>"
			-- else
			-- 	self.changeValueTxt.text.text = "<color=#46B152>"..math.ceil(attrData.value - oldAttrList[index].value).."</color>"
			-- end
		elseif oldAttrList == nil then
			self.icon:SetActive(false)
			self.upIcon:SetActive(false)
			self.downIcon:SetActive(false)
		else
			self.icon:SetActive(true)
			self.upIcon:SetActive(true)
			self.downIcon:SetActive(false)
		end
		if attrData.type ~= 99 then
			self.mono:LoadSpriteAsync(string.format(Config.SpritePath.AttributeIcon, attrData.type), self.attrIcon.image)
		end
	end
end

--播放升级动画
---@param attrData table 升级数据
function AttributeBox:playLevelUpAnim(attrData)
	if not attrData then
		return
	end
	if not attrData.value then
		return
	end
	if attrData.valueType == GE.WeaponEntryAttrType.integer then--数值
		if self.msgNumTxt.text.text == tostring(attrData.value) then
			return
		end
	elseif attrData.valueType == GE.WeaponEntryAttrType.percentage then--百分比
		if self.msgNumTxt.text.text == attrData.value.."%" then
			return
		end
	end
	
	self.effect.animOverCallBack:SetCallBack(function()
		self.effect:SetActive(false)
	end)
	self.effect:SetActive(true)
end

--function AttributeBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

return AttributeBox
