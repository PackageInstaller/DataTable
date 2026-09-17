local page = class("pagePlacePoint", G_UIPageBase)
local _homeResourceTpl = L_GameTpl:getHomeResourceTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function page.bind()
  return {
    scrollPoint = {
      moduleName = "pages/placePoint/cellPlacePoint"
    },
    heroPointList = {
      moduleName = "modulePages/cellItemCommon"
    },
    infoRewardList = {
      moduleName = "modulePages/cellItemCommon"
    },
    infoRewardStandList = {
      moduleName = "pages/placePoint/cellPlacePointStandReward"
    },
    txt_title = "",
    go_txtEmpty = false
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    scrollPoint = {
      onClick = function(self, bind)
        self:OnClick_point(bind.serverData.guid)
      end
    },
    heroPointList = {
      onClick = function(self, bind)
        self:OnClick_heroPoint(bind)
      end
    },
    infoRewardList = {
      onClick = function(self, bind)
        self:OnClick_infoReward(bind)
      end
    }
  }
end

function page:created(...)
end

return page
