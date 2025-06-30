module("arena.ArenaItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

	self.m_headNode = self:getChildGO("HeadNode").transform
    self.m_imgCost = self:getChildGO("ImgMoney"):GetComponent(ty.AutoRefImage)
	self.m_textCost = self:getChildGO("TextMoney"):GetComponent(ty.Text)
	self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
	self.m_textFightNum = self:getChildGO("TextFightNum"):GetComponent(ty.Text)
	self.m_textScore = self:getChildGO("TextScore"):GetComponent(ty.Text)

	self.m_btnChallenge = self:getChildGO("BtnChallenge")
    self:addOnClick(self.m_btnChallenge, self.__onClickChallengeHandler)
end

function setData(self, param)
    super.setData(self, param)

    local arenaEnemyVo = self.data

	if (not self.m_playerHeadGrid) then
		self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
	end
	self.m_playerHeadGrid:setData(arenaEnemyVo.avatar)
	self.m_playerHeadGrid:setParent(self.m_headNode)
	self.m_playerHeadGrid:setScale(1)
    self.m_playerHeadGrid:setLvl(arenaEnemyVo.lvl)
    self.m_playerHeadGrid:setClickEnable(true)
    self.m_playerHeadGrid:setCallBack(self, self.__onClickHeadHandler)

    local freeTimes = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_FREE_TIMES)
    local costTid = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_TID)
    local costCount = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_COUNT)
    if(arena.ArenaManager.remainChallengeTimes > 0)then
        self.m_textCost.text = _TT(62216)
        self.m_imgCost:SetImg(UrlManager:getPropsIconUrl(costTid), false)
    else
        if(bag.BagManager:getPropsCountByTid(costTid) >= costCount)then
            self.m_textCost.text = "x"..costCount
        else
            self.m_textCost.text = HtmlUtil:color("x"..costCount, ColorUtil.RED_NUM)
        end
        
        self.m_imgCost:SetImg(UrlManager:getPropsIconUrl(costTid), false)
    end
	self.mTxtName.text = arenaEnemyVo.name
	self.m_textFightNum.text = _TT(62217, arenaEnemyVo.fightNum)--"战力".. arenaEnemyVo.fightNum
	self.m_textScore.text = _TT(62218, arenaEnemyVo.score)--"积分".. arenaEnemyVo.score
end

function __onClickHeadHandler(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_ENEMY_DEFENSE_PANEL, {playerId = self.data.playerId})
end

function __onClickChallengeHandler(self, args)
    if(arena.ArenaManager.remainChallengeTimes > 0)then
        self:__sendChallenge()
    else
        local costTid = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_TID)
        local costCount = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_COUNT)
        local judgeType = shop.ShopManager:getPropsJudgeType(costTid, costCount)
        if (judgeType == shop.PropsJudge.PROPS_ENOUGH) then
            self:__sendChallenge()
        elseif (judgeType ~= shop.PropsJudge.MONEY_ENOUGH and judgeType ~= shop.PropsJudge.MONEY_NOT_ENOUGH) then
            gs.Message.Show(_TT(62219))
        end
    end
end

-- 发送挑战
function __sendChallenge(self)
    local arenaEnemyVo = self.data
    formation.checkFormationFight(PreFightBattleType.ArenaChallenge, nil, arenaEnemyVo.playerId, nil, nil, nil)
end

function deActive(self)
    super.deActive(self)

    if (self.m_playerHeadGrid) then
        self.m_playerHeadGrid:poolRecover()
        self.m_playerHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(62219):	"道具不足"
	语言包: _TT(62216):	"免费"
]]
