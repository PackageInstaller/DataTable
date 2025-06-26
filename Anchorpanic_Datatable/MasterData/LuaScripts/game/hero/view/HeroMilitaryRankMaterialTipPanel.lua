--[[   
     英雄军衔材料选择界面
]]
module("hero.HeroMilitaryRankMaterialTipPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("hero/HeroMilitaryRankMaterialTipPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 530)
    self:setTxtTitle("")
end

-- 初始化数据
function initData(self)
    self.m_heroVo = nil
    self.m_headList = nil
    self.m_isNotRemind = false
end

-- 初始化
function configUI(self)
    self.m_rectContent = self:getChildGO("Scroll View"):GetComponent(ty.RectTransform)

    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.m_scrollerMaterial = self:getChildTrans("MaterialContent")

    self.m_textNotRemind = self:getChildGO("TextNotRemind"):GetComponent(ty.Text)
    self.m_textTip = self:getChildGO("TextTip"):GetComponent(ty.Text)

    self.m_btnNotRemind = self:getChildGO("BtnNotRemind")
    --self.m_imgSelectGo = self:getChildGO('ImgSelect')
    self.m_selectImg = self:getChildGO("selectImg")
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:setData(args)
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:__recyHeadList()
end

function initViewText(self)
    self.m_textNotRemind.text = _TT(1073)
     --"今日不再提示"
    self.m_textTip.text = _TT(1074)
 --"确定消耗以下材料继续晋升吗？(已装备的芯片会返回背包)"
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
    self:addUIEvent(self.m_btnNotRemind, self.__onClickNotRemindHandler)
end

function __recyHeadList(self)
    if (self.m_headList) then
        for i = 1, #self.m_headList do
            local item = self.m_headList[i]
            item:poolRecover()
        end
    end
    self.m_headList = {}
end

function __onClickCancelHandler(self)
    self:close()
end

function __onClickConfirmHandler(self)
    local materialIdList = self:__getMaterialHeroIdList()
    self:close()
    if (self.m_isNotRemind) then
        GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, {moduleId = self:__remindType()})
    end
    GameDispatcher:dispatchEvent(
        EventName.REQ_HERO_MILITARY_RANK_UP,
        {heroId = self.m_heroId, costHeroIdList = materialIdList}
    )
end

function __remindType(self)
    return RemindConst.HERO_MILITARY_RANK_UP
end

function __getMaterialHeroIdList(self)
    return hero.HeroMilitaryRankManager.materialHeroIdList
end

function __getNeedMaterialCount(self)
    return hero.HeroMilitaryRankManager.needMaterialCount
end

function __onClickNotRemindHandler(self)
    self.m_isNotRemind = not self.m_isNotRemind

    --self.m_imgSelectGo:SetActive(self.m_isNotRemind)
    if self.m_isNotRemind then
        self.m_selectImg:SetImg(UrlManager:getCommon4Path("common_3414.png"), false)
    else
        self.m_selectImg:SetImg(UrlManager:getCommon4Path("common_3413.png"), false)
    end
end

function setData(self, heroId)
    self.m_heroId = heroId
    self:__updateView()
end

function __updateView(self)
    self:__recyHeadList()

    local materialIdList = self:__getMaterialHeroIdList()
    local needMaterialCount = self:__getNeedMaterialCount()
    for i = 1, needMaterialCount do
        local heroVo = hero.HeroManager:getHeroVo(materialIdList[i])
        local grid = HeroHeadGrid:create(self.m_scrollerMaterial, heroVo)
        if (heroVo) then
            grid:setLvl(heroVo.lvl)
        end
        table.insert(self.m_headList, grid)
        grid:setClickEnable(false)
    end
    gs.TransQuick:SizeDelta01(self.m_rectContent, #self.m_headList * 130 + (#self.m_headList - 1) * 36)

    self.m_isNotRemind = remind.RemindManager:isTodayNotRemain(self:__remindType())
    --self.m_imgSelectGo:SetActive(self.m_isNotRemind)
	if self.m_isNotRemind then
        self.m_selectImg:SetImg(UrlManager:getCommon4Path("common_3414.png"), false)
    else
        self.m_selectImg:SetImg(UrlManager:getCommon4Path("common_3413.png"), false)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
