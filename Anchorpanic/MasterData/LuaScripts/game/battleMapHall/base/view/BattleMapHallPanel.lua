module("battleMap.BattleMapHallPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/BattleMapHall.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("common_bg_6.jpg", false)
    self:setUICode(LinkCode.Adventure)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.m_curTabType = nil
    self.m_groupEnterDic = {}
    self.m_goLockDic = {}
    self.mItemList = {}
end

function configUI(self)
    super.configUI(self)

    self.mScrollView = self:getChildTrans("Content")
    self.mGroupBig = self:getChildGO("mGroupBig")
    self.mGroupBtn = self:getChildGO("mGroupBtn")
    self.mImgToucher = self:getChildGO("mImgToucher")

    self.mImgSelectIcon = self:getChildGO("mImgSelectIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtSelectTitle = self:getChildGO("mTxtSelectTitle"):GetComponent(ty.Text)
    self.mTxtSelectTitleEn = self:getChildGO("mTxtSelectTitleEn"):GetComponent(ty.Text)


    self.mImgGroupMainStage = self:getChildGO("GroupMainStage"):GetComponent(ty.AutoRefImage)
    self.mImgMainStage = self:getChildGO("ImgMainStage")
    self.mTextMainStagePro = self:getChildGO("TextMainStagePro"):GetComponent(ty.Text)
    self.mImgBranchStory = self:getChildGO("ImgBranchStory")
    self.mTextBranchGatePro = self:getChildGO("TextBranchGatePro"):GetComponent(ty.Text)
    self.m_groupEnterDic[battleMap.HallTabType.MAIN_MAP_TAB] = self:getChildGO("GroupMainStage")
    self.m_groupEnterDic[battleMap.HallTabType.BRANCH_STORY] = self:getChildGO("GroupBranchStory")
    self.m_groupEnterDic[battleMap.HallTabType.DUP_MAP_TAB] = self:getChildGO("GroupDailyDup")
    self.m_groupEnterDic[battleMap.HallTabType.DUP_CHALLENGE_TAB] = self:getChildGO("GroupChallenceDup")
    self.m_groupEnterDic[battleMap.HallTabType.HERO_BIOGRAPHY] = self:getChildGO("GroupBiography")
    self.m_goLockDic[battleMap.HallTabType.MAIN_MAP_TAB] = self:getChildGO("LockMainStage")
    self.m_goLockDic[battleMap.HallTabType.BRANCH_STORY] = self:getChildGO("LockBranchStory")
    self.m_goLockDic[battleMap.HallTabType.DUP_MAP_TAB] = self:getChildGO("LockDailyDup")
    self.m_goLockDic[battleMap.HallTabType.DUP_CHALLENGE_TAB] = self:getChildGO("LockChallenceDup")
    self.m_goLockDic[battleMap.HallTabType.HERO_BIOGRAPHY] = self:getChildGO("LockBiography")

    self:setGuideTrans("guide_GroupChallenceDup", self:getChildTrans("GroupChallenceDup"))
    self:setGuideTrans("guide_GroupMainStage", self:getChildTrans("GroupMainStage"))
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.CHANGE_MAIN_MAP_CHAPTER_BG, self.__onUpdateMainMapBgHandler, self)

    self:updateView()
    self:updateRed()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.CHANGE_MAIN_MAP_CHAPTER_BG, self.__onUpdateMainMapBgHandler, self)
    self:onCloseBigGroup()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
    ]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupBtn, self.onEnter)
    self:addUIEvent(self.mImgToucher, self.onCloseBigGroup)

    for type = battleMap.HallTabType.MAIN_MAP_TAB, battleMap.HallTabType.HERO_BIOGRAPHY do
        self:addUIEvent(self.m_groupEnterDic[type], self.onClickEnterHandler, nil, type)
    end
end

