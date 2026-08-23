return {
	OTHER_BIND = 2,
	NORMAL_BIND = 1,
	default = {
		SDKName = "GTA",
		resultName = "gta",
		showName = "Gtarcade",
		selIndex = 0
	},
	btnConfig = {
		{
			ios = {
				{
					SDKName = "Apple",
					resultName = "apple",
					showName = "Apple",
					selIndex = 1
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				},
				{
					SDKName = "Twitter",
					resultName = "twitter",
					showName = "Twitter",
					selIndex = 3
				}
			},
			android = {
				{
					SDKName = "Google",
					resultName = "google",
					showName = "Google",
					selIndex = 4
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				},
				{
					SDKName = "Twitter",
					resultName = "twitter",
					showName = "Twitter",
					selIndex = 3
				}
			}
		},
		{
			ios = {
				{
					SDKName = "Apple",
					resultName = "apple",
					showName = "Apple",
					selIndex = 1
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				},
				{
					selIndex = 6,
					resultName = "dmm",
					SDKName = "DMM",
					showName = "DMM",
					showCondition = function(arg_1_0, arg_1_1)
						return g.core.platform.PlatformProxy:checkGameVersion(1040018)
					end
				}
			},
			android = {
				{
					SDKName = "Google",
					resultName = "google",
					showName = "Google",
					selIndex = 4
				},
				{
					selIndex = 6,
					resultName = "dmm",
					SDKName = "DMM",
					showName = "DMM",
					showCondition = function(arg_2_0, arg_2_1)
						return g.core.platform.PlatformProxy:checkGameVersion(1050002) and tonumber(arg_2_0) == 2335 and tonumber(arg_2_1) == 2972
					end
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				}
			}
		},
		{
			ios = {
				{
					SDKName = "Apple",
					resultName = "apple",
					showName = "Apple",
					selIndex = 1
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				}
			},
			android = {
				{
					SDKName = "Google",
					resultName = "google",
					showName = "Google",
					selIndex = 4
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
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
					SDKName = "Apple",
					resultName = "apple",
					showName = "Apple",
					selIndex = 1
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				}
			},
			android = {
				{
					SDKName = "Google",
					resultName = "google",
					showName = "Google",
					selIndex = 4
				},
				{
					selIndex = 2,
					resultName = "facebook",
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
					SDKName = "Apple",
					resultName = "apple",
					showName = "Apple",
					selIndex = 1
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				}
			},
			android = {
				{
					SDKName = "Google",
					resultName = "google",
					showName = "Google",
					selIndex = 4
				},
				{
					SDKName = "Facebook",
					resultName = "facebook",
					showName = "FaceBook",
					selIndex = 2
				}
			}
		}
	},
	defaultRegion = {
		[4] = {
			selIndex = 5,
			outRule = true,
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
		Google = "google",
		GTA = "gta",
		FaceBook = "facebook",
		Apple = "apple"
	}
}
