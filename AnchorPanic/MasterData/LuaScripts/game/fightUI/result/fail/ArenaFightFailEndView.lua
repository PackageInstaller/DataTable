--[[   
     竞技场战斗结算失败界面
]]
module('fight.ArenaFightFailEndView', Class.impl(fightUI.FightResultWinView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("figthtResult/ArenaFightFailEnd.prefab")

function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mTxtRank = self:getChildGO("TextRank"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("TextScore"):GetComponent(ty.Text)

    self.m_rankUp = self:getChildGO("GroupRankUp")
    self.mTxtRankUp = self:getChildGO("TextRankUp"):GetComponent(ty.Text)

    self.m_rankUpIcon = self:getChildGO("ImgRankUp"):GetComponent(ty.AutoRefImage)

    self.m_goTxtSameRank = self:getChildGO("TxtSameRank")

    self.mPreviewBtn = self:getChildGO("mPreViewBtn")
end

--激活
function active(self, args)
    super.active(self, args)
    self:updateScore()
end

--非激活
function deActive(self)
    super.deActive(self)
    self.resultData.state = "Fail"
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_FIGHT_INFO, self.resultData)
end

function enterTween(self)
    gs.TransQuick:UIPosX(self.mImgTitleBg, -1200)
    -- self.mGroupInfo:GetComponent(ty.CanvasGroup).alpha = 0
    self.mGroupHead.gameObject:SetActive(false)
    self:updateHeadList()

    self:setTimeout(0.2, function()
        gs.TransQuick:UIPosX(self.mImgTitle1, -423)
        TweenFactory:move2LPosX(self.mImgTitle1, -418, 0.1)
    end)
    self.tween1 = TweenFactory:move2PosXEx(self.mImgTitleBg, -483, 0.3, nil, function()

        self:updateInfo()

        if #self.preResultData.heroData > 0 then
            self.timeId = self:setTimeout(0.4, function()
                self.mGroupHead.gameObject:SetActive(true)

                self.timeId2 = self:addTimer(0.1, #self.mHeadList, function()
                    local item = self.mHeadList[self.idx]
                    self.idx = self.idx + 1
                    item:setActive(true)
                end)
            end)
        end
    end)
end

function updateScore(self)
    local score = self.resultData.args[1]
    self.mTxtScore.text = "-" .. math.abs(score)

    local currRank = self.resultData.args[3]
    self.mTxtRank.text = currRank

    local upRank = self.resultData.args[2] - currRank
    if upRank < 0 then
        self.m_goTxtSameRank:SetActive(false)
        self.m_rankUp:SetActive(false)
        self.mTxtRankUp.text = string.format("(   %s)", math.abs(upRank))
        self.mTxtRankUp.color = gs.ColorUtil.GetColor("ed5239ff")
        self.m_rankUpIcon:SetImg(UrlManager:getCommonPath("common_5433.png"), false)
    else
        -- self.m_goTxtSameRank:SetActive(true) --ui设计排名不变不显示提示
        self.m_rankUp:SetActive(false)
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
    -- self:addUIEvent(self.aa,self.onClick)
    -- self:addUIEvent(self.mImgToucher, self.onPreTouch)
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
