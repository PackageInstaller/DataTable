--[[ 
-----------------------------------------------------
@filename       : PlayerHeadFrameGrid
@Description    : 玩家头像框
@date           : 2023-05-23 17:44:29
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("PlayerHeadFrameGrid", Class.impl(BaseReuseItem))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/PlayerHeadFrameGrid.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function poolRecover(self)
    super.poolRecover(self)
    self:initData()
end

function initData(self)

end

function configUI(self)
    self.mImgFrameIcon = self:getChildGO("mImgFrameIcon"):GetComponent(ty.AutoRefImage)
    self.mGroupDynamic = self:getChildTrans("mGroupDynamic")
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    if self.mDynamicFrameGo and not gs.GoUtil.IsGoNull(self.mDynamicFrameGo) then
        gs.GameObject.Destroy(self.mDynamicFrameGo)
        self.mDynamicFrameGo = nil
    end
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, self.onClickHandler)
end

-- 设置数据
function setData(self, cusData, cusParent)
    self:setParentTrans(cusParent)

    if self.mDynamicFrameGo and not gs.GoUtil.IsGoNull(self.mDynamicFrameGo) then
        gs.GameObject.Destroy(self.mDynamicFrameGo)
        self.mDynamicFrameGo = nil
    end

    self.mHeadFrameId = cusData
    local dynamics, resUrl = decorate.DecorateManager:getHeadFrameResUrl(self.mHeadFrameId)
    if dynamics == 1 then
        -- 动态头像框
        self.mImgFrameIcon.gameObject:SetActive(false)
        self.mDynamicFrameGo = gs.ResMgr:LoadGO(resUrl)
        gs.TransQuick:SetParentOrg01(self.mDynamicFrameGo, self.mGroupDynamic)
    else
        -- 静态头像框
        self.mImgFrameIcon.gameObject:SetActive(true)
        self.mImgFrameIcon:SetImg(resUrl)
    end
end

-- 播放入场动画
function showEnterAnim(self)
    if not self.mDynamicFrameGo then
        return
    end
    local anim = self.mDynamicFrameGo:GetComponent(ty.Animator)
    if anim then
        anim:SetTrigger("show")
    end
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]