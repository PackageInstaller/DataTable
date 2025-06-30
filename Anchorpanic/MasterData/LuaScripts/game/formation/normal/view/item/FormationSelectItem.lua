--[[ 
-----------------------------------------------------
@filename       : FormationSelectItem
@Description    : 阵型-选择项
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationSelectItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
	self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
	self.mImgLock = self:getChildGO("mImgLock")
	self.mTxtLock = self:getChildGO("mTxtLock"):GetComponent(ty.Text)
	self.mTween = self.UIObject:GetComponent(ty.UIDoTween)
	self:addOnClick(self.UIObject, self.onClickItemHandler)
end

function getGuideTrans(self)
    return self.UITrans
end

function active(self)
	self.mTween.enabled = not self.data.isInit
end

function setData(self, param)
    super.setData(self, param)
	local selectVo = self.data
	local showTeamId = selectVo:getDataVo().showTeamId
	local formationConfigVo = selectVo:getDataVo().formationConfigVo
	local manager = selectVo:getDataVo().manager
	local needLvl = formationConfigVo:getLimit()
	local playerLvl = role.RoleManager:getRoleVo():getPlayerLvl()
	if(playerLvl >= needLvl)then
		if(formationConfigVo:getDupId() > 0)then
			local isPass = battleMap.MainMapManager:isStagePass(formationConfigVo:getDupId())
			if(isPass)then
				self.mImgLock:SetActive(false)
			else
                local stageVo = battleMap.MainMapManager:getStageVo(formationConfigVo:getDupId())
				self.mTxtLock.text = string.format(_TT(1384), stageVo.indexName, stageVo:getName()) -- 通关%s解锁
				self.mImgLock:SetActive(true)
			end
		else
			self.mImgLock:SetActive(false)
		end
	else
		self.mTxtLock.text = string.format(_TT(1154), needLvl) --"指挥官%s级解锁"
		self.mImgLock:SetActive(true)
	end
	self.mImgIcon:SetImg(UrlManager:getPackPath(string.format("formation5/formation_mini_icon_%s.png", formationConfigVo:getRefID())), true)
end

function onClickItemHandler(self)
	local selectVo = self.data
	local showTeamId = selectVo:getDataVo().showTeamId
	local formationConfigVo = selectVo:getDataVo().formationConfigVo
	local manager = selectVo:getDataVo().manager
	
	local needLvl = formationConfigVo:getLimit()
	local playerLvl = role.RoleManager:getRoleVo():getPlayerLvl()
	if(playerLvl >= needLvl)then
		if(formationConfigVo:getDupId() > 0)then
			local isPass = battleMap.MainMapManager:isStagePass(formationConfigVo:getDupId())
			if(isPass)then
				manager:dispatchEvent(manager.HERO_FORMATION_SEE, {formationId = formationConfigVo:getRefID()})
			else
                local stageVo = battleMap.MainMapManager:getStageVo(formationConfigVo:getDupId())
				gs.Message.Show(string.format(_TT(1151), stageVo.indexName, stageVo:getName())) -- 通关%s解锁
			end
		else
			manager:dispatchEvent(manager.HERO_FORMATION_SEE, {formationId = formationConfigVo:getRefID()})
		end
	else
		gs.Message.Show(string.format(_TT(1152), needLvl)) -- 指挥官等级达到%s级解锁
	end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1271):	"当前阵型"
]]
