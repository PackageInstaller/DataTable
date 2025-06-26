--[[   
     英雄招募规则界面
]]
module('recruit.RecruitNewPlayResulitPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('recruit/RecruitNewPlayResulitPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 518.6)
    self:setTxtTitle(_TT(28042))
end

-- 初始化数据
function initData(self)

end

-- 初始化
function configUI(self)
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnComfirm = self:getChildGO("mBtnComfirm")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mContentRect = self:getChildTrans('Content')
end

-- 激活
function active(self)
    super.active(self)
    self:recyAllItem()

    local heroVoList = recruit.RecruitManager:getRecruitHeroResultList()
    for i=1,#heroVoList do
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroVoList[i].heroTid)
        local item = HeroHeadGrid:poolGet()

        item:setData(heroConfigVo)
        item:setParent(self.mContentRect)
        item:setSiblingIndex(i)
        item:setName(heroConfigVo.name)
        item:setEleType(true)
        item:setType(true)
        item:setLvl(1)
        item:setStarLvl(heroConfigVo:getStar())
        item:setScale(0.95)

        local heroCloseCall = function ()
            GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW)
            GameDispatcher:dispatchEvent(EventName.OPEN_RECRUITNEWPLAYRESULIT_PANEL)
        end

        item:setCallBack(self, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILSINFOPANEL, { heroTid = heroConfigVo.tid ,closeCall = heroCloseCall})
            GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_SHOW_ALL_VIEW)
            self:close()
        end)
        self.mHeadItem[i] = item
    end
end

-- 非激活
function deActive(self)
    super.deActive(self)

    self:recyAllItem()
end

function initViewText(self)
    self.mTxtTips.text = _TT(28043)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnComfirm, self.onBtnComfirm)

end

function recyAllItem(self)
    if self.mHeadItem then
        for i, v in pairs(self.mHeadItem) do
            v:poolRecover()
        end
    end
    self.mHeadItem = {}
end

function onBtnComfirm(self)
    GameDispatcher:dispatchEvent(EventName.REQ_CONFIRM_NEWPLAY_RECRUIT_RESULT)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
