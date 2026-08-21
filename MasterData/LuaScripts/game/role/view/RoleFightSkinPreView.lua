module("role.RoleFightSkinPreView", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/RoleFightSkinPreView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("战斗皮肤预览")

    self:setSize(0, 0)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mImgPre = self:getChildGO("mImgPre"):GetComponent(ty.AutoRefImage)
    self.mPrefabContent = self:getChildTrans("mPrefabContent")
end

function initViewText(self)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.selectId = args
    local skinInfoVo = role.RoleManager:getFightSkinDataById(self.selectId)
    if table.indexof01(skinInfoVo.tap, 1) > 0 then
        self.prefab = AssetLoader.GetGO(skinInfoVo.prefabName)
        self.prefab.transform:SetParent(self.mPrefabContent, false)
        --gs.Message.Show("动态皮肤TODO")
    else
        self.mImgPre:SetImg(UrlManager:getIconPath(skinInfoVo.preImg), false)
    end
    self.mPrefabContent.gameObject:SetActive(table.indexof01(skinInfoVo.tap, 1) > 0)
    
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    if self.prefab then
        gs.GameObject.Destroy(self.prefab)
        self.prefab = nil
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

return _M
