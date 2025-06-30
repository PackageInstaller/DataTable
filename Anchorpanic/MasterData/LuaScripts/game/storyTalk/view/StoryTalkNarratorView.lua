module('storyTalk.StoryTalkNarratorView', Class.impl('lib.component.BaseNode'))
local MSG_INTERVAL = 3
function initData(self, rootGo, rootPanel)
    super.initData(self, rootGo)
    self.m_rootPanel = rootPanel
    self.m_narratorContentRTrans = self:getChildGO('NarratorContent'):GetComponent(ty.RectTransform)
    self.m_narratorCellInterval = self.m_narratorContentRTrans:GetComponent(ty.VerticalLayoutGroup).spacing
    self.m_minContentSize = self.m_narratorContentRTrans.sizeDelta
    self.m_centerTxt = self:getChildGO('CenterTxt'):GetComponent(ty.Text)
    self.m_subTxt = self:getChildGO('SubTxt'):GetComponent(ty.Text)
    self.m_narratorMsgCell = {}
    self.m_talkIDHistory = {}

    self.m_talkDatas = nil

    self.m_totalH = 0

    self.m_curTalkID = nil

    -- self:addOnClick(rootGo, self.onClickBg)
end

function onClickBg(self)
    local td = self.m_talkDatas[self.m_curTalkID]
    if td then
        -- 旁白处理
        if td.talker_type==2 then
            self:addTalkID(self.m_curTalkID)
            self.m_curTalkID = td.next_id
            -- LoopManager:setTimeout(1.5, self, self.onClickBg)
            return    
        end

        --退出旁白
        self.m_rootPanel.m_curTalkID = self.m_curTalkID
        self:close()
        self.m_rootPanel:runTalk()
    else
        -- 退出剧情
        GameDispatcher:dispatchEvent(EventName.CLOSE_STORY_TALK_PANEL)
    end
end

-- 设置本组的对话数据
function setTalkDatas(self, talkDatas, talkID)
    -- print("setTalkDatas ======", talkID)
    self.m_talkDatas = talkDatas
    self.m_curTalkID = talkID
    self.m_centerTxt.text = ""
    self.m_subTxt.text = ""
    -- self:addTalkID(self.m_curTalkID)
    local function _lazyCall()
        self.m_lazySn = 0
        self:onClickBg()
    end
    LoopManager:clearTimeout(self.m_lazySn)
    self.m_lazySn = LoopManager:setTimeout(1, self, _lazyCall)
end

-- 添加出现过的对话ID
function addTalkID(self, talkID)
    for _,v in ipairs(self.m_talkIDHistory) do
        if v==talkID then
            return
        end
    end
    table.insert(self.m_talkIDHistory, talkID)

    if not table.empty(self.m_narratorMsgCell) then
        for _,v in ipairs(self.m_narratorMsgCell) do
            v:destroy()
        end
        self.m_narratorMsgCell = {}
    end
    self.m_totalH = 0

    local td = self.m_talkDatas[talkID]
    if td then
        LoopManager:clearTimeout(self.m_timeoutSn)
        self.m_timeoutSn = 0
        local playername = role.RoleManager:getRoleVo():getPlayerName() or " "
        local msgContext = string.gsub(td.msg,_TT(72202),playername)
        if td.aside and #td.aside>0 then
            self.m_subTxt.text = td.aside
        else
            self.m_subTxt.text = ""
        end
        if td.msg_type==3 then
            local msgArr = string.split(msgContext, ";")
            if not msgArr or #msgArr<=1 then
                self.m_centerTxt.text = msgContext
                -- self.m_centerTxt.gameObject:SetActive(true)
                self.m_centerTxt:DOFade(0,0)
                self.m_centerTxt:DOFade(1,0.8)

                -- self.m_subTxt.gameObject:SetActive(true)
                self.m_subTxt:DOFade(0,0)
                self.m_subTxt:DOFade(1,0.8)

                self.m_timeoutSn = LoopManager:setTimeout(MSG_INTERVAL, self, self.onClickBg)
            else
                self.m_centerTxt.text = ""
                -- self.m_centerTxt.gameObject:SetActive(false)
                -- self.m_subTxt.gameObject:SetActive(false)
                local function _setMsg()
                    self:addMsg(msgArr[1])
                    table.remove(msgArr, 1)
                    if not table.empty(msgArr) then
                        self.m_timeoutSn = LoopManager:setTimeout(MSG_INTERVAL, nil, _setMsg)
                    else
                        -- self.m_subTxt.gameObject:SetActive(true)
                        self.m_subTxt:DOFade(0,0)
                        self.m_subTxt:DOFade(1,0.8)
                        self.m_timeoutSn = LoopManager:setTimeout(MSG_INTERVAL+0.8, self, self.onClickBg)
                    end
                end
                _setMsg()
            end
        else
            self.m_centerTxt.text = msgContext
            -- self.m_centerTxt.gameObject:SetActive(true)
            self.m_centerTxt:DOFade(0,0)
            self.m_centerTxt:DOFade(1,0.8)

            -- self.m_subTxt.gameObject:SetActive(true)
            self.m_subTxt:DOFade(0,0)
            self.m_subTxt:DOFade(1,0.8)
            self.m_timeoutSn = LoopManager:setTimeout(MSG_INTERVAL, self, self.onClickBg)
        end
    end
end

function addMsg(self, msg)
    local msgCell = storyTalk.StoryMsgCell.new()
    msgCell:setup(UrlManager:getUIPrefabPath("storyTalk/StoryNarratorCell.prefab"))
    msgCell:addOnParent(self.m_narratorContentRTrans)
    self.m_totalH = self.m_totalH+msgCell:setTxt(msg, 0.5)+self.m_narratorCellInterval
    table.insert(self.m_narratorMsgCell, msgCell)

    if self.m_totalH > self.m_minContentSize.y then
        gs.TransQuick:SizeDelta(self.m_narratorContentRTrans, self.m_minContentSize.x, self.m_totalH)
        local offsetY = self.m_totalH - self.m_minContentSize.y
        gs.TransQuick:UIPos(self.m_narratorContentRTrans, 0, offsetY)
    end
end

function close(self)
    LoopManager:clearTimeout(self.m_lazySn)
    self.m_lazySn = 0
    LoopManager:clearTimeout(self.m_timeoutSn)
    self.m_timeoutSn = 0
    self:setActive(false)
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(72202):	"玩家名字"
]]
