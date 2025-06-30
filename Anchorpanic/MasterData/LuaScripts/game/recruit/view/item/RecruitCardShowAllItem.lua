--[[ 
-----------------------------------------------------
@filename       : RecruitCardShowAllItem
@Description    : 招募十连抽总览item
@date           : 2021-03-23 16:40:22
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.recruit.view.item.RecruitCardShowAllItem', Class.impl(BaseReuseItem))

--对应的ui文件
-- UIRes = UrlManager:getUIPrefabPath("recruit/item/RecruitCardShowAllItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function loadAsset(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTextConvertTip.text = _TT(571)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, self.showTips)
end

function showTips(self)
    if not self.cardVo then return end

    local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
    equipVo:setTid(self.cardVo.tid)
    TipsFactory:equipTips(equipVo)
end

function setData(self, go, cardVo)
    if self.UIObject == nil then
        self.UIObject = go
        if self.UIObject then
            self.UITrans = self.UIObject.transform
            self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
            self:configUI()
            self:addAllUIEvent()
        end
    end

    self.cardVo = cardVo
    local configVo = props.PropsManager:getPropsConfigVo(cardVo.tid)
    if configVo then
        for i = 1, 3 do
            self:getChildGO("mImgQualityBg_" .. i):SetActive(configVo.color - 1 == i)
            self:getChildGO("fxColor_top_0" .. (i + 1)):SetActive(configVo.color - 1 == i)
        end

        self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(cardVo.tid), true)
    end
end

function poolRecover(self)
    self:removeAllUIEvent()

    self.UIObject = nil
    self.UITrans = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self:__deActive()

    LuaPoolMgr:poolRecover(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(571):	"已转化"
]]