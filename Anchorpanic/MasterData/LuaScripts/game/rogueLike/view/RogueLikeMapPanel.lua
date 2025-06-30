--[[ 
-----------------------------------------------------
@filename       : RogueLikeMapPanel
@Description    : 肉鸽地图界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("rogueLike.RogueLikeMapPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeMapPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(331))
    self:setBg("")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mRogueLikePointDic = {}
    self.mHeroInfo = {}
    self.mColGroup = {}

    self.isFirstOpen = true
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mRogueLikePointDic = {}
    for col = 1, 7 do
        for row = 1, 5 do
            local name = col .. "_" .. row
            local node = "MapItem_0" .. col .. "_0" .. row
            local obj = self:getChildGO(node)
            local lineAbove = obj.transform:Find("Line_Above").gameObject
            local lineUnder = obj.transform:Find("Line_Under").gameObject
            local lineSpecial = obj.transform:Find("Line_Special").gameObject
            local lineFront
            if row == 3 then
                lineFront = obj.transform:Find("Line_Front").gameObject
                lineFront:SetActive(false)
            end

            -- parent 线(上,下) 是否有子对象 列 行
            self.mRogueLikePointDic[name] = { obj = obj, lineAbove = lineAbove, lineUnder = lineUnder, lineSpecial = lineSpecial, lineFront = lineFront, hasChild = false, col = col, row = row }
        end
    end

    self.mColGroup = {}
    for col = 1, 7 do
        local rt = self:getChildGO("ItemGroup_0" .. col):GetComponent(ty.RectTransform)
        self.mColGroup[col] = rt
    end

    self.mBtnRetCell = self:getChildGO("mBtnRetCell")
    self.mBtnFormationEdit = self:getChildGO("BtnFormationEdit")
    self.mTxtPoint = self:getChildGO("mTxtPoint"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxtLayer = self:getChildGO("mTxtLayer"):GetComponent(ty.Text)
    self.mBtnBuffList = self:getChildGO("mBtnBuffList")
    self.mBtnQuit = self:getChildGO("mBtnQuit")

    self.mHeroScroll = self:getChildGO("mHeroScroll"):GetComponent(ty.ScrollRect)

    self.mRogueMapItemScroll = self:getChildGO("mRogueMapItemScroll"):GetComponent(ty.ScrollRect)

    self.mFightInfoGroup = self:getChildTrans("mFightInfoGroup")
    self.mEmptyGroup = self:getChildGO("mEmptyGroup")

    self.mEmptyGroup:SetActive(false)

    self.mTipsBtn = self:getChildGO("mTipsBtn")

    --self.mBuffTxt = self:getChildGO("mBuffTxt"):GetComponent(ty.Text)
end

-- 激活
function active(self)
    super.active(self)
    -- gs.CameraMgr:SetUICameraProjetion(false, 1)
    MoneyManager:setMoneyTidList({ MoneyTid.FUNCTION_TID })
    self.base_childGos["MoneyBar"]:SetActive(true)
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_MAP_PANEL, self.onUpdateMap, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_POINT, self.onUpdatePoint, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_FIGHT_INFO_PANEL, self.onOpenRogueLikeFightInfoPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_INFINITE_CITY_DUP_INFO_VIEW, self.onEmptyClick, self)

    -- local t = os.time()
    self:showPanel()
    self.mRogueMapItemScroll.gameObject:SetActive(true)
    -- cusLog(os.time() - t)
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    -- gs.CameraMgr:SetUICameraProjetion(true, 1)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_MAP_PANEL, self.onUpdateMap, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_POINT, self.onUpdatePoint, self)
    GameDispatcher:removeEventListener(EventName.OPEN_ROGUELIKE_FIGHT_INFO_PANEL, self.onOpenRogueLikeFightInfoPanel, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_INFINITE_CITY_DUP_INFO_VIEW, self.onEmptyClick, self)
    self:clearMapList()
    self:clearHeroInfo()
    self.mEmptyGroup:SetActive(false)
    if self.mRogueLikeFightInfoPanel then
        self.mRogueLikeFightInfoPanel:destroy()
        self.mRogueLikeFightInfoPanel = nil
    end

end

function onUpdatePoint(self)
    self.mTxtPoint.text = rogueLike.RogueLikeManager:getPoint()
end

function onOpenRogueLikeFightInfoPanel(self, args)
    if self.mRogueLikeFightInfoPanel == nil then
        self.mRogueLikeFightInfoPanel = rogueLike.RogueLikeFightInfoPanel.new()
    end
    self.mRogueLikeFightInfoPanel:show(args, self.mFightInfoGroup)
    self.mEmptyGroup:SetActive(true)
    self.base_childGos["MoneyBar"]:SetActive(false)
end

function onEmptyClick(self)
    if self.mRogueLikeFightInfoPanel then
        self.mRogueLikeFightInfoPanel:hideViewAni()
        self.mEmptyGroup:SetActive(false)
        self.base_childGos["MoneyBar"]:SetActive(true)
    end
end

function onTipsClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_SCORE_TIPS)
end

function onUpdateMap(self)
    self:showPanel()
end

-- 新
function showPanel(self)
    self:clearMapList()
    self:clearHeroInfo()

    -- 如果没有开启或者没有挑战 关闭自身
    if rogueLike.RogueLikeManager:isOpen() == false then
        self:onClickClose()
        return
    end

    -- 如果是已经通关的情况 关闭自身
    local layout = rogueLike.RogueLikeManager:getRogueLayout()
    if layout == 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_SETT_PANEL)
        self:onClickClose()
        return
    end

    if rogueLike.RogueLikeManager:getRogueDifficulty() == nil or rogueLike.RogueLikeManager:getRogueDifficulty() == 0 then
        self:onClickClose()
        return
    end

    local difficulty = rogueLike.RogueLikeManager:getRogueDifficulty()
    local difficultyData = rogueLike.RogueLikeManager:getSingleDifficulty(difficulty)

    self:onUpdatePoint()
    self.mTxtLevel.text = _TT(difficultyData.name)
    self.mTxtLayer.text = layout .. "/" .. difficultyData.maxLayer

    local teamId = formation.FormationRogueLikeManager:getFightTeamId2(formation.TYPE.ROGUELIKE)
    local list = formation.FormationRogueLikeManager:__getFormationHeroListByTeamId(teamId)

    for i = 1, #list do
        local head = HeroHeadGrid:poolGet()
        local heroId = list[i].heroId
        local heroVo = hero.HeroManager:getHeroVo(heroId)

        local hpInfo = rogueLike.RogueLikeManager:getHeroInfo(heroId)
        local pro = math.ceil(hpInfo.nowHp / hpInfo.maxHp * 100)
        head:setData(heroVo)
        head:setParent(self.mHeroScroll.content)
        head:setHpPro(pro)
        table.insert(self.mHeroInfo, head)
    end

    local mapData = rogueLike.RogueLikeManager:getRogueLikeMap()
    for id, data in pairs(mapData) do
        local item = rogueLike.RogueLikeMapItem:poolGet()
        local col, row = rogueLike.RogueLikeManager:getRogueMapColRow(data.cell_id)
        local node = "MapItem_0" .. col .. "_0" .. row
        local parentTran = self:getChildTrans(node).transform:Find("RogueLikeMapItem_UE").transform
        item:setData(parentTran, data)
        local name = col .. "_" .. row

        self.mRogueLikePointDic[name].hasChild = true
        self.mRogueLikePointDic[name].data = data
        self.mRogueLikePointDic[name].item = item
    end

    self:updateHasChild()
    self:updateMapState()

    local t
    if self.isFirstOpen then
        t = 0
    else
        t = 0.3
    end

    local maxX = 996
    local maxY = 388

    local c, r = rogueLike.RogueLikeManager:getLastMapColRow()
    local posX = 0
    local posY = 388 / 2
    if c and c >= 1 and c <= 7 then
        -- 固定补充的500像素
        posX = gs.Mathf.Clamp(-(self.mColGroup[c].anchoredPosition.x - 500), -maxX, 0)
    end

    -- if r and r >= 1 and r <= 7 then
    --     posY = gs.Mathf.Clamp(maxY / 7 * r, 0, maxY)
    -- end

    TweenFactory:move2LPosX(self.mRogueMapItemScroll.content, posX, t)
    --TweenFactory:move2LPosY(self.mRogueMapItemScroll.content, posY, t)

    self.isFirstOpen = false
    self.mBtnRetCell:SetActive(rogueLike.RogueLikeManager:getCurrentCell() ~= 0)
