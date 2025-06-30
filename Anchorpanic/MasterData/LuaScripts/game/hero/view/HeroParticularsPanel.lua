--[[ 
-----------------------------------------------------
@filename       : HeroParticularsPanel
@Description    : 招募预览-详情
@date           : 2023-04-28 2:43:13
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroParticularsPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroParticularsPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShowCloseAll = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(70004))
    --self:setBg("")
end

--只适配按钮
function getAdaptaTrans(self)
    return self:getChildTrans("mGroupClose")
end

-- 初始化数据
function initData(self)
    self.curHeroTid = nil
    self.mPropGrid = nil
    self.mReuseItemList = {}
end

function configUI(self)
    self.mImgBg = self:getChildGO("mImgBg")
    self.mImgMask = self:getChildGO("mImgMask")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mImgReuseBg = self:getChildGO("mImgReuseBg")
    self.mScrollContent = self:getChildTrans("mContent")
    self.mImgHeroPicBg = self:getChildGO("mImgHeroPicBg")
    self.mEffectTrans = self:getChildTrans("mEffectTrans")
    self.mImgMassTrans = self:getChildTrans("mImgMassTrans")
    self.mGroupEleAndOcc = self:getChildTrans("mGroupEleAndOcc")
    self.mTxtDEF = self:getChildGO("mTxtDEF"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtCvZh = self:getChildGO("mTxtCvZh"):GetComponent(ty.Text)
    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mTxtCvJp = self:getChildGO("mTxtCvJp"):GetComponent(ty.Text)
    self.mTxtLife = self:getChildGO("mTxtLife"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtStats = self:getChildGO("mTxtStats"):GetComponent(ty.Text)
    self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)
    self.mTxtSpeed = self:getChildGO("mTxtSpeed"):GetComponent(ty.Text)
    self.mTxtDEFDes = self:getChildGO("mTxtDEFDes"):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
    self.mTxtLifeDes = self:getChildGO("mTxtLifeDes"):GetComponent(ty.Text)
    self.mTxtFightDes = self:getChildGO("mTxtFightDes"):GetComponent(ty.Text)
    self.mTxtSpeedDes = self:getChildGO("mTxtSpeedDes"):GetComponent(ty.Text)
    self.mImgHeroPic = self:getChildGO("mImgHeroPic"):GetComponent(ty.AutoRefImage)

    self.mIsLimit = self:getChildGO("mIsLimit")
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:setData(args.heroId, args.heroTid)
    self.mImgMask:GetComponent(ty.AutoRefImage).alphaHitTestMinimumThreshold = 0.5
    GameDispatcher:addEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
    self:setAdapta()
end

function deActive(self)
    MoneyManager:setMoneyTidList()
    super.deActive(self)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mImgMask, self.onClickClose)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtStats.text = _TT(1030)--属性
    self.mTxtInfo.text = _TT(25116)--"信息"
    self.mTxtDEFDes.text = _TT(35)-- "防御"
    self.mTxtFightDes.text = _TT(34) --"攻击"
    self.mTxtLifeDes.text = _TT(3101)-- "生命"
    self.mTxtSpeedDes.text = _TT(1033)-- "速度"
    self.mTxtTitle.text = "战员简介"--_TT()
end

function onClickCloseHandler(self)
    self.onClickClose(self)
end

function setData(self, cusHeroId, cusHeroTid)
    self.curHeroId = cusHeroId
    self.curHeroTid = cusHeroTid
    if (cusHeroId == nil) then
        self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.curHeroTid)
    else
        self.curHeroVo = hero.HeroManager:getHeroVo(self.curHeroId)
    end
    self:updateView()
end

function updateView(self)
    self:removeEffect()
    self:removeReuseItemList()
    if (self.curHeroVo) then --AttConst.HP_MAX, AttConst.ATTACK, AttConst.DEFENSE, AttConst.SPEED
        self.mIsLimit:SetActive(self.curHeroVo.isLimit==1)
        local heroVo = hero.HeroManager:getHeroConfigVo(self.curHeroTid)
        self.mTxtName.text = self.curHeroVo.name
        self.mTxtCvZh.text = _TT(1015, self.curHeroVo.zhCVName)--"中：" .. self.curHeroVo.zhCVName
        self.mTxtCvJp.text = _TT(1016, self.curHeroVo.jpCVName)--"日：" .. self.curHeroVo.jpCVName
        self.mScrollContent.anchoredPosition = gs.Vector2.zero
        self.mTxtContent.text = self.curHeroVo.life
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mScrollContent)--立即刷新
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtContent:GetComponent(ty.RectTransform))--立即刷新
        for i = 1, 3 do
            self:getChildGO("mImgQuality_" .. i):SetActive(heroVo.color - 1 == i)
        end
        if heroVo.professionType ~= nil then
            local occItem = SimpleInsItem:create(self.mImgReuseBg, self.mGroupEleAndOcc, "heroOccReuseItem")
            occItem:getChildGO("mIconReuse"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getMonsterJobSmallIconUrl(heroVo.professionType), true)
            occItem:getChildGO("mTxtReuse"):GetComponent(ty.Text).text = hero.getProfessionName(heroVo.professionType)
            occItem:addUIEvent(nil, function()
                --  TipsFactory:heroEleAndOccTips(1, occItem:getTrans())
            end)
            table.insert(self.mReuseItemList, occItem)
        end
        if heroVo.eleType ~= -1 then
            local eleItem = SimpleInsItem:create(self.mImgReuseBg, self.mGroupEleAndOcc, "heroEleReuseItem")
            eleItem:getChildGO("mIconReuse"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(heroVo.eleType), true)
            local color, txt = hero.getHeroTypeName(heroVo.eleType)
            eleItem:getChildGO("mTxtReuse"):GetComponent(ty.Text).text = HtmlUtil:color(txt, color)
            eleItem:addUIEvent(nil, function()
                --TipsFactory:heroEleAndOccTips(2, eleItem:getTrans())
            end)
            table.insert(self.mReuseItemList, eleItem)
        end
        self.mTxtFight.text = heroVo.basicAttrDic[AttConst.ATTACK]
        self.mTxtDEF.text = heroVo.basicAttrDic[AttConst.DEFENSE]
        self.mTxtLife.text = heroVo.basicAttrDic[AttConst.HP_MAX]
        self.mTxtSpeed.text = heroVo.basicAttrDic[AttConst.SPEED]
        self.mImgHeroPic:SetImg(UrlManager:getheroRecordUrl(self.curHeroVo.model), true)
        self.mImgBg:SetActive(self.curHeroTid == 1011)
        self.mImgHeroPicBg:SetActive(self.curHeroTid ~= 1011)
    end
end
function removeReuseItemList(self)
    if #self.mReuseItemList > 0 then
        for _, item in ipairs(self.mReuseItemList) do
            item:poolRecover()
            item = nil
        end
        self.mReuseItemList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]