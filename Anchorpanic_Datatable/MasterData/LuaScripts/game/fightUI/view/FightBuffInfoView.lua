
module('game.fightUI.view.FightBuffInfoView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fight/FightBuffInfoView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end


-- 设置全屏透明遮罩
function setMask(self)

end


-- 初始化数据
function initData(self)
    self.m_selectVo = nil
    self.m_buffInfoItemArr = {}
end

--初始化UI
function configUI(self)
    self.mLyScroller_L = self:getChildGO('mLyScroller_L'):GetComponent(ty.LyScroller)
    self.mLyScroller_L:SetItemRender(fight.FightBuffHeroListItem)

    self.mLyScroller_R = self:getChildGO('mLyScroller_R'):GetComponent(ty.LyScroller)
    self.mLyScroller_R:SetItemRender(fight.FightBuffHeroListItem)

    self.mFightBuffIcon = self:getChildGO("mFightBuffIcon")
    self.mFightBuffIcon:SetActive(false)

    self.mGroupNoBuff = self:getChildGO("mGroupNoBuff")
    self.mGroupBuffData = self:getChildGO("mGroupBuffData")
    self.mGroupBuffDataTrans = self:getChildTrans("mGroupBuffData")

    self.mBuffInfoPanel = self:getChildGO("mBuffInfoPanel")
    self.mBuffInfoItem = self:getChildGO("mBuffInfoItem")
    self.mBuffInfoItem:SetActive(false)

    self.mBtnTab = self:getChildGO("mBtnTab")
    self.mBtnTab:SetActive(false)
    self.mButtonLayout = self:getChildTrans("mButtonLayout")

    self.mTxtTitle_1 = self:getChildGO("mTxtTitle_1"):GetComponent(ty.Text)
    self.mTxtTitle_3 = self:getChildGO("mTxtTitle_3"):GetComponent(ty.Text)

    self:getChildGO("mLyScrollerItem_L"):SetActive(false)
    self:getChildGO("mLyScrollerItem_R"):SetActive(false)

    self.mClickTouch = self:getChildGO('mClickTouch')
    self.mClickTouch:GetComponent(ty.LongPressOrClickEventTrigger):SetIsPassEvent(true)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mClickTouch, self.close)
end

--激活
function active(self)
    super.active(self)
    fight.FightManager:addEventListener(fight.FightManager.EVENT_SHOW_BUFF_INFO_ID_CHANGE,self.__onUpdateInfo, self)

    GameDispatcher:addEventListener(EventName.HIDE_FIGHT_UI, self.close, self)

    self:__onUpdateInfo()
    self:initBtnTab()
end


function deActive(self)
    fight.FightManager:removeEventListener(fight.FightManager.EVENT_SHOW_BUFF_INFO_ID_CHANGE,self.__onUpdateInfo, self)
    fight.FightManager:setShowBuffInfoId(nil)
    GameDispatcher:removeEventListener(EventName.HIDE_FIGHT_UI, self.close, self)
end

function initBtnTab(self)
    if not self.mBtnTabList then
        self.mBtnTabList = {}
    end

    self.mSelectTabIndex = 0

    local tabCount = 2

    local curFightType = fight.FightManager:getBattleType()
    if curFightType == PreFightBattleType.DupImplied or curFightType == PreFightBattleType.RogueLike or curFightType == PreFightBattleType.DupMaze then
        tabCount = 3
    end

    for i=1,2 do
        local item = SimpleInsItem:create(self.mBtnTab, self.mButtonLayout, "FightBuffInfoViewmBtnTab")
        item.mIndex = i
        item:addUIEvent(nil,function ()
            self:selectBtnTab(item.mIndex)
        end)
        item:setText("mNormalText",62000+i)
        item:setText("mSelectText",62000+i)
        if i == 2 then 
            item:getChildTrans("mSelectImg").localScale = gs.Vector3(-1,1,1)
        end
        item:getChildGO("mSelect"):SetActive(false)

        self.mBtnTabList[i] = item
    end

    self:selectBtnTab(1)
end

