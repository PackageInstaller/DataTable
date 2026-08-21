module("CovenantLvUpPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("covenant/CovenantLvUpPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mRewardList = {}
    self.cusLevel = covenant.CovenantManager:getPerstigeStage()
end

function configUI(self)
    super.configUI()
    self.mTxtCovTitle = self:getChildGO("mTxtCovTitle"):GetComponent(ty.Text)
    self.mTxtResearchLimit = self:getChildGO("mTxtResearchLimit"):GetComponent(ty.Text)
    self.mTxtNewScience = self:getChildGO("mTxtNewScience"):GetComponent(ty.Text)

    self.mTxtCovPreLv = self:getChildGO("mTxtCovPreLv"):GetComponent(ty.Text)
    self.mTxtCovNextLv = self:getChildGO("mTxtCovNextLv"):GetComponent(ty.Text)
    self.mTxtResearchPre = self:getChildGO("mTxtResearchPre"):GetComponent(ty.Text)
    self.mTxtResearchNext = self:getChildGO("mTxtResearchNext"):GetComponent(ty.Text)

    self.mScienceContent = self:getChildTrans("mScienceContent")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtCovTitle.text = _TT(29544)
    self.mTxtResearchLimit.text = _TT(29545)
    self.mTxtNewScience.text = _TT(29543)

    self.mTxtCovPreLv.text = _TT(29548, self.cusLevel-1)
    self.mTxtCovNextLv.text = _TT(29547, self.cusLevel)
    self.mTxtTitle.text = _TT(29573)
end

function active(self, args)
    super.active(self, args)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:clearItem()
end

function close(self)
    super.close(self)
end

function updateView(self)
    self:clearItem()
    self.mTxtResearchNext.text = covenant.CovenantManager:getCovenantPrestigeDataById(self.cusLevel).helperLimitLvl
    self.mTxtResearchPre.text = covenant.CovenantManager:getCovenantPrestigeDataById(self.cusLevel - 1).helperLimitLvl
    local prestigeData = covenant.CovenantManager:getCovenantPrestigeData()
    local rewardList = AwardPackManager:getAwardListById(prestigeData[self.cusLevel-1].reward)
    for k, v in pairs(rewardList) do
        local propsGrid = PropsGrid:create(self.mScienceContent, {v.tid, v.num}, 1)
        table.insert(self.mRewardList, propsGrid) 
    end
end

function clearItem(self)
    for i = 1, #self.mRewardList do
        local item = self.mRewardList[i]
        item:poolRecover()
    end
    self.mRewardList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
