module("formation.FormationArenaAttackPanel", Class.impl(formation.FormationPanel))

function configUI(self)
    super.configUI(self)
    
    self.mBtnControl:SetActive(false)
    self:getChildGO("mBtnFuncTips"):SetActive(false)

    self.mBtnSave = self:getChildGO('mBtnSave')
    self.mBtnSave:SetActive(true)
end

function initViewText(self)
    super.initViewText(self)
    self.m_textTitle.text = _TT(1243)
    self:setBtnLabel(self.mBtnSave, nil, _TT(173))
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnSave, self.__onClickBtnControlHandler)
end

-- 玩家点击关闭
function onClickClose(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
    if(#formationHeroList <= 0)then
        gs.Message.Show(_TT(1214)) -- 出战队列不可为空
        super.onClickClose(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
        UIFactory:alertMessge(_TT(171), true, function()
            self:__onClickBtnControlHandler()
            super.onClickClose(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        end, _TT(1), nil, true, function()
            super.onClickClose(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        end, _TT(2), _TT(5), nil)
    else
        super.onClickClose(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
    end
end

-- 玩家关闭所有窗口的c#回调
function closeAll(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
    if(#formationHeroList <= 0)then
        gs.Message.Show(_TT(1214)) -- 出战队列不可为空
        super.closeAll(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
        UIFactory:alertMessge(_TT(171), true, function()
            self:__onClickBtnControlHandler()
            super.closeAll(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
        end, _TT(1), nil, true, function()
            super.closeAll(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
        end, _TT(2), _TT(5), nil)
    else
        super.closeAll(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    end
end

function __playerClose(self)
    self:recoverHeadItems()
    self:initData()
    -- -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
    -- self:rsyncFormationList(true)
    self:getManager():setSelectFormationTeamId(nil)
    
    self:getManager():clearSelectHeroDic()
    self:getManager():clearSelectAssistHeroDic()
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
    if(#formationHeroList <= 0)then
        gs.Message.Show(_TT(1214)) -- 出战队列不可为空
    elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) == false then
        gs.Message.Show(_TT(172)) -- 暂无可保存的队伍
    else
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, { })
    end
end

--  获取背景图路径
function __getBgURL(self)
    return UrlManager:getBgPath("formation/formation_defence_bg.jpg")
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1243):	"进攻队伍总战力"
]]
