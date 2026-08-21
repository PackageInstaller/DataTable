--[[ 
    爬塔副本区域item
    @autor Jacob 
]]
module('dup.DupClimbTowerAreaItem', Class.impl(BaseComponent))

function __getPrefabName(self)
    return UrlManager:getUIPrefabPath('domainSurvey/DomainSurveyItem.prefab')
end

function __initGo(self)
    self.mItemName = self:getChildGO("mItemName"):GetComponent(ty.Text)

    self.mNormal = self:getChildGO("mNormal")
    self.mLock = self:getChildGO("mLock")
    self.mComplete = self:getChildGO("mComplete")

    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTxtProNum = self:getChildGO("mTxtProNum"):GetComponent(ty.Text)
    self.mTxt_01 = self:getChildGO("mTxt_01"):GetComponent(ty.Text)
    self.mTxtOpenDate = self:getChildGO("mTxtOpenDate"):GetComponent(ty.Text)
    self.mTxtPersent = self:getChildGO("mTxtPersent")
end

function getAreaVo(self)
    return self:getData().areaVo
end

function __updateCustomView(self)
    self:updateView()
end

function updateView(self)
    local txtColor = "242728ff" 
    -- Lock
    self.mTxtOpenDate.gameObject:SetActive(false)
    self.mTxtPersent:SetActive(true)
    if self:getAreaVo().level > role.RoleManager:getRoleVo():getPlayerLvl() or self:getAreaVo().areaId > dup.DupClimbTowerManager:maxAreaId() then 
        self.mNormal:SetActive(false)
        self.mLock:SetActive(true)
        self.mComplete:SetActive(false)
        txtColor = "d2dce8ff"
    else
        local progress = dup.DupClimbTowerManager:getDupProgressByAreaId(self:getAreaVo().areaId)
        -- Complete
        if dup.DupClimbTowerManager:curDupId() == 0 or self:getAreaVo().areaId < dup.DupClimbTowerManager:maxAreaId() then 
            self.mNormal:SetActive(false)
            self.mComplete:SetActive(true)
            self.mLock:SetActive(false)
            self.mTxt_01.text = math.floor(progress * 100) 
            txtColor = "ffffffff"
        else    --Normal
            self.mNormal:SetActive(true)
            self.mLock:SetActive(false)
            self.mComplete:SetActive(false)
            self.mImgProgress.fillAmount = progress
            self.mTxtProNum.text = math.floor(progress * 100) 
        end


        local canRec = dup.DupClimbTowerManager:canRecMainChapterAward(self:getAreaVo().areaId)
        if(canRec) then 
            RedPointManager:add(self:getTrans(), nil, -60, -41)
        else
            RedPointManager:remove(self:getTrans())
        end
    end
    self.mItemName.text = self:getAreaVo():getName()
    self.mItemName.color = gs.ColorUtil.GetColor(txtColor)

end

function poolRecover(self)
    RedPointManager:remove(self:getTrans())
    -- gs.TransQuick:UIPos(self:getTrans(), -60, -41)
    super.poolRecover(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