end

-- 更新派生子格子
function updateHasChild(self)
    self.specialList = {}
    for name, args in pairs(self.mRogueLikePointDic) do

        local lineAbove = args.lineAbove
        local lineUnder = args.lineUnder
        local lineSpecial = args.lineSpecial
        local col = args.col
        local row = args.row

        if args.hasChild then
            local aboveName = ""
            local underName = ""
            local specialName = ""
            local rule = rogueLike.RogueLikeManager:getRogueMapRule(args.data.cell_id)
            local linkNum = rogueLike.RogueLikeManager:getLinkNum(args.data.cell_id)

            if linkNum > 0 then
                lineAbove:SetActive(false)
                lineUnder:SetActive(false)
                local linkCol, LinkRow = rogueLike.RogueLikeManager:getRogueMapColRow(linkNum)
                if self.mRogueLikePointDic[linkCol .. "_" .. LinkRow] then
                    specialName = linkCol .. "_" .. LinkRow
                    if table.indexof01(self.specialList, specialName) <= 0 then
                        table.insert(self.specialList, specialName)
                    end
                    lineSpecial:SetActive(true)
                end
            else
                lineSpecial:SetActive(false)
                if rule == 1 then
                    if self.mRogueLikePointDic[(col + 1) .. "_" .. (row - 1)] ~= nil and self.mRogueLikePointDic[(col + 1) .. "_" .. (row - 1)].hasChild == true then
                        lineAbove:SetActive(true)
                        aboveName = (col + 1) .. "_" .. (row - 1)
                    else
                        lineAbove:SetActive(false)
                    end

                    if self.mRogueLikePointDic[(col + 1) .. "_" .. row] ~= nil and self.mRogueLikePointDic[(col + 1) .. "_" .. row].hasChild == true then
                        lineUnder:SetActive(true)
                        underName = (col + 1) .. "_" .. row
                    else
                        lineUnder:SetActive(false)
                    end
                else
                    if self.mRogueLikePointDic[(col + 1) .. "_" .. row] ~= nil and self.mRogueLikePointDic[(col + 1) .. "_" .. row].hasChild == true then
                        lineAbove:SetActive(true)
                        aboveName = (col + 1) .. "_" .. row
                    else
                        lineAbove:SetActive(false)
                    end

                    if self.mRogueLikePointDic[(col + 1) .. "_" .. (row + 1)] ~= nil and self.mRogueLikePointDic[(col + 1) .. "_" .. (row + 1)].hasChild == true then
                        lineUnder:SetActive(true)

                        underName = (col + 1) .. "_" .. (row + 1)
                    else
                        lineUnder:SetActive(false)
                    end
                end
            end
            args.aboveName = aboveName
            args.underName = underName
            args.specialName = specialName
        else
            lineAbove:SetActive(false)
            lineUnder:SetActive(false)
            lineSpecial:SetActive(false)
        end
    end
