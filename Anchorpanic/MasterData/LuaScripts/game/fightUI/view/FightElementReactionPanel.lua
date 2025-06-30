--[[   
     英雄招募日志界面
]]
module('fightUI.FightElementReactionPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('fight/FightElementReactionPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle(_TT(130118))
end

-- 初始化数据
function initData(self)
end

-- 初始化
function configUI(self)
    self.mContent = self:getChildTrans("mContent")
    self.mItem = self:getChildGO("mItem")
    self.mItem:SetActive(false)

    self:getChildGO("mTxtDesc"):GetComponent(ty.Text).text = _TT(130113)
    self:getChildGO("mTxtTitle"):GetComponent(ty.Text).text = _TT(130118)
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.HIDE_FIGHT_UI, self.close, self)

    if not self.elementConfig then
        self.elementConfig = {}
        local baseData = RefMgr:getData("element_des")
        for key, data in pairs(baseData) do
            self.elementConfig[key] = data
        end
    end

    if not self.mItemList then
        self.mItemList = {}
    else
        self:poolRecover()
    end

    for i = 1, #self.elementConfig do
        local item = SimpleInsItem:create(self.mItem, self.mContent, "FightElementReactionPanel_item")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(self.elementConfig[i].language_title)
        item:getChildGO("mTxtElement"):GetComponent(ty.Text).text = _TT(130114)
        item:getChildGO("mTxtRestraint"):GetComponent(ty.Text).text = _TT(130119)
        item:getChildGO("mTxtElementDesc"):GetComponent(ty.Text).text = _TT(self.elementConfig[i].language_des)
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/icon/%s", self.elementConfig[i].element_pic))
        item:getChildGO("mImgEleType_1"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(self.elementConfig[i].sign), false)
        item:getChildGO("mImgEleType_2"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(self.elementConfig[i].touch), false)

        table.insert(self.mItemList, item)
    end
end

function poolRecover(self)
    for k, v in pairs(self.mItemList) do
        v:poolRecover()
    end
    self.mItemList = {}
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:poolRecover()
    GameDispatcher:removeEventListener(EventName.HIDE_FIGHT_UI, self.close, self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]