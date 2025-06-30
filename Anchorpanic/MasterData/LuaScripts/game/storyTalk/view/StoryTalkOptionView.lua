module('storyTalk.StoryTalkOptionView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)

    self.mTalkDatas = {}
    self.mUsedIDs = {} -- 已经使用过的Id

    self.mChooseItem = {}
    self.mChooseItemTxt = {}
    for i = 1, 4 do
        self.mChooseItem[i] = self:getChildGO("Choose" .. i)
        self.mChooseItemTxt[i] = self:getChildGO(string.format("Choose%dTxt", i)):GetComponent(ty.Text)
    end

    self.lastList = {}
    self.mGroup = self:getChildTrans('Group')
    self.mIsActive = false
end

-- 关闭窗口
function close(self)
    for _, v in ipairs(self.mChooseItem) do
        v:SetActive(false)
        self:removeOnClick(v)
    end
    self:setActive(false)
    self.mIsActive = false
end

function isActive(self)
    return (self.mIsActive == true)
end

-- 设置回调
function setResultCall(self, call)
    self.mChooseResultCall = call
end

-- 按钮被点击 索引
function onChooseClick(self, id)
    if self.mChooseResultCall then
        local curData = self.mTalkDatas[id]
        self:close()
        -- if curData and curData.next_id == -1 and #curData.abreast_id > 0 then
        --     --self.mChooseResultCall(id, id)
        -- else
        self.mChooseResultCall(id, curData.next_id)
        --end

        -- if curData and curData.next_id then

        -- end
    end
end

-- 设置剧情内容
function setTalkDatas(self, talkDatas)
    self.mTalkDatas = talkDatas
    self.mUsedIDs = {}
end

function open(self, optData)
    self.mLastId = optData["lastId"]
    self.mAbreastList = optData["abreastList"]

    for i = 1, #self.mChooseItem do
        self.mChooseItem[i]:SetActive(false)
    end
    self:setActive(true)
    self.mRetToLast = true

    for i, talkID in pairs(self.mAbreastList) do
        local curData = self.mTalkDatas[talkID]
        if curData and self.mChooseItem[i] then
            self.mChooseItemTxt[i].text = curData.msg

            -- self.mChooseItemTxt[i].color = (self.mAbreastList and table.indexof01(self.mAbreastList, talkID) > 0) and
            -- gs.ColorUtil.GetColor("BCBDBDFF") or gs.ColorUtil.GetColor("FFFFFFFF")

            self.mChooseItem[i]:SetActive(true)

            -- 是否可以到最后结果
            -- self.mRetToLast =  self.mRetToLast and (self.mAbreastList and table.indexof01(self.mAbreastList, talkID) > 0)
            self:addOnClick(self.mChooseItem[i], self.onChooseClick, nil, talkID)
        end
    end
    self.mIsActive = true
end

return _M
