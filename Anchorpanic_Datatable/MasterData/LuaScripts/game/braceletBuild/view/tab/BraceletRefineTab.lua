module("braceletBuild.BraceletRefineTab", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/tab/BraceletRefineTab.prefab")

-- 精练是单独的表============================

-- 初始化数据
function initData(self)
    -- 当前装备数据vo
    self.mEquipVo = nil
end

function configUI(self)

    
    -- self.mImgBraceletsIcon = self:getChildGO("mImgBraceletsIcon"):GetComponent(ty.AutoRefImage)
    -- self.mImgButtum = self:getChildGO("mImgButtum"):GetComponent(ty.AutoRefImage)
    -- self.mImgRight = self:getChildGO("mImgRight"):GetComponent(ty.AutoRefImage)
    self.ShowBracelets = self:getChildGO("ShowBracelets")

    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mScrollView = self:getChildTrans('Scroll View')
    self.m_groupContent = self:getChildGO('GroupContent')
    self.m_rightContent = self:getChildGO("RightContent")
    self.m_scrollContent = self:getChildTrans('Content')
    self.m_groupGrid = self:getChildTrans("GroupGrid")

    --self.mPropsImg = self:getChildTrans("GroupGrid"):GetComponent(ty.AutoRefImage)
    self.m_textEquipName = self:getChildGO("TextEquipName"):GetComponent(ty.Text)
    --self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.m_imgEmpty = self:getChildGO('ImgEmpty')
    self.m_textEmpty = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mTxtAttr = self:getChildGO("mTxtAttr"):GetComponent(ty.Text)

    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)
    self.mRelGroup = self:getChildGO("mRelGroup")

    self.mTxtRefine = self:getChildGO("mTxtRefine"):GetComponent(ty.Text)
    self.mBtnRefine = self:getChildGO("mBtnRefine")

    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
    self.mTxtDesLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mTxtNextDes = self:getChildGO("mTxtNextDes"):GetComponent(ty.TMP_Text)
    self.mTxtNextDesLink = self:getChildGO("mTxtNextDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtNextDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mTxtDesMax = self:getChildGO("mTxtDesMax"):GetComponent(ty.TMP_Text)
    self.mTxtDesMaxLink = self:getChildGO("mTxtDesMax"):GetComponent(ty.TextMeshProLink)
    self.mTxtDesMaxLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mTxtLvCurrent = self:getChildGO("mTxtLvCurrent"):GetComponent(ty.Text)
    self.mTxtLvNext = self:getChildGO("mTxtLvNext"):GetComponent(ty.Text)

    self.mBtnSelect = self:getChildGO("mBtnSelect")

    self.mSelectInfo = self:getChildGO("mSelectInfo")
    self.mBtnMax = self:getChildGO("mBtnMax")

    self.mTxtRefineCost = self:getChildGO("mTxtRefineCost"):GetComponent(ty.Text)
    self.mRefineUpCostIcon = self:getChildGO("mRefineUpCostIcon"):GetComponent(ty.AutoRefImage)


    self.mImgCircleMax = self:getChildGO("mImgCircleMax")
    self:setGuideTrans("funcTips_guide_braceletRefineTab_1", self:getChildTrans("mBraceletRefineGuide1"))
end

function active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_BRACELETS_REFINE_PANEL, self.refineUpdateView, self)
    GameDispatcher:addEventListener(EventName.SELECT_REFINE_CHANGE_EVENT, self.onSelectVoChange, self)

    self.mEquipVo = braceletBuild.BraceletBuildManager:getOpenEquipVo()
    -- UPDATE_EQUIP_DETAIL_DATA

    self:updateView()
end


function onSelectVoChange(self, args)
    self.mSelectEquipVo = braceletBuild.BraceletBuildManager:getSelectRefineVo()
    self:updateView()
end

function deActive(self)

    -- if self.mGrid then
    --     self.mGrid:poolRecover()
    --     self.mGrid = nil
    -- end

    if self.mSelectGrid then
        self.mSelectGrid:poolRecover()
        self.mSelectGrid = nil
    end

    self.mSelectEquipVo = nil

    if self.materialPanel then
        self.materialPanel:close()
    end

    braceletBuild.BraceletBuildManager:updateSelectRefineVo(nil)
    LoopManager:removeFrameByIndex(self.frameId)
    GameDispatcher:removeEventListener(EventName.SELECT_REFINE_CHANGE_EVENT, self.onSelectVoChange, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BRACELETS_REFINE_PANEL, self.refineUpdateView, self)
    -- self.mEquipVo:removeEventListener(self.mEquipVo.UPDATE_EQUIP_DETAIL_DATA,self.updateView,self)
end

function initViewText(self)
    self.m_textEmpty.text = _TT(4364)
end

