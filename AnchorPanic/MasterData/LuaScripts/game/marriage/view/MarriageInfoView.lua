--[[
-----------------------------------------------------
@filename       : MarriageInfoView
@Description    : 结婚详情界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("marriage.MarriageInfoView", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("marriage/MarriageInfoView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowCloseAll = 0
escapeClose = 0

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(152003))
    self:setSize(0, 0)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mColorItemList = {}
    self.mDragInfo = {}

    self.preDragPos = gs.VEC3_ZERO
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mIconHero = self:getChildGO("mIconHero"):GetComponent(ty.AutoRefImage)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtHeroNameTips = self:getChildGO("mTxtHeroNameTips"):GetComponent(ty.Text)
    self.mTxtRoleName = self:getChildGO("mTxtRoleName"):GetComponent(ty.Text)
    self.mTxtRoleNameTips = self:getChildGO("mTxtRoleNameTips"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtTimeTips = self:getChildGO("mTxtTimeTips"):GetComponent(ty.Text)

    self.mFirstShow = self:getChildGO("mFirstShow")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mBtnStory = self:getChildGO("mBtnStory")
    self.mTxtStory = self:getChildGO("mTxtStory"):GetComponent(ty.Text)
    self.mTxtSign = self:getChildGO("mTxtSign"):GetComponent(ty.Text)

    self.mSignContent = self:getChildTrans("mSignContent")
    self.mColorItem = self:getChildGO("mColorItem")

    self.mSignInfo = self:getChildGO("mSignInfo")
    self.mBtnRes = self:getChildGO("mBtnRes")
    self.mBtnAgree = self:getChildGO("mBtnAgree")

    self.mTxtRes = self:getChildGO("mTxtRes"):GetComponent(ty.Text)
    self.mTxtAgree = self:getChildGO("mTxtAgree"):GetComponent(ty.Text)

    self.mAnim = self.UIObject:GetComponent(ty.Animator)
    self.mBtnSign = self:getChildGO("mBtnSign")

    self.mTimerInfo = self:getChildGO("mTimerInfo")

    self.mBtnAudio = self:getChildGO("mBtnAudio")
end

function initViewText(self)
    self.mTxtHeroNameTips.text = _TT(152004)
    self.mTxtRoleNameTips.text = _TT(152005)
    self.mTxtTimeTips.text = _TT(152023)
    self.mTxtStory.text = _TT(152006)
    self.mTxtSign.text = _TT(152007)
    self.mTxtRes.text = _TT(152008)
    self.mTxtAgree.text = _TT(152009)
    self.mTxtTips.text = _TT(152010)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.heroId = args.heroId
    self.isFirst = args.isFirst
    AudioManager:playMusicById(85, true)
    self.mBtnSign:SetActive(false)
    GameDispatcher:addEventListener(EventName.UPDATE_SAVE_MARRIAGE_SIGNPOS_SUCCESS, self.updateSingPos, self)
    self.heroVo = hero.HeroManager:getHeroVo(self.heroId)
    self.favorableData = favorable.FavorableManager:getHeroFavorableData(self.heroVo.tid)
    self.mTimerInfo:SetActive(not self.isFirst)

    self.base_childGos["mGroupTop"]:SetActive(not self.isFirst)
    self.mBtnAudio:SetActive(not self.isFirst)

    if self.isFirst then
        -- storyTalk.StoryTalkCondition:setAlwayCallback(function()

        -- end)
        -- storyTalk.StoryTalkManager:setCurStoryID(self.favorableData.promiseStoryId)
        -- GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
        self.mAnim:SetTrigger("enter")
        self.mBtnSign:SetActive(true)
    else
        self:resShowSignPos(self.heroVo.signPos)
        self.mAnim:SetTrigger("firstenter")
    end
    MoneyManager:setMoneyTidList({})
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SAVE_MARRIAGE_SIGNPOS_SUCCESS, self.updateSingPos, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

function updateSingPos(self)
    GameDispatcher:dispatchEvent(EventName.REQ_MARRIAGE_HERO, {
        heroId = self.heroId
    })
    self.mSignInfo:SetActive(false)
    self.heroVo = hero.HeroManager:getHeroVo(self.heroId)
    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_4(self.heroVo.promiseTime)
    self.mTimerInfo:SetActive(true)
end
-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnStory, self.onClickStory)

    self:addUIEvent(self.mBtnRes, self.onClickRes)
    self:addUIEvent(self.mBtnAgree, self.onClickAgree)

    self:addUIEvent(self.mBtnSign, self.onClickSign)
    self:addUIEvent(self.mBtnAudio, self.onClickSAudio)

end

function onClickSAudio(self)
    AudioManager:playHeroCVOnReplace(self.favorableData.promiseCv)
end

function onClickSign(self)
    self.mBtnSign:SetActive(false)
    self.mAnim:SetTrigger("open")

    self.isSign = true
    self.signSn = LoopManager:addFrame(0, 0, self, self.updateSign)
end

function onClickRes(self)
    for i = 1, #self.mColorItemList, 1 do
        self.mColorItemList[i]:getChildGO("mIsSelect"):SetActive(false)
    end
    self.mDragInfo = {}
end

function packList(self, list)

    local len = #list
    local packed = string.char(len % 256, math.floor(len / 256))

    for i = 1, len do
        local num = list[i]
        packed = packed .. string.char(num % 256, math.floor(num / 256))
    end
    return packed
end

function unpackList(self, string)
    local len = string.byte(string, 1) + string.byte(string, 2) * 256
    local list = {}
    local pos = 3
    for i = 1, len do
        local low = string.byte(string, pos)
        local high = string.byte(string, pos + 1)
        list[i] = low + high * 256
        pos = pos + 2
    end
    return list
end

function onClickAgree(self)
    if #self.mDragInfo == 0 then
        gs.Message.Show(_TT(152024))
        return
    end

    self.mAnim:SetTrigger("close")

    self.isSign = false
    LoopManager:removeFrameByIndex(self.signSn)

    marriage.MarriageManager:setMarriageHeroId(self.heroId)
    local s = self:packList(self.mDragInfo)

    AudioManager:playHeroCVOnReplace(self.favorableData.promiseCv)
    GameDispatcher:dispatchEvent(EventName.REQ_SAVE_MARRIAGE_SIGNPOS, {
        heroId = self.heroId,
        signPos = self:base64Encode(s)
    })
    self.base_childGos["mGroupTop"]:SetActive(true)
end

function resShowSignPos(self, signPos)
    local s = self:base64Decode(signPos)
    local list = self:unpackList(s)
    self.mDragInfo = list
end

-- base64编码
function base64Encode(self, data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do
            r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0')
        end
        return r;
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then
            return ''
        end
        local c = 0
        for i = 1, 6 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
        end
        return b:sub(c + 1, c + 1)
    end) .. ({'', '==', '='})[#data % 3 + 1])
end

-- base64解码
function base64Decode(self, data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then
            return ''
        end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do
            r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0')
        end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then
            return ''
        end
        local c = 0
        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0)
        end
        return string.char(c)
    end))
end

function onClickStory(self)
    storyTalk.StoryTalkManager:setCurStoryID(self.favorableData.promiseStoryId)
    GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
end

function showPanel(self)

    self.mFirstShow:SetActive(self.isFirst)
    self.mBtnStory:SetActive(false)

    self.mTxtHeroName.text = self.heroVo.name

    local roleVo = role.RoleManager:getRoleVo()
    self.mTxtRoleName.text = roleVo:getPlayerName()

    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_4(self.heroVo.promiseTime)

    for i = 1, 800 do
        -- table.insert(self.mDragInfo, i) 测试全格子涂满
        local colorItem = SimpleInsItem:create(self.mColorItem, self.mSignContent, "mColorItem")
        colorItem:getChildGO("mIsSelect"):SetActive(table.indexof01(self.mDragInfo, i) > 0)
        colorItem.m_go.gameObject.name = "colorItem" .. i
        table.insert(self.mColorItemList, colorItem)
    end

end

function updateSign(self)
    if gs.Input.GetMouseButtonDown(0) then
        self.isDrag = true
    elseif gs.Input.GetMouseButtonUp(0) then
        self.isDrag = false
        self.preDragPos = gs.VEC3_ZERO
    end

    if self.isDrag and self.isSign then
        local mousePos = gs.Input.mousePosition
        local v3 = gs.Vector3(mousePos.x, mousePos.y, 0)
        if self.preDragPos == gs.VEC3_ZERO then
            self.preDragPos = v3
        end

        local dis = gs.Vector3.Distance(v3, self.preDragPos) / 20
        local steps = (1 / dis > 0 and 1 / dis < 1) and 1 / dis or 1

        local lerp = 0
        while lerp <= 1 do
            local curPos = gs.Vector3.Lerp(self.preDragPos, v3, lerp)
            local v2 = gs.Vector2(curPos.x, curPos.y)

            local list = gs.UnityEngineUtil.GetRaycastUIResults(v2, true)
            local index = string.find(list[0].gameObject.name, "colorItem")
            if index ~= nil then
                local id = string.sub(list[0].gameObject.name, index + 9)
                if table.indexof01(self.mDragInfo, id) == 0 then
                    table.insert(self.mDragInfo, id)
                    list[0].gameObject.transform:Find("mIsSelect").gameObject:SetActive(true)
                end
            end
            lerp = lerp + steps
        end
        self.preDragPos = v3
    end
end

return _M