function selectBtnTab(self,_index)
    if self.mSelectTabIndex == _index then return end 

    local tabItem = self.mBtnTabList[self.mSelectTabIndex]
    if tabItem then
        tabItem:getChildGO("mNormal"):SetActive(true)
        tabItem:getChildGO("mSelect"):SetActive(false)
    end

    self.mSelectTabIndex = _index

    tabItem = self.mBtnTabList[self.mSelectTabIndex]
    if tabItem then
        tabItem:getChildGO("mNormal"):SetActive(false)
        tabItem:getChildGO("mSelect"):SetActive(true)
    end

    if self.mSelectTabIndex == 1 then
        self.mTxtTitle_1.text = _TT(3004)
        self.mTxtTitle_3.text = _TT(3005)

        fight.FightManager:setShowSkillInfo(nil)
        self:__updateList()
    elseif self.mSelectTabIndex == 2 then
        self.mTxtTitle_1.text = _TT(3045)
        self.mTxtTitle_3.text = _TT(3046)

        fight.FightManager:setShowBuffInfoId(nil)
        self:updateBattleAssistList()
    elseif self.mSelectTabIndex == 3 then
        self.mTxtTitle_1.text = "buff"
        self.mTxtTitle_3.text = "debuff"

        self:updateOtherBuffList()
    end

    self.mBuffInfoPanel:SetActive(false)
end

function updateOtherBuffList(self)
    local sceneBuffList = fight.FightManager:getSceneSkillList()
    local data_L = {}
    local data_R = {}
    for i=1,#sceneBuffList do
        local skillCfg = fight.SkillManager:getSkillRo(sceneBuffList[i])
        if skillCfg then
            local gainType = skillCfg:getGainType()
            if gainType == 1 then
                table.insert(data_L,{otherBuff = skillCfg,mFightBuffIcon = self.mFightBuffIcon,dir = 1})
            else
                table.insert(data_R,{otherBuff = skillCfg,mFightBuffIcon = self.mFightBuffIcon,dir = 2})
            end
        end
    end

    self:updateScroll(data_L,data_R)
end

function updateBattleAssistList(self)
    local selfAssistList = fight.FightManager:getBattleAssistList(1)
    local enemyAssistList = fight.FightManager:getBattleAssistList(2)

    local data_L = {}
    for i=1,#selfAssistList do
        table.insert(data_L,{assist = selfAssistList[i],mFightBuffIcon = self.mFightBuffIcon,dir = 1})
    end

    local data_R = {}
    for i=1,#enemyAssistList do
        table.insert(data_R,{assist = enemyAssistList[i],mFightBuffIcon = self.mFightBuffIcon,dir = 2})
    end

    self:updateScroll(data_L,data_R)
end

function __updateList(self)
    local attList = fight.SceneManager:getSideThingIDs(1)
    local defList = fight.SceneManager:getSideThingIDs(2)
    local function _sort(id1, id2)
        local d1 = fight.SceneManager:getThing(id1):isDead()
        local d2 = fight.SceneManager:getThing(id2):isDead()

        if d2 and not d1 then
            return true
        end

        return false
    end

    table.sort(attList,_sort)
    table.sort(defList,_sort)

    local data_L = {}
    for i=1,#attList do
        if not fight.SceneManager:getThing(attList[i]):isDead() then
            table.insert(data_L,{fightHero = attList[i],mFightBuffIcon = self.mFightBuffIcon,dir = 1})
        end
    end

    local data_R = {}
    for i=1,#defList do
        if not fight.SceneManager:getThing(defList[i]):isDead() then
            table.insert(data_R,{fightHero = defList[i],mFightBuffIcon = self.mFightBuffIcon,dir = 2})
        end
    end

    self:updateScroll(data_L,data_R)
end

function updateScroll(self,data_L,data_R)
    if not self.isInitScroller then 
        self.mLyScroller_L.DataProvider = data_L
        self.mLyScroller_R.DataProvider = data_R

        self.isInitScroller = true
    else
        if self.mLyScroller_L.Count <= 0 then 
            self.mLyScroller_L.DataProvider = data_L
            self.isInitScroller = true
        else
            self.mLyScroller_L:ReplaceAllDataProvider(data_L)
        end

        if self.mLyScroller_R.Count <= 0 then 
            self.mLyScroller_R.DataProvider = data_R
            self.isInitScroller = true
        else
            self.mLyScroller_R:ReplaceAllDataProvider(data_R)
        end
    end