function addAllUIEvent(self)

    self:addUIEvent(self.mBtnSelect, self.onBtnSelectClickHandler)

    self:addUIEvent(self.mBtnRefine, self.onBtnRefineClickHandler)

    self:addUIEvent(self.mBtnMax, self.onBtnMaxClickHandler)

    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroBraceletsRefine })
end

function onBtnMaxClickHandler(self)
    gs.Message.Show(_TT(4339)) -- "当前精炼已满"
end

function onBtnRefineClickHandler(self)
    if self.mSelectEquipVo == nil then
        gs.Message.Show("请选择一个精炼材料")
        return
    end
    local maxRefineLvl = braceletBuild.BraceletBuildManager:getMaxRefineLvl(self.mEquipVo.tid)
    if (self.mEquipVo.refineLvl >= maxRefineLvl) then
        gs.Message.Show(_TT(4339)) -- "当前精炼已满"
        return
    else
        local nextRefineConfigVo = braceletBuild.BraceletBuildManager:getRefineConfigVo(self.mEquipVo.tid,
        self.mEquipVo.refineLvl + 1)
        local costTid = nextRefineConfigVo.cost[1]
        local costCount = nextRefineConfigVo.cost[2]
        if (MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount)) then
            local function onReqRefineHandler()
                local list = {}
                table.insert(list, {
                    item_id = self.mSelectEquipVo.id,
                    num = 1
                })

                GameDispatcher:dispatchEvent(EventName.REQ_BRACELETS_REFINE, {
                    heroId = self.mEquipVo.heroId,
                    equipId = self.mEquipVo.id,
                    list = list
                })
                braceletBuild.BraceletBuildManager:updateSelectRefineVo(nil)
                --self.mSelectEquipVo = nil
                -- self:close()
            end

            local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.BRACELETS_REFINE)
            if (isNotRemind) then
                onReqRefineHandler()
            else
                local includeHighColor = self.mSelectEquipVo.color >= ColorType.ORANGE

                if (includeHighColor) then
                    UIFactory:alertMessge(_TT(4340), -- "精炼的材料包含橙色品质，是否继续精炼？"
                    true, function()
                        onReqRefineHandler()
                    end, _TT(1), -- "确定"
                    nil, true, function()
                    end, _TT(2), -- "取消"
                    _TT(4341), -- "精炼提示"
                    nil, RemindConst.BRACELETS_REFINE)
                else
                    onReqRefineHandler()
                end
            end
        end
    end
end



function onBtnSelectClickHandler(self)
    --self.m_groupContent:SetActive(false)

    if self.materialPanel == nil then
        self.materialPanel = braceletBuild.BraceletRefineUpView.new()
        local function _onDestroyPanelHandler(self)
            self.materialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
            self.materialPanel = nil
            self:updateView()
        end
        self.materialPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
    end

    local function _showRightView(visible, materialVo)
        --self.m_groupContent:SetActive(not visible)
        self.mSelectEquipVo = materialVo
    end
    self.materialPanel:setVisibleCall(_showRightView)
    self.materialPanel:setData({
        equipVo = self.mEquipVo
    })
    self.materialPanel:open()
end

function refineUpdateView(self)
    if self.mSelectGrid then
        self.mSelectGrid:poolRecover()
        self.mSelectGrid = nil
    end

    self.mSelectEquipVo = nil
    self:updateView()
end

function updateView(self)
    -- if self.mGrid then
    --     self.mGrid:poolRecover()
    --     self.mGrid = nil
    -- end
    -- self.mGrid = EquipGrid3:create(self.m_groupGrid, self.mEquipVo)
    -- self.mGrid:setClickEnable(false)
    -- self.mGrid:setShowEquipStrengthenLvl(false)
    -- self.mGrid:setIdxTap(false)

    -- self.mImgIcon:SetImg(UrlManager:getIconPath("bracelet/props_"..self.mEquipVo.tid..".png"), false)
    -- self.mImgButtum:SetImg(UrlManager:getPackPath("bracelet/Nucleariron_pnl_"..self.mEquipVo.color..".png"), false)
    -- self.m_childGos["Content"]:GetComponent(ty.RectTransform).anchoredPosition = gs.VEC2_ZERO 
    -- self.m_childGos["Content_02"]:GetComponent(ty.RectTransform).anchoredPosition = gs.VEC2_ZERO 
    -- self.mImgBraceletsIcon:SetImg(UrlManager:getBraceletIconUrl(self.mEquipVo.tid), false)
    -- self.mImgButtum:SetImg(UrlManager:getNraceletColorUrl(self.mEquipVo.color), false)
    -- self.mImgRight:SetImg(UrlManager:getNraceletRightColorUrl(self.mEquipVo.color), false)
    
    braceletBuild.BraceletBuildManager:setBraceletsInfo(self.mEquipVo, self.ShowBracelets)
    --self.mPropsImg:SetImg(UrlManager:getPropsIconUrl(self.mEquipVo.tid), false)
    self.m_textEquipName.text = self.mEquipVo.name
    --self.mTxtLv.text = self.mEquipVo.strengthenLvl

    -- 检测装备是否可改造
    if (braceletBuild.BraceletBuildManager:isCanRefine(self.mEquipVo.tid)) then
        self.m_groupContent:SetActive(true)
        self.m_imgEmpty:SetActive(false)
    else
        self.m_groupContent:SetActive(false)
        self.m_imgEmpty:SetActive(true)
    end

    self:updateStrengthenAttr()

    self:updateSkillDes()

    if self.mSelectGrid then
        self.mSelectGrid:poolRecover()
        self.mSelectGrid = nil
    end

    if self.mSelectEquipVo then
        self.mSelectGrid = BraceletsGrid:poolGet()
        self.mSelectGrid:setData(self.mSelectEquipVo)
        self.mSelectGrid:setParent(self.m_childTrans['mPropsTrans'])
        self.mSelectGrid:setClickEnable(false)
        self.mSelectGrid.UIObject.transform:SetSiblingIndex(1)
        self.mSelectGrid:setScale(0.72)
    end

