module('storyTalk.StoryTalkHistoryView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.mScrollRect = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mTalkIDHistory = {}
    self.mTalkDatas = nil

    self.mHistoryTxt = self:getChildGO("mHistoryTxt"):GetComponent(ty.Text)
    self.mHistoryHideBtn = self:getChildGO("mHistoryHideBtn")
    self:addOnClick(self.mHistoryHideBtn, self.onHistoryHideClick)
end

function setCloseCall(self, call)
    self.closeCall = call
end

-- 历史回顾隐藏
function onHistoryHideClick(self)
    self:setActive(false)
    if self.closeCall then
        self.closeCall()
    end
end

-- 设置本组的对话数据
function setTalkDatas(self, talkDatas)
    self.mTalkDatas = talkDatas
end

-- 添加出现过的对话ID
function addTalkID(self, talkID)
    for _, v in ipairs(self.mTalkIDHistory) do
        if v == talkID then
            return
        end
    end
    table.insert(self.mTalkIDHistory, talkID)
end

function open(self)
    self:setActive(true)

    if not self.mTalkDatas then
        return
    end

    local string = ""
    for _, talkID in ipairs(self.mTalkIDHistory) do
        local td = self.mTalkDatas[talkID]
        if td then
            if #td.talker > 0 then
                local playerName = role.RoleManager:getRoleVo():getPlayerName() or _TT(72202)
                local showTxt = string.gsub(td.talker, _TT(72202), playerName)
                string = string .. showTxt .. "："
            end
            if #td.msg > 0 then
                local playerName = role.RoleManager:getRoleVo():getPlayerName() or _TT(72202)
                local msgContext = string.gsub(td.msg, _TT(72202), playerName)

                if td.talker == "" then
                    string = string .. "<color=#82898C>" .. msgContext .. "</color>" .. "\n"
                else
                    string = string .. "<color=#FFFFFF>" .. msgContext .. "</color>" .. "\n"
                end
            end
        end
    end

    self.mHistoryTxt.text = string
    gs.Canvas.ForceUpdateCanvases()

    self.mScrollRect.content:GetComponent(ty.ContentSizeFitter):SetLayoutVertical()
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mScrollRect.content)

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mScrollRect.gameObject.transform)
    gs.Canvas.ForceUpdateCanvases()

    self.mScrollRect.verticalNormalizedPosition = 0

    local function callback()
        gs.Canvas.ForceUpdateCanvases()
        self.mScrollRect.verticalNormalizedPosition = 0
    end

    self.callbackSn = LoopManager:addFrame(3, 1, self, callback)
end

function close(self)
    if (self.callbackSn) then
        LoopManager:removeFrameByIndex(self.callbackSn)
        self.callbackSn = nil
    end

    self:setActive(false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(72202):	"玩家名字"
]]
