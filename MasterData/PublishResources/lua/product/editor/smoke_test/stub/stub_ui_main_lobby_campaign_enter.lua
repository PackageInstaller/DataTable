if not SMOKE_TEST_ENABLED then
  return
end
Log.warn("TestRobotModule: UIMainLobbyCampaignEnter stub!")

function UIMainLobbyCampaignEnter:OnShow()
end

function UIMainLobbyCampaignEnter:Flush(controller, latestCampObj)
  return false
end

function UIMainLobbyCampaignEnter:LoadSummerTwoData(TT, callback)
end

function UIMainLobbyCampaignEnter:FlushRoll(sampleInfo, campConfig)
end

function UIMainLobbyCampaignEnter:btnCampaignOnClick(go)
end

function UIMainLobbyCampaignEnter:_BindCampaignEnterBtnAinm(camp_type)
end

function UIMainLobbyCampaignEnter:_BindCampaignSakuraEnterBtnAinm()
end

function UIMainLobbyCampaignEnter:_OnCampaignStepChagne(campaign_id, component_id, component_step)
end