function updateEnterList(self)
    self.mList = {}
    for type = battleMap.HallTabType.MAIN_MAP_TAB, battleMap.HallTabType.HERO_BIOGRAPHY do
        if battleMap.getIsOpenByTabType(type) then
            self.mList[type] = { type = type, name = battleMap.getHallTabName(type), uicode = battleMap.getUICodeByTabType(type) }
            self.m_goLockDic[type]:SetActive(false)
        else
            self.m_goLockDic[type]:SetActive(true)
        end
    end
end

function updateView(self)
    self:updateEnterList()
    self:poolRecover()

    for i, v in pairs(self.mList) do
        local item = battleMap.BattleMapHallItem:poolGet()
        item:addEventListener(battleMap.BattleMapHallItem.EVENT_SELECT, self.onSelect, self)
        item:setData(self.mScrollView, v)
        table.insert(self.mItemList, item)
    end

    if (battleMap.getIsOpenByTabType(battleMap.HallTabType.MAIN_MAP_TAB)) then
        self.mImgMainStage:SetActive(true)
        local stageId = battleMap.MainMapManager:getMainMapCurStage()
        local chapterVo = battleMap.MainMapManager:getChapterVoByStageId(stageId)
        local proPercent, proStr = chapterVo:getStagePro()
        self.mTextMainStagePro.text = _TT(71305, chapterVo.chapterId, chapterVo:getName(), HtmlUtil:color(proPercent .. "%", "f57921ff"))
        local bgName = UrlManager:getMainMapChapterBgUrl(battleMap.MainMapStyleType.Easy, chapterVo.chapterId)
        self.mImgGroupMainStage:SetImg(bgName, false)
    else
        self.mImgMainStage:SetActive(false)
        self.mTextMainStagePro.text = ""
    end

    if (battleMap.getIsOpenByTabType(battleMap.HallTabType.BRANCH_STORY)) then
        self.mImgBranchStory:SetActive(false)
        self.mTextBranchGatePro.text = ""
    else
        self.mImgBranchStory:SetActive(false)
        self.mTextBranchGatePro.text = ""
    end
end

function poolRecover(self)
    for i, v in pairs(self.mItemList) do
        v:removeEventListener(battleMap.BattleMapHallItem.EVENT_SELECT, self.onSelect, self)
        v:poolRecover()
    end
    self.mItemList = {}
end

function onEnter(self)
    local data = self.mList[self.selectType]
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = data.uicode })
end

function onClickEnterHandler(self, args)
    local type = args
    if (battleMap.getIsOpenByTabType(type, true)) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = battleMap.getUICodeByTabType(type) })
    end
end

function onSelect(self, args)
    self.selectType = args
    self.mImgSelectIcon:SetImg(UrlManager:getBgPath(string.format("battleHall/battle_enter_b_%s.png", self.selectType + 1)))
    self.mTxtSelectTitle.text = self.mList[self.selectType].name
    self.mTxtSelectTitleEn.text = "HELLO WORLD"
    self.mGroupBig:SetActive(true)
end

function onCloseBigGroup(self)
    self.mGroupBig:SetActive(false)
end

function __onUpdateMainMapBgHandler(self, args)
    if (self.m_curTabType == battleMap.HallTabType.MAIN_MAP_TAB) then
        local styleType = battleMap.MainMapManager:getStyle()
        local chapterId = args.chapterVo.chapterId
        local bgName = UrlManager:getMainMapChapterBgUrl(styleType, chapterId)
        if (bgName ~= self:getBg()) then
            self:setBg(bgName, false)
        end
    end
end

function updateRed(self)
    local flag = dup.DupChallengeManager:checkFlag()
    if flag then
        RedPointManager:add(self:getChildGO("GroupChallenceDup").transform, nil, 117, -31)
    else
        RedPointManager:remove(self:getChildGO("GroupChallenceDup").transform)
    end
end

function close(self)
    super.close(self)
end

function destroyPanel(self)
    super.destroyPanel(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
