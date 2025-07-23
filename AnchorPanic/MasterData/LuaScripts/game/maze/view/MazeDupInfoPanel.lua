--[[ 
-----------------------------------------------------
@filename       : MazeDupInfoPanel
@Description    : 迷宫·副本详情
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeDupInfoPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("maze/MazeDupInfoPanel.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mWeaknessGrid = {}
    self.m_awardList = {}
end

--初始化UI
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupStamina = self:getChildGO("TextCost")
    self.mTxtCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.mTxtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("mTxtStageName"):GetComponent(ty.Text)
    self.mTxtAwardTitle = self:getChildGO("mTxtAwardTitle"):GetComponent(ty.Text)
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mMoneyItem = self:getChildTrans("mMoneyItem")

    self.mBtnAnemyFormation = self:getChildGO("mBtnAnemyFormation")

    self.mScrollContent = self:getChildTrans("AwardContent")

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnCose = self:getChildGO("mBtnClose")
    self.mFormationIconNode = self:getChildTrans("mFormationIconNode")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

function initViewText(self)
    self.mTxtAwardTitle.text = _TT(71311)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onClickAbleHandler)
    self:addUIEvent(self.mBtnClose, self.close)

    self:addUIEvent(self.mBtnAnemyFormation, self.onOpenFormationPanel)
end

--激活
function active(self, args)
    self.mMazeId = args.mazeId
    self.mEventVo = args.eventVo
    self.mCallFun = args.callFun

    self.dupId = self.mEventVo:getEffecctList()[1]
    self.dupVo = maze.MazeManager:getDupConfigVo(self.dupId)
    
    self:updateView()
end

--非激活
function deActive(self)
    self:recoverEleGrid()
    self:removeItem()
    
    if self.mMoneyBatItem then 
        self.mMoneyBatItem:poolRecover()
        self.mMoneyBatItem = nil
    end
end

function __playOpenAction(self)

end

function __closeOpenAction(self)
    self.mAnimator:SetTrigger("exit")
    self:setTimeout(AnimatorUtil.getAnimatorClipTime(self.mAnimator, "MainMapStageInfoPanel_Exit"), function()
        self:close()
    end)
end

function recoverEleGrid(self)
    for k,v in pairs(self.mWeaknessGrid) do
        v:poolRecover()
    end
    self.mWeaknessGrid = {}
end

function updateView(self)
    self.isPass = false
    local tileIdList = maze.MazeSceneManager:getPassMonsterTileIdList()
    for i = 1, #tileIdList do
        if tileIdList[i] == self.mEventVo:getTileId() then 
            self.isPass = true 
            break
        end
    end

    if self.dupVo then 
        self.mTxtStageName.text = _TT(self.dupVo.dupName)
        self.mTxtStageDes.text = _TT(self.dupVo.dupScr)

        local costTid = self.dupVo.cost[1]
        local costCount = self.dupVo.cost[2]
        self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
        self.mTxtCost.text = MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= costCount and HtmlUtil:color(costCount, "474C50ff") or HtmlUtil:color(costCount, "BD2A2AFF")

        self.mGroupStamina:SetActive((not self.isPass) and (costCount ~= 0))

        -- if not self.mMoneyBatItem then 
        --     self.mMoneyBatItem = MoneyItem:poolGet()
        --     self.mMoneyBatItem:setData(self.mMoneyItem, { tid = costTid, frontType = 2 })
        --     self.mMoneyBatItem:getAdaptaTrans().localPosition = gs.VEC3_ZERO
        -- end

        self:updateSuggest()
        self:updateItem()
    end
end

function onOpenFormationPanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = self.dupVo })
    self:close()
end

function updateSuggest(self)
    self:recoverEleGrid()
    local suggestEle = self.dupVo.suggestEle
    for i=1,#suggestEle do
        local item = SimpleInsItem:create(self.mImgEleBg, self.mFormationIconNode, "MazeDupInfoPanelelegrid")
        local type = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
        type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), false)
        table.insert(self.mWeaknessGrid, item)
    end
end

function updateItem(self)
    self:removeItem()

    local awardList = AwardPackManager:getAwardListById(self.dupVo.show_drop)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 0.95, false)
        table.insert(self.m_awardList, propsGrid)

        propsGrid:setHasRec(self.isPass == true)
        propsGrid:setIconGray(self.isPass == true)
    end
end

function removeItem(self)
    if (self.m_awardList) then
        for i = #self.m_awardList, 1, -1 do
            local item = self.m_awardList[i]
            item:poolRecover()
        end
    end
    self.m_awardList = {}
end

function onClickAbleHandler(self)
    if(self.mCallFun)then
        self.mCallFun()
    end
    self:close()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
