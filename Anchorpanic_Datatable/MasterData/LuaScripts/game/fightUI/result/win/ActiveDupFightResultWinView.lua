--[[ 
-----------------------------------------------------
@filename       : FightResultWinView
@Description    : 1.1活动副本 战斗结算胜利界面
@date           : 2021-01-21 13:53:28
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('mainActivity.ActiveDupFightResultWinView', Class.impl(fightUI.FightResultWinView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainActivity/ActiveDupFightResultWinView.prefab")

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mStarItemList = {}
    self.mGroupStar = self:getChildTrans("mGroupStar")
    self.mStarItem = self:getChildGO("mStar")
    self.Text1 = self:getChildGO("Text1"):GetComponent(ty.Text)
    self.Text2 = self:getChildGO("Text2"):GetComponent(ty.Text)

    self.mUpInfo = self:getChildGO("mUpInfo")
end

function initViewText(self)
    super.initViewText(self)
    self.Text1.text = _TT(77)
    self.Text2.text = _TT(78)
end

function active(self, args)
    super.active(self, args)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:recoverStarItem()
end

function updateView(self)
    self:updateStarInfo()

    self.mTxtAddExp.gameObject:SetActive(self.resultData.player_exp > 0)
    self.mUpInfo.gameObject:SetActive(self.resultData.player_exp > 0)
end

function updateStarInfo(self, args)
    self.stageVo = mainActivity.ActiveDupManager:getStageVo(tonumber(self.battleFieldID))
    local list = self.stageVo.starList
    local passList = self.resultData.args
    self:recoverStarItem()
    for k, v in pairs(list) do
        local item = SimpleInsItem:create(self.mStarItem, self.mGroupStar, "ActiveDupFindEndStarItem")
        local starImg = item:getChildGO("mImgStar"):GetComponent(ty.Image)
        local mDesc = item:getChildGO("mTxtStarDes"):GetComponent(ty.Text)
        local starConfig = mainActivity.ActiveDupManager:getStarConfigData(v)
        mDesc.text = _TT(starConfig.des)
        local color = "82898cff"
        if table.indexof(passList, v) then
            color = "ffe76fff"
        end
        starImg.color = gs.ColorUtil.GetColor(color)
        table.insert(self.mStarItemList, item)
    end
end

function recoverStarItem(self)
    for k, v in pairs(self.mStarItemList) do
        v:poolRecover()
    end
    self.mStarItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]