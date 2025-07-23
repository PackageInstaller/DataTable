module("formation.FormationElementPanel", Class.impl(formation.FormationPanel))

function initData(self)
    super.initData(self)
end

function configUI(self)
	super.configUI(self)
    self.mTxt1 = self:getChildGO("mTxt_1"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.closeAll, self)
    self.mRecommandLv:SetActive(false)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.closeAll, self)
end

function initViewText(self)
    super.initViewText(self)
    self.mTxt1.text = "上阵要求"
end

function getDupVo(self)
    local dupId = self:getManager():getData().dupId
    local dupVo = dup.DupClimbTowerManager:getDeepDupVo(dupId)
    return dupVo
end

function getIsFullOfCondition(self)
	local dupId = self:getManager():getData().dupId
	local dupVo = dup.DupClimbTowerManager:getDeepDupVo(dupId)
	local teamHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
	local eleTypeList = dupVo.eleType
	local eleTypeNum = dupVo.eleTypeNum
	for k,v in pairs(eleTypeList) do
		local nowNum = 0 
		for m,n in pairs(teamHeroList) do
			local heroVo = hero.HeroManager:getHeroVo(n.heroId)
			if(heroVo.eleType == v) then 
				nowNum = nowNum + 1
			end
		end
		if(eleTypeNum[k] ~= nil and eleTypeNum[k] > nowNum) then 
			return false
		end
	end
	return true
end

function __updateFightPowerView(self, cusInit)
    local dupId = self:getManager():getData().dupId
    local dupVo = dup.DupClimbTowerManager:getDeepDupVo(dupId)
    local eleTypeList = dupVo.eleType
	local eleTypeNum = dupVo.eleTypeNum

    -- local recommandFight = self:getManager():getRecommandFight()
    -- if (recommandFight == nil or recommandFight <= 0) then
    --     self.mRecommandFight:SetActive(false)
    -- else

    local text = ""
    for i = 1, #eleTypeList do 
        local count = eleTypeNum[i]
        if(i ~= 0 and count ~= nil) then 
            local color, name = hero.getHeroTypeName(eleTypeList[i])
            text = text .. _TT(24516, name, count)
            --text = text .. string.substitute("至少{0}名{1}\n", count, name)
        end
    end
    self.mTxtRecommandFight.text = text
    self.mRecommandFight:SetActive(text ~= "")

    local color = not self:getIsFullOfCondition() and gs.ColorUtil.GetColor("E36C77ff") or gs.ColorUtil.GetColor("489E4Eff")
    self.mRecommandBg.color = color
    self.mTxtRecommandFight.color = color
    -- end
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
	local dupId = self:getManager():getData().dupId
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
            self:onClickBtnControlHandler()
        end
        local dupId = self:getManager():getData().dupId
        local dupVo = dup.DupClimbTowerManager:getDeepDupVo(dupId)
        local areaMsgVo = dup.DupClimbTowerManager:getDeepDetail(dupVo.areaId)
        if(areaMsgVo.times <= 0) then 
            gs.Message.Show("剩余挑战次数不足")
        elseif(not self:getIsFullOfCondition()) then 
            gs.Message.Show("出战队员不符合要求")
        else
            run()
        end
    end
end

function onClickBtnControlHandler(self)
    -- 可能会有援助的怪物，必要同步
    self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
    -- 设置出战队列
    self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {teamId = self.m_teamId})
    -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
    self:forceClose()
    -- 回调外部
    self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
    -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
    self:rsyncFormationList(true)
    dup.DupClimbTowerManager.isInElementFight = true
end

return _M