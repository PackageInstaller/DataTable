return {
	OTHER_BIND = 2,
	NORMAL_BIND = 1,
	default = {
		selIndex = 0,
		SDKName = "GTA",
		showName = "Gtarcade",
		resultName = "gta"
	},
	btnConfig = {
		{
			ios = {
				{
					selIndex = 1,
					SDKName = "Apple",
					showName = "Apple",
					resultName = "apple"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				},
				{
					selIndex = 3,
					SDKName = "Twitter",
					showName = "Twitter",
					resultName = "twitter"
				}
			},
			android = {
				{
					selIndex = 4,
					SDKName = "Google",
					showName = "Google",
					resultName = "google"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				},
				{
					selIndex = 3,
					SDKName = "Twitter",
					showName = "Twitter",
					resultName = "twitter"
				}
			}
		},
		{
			ios = {
				{
					selIndex = 1,
					SDKName = "Apple",
					showName = "Apple",
					resultName = "apple"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				},
				{
					SDKName = "DMM",
					resultName = "dmm",
					selIndex = 6,
					showName = "DMM",
					showCondition = function(arg_1_0, arg_1_1)
						return g.core.platform.PlatformProxy:checkGameVersion(1040018)
					end
				}
			},
			android = {
				{
					selIndex = 4,
					SDKName = "Google",
					showName = "Google",
					resultName = "google"
				},
				{
					SDKName = "DMM",
					resultName = "dmm",
					selIndex = 6,
					showName = "DMM",
					showCondition = function(arg_2_0, arg_2_1)
						return g.core.platform.PlatformProxy:checkGameVersion(1050002) and tonumber(arg_2_0) == 2335 and tonumber(arg_2_1) == 2972
					end
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				}
			}
		},
		{
			ios = {
				{
					selIndex = 1,
					SDKName = "Apple",
					showName = "Apple",
					resultName = "apple"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				}
			},
			android = {
				{
					selIndex = 4,
					SDKName = "Google",
					showName = "Google",
					resultName = "google"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				}
			}
		},
		{
			ios = {},
			android = {}
		},
		{
			ios = {
				{
					selIndex = 1,
					SDKName = "Apple",
					showName = "Apple",
					resultName = "apple"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				}
			},
			android = {
				{
					selIndex = 4,
					SDKName = "Google",
					showName = "Google",
					resultName = "google"
				},
				{
					resultName = "facebook",
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					showCondition = function(arg_3_0, arg_3_1)
						return tostring(arg_3_0) ~= "3223"
					end
				}
			}
		},
		{
			ios = {
				{
					selIndex = 1,
					SDKName = "Apple",
					showName = "Apple",
					resultName = "apple"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				}
			},
			android = {
				{
					selIndex = 4,
					SDKName = "Google",
					showName = "Google",
					resultName = "google"
				},
				{
					selIndex = 2,
					SDKName = "Facebook",
					showName = "FaceBook",
					resultName = "facebook"
				}
			}
		}
	},
	defaultRegion = {
		[4] = {
			outRule = true,
			selIndex = 5,
			showName = "Gama",
			bindFunc = function()
				g.core.platform.PlatformProxy:showAuthennticationView()
			end,
			stateFunc = function()
				return g.core.model.User.accountAutheData:getPhoneState()
			end
		}
	},
	RETURN_MAP = {
		Twitter = "twitter",
		GTA = "gta",
		Apple = "apple",
		Google = "google",
		FaceBook = "facebook"
	}
}
