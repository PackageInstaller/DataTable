local HeroHeadItemCtrl = BaseClass("HeroHeadItemCtrl",require("Framework.UI.Component.CircularScrollViewItem"))
local M = HeroHeadItemCtrl
function M:Init()
    self._view.ItemToggle:OnToggleClick(Bind(self, self._OnClick))
    --self._view.ItemToggle.onValueChanged:AddListener(Bind(self, self._OnClick))
    self.clickFun=nil
    self.qualityColor={
        {255,174,58,255},
        {220,117,250,255},
        {192,212,77,255},
        {255,174,58,255},
    }
end

function M:UpdateItem(data,idx)
    self.idx = idx
    self.data = data
    if data == nil then
        return 
    end

    self._heroId = data.heroId
    self._selectIndex = data.selectIndex
    self._heroData = IHeroDataMgr:GetMyHeroDataById(self._heroId)
    self._heroConf = ConfigHelper.GetCfgByLua("hero", self._heroId)
    self._roleConf = ConfigHelper.GetCfgByLua("role", self._heroId)
    self._view.HeadIcon:SetAvatarIcon(data.heroId, RoleType.ERT_Hero)
    self._view.Name:SetText(self._heroConf.name)
    --self._view.Choose:SetActive(idx==1)
    if self._view.ItemToggle then      
        --为了解决togglegroup下面一个都没有选中的情况，属于特别处理      
		self._view.ItemToggle:SetActive(true)
		self._view.ItemToggle:SetIsOn(data.selectIndex==self._heroId,false)
    end

    -- 配置红点参数
    if self._view.RedPoint then
        self._view.RedPoint:SetParam(0, self._heroId)
        self._view.RedPoint:SetParam(1, self._heroId)
        self._view.RedPoint:Check()
    end
    if self._view.Quality then
        local color = self.qualityColor[self._heroConf.rare] or {255,255,255,255} 
        self._view.Quality:SetColor(color[1],color[2],color[3],color[4])
        self._view.Quality:SetActive(true)
    end
end

function M:Reset()
    -- body
    self._view.ItemToggle:SetActive(false)
    self._view.ItemToggle:SetIsOn(false,false)
end

function M:SetSelectCallback(callback)
    self.clickFun = callback
end


function M:_OnClick(isOn)
    -- if self._view.ItemToggle then
    --     self._view.ItemToggle:SetIsOn(isOn)
    -- end
    if isOn and self.clickFun then
        self.clickFun(self.data,self.idx)
    end
end

return HeroHeadItemCtrl