end

function updateStrengthenAttr(self)
    local mainAttrList, _ = self.mEquipVo:getMainAttr()
    if #mainAttrList > 0 then
        local preKey = mainAttrList[1].key
        local preValue = mainAttrList[1].value
        self.mTxtAttr.text = AttConst.getName(preKey) .. "   +" .. AttConst.getValueStr(preKey, preValue)
    end
end

function updateSkillDes(self)
    local isCanRefine = braceletBuild.BraceletBuildManager:isCanRefine(self.mEquipVo.tid)
    self.mRelGroup:SetActive(isCanRefine)
    if isCanRefine then
        local maxRefineLvl = braceletBuild.BraceletBuildManager:getMaxRefineLvl(self.mEquipVo.tid)
        local currentRefineLvl = self.mEquipVo.refineLvl
        local mStr = maxRefineLvl == currentRefineLvl and "bracelet/bracelet_refine_2.png" or "bracelet/bracelet_refine_1.png"
        for i = 1, maxRefineLvl do
            local img = self:getChildGO("mImgRel" .. i):GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getPackPath(mStr), false)
            img.color = gs.ColorUtil.GetColor(i > currentRefineLvl and "82898cff" or "ffffffff")
        end

        local skillEffectList, skillEffectDic = self.mEquipVo:getSkillEffect()
        local skillVo = fight.SkillManager:getSkillRo(skillEffectList[1].skillId)
        self.mTxtSkill.text = skillVo:getName()

        if maxRefineLvl > currentRefineLvl then
            self.mTxtDes.text = equip.EquipSkillManager:getBraceletSkillDes(self.mEquipVo, skillEffectList[1])
            self.mTxtNextDes.text =            equip.EquipSkillManager:getBraceletPreviewSkillDes(self.mEquipVo, skillEffectList[1])

            self.mTxtLvCurrent.text = _TT(1392) .. self.mEquipVo.refineLvl
            self.mTxtLvNext.text = _TT(1392) .. self.mEquipVo.refineLvl + 1

            local nextRefineConfigVo = braceletBuild.BraceletBuildManager:getRefineConfigVo(self.mEquipVo.tid,
            self.mEquipVo.refineLvl + 1)
            local costTid = nextRefineConfigVo.cost[1]
            local costCount = nextRefineConfigVo.cost[2]
            self.mRefineUpCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)

            self.mTxtRefineCost.text = costCount
            self.mTxtRefineCost.color = gs.ColorUtil.GetColor(
            MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, false, false) and "FFFFFFFF" or ColorUtil.RED_NUM)

        else
            self.mTxtDes.text = equip.EquipSkillManager:getBraceletSkillDes(self.mEquipVo, skillEffectList[1])
            self.mTxtLvCurrent.text = _TT(1392) .. self.mEquipVo.refineLvl

            self.mTxtNextDes.text = ""
            self.mTxtLvNext.text = ""
            -- if not self.mTxtDesMax then 
            --     self.mTxtDesMax = self.m_childGos["mTxtDesMax"]:GetComponent(ty.Text)
            -- end
            self.mTxtDesMax.text = equip.EquipSkillManager:getBraceletSkillDes(self.mEquipVo, skillEffectList[1])
        end

        self.mSelectInfo:SetActive(currentRefineLvl < maxRefineLvl)
        self.m_childGos["mCurrentSkillInfo"]:SetActive(currentRefineLvl < maxRefineLvl)
        self.m_childGos["mTxtMax"]:SetActive(currentRefineLvl == maxRefineLvl)
        self.mBtnMax:SetActive(maxRefineLvl == currentRefineLvl)

        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mTxtDes"))
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mTxtNextDes"))

        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mDesScroll"))
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mDesNextScroll"))
        --gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mStrengthenScrollView.transform)
        -- self.mImgCircleMax:SetActive(not maxRefineLvl == currentRefineLvl)
    end

end

return _M