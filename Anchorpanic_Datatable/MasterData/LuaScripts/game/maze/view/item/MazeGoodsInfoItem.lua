--[[ 
-----------------------------------------------------
@filename       : MazeGoodsInfoItem
@Description    : 迷宫物品信息item
@date           : 2021-08-07 11:11:58
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeGoodsInfoItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("maze/MazeBuffItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)
    self.isSelect = false
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mGroupRect = self.mGroup:GetComponent(ty.RectTransform)
    self.mGroupSelect = self:getChildGO("GroupSelect")
    self.mTxtSelectTip = self:getChildGO("mTxtSelectTip"):GetComponent(ty.Text)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtImprove = self:getChildGO("mTxtImprove"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
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
    self.mTxtTitle.text = "物资"
    self.mTxtSelectTip.text = "确 认 选 择"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroup, self.onClick)
end

function setData(self, cusParent, cusBuffId)
    self:setParentTrans(cusParent)
    self:setSelect(false)

    self.buffId = cusBuffId
    local goodsConfigVo = maze.MazeManager:getGoodsConfigVo(self.buffId)
    local skillVo = fight.SkillManager:getSkillRo(goodsConfigVo.skillId)
    self.mImgBg:SetImg(UrlManager:getPackPath(string.format("maze5/maze_buff_%s.png", goodsConfigVo.color)), true)
    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    self.mTxtTitle.text = _TT(63014)
    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtImprove.text = _TT(63013, goodsConfigVo.efficiency / 10)
    self.mTxtDes.text = goodsConfigVo:getDes()
    
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupRect) --立即刷新
end

function onClick(self)
    self:dispatchEvent(self.EVENT_CHANGE, { item = self })
end

function setSelect(self, bool)
    self.isSelect = bool
    self:updateState()
end

function updateState(self)
    if self.isSelect then
        self.mGroupSelect:SetActive(true)
    else
        self.mGroupSelect:SetActive(false)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