end

function __onUpdateInfo(self)
    if fight.FightManager.m_showBuffInfoId == nil and fight.FightManager.m_showHeroID == nil then
        self.mBuffInfoPanel:SetActive(false)
    else
        self.mBuffInfoPanel:SetActive(true)
        self:__updateBuff()
    end
end


function __updateBuff(self)
    self:__recoverBuffInfoItem()
    local bDict = fight.FightManager.m_showBuffInfoData
    local has = false
    if bDict then
        for i, v in ipairs(bDict) do
            local buffRefID = v.buffRefID
            local bRo = Buff.BuffRoMgr:getBuffRo(buffRefID)
            local bData = v
            if bRo then
                local iconUrl = UrlManager:getBuffIconUrl(bRo:getIcon())
                if bRo:getBuff_show() then
                    local item = SimpleInsItem:create(self.mBuffInfoItem, self.mGroupBuffDataTrans, self.__cname .. "_buff_info_item")
                    local imgIcon = item:getChildGO("ImgBuffIcon"):GetComponent(ty.AutoRefImage)
                    local textName = item:getChildGO("TxtName"):GetComponent(ty.Text)
                    local textRound = item:getChildGO("TxtRound"):GetComponent(ty.Text)
                    local textDes_1 = item:getChildGO("TxtDes_1"):GetComponent(ty.Text)
                    local textDes_2 = item:getChildGO("TxtDes_2"):GetComponent(ty.Text)
                    local TxtBuffName = item:getChildGO("TxtBuffName"):GetComponent(ty.Text)

                    imgIcon:SetImg(iconUrl,false)
                    textName.text = _TT(3058, bData.level)
                    TxtBuffName.text = bRo:getName()
                    if bData.round > 0 then
                        textRound.text = _TT(3047, bData.round)
                    else
                        textRound.text = _TT(1198)
                    end
                    textDes_1.text = string.format(bRo:getDesc(),bData.bdesc_value)
                    textDes_2.text = ""
                    table.insert(self.m_buffInfoItemArr, item)

                    has = true
                end
            end
        end
    end

    local skillList = fight.FightManager.m_showHeroSkill
    if skillList then
        for _,v in ipairs(skillList) do
            local skillVo = fight.SkillManager:getSkillRo(v.skill_id)
            if skillVo then
                local iconUrl = UrlManager:getSkillIconPath(skillVo:getIcon())

                local item = SimpleInsItem:create(self.mBuffInfoItem, self.mGroupBuffDataTrans, self.__cname .. "_buff_info_item")
                local imgIcon = item:getChildGO("ImgBuffIcon"):GetComponent(ty.AutoRefImage)
                imgIcon:SetImg(iconUrl,false)

                item:getChildGO("TxtName"):GetComponent(ty.Text).text = ""
                item:getChildGO("TxtRound"):GetComponent(ty.Text).text = ""
                item:getChildGO("TxtDes_1"):GetComponent(ty.Text).text = ""
                item:getChildGO("TxtDes_2"):GetComponent(ty.Text).text = skillVo:getDesc()

                table.insert(self.m_buffInfoItemArr, item)
                has = true
            end
        end
    end

    if has then
        self.mGroupNoBuff:SetActive(false)
        self.mGroupBuffData:SetActive(true)
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupBuffDataTrans)
        gs.TransQuick:UIPosY(self.mGroupBuffDataTrans,0)
    else
        self.mGroupNoBuff:SetActive(true)
        self.mGroupBuffData:SetActive(false)
    end
end

function __recoverBuffInfoItem(self)
    if(self.m_buffInfoItemArr)then
        for k, item in pairs(self.m_buffInfoItemArr) do
            item:poolRecover()
        end
    end
    self.m_buffInfoItemArr = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3046):	"敌方助战效果"
	语言包: _TT(3045):	"我方助战效果"
	语言包: _TT(3005):	"敌方"
	语言包: _TT(3004):	"我方"
]]