end

-- 更新地图状态
function updateMapState(self)
    for name, args in pairs(self.mRogueLikePointDic) do
        if args.hasChild and args.item then
            local canRun = args.item:getCanWalk()
            local isLast = args.item:getIsLasMap()
            if args.aboveName ~= "" then
                local otherCanRun = self.mRogueLikePointDic[args.aboveName].item:getCanWalk()
                self:updateLine(args.lineAbove, canRun, otherCanRun, isLast)
            end
            if args.underName ~= "" then
                local otherCanRun = self.mRogueLikePointDic[args.underName].item:getCanWalk()
                self:updateLine(args.lineUnder, canRun, otherCanRun, isLast)
            end

            if args.specialName ~= "" then
                local otherCanRun = self.mRogueLikePointDic[args.specialName].item:getCanWalk()
                self:updateLine(args.lineSpecial, canRun, otherCanRun, isLast)
            end
        end
    end

    for i = 1, #self.specialList do
        self:updateLine(self.mRogueLikePointDic[self.specialList[i]].lineFront, true, true, true, true)
    end
end

-- 更新线条状态
function updateLine(self, line, canRun, otherCanRun, isLast, isSpecial)
    local normal = line.transform:Find("Normal").gameObject
    local lock = line.transform:Find("Lock").gameObject
    local select = line.transform:Find("Select").gameObject

    normal:SetActive(false)
    lock:SetActive(false)
    select:SetActive(false)

    if isSpecial then
        normal:SetActive(true)
        line:SetActive(true)
        return
    end

    if isLast then
        normal:SetActive(true)
        -- select:SetActive(true)
    else
        if canRun and otherCanRun then
            normal:SetActive(true)
        else
            lock:SetActive(true)
        end
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnRetCell, 56060, "回到选定事件")
    self:setBtnLabel(self.mBtnBuffList, 56070, "特殊能力图鉴")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRetCell, self.onRetCellClick)
    self:addUIEvent(self.mBtnBuffList, self.onBtnBuffClick)
    self:addUIEvent(self.mBtnQuit, self.onReStartBuffClick)
    self:addUIEvent(self.mEmptyGroup, self.onEmptyClick)
    self:addUIEvent(self.mTipsBtn, self.onTipsClick)
end

function onBtnBuffClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_COLLECTION_PANEL, { type = rogueLike.CollectionType.All, showHas = true })
end

function onReStartBuffClick(self)
    UIFactory:alertMessge(_TT(56071), true, function()
        self:onClickClose()
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_RESET)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
end

function clearMapList(self)
    for name, data in pairs(self.mRogueLikePointDic) do
        if data.hasChild and data.item then
            data.item:poolRecover()
            data.item = nil
            data.hasChild = false
            data.data = nil
            data.aboveName = ""
            data.underName = ""
        end
    end
end

function clearHeroInfo(self)
    for i = 1, #self.mHeroInfo do
        self.mHeroInfo[i]:poolRecover()
    end
    self.mHeroInfo = {}
end

-- 返回当前选择的界面
function onRetCellClick(self)
    local cellId = rogueLike.RogueLikeManager:getCurrentCell()
    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_CLOSE_VIEW, cellId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]