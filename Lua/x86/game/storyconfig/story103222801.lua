return {
	Play322281001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322281001
		arg_1_1.duration_ = 3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322281002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STblack

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_23 = 1

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322281001,
				charCount = 30,
				enableLayoutChange = true,
				duration = 2,
				groupID = "1",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322281002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 322281002
		arg_6_1.duration_ = 3.2

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play322281003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			return
		end

		arg_6_1.nodeConfigList_ = {
			{
				groupID = "1",
				duration = 0.2,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322281002,
				charCount = 48,
				enableLayoutChange = true,
				duration = 3.2,
				groupID = "2",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play322281003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322281003
		arg_10_1.duration_ = 4.87

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322281004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			return
		end

		arg_10_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322281003,
				charCount = 73,
				enableLayoutChange = true,
				duration = 4.86666666666667,
				groupID = "3",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "2",
				duration = 0.166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play322281004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322281004
		arg_14_1.duration_ = 3

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322281005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			return
		end

		arg_14_1.nodeConfigList_ = {
			{
				groupID = "3",
				duration = 1.43333333333333,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322281004,
				charCount = 45,
				enableLayoutChange = true,
				duration = 3,
				groupID = "4",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322281005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322281005
		arg_18_1.duration_ = 5.33

		local var_18_0 = {
			zh = 3.399999999999,
			ja = 5.332999999999
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322281006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1.999999999999

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_1 = 0.133333333334333

			if arg_18_1.time_ >= var_21_0 + var_21_1 and arg_18_1.time_ < var_21_0 + var_21_1 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_2 = "ST18a"

			if arg_18_1.bgs_[var_21_2] == nil then
				local var_21_3 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_2)
				var_21_3.name = var_21_2
				var_21_3.transform.parent = arg_18_1.stage_.transform
				var_21_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_2] = var_21_3
			end

			local var_21_4 = 1.03333333333333

			if var_21_4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				local var_21_5 = manager.ui.mainCamera.transform.localPosition
				local var_21_6 = Vector3.New(0, 0, 10) + Vector3.New(var_21_5.x, var_21_5.y, 0)
				local var_21_7 = arg_18_1.bgs_.ST18a

				var_21_7.transform.localPosition = var_21_6
				var_21_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_8 = var_21_7:GetComponent("SpriteRenderer")

				if var_21_8 and var_21_8.sprite then
					local var_21_9 = (var_21_7.transform.localPosition - var_21_5).z
					local var_21_10 = manager.ui.mainCameraCom_
					local var_21_11 = 2 * var_21_9 * Mathf.Tan(var_21_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_21_12 = var_21_11 * var_21_10.aspect
					local var_21_13 = var_21_8.sprite.bounds.size.x
					local var_21_14 = var_21_8.sprite.bounds.size.y
					local var_21_15 = var_21_12 / var_21_13
					local var_21_16 = var_21_11 / var_21_14
					local var_21_17 = var_21_16 < var_21_15 and var_21_15 or var_21_16

					var_21_7.transform.localScale = Vector3.New(var_21_17, var_21_17, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "ST18a" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_18 = 0

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_19 = 1

			if var_21_18 <= arg_18_1.time_ and arg_18_1.time_ < var_21_18 + var_21_19 then
				local var_21_20 = (arg_18_1.time_ - var_21_18) / var_21_19
				local var_21_21 = Color.New(0, 0, 0)

				var_21_21.a = Mathf.Lerp(0, 1, var_21_20)
				arg_18_1.mask_.color = var_21_21
			end

			if arg_18_1.time_ >= var_21_18 + var_21_19 and arg_18_1.time_ < var_21_18 + var_21_19 + arg_21_0 then
				local var_21_22 = Color.New(0, 0, 0)

				var_21_22.a = 1
				arg_18_1.mask_.color = var_21_22
			end

			local var_21_23 = 1

			if var_21_23 < arg_18_1.time_ and arg_18_1.time_ <= var_21_23 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_24 = 1

			if var_21_23 <= arg_18_1.time_ and arg_18_1.time_ < var_21_23 + var_21_24 then
				local var_21_25 = (arg_18_1.time_ - var_21_23) / var_21_24
				local var_21_26 = Color.New(0, 0, 0)

				var_21_26.a = Mathf.Lerp(1, 0, var_21_25)
				arg_18_1.mask_.color = var_21_26
			end

			if arg_18_1.time_ >= var_21_23 + var_21_24 and arg_18_1.time_ < var_21_23 + var_21_24 + arg_21_0 then
				local var_21_27 = Color.New(0, 0, 0)
				local var_21_28 = 0

				arg_18_1.mask_.enabled = false
				var_21_27.a = var_21_28
				arg_18_1.mask_.color = var_21_27
			end

			local var_21_29 = "10101ui_story"

			if arg_18_1.actors_[var_21_29] == nil then
				local var_21_30 = Asset.Load("Char/" .. "10101ui_story")

				if not isNil(var_21_30) then
					local var_21_31 = Object.Instantiate(Asset.Load("Char/" .. "10101ui_story"), arg_18_1.stage_.transform)

					var_21_31.name = var_21_29
					var_21_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_18_1.actors_[var_21_29] = var_21_31

					local var_21_32 = var_21_31:GetComponentInChildren(typeof(CharacterEffect))

					var_21_32.enabled = true

					local var_21_33 = GameObjectTools.GetOrAddComponent(var_21_31, typeof(DynamicBoneHelper))

					if var_21_33 then
						var_21_33:EnableDynamicBone(false)
					end

					arg_18_1:ShowWeapon(var_21_32.transform, false)

					arg_18_1.var_[var_21_29 .. "Animator"] = var_21_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_18_1.var_[var_21_29 .. "Animator"].applyRootMotion = true
					arg_18_1.var_[var_21_29 .. "LipSync"] = var_21_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_21_34 = arg_18_1.actors_["10101ui_story"].transform
			local var_21_35 = 1.03333333333333

			if var_21_35 < arg_18_1.time_ and arg_18_1.time_ <= var_21_35 + arg_21_0 then
				arg_18_1.var_.moveOldPos10101ui_story = var_21_34.localPosition
			end

			local var_21_36 = 0.001

			if var_21_35 <= arg_18_1.time_ and arg_18_1.time_ < var_21_35 + var_21_36 then
				local var_21_37 = (arg_18_1.time_ - var_21_35) / var_21_36
				local var_21_38 = Vector3.New(0, -1.16, -6.01)

				var_21_34.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10101ui_story, var_21_38, var_21_37)

				local var_21_39 = manager.ui.mainCamera.transform.position - var_21_34.position

				var_21_34.forward = Vector3.New(var_21_39.x, var_21_39.y, var_21_39.z)

				local var_21_40 = var_21_34.localEulerAngles

				var_21_40.z = 0
				var_21_40.x = 0
				var_21_34.localEulerAngles = var_21_40
			end

			if arg_18_1.time_ >= var_21_35 + var_21_36 and arg_18_1.time_ < var_21_35 + var_21_36 + arg_21_0 then
				var_21_34.localPosition = Vector3.New(0, -1.16, -6.01)

				local var_21_41 = manager.ui.mainCamera.transform.position - var_21_34.position

				var_21_34.forward = Vector3.New(var_21_41.x, var_21_41.y, var_21_41.z)

				local var_21_42 = var_21_34.localEulerAngles

				var_21_42.z = 0
				var_21_42.x = 0
				var_21_34.localEulerAngles = var_21_42
			end

			local var_21_43 = arg_18_1.actors_["10101ui_story"]
			local var_21_44 = 1.03333333333333

			if var_21_44 < arg_18_1.time_ and arg_18_1.time_ <= var_21_44 + arg_21_0 and not isNil(var_21_43) and arg_18_1.var_.characterEffect10101ui_story == nil then
				arg_18_1.var_.characterEffect10101ui_story = var_21_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_45 = 0.2

			if var_21_44 <= arg_18_1.time_ and arg_18_1.time_ < var_21_44 + var_21_45 and not isNil(var_21_43) then
				local var_21_46 = (arg_18_1.time_ - var_21_44) / var_21_45

				if arg_18_1.var_.characterEffect10101ui_story and not isNil(var_21_43) then
					arg_18_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_44 + var_21_45 and arg_18_1.time_ < var_21_44 + var_21_45 + arg_21_0 and not isNil(var_21_43) and arg_18_1.var_.characterEffect10101ui_story then
				arg_18_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_21_47 = 1.03333333333333

			if var_21_47 < arg_18_1.time_ and arg_18_1.time_ <= var_21_47 + arg_21_0 then
				arg_18_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_21_48 = 1.03333333333433

			if var_21_48 < arg_18_1.time_ and arg_18_1.time_ <= var_21_48 + arg_21_0 then
				arg_18_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_21_49 = 0
			local var_21_50 = 0.3

			if var_21_49 < arg_18_1.time_ and arg_18_1.time_ <= var_21_49 + arg_21_0 then
				local var_21_51 = "play"
				local var_21_52 = "music"

				arg_18_1:AudioAction(var_21_51, var_21_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_21_53 = ""
				local var_21_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_21_54 ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_54 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_54

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_54
						arg_18_1.bgmTxt2_.text = var_21_54
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_21_55 = 0.500666666666667
			local var_21_56 = 1

			if var_21_55 < arg_18_1.time_ and arg_18_1.time_ <= var_21_55 + arg_21_0 then
				local var_21_57 = "play"
				local var_21_58 = "music"

				arg_18_1:AudioAction(var_21_57, var_21_58, "bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra.awb")

				local var_21_59 = ""
				local var_21_60 = manager.audio:GetAudioName("bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra")

				if var_21_60 ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_60 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_60

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_60
						arg_18_1.bgmTxt2_.text = var_21_60
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_21_61 = 0.2
			local var_21_62 = 1

			if var_21_61 < arg_18_1.time_ and arg_18_1.time_ <= var_21_61 + arg_21_0 then
				local var_21_63 = "play"
				local var_21_64 = "effect"

				arg_18_1:AudioAction(var_21_63, var_21_64, "se_story_side_1037", "se_story_1037_ui_loop", "")
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_65 = 1.999999999999
			local var_21_66 = 0.175

			if var_21_65 < arg_18_1.time_ and arg_18_1.time_ <= var_21_65 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_67 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_67:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_18_1.dialogCg_.alpha = arg_24_0
				end))
				var_21_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_68 = arg_18_1:FormatText(StoryNameCfg[1023].name)

				arg_18_1.leftNameTxt_.text = var_21_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_69 = arg_18_1:GetWordFromCfg(322281005)
				local var_21_70 = arg_18_1:FormatText(var_21_69.content)

				arg_18_1.text_.text = var_21_70

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_71 = 7
				local var_21_72 = utf8.len(var_21_70)
				local var_21_73 = var_21_71 <= 0 and var_21_66 or var_21_66 * (var_21_72 / var_21_71)

				if var_21_73 > 0 and var_21_66 < var_21_73 then
					arg_18_1.talkMaxDuration = var_21_73
					var_21_65 = var_21_65 + 0.3

					if var_21_73 + var_21_65 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_73 + var_21_65
					end
				end

				arg_18_1.text_.text = var_21_70
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281005", "story_v_out_322281.awb") ~= 0 then
					local var_21_74 = manager.audio:GetVoiceLength("story_v_out_322281", "322281005", "story_v_out_322281.awb") / 1000

					if var_21_74 + var_21_65 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_74 + var_21_65
					end

					if var_21_69.prefab_name ~= "" and arg_18_1.actors_[var_21_69.prefab_name] ~= nil then
						local var_21_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_69.prefab_name].transform, "story_v_out_322281", "322281005", "story_v_out_322281.awb")

						arg_18_1:RecordAudio("322281005", var_21_75)
						arg_18_1:RecordAudio("322281005", var_21_75)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322281", "322281005", "story_v_out_322281.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322281", "322281005", "story_v_out_322281.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_76 = var_21_65 + 0.3
			local var_21_77 = math.max(var_21_66, arg_18_1.talkMaxDuration)

			if var_21_76 <= arg_18_1.time_ and arg_18_1.time_ < var_21_76 + var_21_77 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_76) / var_21_77

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_76 + var_21_77 and arg_18_1.time_ < var_21_76 + var_21_77 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "4",
				duration = 0.0339999999999999,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play322281006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322281006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play322281007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10101ui_story"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos10101ui_story = var_29_0.localPosition
			end

			local var_29_2 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2
				local var_29_4 = Vector3.New(0, 100, 0)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10101ui_story, var_29_4, var_29_3)

				local var_29_5 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_5.x, var_29_5.y, var_29_5.z)

				local var_29_6 = var_29_0.localEulerAngles

				var_29_6.z = 0
				var_29_6.x = 0
				var_29_0.localEulerAngles = var_29_6
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(0, 100, 0)

				local var_29_7 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_7.x, var_29_7.y, var_29_7.z)

				local var_29_8 = var_29_0.localEulerAngles

				var_29_8.z = 0
				var_29_8.x = 0
				var_29_0.localEulerAngles = var_29_8
			end

			local var_29_9 = 0
			local var_29_10 = 1.45

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_11 = arg_26_1:GetWordFromCfg(322281006)
				local var_29_12 = arg_26_1:FormatText(var_29_11.content)

				arg_26_1.text_.text = var_29_12

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 58
				local var_29_14 = utf8.len(var_29_12)
				local var_29_15 = var_29_13 <= 0 and var_29_10 or var_29_10 * (var_29_14 / var_29_13)

				if var_29_15 > 0 and var_29_10 < var_29_15 then
					arg_26_1.talkMaxDuration = var_29_15

					if var_29_15 + var_29_9 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_15 + var_29_9
					end
				end

				arg_26_1.text_.text = var_29_12
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_16 = math.max(var_29_10, arg_26_1.talkMaxDuration)

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_16 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_9) / var_29_16

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_9 + var_29_16 and arg_26_1.time_ < var_29_9 + var_29_16 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play322281007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322281007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322281008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.275

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[7].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:GetWordFromCfg(322281007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 11
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_8 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_8 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_8

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_8 and arg_30_1.time_ < var_33_0 + var_33_8 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322281008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322281008
		arg_34_1.duration_ = 5.37

		local var_34_0 = {
			zh = 3.1,
			ja = 5.366
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play322281009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10101ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos10101ui_story = var_37_0.localPosition
			end

			local var_37_2 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2
				local var_37_4 = Vector3.New(0, -1.16, -6.01)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10101ui_story, var_37_4, var_37_3)

				local var_37_5 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_5.x, var_37_5.y, var_37_5.z)

				local var_37_6 = var_37_0.localEulerAngles

				var_37_6.z = 0
				var_37_6.x = 0
				var_37_0.localEulerAngles = var_37_6
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(0, -1.16, -6.01)

				local var_37_7 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_7.x, var_37_7.y, var_37_7.z)

				local var_37_8 = var_37_0.localEulerAngles

				var_37_8.z = 0
				var_37_8.x = 0
				var_37_0.localEulerAngles = var_37_8
			end

			local var_37_9 = arg_34_1.actors_["10101ui_story"]
			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect10101ui_story == nil then
				arg_34_1.var_.characterEffect10101ui_story = var_37_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_11 = 0.200000002980232

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_11 and not isNil(var_37_9) then
				local var_37_12 = (arg_34_1.time_ - var_37_10) / var_37_11

				if arg_34_1.var_.characterEffect10101ui_story and not isNil(var_37_9) then
					arg_34_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_10 + var_37_11 and arg_34_1.time_ < var_37_10 + var_37_11 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect10101ui_story then
				arg_34_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_37_13 = 0

			if var_37_13 < arg_34_1.time_ and arg_34_1.time_ <= var_37_13 + arg_37_0 then
				arg_34_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_37_14 = 0

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_37_15 = 0
			local var_37_16 = 0.275

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_17 = arg_34_1:FormatText(StoryNameCfg[1023].name)

				arg_34_1.leftNameTxt_.text = var_37_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_18 = arg_34_1:GetWordFromCfg(322281008)
				local var_37_19 = arg_34_1:FormatText(var_37_18.content)

				arg_34_1.text_.text = var_37_19

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_20 = 11
				local var_37_21 = utf8.len(var_37_19)
				local var_37_22 = var_37_20 <= 0 and var_37_16 or var_37_16 * (var_37_21 / var_37_20)

				if var_37_22 > 0 and var_37_16 < var_37_22 then
					arg_34_1.talkMaxDuration = var_37_22

					if var_37_22 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_15
					end
				end

				arg_34_1.text_.text = var_37_19
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281008", "story_v_out_322281.awb") ~= 0 then
					local var_37_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281008", "story_v_out_322281.awb") / 1000

					if var_37_23 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_23 + var_37_15
					end

					if var_37_18.prefab_name ~= "" and arg_34_1.actors_[var_37_18.prefab_name] ~= nil then
						local var_37_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_18.prefab_name].transform, "story_v_out_322281", "322281008", "story_v_out_322281.awb")

						arg_34_1:RecordAudio("322281008", var_37_24)
						arg_34_1:RecordAudio("322281008", var_37_24)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322281", "322281008", "story_v_out_322281.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322281", "322281008", "story_v_out_322281.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_25 = math.max(var_37_16, arg_34_1.talkMaxDuration)

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_25 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_15) / var_37_25

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_15 + var_37_25 and arg_34_1.time_ < var_37_15 + var_37_25 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play322281009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322281009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322281010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10101ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10101ui_story == nil then
				arg_38_1.var_.characterEffect10101ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect10101ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_38_1.var_.characterEffect10101ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10101ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_38_1.var_.characterEffect10101ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.7

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(322281009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 28
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play322281010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322281010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play322281011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 1.225

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:GetWordFromCfg(322281010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 49
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_8 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_8 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_8

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_8 and arg_42_1.time_ < var_45_0 + var_45_8 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play322281011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322281011
		arg_46_1.duration_ = 6.37

		local var_46_0 = {
			zh = 3.5,
			ja = 6.366
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322281012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10101ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10101ui_story == nil then
				arg_46_1.var_.characterEffect10101ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect10101ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10101ui_story then
				arg_46_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_49_4 = 0
			local var_49_5 = 0.3

			if var_49_4 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_6 = arg_46_1:FormatText(StoryNameCfg[1023].name)

				arg_46_1.leftNameTxt_.text = var_49_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(322281011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 12
				local var_49_10 = utf8.len(var_49_8)
				local var_49_11 = var_49_9 <= 0 and var_49_5 or var_49_5 * (var_49_10 / var_49_9)

				if var_49_11 > 0 and var_49_5 < var_49_11 then
					arg_46_1.talkMaxDuration = var_49_11

					if var_49_11 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_4
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281011", "story_v_out_322281.awb") ~= 0 then
					local var_49_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281011", "story_v_out_322281.awb") / 1000

					if var_49_12 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_4
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_322281", "322281011", "story_v_out_322281.awb")

						arg_46_1:RecordAudio("322281011", var_49_13)
						arg_46_1:RecordAudio("322281011", var_49_13)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_322281", "322281011", "story_v_out_322281.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_322281", "322281011", "story_v_out_322281.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_5, arg_46_1.talkMaxDuration)

			if var_49_4 <= arg_46_1.time_ and arg_46_1.time_ < var_49_4 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_4) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_4 + var_49_14 and arg_46_1.time_ < var_49_4 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play322281012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322281012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322281013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10101ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10101ui_story == nil then
				arg_50_1.var_.characterEffect10101ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect10101ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_50_1.var_.characterEffect10101ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10101ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_50_1.var_.characterEffect10101ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.575

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(322281012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 23
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play322281013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322281013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play322281014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.425

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(322281013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 17
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_8 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_8 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_8

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_8 and arg_54_1.time_ < var_57_0 + var_57_8 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play322281014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322281014
		arg_58_1.duration_ = 6.03

		local var_58_0 = {
			zh = 3.233,
			ja = 6.033
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322281015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10101ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10101ui_story == nil then
				arg_58_1.var_.characterEffect10101ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect10101ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10101ui_story then
				arg_58_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_61_4 = 0

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_61_5 = 0
			local var_61_6 = 0.225

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_7 = arg_58_1:FormatText(StoryNameCfg[1023].name)

				arg_58_1.leftNameTxt_.text = var_61_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(322281014)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 9
				local var_61_11 = utf8.len(var_61_9)
				local var_61_12 = var_61_10 <= 0 and var_61_6 or var_61_6 * (var_61_11 / var_61_10)

				if var_61_12 > 0 and var_61_6 < var_61_12 then
					arg_58_1.talkMaxDuration = var_61_12

					if var_61_12 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_5
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281014", "story_v_out_322281.awb") ~= 0 then
					local var_61_13 = manager.audio:GetVoiceLength("story_v_out_322281", "322281014", "story_v_out_322281.awb") / 1000

					if var_61_13 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_5
					end

					if var_61_8.prefab_name ~= "" and arg_58_1.actors_[var_61_8.prefab_name] ~= nil then
						local var_61_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_8.prefab_name].transform, "story_v_out_322281", "322281014", "story_v_out_322281.awb")

						arg_58_1:RecordAudio("322281014", var_61_14)
						arg_58_1:RecordAudio("322281014", var_61_14)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_322281", "322281014", "story_v_out_322281.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_322281", "322281014", "story_v_out_322281.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_15 = math.max(var_61_6, arg_58_1.talkMaxDuration)

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_15 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_5) / var_61_15

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_5 + var_61_15 and arg_58_1.time_ < var_61_5 + var_61_15 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play322281015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322281015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322281016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10101ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10101ui_story == nil then
				arg_62_1.var_.characterEffect10101ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect10101ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10101ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10101ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10101ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 1.475

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(322281015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 59
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play322281016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322281016
		arg_66_1.duration_ = 10.5

		local var_66_0 = {
			zh = 6.866,
			ja = 10.5
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322281017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10101ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10101ui_story == nil then
				arg_66_1.var_.characterEffect10101ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10101ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10101ui_story then
				arg_66_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_5 = 0
			local var_69_6 = 0.725

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_7 = arg_66_1:FormatText(StoryNameCfg[1023].name)

				arg_66_1.leftNameTxt_.text = var_69_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_8 = arg_66_1:GetWordFromCfg(322281016)
				local var_69_9 = arg_66_1:FormatText(var_69_8.content)

				arg_66_1.text_.text = var_69_9

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_10 = 29
				local var_69_11 = utf8.len(var_69_9)
				local var_69_12 = var_69_10 <= 0 and var_69_6 or var_69_6 * (var_69_11 / var_69_10)

				if var_69_12 > 0 and var_69_6 < var_69_12 then
					arg_66_1.talkMaxDuration = var_69_12

					if var_69_12 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_5
					end
				end

				arg_66_1.text_.text = var_69_9
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281016", "story_v_out_322281.awb") ~= 0 then
					local var_69_13 = manager.audio:GetVoiceLength("story_v_out_322281", "322281016", "story_v_out_322281.awb") / 1000

					if var_69_13 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_5
					end

					if var_69_8.prefab_name ~= "" and arg_66_1.actors_[var_69_8.prefab_name] ~= nil then
						local var_69_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_8.prefab_name].transform, "story_v_out_322281", "322281016", "story_v_out_322281.awb")

						arg_66_1:RecordAudio("322281016", var_69_14)
						arg_66_1:RecordAudio("322281016", var_69_14)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322281", "322281016", "story_v_out_322281.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322281", "322281016", "story_v_out_322281.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_15 = math.max(var_69_6, arg_66_1.talkMaxDuration)

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_15 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_5) / var_69_15

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_5 + var_69_15 and arg_66_1.time_ < var_69_5 + var_69_15 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play322281017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322281017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play322281018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10101ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10101ui_story == nil then
				arg_70_1.var_.characterEffect10101ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10101ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10101ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10101ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10101ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.375

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(322281017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 15
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play322281018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322281018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play322281019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.025

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(322281018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 41
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play322281019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322281019
		arg_78_1.duration_ = 8.43

		local var_78_0 = {
			zh = 6.3,
			ja = 8.433
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play322281020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10101ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10101ui_story == nil then
				arg_78_1.var_.characterEffect10101ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10101ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10101ui_story then
				arg_78_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_81_4 = 0

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_81_6 = 0
			local var_81_7 = 0.5

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[1023].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_9 = arg_78_1:GetWordFromCfg(322281019)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 20
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281019", "story_v_out_322281.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281019", "story_v_out_322281.awb") / 1000

					if var_81_14 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_6
					end

					if var_81_9.prefab_name ~= "" and arg_78_1.actors_[var_81_9.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_9.prefab_name].transform, "story_v_out_322281", "322281019", "story_v_out_322281.awb")

						arg_78_1:RecordAudio("322281019", var_81_15)
						arg_78_1:RecordAudio("322281019", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322281", "322281019", "story_v_out_322281.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322281", "322281019", "story_v_out_322281.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_16 and arg_78_1.time_ < var_81_6 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play322281020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322281020
		arg_82_1.duration_ = 17.03

		local var_82_0 = {
			zh = 11.033,
			ja = 17.033
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play322281021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 1.1

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[1023].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(322281020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 44
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281020", "story_v_out_322281.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281020", "story_v_out_322281.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_322281", "322281020", "story_v_out_322281.awb")

						arg_82_1:RecordAudio("322281020", var_85_9)
						arg_82_1:RecordAudio("322281020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322281", "322281020", "story_v_out_322281.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322281", "322281020", "story_v_out_322281.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322281021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322281021
		arg_86_1.duration_ = 15.37

		local var_86_0 = {
			zh = 13.433,
			ja = 15.366
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322281022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1.375

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[1023].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(322281021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 55
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281021", "story_v_out_322281.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281021", "story_v_out_322281.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_322281", "322281021", "story_v_out_322281.awb")

						arg_86_1:RecordAudio("322281021", var_89_9)
						arg_86_1:RecordAudio("322281021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322281", "322281021", "story_v_out_322281.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322281", "322281021", "story_v_out_322281.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play322281022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322281022
		arg_90_1.duration_ = 15.67

		local var_90_0 = {
			zh = 8.9,
			ja = 15.666
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play322281023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.7

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[1023].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(322281022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 28
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281022", "story_v_out_322281.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281022", "story_v_out_322281.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_322281", "322281022", "story_v_out_322281.awb")

						arg_90_1:RecordAudio("322281022", var_93_9)
						arg_90_1:RecordAudio("322281022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322281", "322281022", "story_v_out_322281.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322281", "322281022", "story_v_out_322281.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play322281023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322281023
		arg_94_1.duration_ = 10.43

		local var_94_0 = {
			zh = 10.433,
			ja = 9.6
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play322281024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.925

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[1023].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(322281023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 37
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281023", "story_v_out_322281.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281023", "story_v_out_322281.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_322281", "322281023", "story_v_out_322281.awb")

						arg_94_1:RecordAudio("322281023", var_97_9)
						arg_94_1:RecordAudio("322281023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322281", "322281023", "story_v_out_322281.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322281", "322281023", "story_v_out_322281.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322281024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322281024
		arg_98_1.duration_ = 5.97

		local var_98_0 = {
			zh = 5.4,
			ja = 5.966
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play322281025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_2")
			end

			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_101_2 = 0
			local var_101_3 = 0.425

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_4 = arg_98_1:FormatText(StoryNameCfg[1023].name)

				arg_98_1.leftNameTxt_.text = var_101_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_5 = arg_98_1:GetWordFromCfg(322281024)
				local var_101_6 = arg_98_1:FormatText(var_101_5.content)

				arg_98_1.text_.text = var_101_6

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 17
				local var_101_8 = utf8.len(var_101_6)
				local var_101_9 = var_101_7 <= 0 and var_101_3 or var_101_3 * (var_101_8 / var_101_7)

				if var_101_9 > 0 and var_101_3 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_6
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281024", "story_v_out_322281.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281024", "story_v_out_322281.awb") / 1000

					if var_101_10 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_2
					end

					if var_101_5.prefab_name ~= "" and arg_98_1.actors_[var_101_5.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_5.prefab_name].transform, "story_v_out_322281", "322281024", "story_v_out_322281.awb")

						arg_98_1:RecordAudio("322281024", var_101_11)
						arg_98_1:RecordAudio("322281024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322281", "322281024", "story_v_out_322281.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322281", "322281024", "story_v_out_322281.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_12 and arg_98_1.time_ < var_101_2 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play322281025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322281025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play322281026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10101ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10101ui_story == nil then
				arg_102_1.var_.characterEffect10101ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect10101ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10101ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10101ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10101ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 0.225

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_9 = arg_102_1:GetWordFromCfg(322281025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 9
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play322281026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322281026
		arg_106_1.duration_ = 7.93

		local var_106_0 = {
			zh = 5.966,
			ja = 7.933
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play322281027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10101ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10101ui_story == nil then
				arg_106_1.var_.characterEffect10101ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect10101ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10101ui_story then
				arg_106_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_109_4 = 0
			local var_109_5 = 0.425

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_6 = arg_106_1:FormatText(StoryNameCfg[1023].name)

				arg_106_1.leftNameTxt_.text = var_109_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_7 = arg_106_1:GetWordFromCfg(322281026)
				local var_109_8 = arg_106_1:FormatText(var_109_7.content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 17
				local var_109_10 = utf8.len(var_109_8)
				local var_109_11 = var_109_9 <= 0 and var_109_5 or var_109_5 * (var_109_10 / var_109_9)

				if var_109_11 > 0 and var_109_5 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_8
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281026", "story_v_out_322281.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281026", "story_v_out_322281.awb") / 1000

					if var_109_12 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_4
					end

					if var_109_7.prefab_name ~= "" and arg_106_1.actors_[var_109_7.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_7.prefab_name].transform, "story_v_out_322281", "322281026", "story_v_out_322281.awb")

						arg_106_1:RecordAudio("322281026", var_109_13)
						arg_106_1:RecordAudio("322281026", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322281", "322281026", "story_v_out_322281.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322281", "322281026", "story_v_out_322281.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_14 and arg_106_1.time_ < var_109_4 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322281027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322281027
		arg_110_1.duration_ = 7.07

		local var_110_0 = {
			zh = 5.999999999999,
			ja = 7.065999999999
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322281028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "ST2401"

			if arg_110_1.bgs_[var_113_0] == nil then
				local var_113_1 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_0)
				var_113_1.name = var_113_0
				var_113_1.transform.parent = arg_110_1.stage_.transform
				var_113_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_0] = var_113_1
			end

			local var_113_2 = 2

			if var_113_2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				local var_113_3 = manager.ui.mainCamera.transform.localPosition
				local var_113_4 = Vector3.New(0, 0, 10) + Vector3.New(var_113_3.x, var_113_3.y, 0)
				local var_113_5 = arg_110_1.bgs_.ST2401

				var_113_5.transform.localPosition = var_113_4
				var_113_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_6 = var_113_5:GetComponent("SpriteRenderer")

				if var_113_6 and var_113_6.sprite then
					local var_113_7 = (var_113_5.transform.localPosition - var_113_3).z
					local var_113_8 = manager.ui.mainCameraCom_
					local var_113_9 = 2 * var_113_7 * Mathf.Tan(var_113_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_10 = var_113_9 * var_113_8.aspect
					local var_113_11 = var_113_6.sprite.bounds.size.x
					local var_113_12 = var_113_6.sprite.bounds.size.y
					local var_113_13 = var_113_10 / var_113_11
					local var_113_14 = var_113_9 / var_113_12
					local var_113_15 = var_113_14 < var_113_13 and var_113_13 or var_113_14

					var_113_5.transform.localScale = Vector3.New(var_113_15, var_113_15, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "ST2401" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_16 = 3.999999999999

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_17 = 0.15

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_18 = 0

			if var_113_18 < arg_110_1.time_ and arg_110_1.time_ <= var_113_18 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_19 = 2

			if var_113_18 <= arg_110_1.time_ and arg_110_1.time_ < var_113_18 + var_113_19 then
				local var_113_20 = (arg_110_1.time_ - var_113_18) / var_113_19
				local var_113_21 = Color.New(0, 0, 0)

				var_113_21.a = Mathf.Lerp(0, 1, var_113_20)
				arg_110_1.mask_.color = var_113_21
			end

			if arg_110_1.time_ >= var_113_18 + var_113_19 and arg_110_1.time_ < var_113_18 + var_113_19 + arg_113_0 then
				local var_113_22 = Color.New(0, 0, 0)

				var_113_22.a = 1
				arg_110_1.mask_.color = var_113_22
			end

			local var_113_23 = 1.999999999999

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_24 = 2

			if var_113_23 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_24 then
				local var_113_25 = (arg_110_1.time_ - var_113_23) / var_113_24
				local var_113_26 = Color.New(0, 0, 0)

				var_113_26.a = Mathf.Lerp(1, 0, var_113_25)
				arg_110_1.mask_.color = var_113_26
			end

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 then
				local var_113_27 = Color.New(0, 0, 0)
				local var_113_28 = 0

				arg_110_1.mask_.enabled = false
				var_113_27.a = var_113_28
				arg_110_1.mask_.color = var_113_27
			end

			local var_113_29 = arg_110_1.actors_["10101ui_story"].transform
			local var_113_30 = 1.999999999999

			if var_113_30 < arg_110_1.time_ and arg_110_1.time_ <= var_113_30 + arg_113_0 then
				arg_110_1.var_.moveOldPos10101ui_story = var_113_29.localPosition
			end

			local var_113_31 = 0.001

			if var_113_30 <= arg_110_1.time_ and arg_110_1.time_ < var_113_30 + var_113_31 then
				local var_113_32 = (arg_110_1.time_ - var_113_30) / var_113_31
				local var_113_33 = Vector3.New(0, 100, 0)

				var_113_29.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10101ui_story, var_113_33, var_113_32)

				local var_113_34 = manager.ui.mainCamera.transform.position - var_113_29.position

				var_113_29.forward = Vector3.New(var_113_34.x, var_113_34.y, var_113_34.z)

				local var_113_35 = var_113_29.localEulerAngles

				var_113_35.z = 0
				var_113_35.x = 0
				var_113_29.localEulerAngles = var_113_35
			end

			if arg_110_1.time_ >= var_113_30 + var_113_31 and arg_110_1.time_ < var_113_30 + var_113_31 + arg_113_0 then
				var_113_29.localPosition = Vector3.New(0, 100, 0)

				local var_113_36 = manager.ui.mainCamera.transform.position - var_113_29.position

				var_113_29.forward = Vector3.New(var_113_36.x, var_113_36.y, var_113_36.z)

				local var_113_37 = var_113_29.localEulerAngles

				var_113_37.z = 0
				var_113_37.x = 0
				var_113_29.localEulerAngles = var_113_37
			end

			local var_113_38 = "1089ui_story"

			if arg_110_1.actors_[var_113_38] == nil then
				local var_113_39 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_113_39) then
					local var_113_40 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_110_1.stage_.transform)

					var_113_40.name = var_113_38
					var_113_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_110_1.actors_[var_113_38] = var_113_40

					local var_113_41 = var_113_40:GetComponentInChildren(typeof(CharacterEffect))

					var_113_41.enabled = true

					local var_113_42 = GameObjectTools.GetOrAddComponent(var_113_40, typeof(DynamicBoneHelper))

					if var_113_42 then
						var_113_42:EnableDynamicBone(false)
					end

					arg_110_1:ShowWeapon(var_113_41.transform, false)

					arg_110_1.var_[var_113_38 .. "Animator"] = var_113_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_110_1.var_[var_113_38 .. "Animator"].applyRootMotion = true
					arg_110_1.var_[var_113_38 .. "LipSync"] = var_113_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_113_43 = arg_110_1.actors_["1089ui_story"].transform
			local var_113_44 = 4

			if var_113_44 < arg_110_1.time_ and arg_110_1.time_ <= var_113_44 + arg_113_0 then
				arg_110_1.var_.moveOldPos1089ui_story = var_113_43.localPosition

				local var_113_45 = "1089ui_story"

				arg_110_1:ShowWeapon(arg_110_1.var_[var_113_45 .. "Animator"].transform, false)
			end

			local var_113_46 = 0.001

			if var_113_44 <= arg_110_1.time_ and arg_110_1.time_ < var_113_44 + var_113_46 then
				local var_113_47 = (arg_110_1.time_ - var_113_44) / var_113_46
				local var_113_48 = Vector3.New(0, -1.1, -6.17)

				var_113_43.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1089ui_story, var_113_48, var_113_47)

				local var_113_49 = manager.ui.mainCamera.transform.position - var_113_43.position

				var_113_43.forward = Vector3.New(var_113_49.x, var_113_49.y, var_113_49.z)

				local var_113_50 = var_113_43.localEulerAngles

				var_113_50.z = 0
				var_113_50.x = 0
				var_113_43.localEulerAngles = var_113_50
			end

			if arg_110_1.time_ >= var_113_44 + var_113_46 and arg_110_1.time_ < var_113_44 + var_113_46 + arg_113_0 then
				var_113_43.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_113_51 = manager.ui.mainCamera.transform.position - var_113_43.position

				var_113_43.forward = Vector3.New(var_113_51.x, var_113_51.y, var_113_51.z)

				local var_113_52 = var_113_43.localEulerAngles

				var_113_52.z = 0
				var_113_52.x = 0
				var_113_43.localEulerAngles = var_113_52
			end

			local var_113_53 = arg_110_1.actors_["1089ui_story"]
			local var_113_54 = 4

			if var_113_54 < arg_110_1.time_ and arg_110_1.time_ <= var_113_54 + arg_113_0 and not isNil(var_113_53) and arg_110_1.var_.characterEffect1089ui_story == nil then
				arg_110_1.var_.characterEffect1089ui_story = var_113_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_55 = 0.200000002980232

			if var_113_54 <= arg_110_1.time_ and arg_110_1.time_ < var_113_54 + var_113_55 and not isNil(var_113_53) then
				local var_113_56 = (arg_110_1.time_ - var_113_54) / var_113_55

				if arg_110_1.var_.characterEffect1089ui_story and not isNil(var_113_53) then
					arg_110_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_54 + var_113_55 and arg_110_1.time_ < var_113_54 + var_113_55 + arg_113_0 and not isNil(var_113_53) and arg_110_1.var_.characterEffect1089ui_story then
				arg_110_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_113_57 = 4

			if var_113_57 < arg_110_1.time_ and arg_110_1.time_ <= var_113_57 + arg_113_0 then
				arg_110_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_113_58 = 4

			if var_113_58 < arg_110_1.time_ and arg_110_1.time_ <= var_113_58 + arg_113_0 then
				arg_110_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_113_59 = 0.2
			local var_113_60 = 1

			if var_113_59 < arg_110_1.time_ and arg_110_1.time_ <= var_113_59 + arg_113_0 then
				local var_113_61 = "stop"
				local var_113_62 = "effect"

				arg_110_1:AudioAction(var_113_61, var_113_62, "se_story_side_1037", "se_story_1037_ui_loop", "")
			end

			local var_113_63 = 1.63333333333333
			local var_113_64 = 1

			if var_113_63 < arg_110_1.time_ and arg_110_1.time_ <= var_113_63 + arg_113_0 then
				local var_113_65 = "play"
				local var_113_66 = "effect"

				arg_110_1:AudioAction(var_113_65, var_113_66, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_67 = 3.999999999999
			local var_113_68 = 0.15

			if var_113_67 < arg_110_1.time_ and arg_110_1.time_ <= var_113_67 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_69 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_69:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_70 = arg_110_1:FormatText(StoryNameCfg[1031].name)

				arg_110_1.leftNameTxt_.text = var_113_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_71 = arg_110_1:GetWordFromCfg(322281027)
				local var_113_72 = arg_110_1:FormatText(var_113_71.content)

				arg_110_1.text_.text = var_113_72

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_73 = 6
				local var_113_74 = utf8.len(var_113_72)
				local var_113_75 = var_113_73 <= 0 and var_113_68 or var_113_68 * (var_113_74 / var_113_73)

				if var_113_75 > 0 and var_113_68 < var_113_75 then
					arg_110_1.talkMaxDuration = var_113_75
					var_113_67 = var_113_67 + 0.3

					if var_113_75 + var_113_67 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_75 + var_113_67
					end
				end

				arg_110_1.text_.text = var_113_72
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281027", "story_v_out_322281.awb") ~= 0 then
					local var_113_76 = manager.audio:GetVoiceLength("story_v_out_322281", "322281027", "story_v_out_322281.awb") / 1000

					if var_113_76 + var_113_67 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_76 + var_113_67
					end

					if var_113_71.prefab_name ~= "" and arg_110_1.actors_[var_113_71.prefab_name] ~= nil then
						local var_113_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_71.prefab_name].transform, "story_v_out_322281", "322281027", "story_v_out_322281.awb")

						arg_110_1:RecordAudio("322281027", var_113_77)
						arg_110_1:RecordAudio("322281027", var_113_77)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322281", "322281027", "story_v_out_322281.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322281", "322281027", "story_v_out_322281.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_78 = var_113_67 + 0.3
			local var_113_79 = math.max(var_113_68, arg_110_1.talkMaxDuration)

			if var_113_78 <= arg_110_1.time_ and arg_110_1.time_ < var_113_78 + var_113_79 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_78) / var_113_79

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_78 + var_113_79 and arg_110_1.time_ < var_113_78 + var_113_79 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play322281028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322281028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322281029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1089ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1089ui_story == nil then
				arg_116_1.var_.characterEffect1089ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1089ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1089ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1089ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1089ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.175

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_9 = arg_116_1:GetWordFromCfg(322281028)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 7
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_14 and arg_116_1.time_ < var_119_6 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play322281029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322281029
		arg_120_1.duration_ = 2

		local var_120_0 = {
			zh = 2,
			ja = 1.999999999999
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play322281030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1089ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1089ui_story == nil then
				arg_120_1.var_.characterEffect1089ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1089ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1089ui_story then
				arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_123_4 = 0

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_123_5 = 0
			local var_123_6 = 0.175

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_7 = arg_120_1:FormatText(StoryNameCfg[1031].name)

				arg_120_1.leftNameTxt_.text = var_123_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(322281029)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 7
				local var_123_11 = utf8.len(var_123_9)
				local var_123_12 = var_123_10 <= 0 and var_123_6 or var_123_6 * (var_123_11 / var_123_10)

				if var_123_12 > 0 and var_123_6 < var_123_12 then
					arg_120_1.talkMaxDuration = var_123_12

					if var_123_12 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281029", "story_v_out_322281.awb") ~= 0 then
					local var_123_13 = manager.audio:GetVoiceLength("story_v_out_322281", "322281029", "story_v_out_322281.awb") / 1000

					if var_123_13 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_5
					end

					if var_123_8.prefab_name ~= "" and arg_120_1.actors_[var_123_8.prefab_name] ~= nil then
						local var_123_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_8.prefab_name].transform, "story_v_out_322281", "322281029", "story_v_out_322281.awb")

						arg_120_1:RecordAudio("322281029", var_123_14)
						arg_120_1:RecordAudio("322281029", var_123_14)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322281", "322281029", "story_v_out_322281.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322281", "322281029", "story_v_out_322281.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_15 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_15 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_15

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_15 and arg_120_1.time_ < var_123_5 + var_123_15 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play322281030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322281030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322281031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1089ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1089ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1089ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = 0
			local var_127_10 = 1.75

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_11 = arg_124_1:GetWordFromCfg(322281030)
				local var_127_12 = arg_124_1:FormatText(var_127_11.content)

				arg_124_1.text_.text = var_127_12

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 70
				local var_127_14 = utf8.len(var_127_12)
				local var_127_15 = var_127_13 <= 0 and var_127_10 or var_127_10 * (var_127_14 / var_127_13)

				if var_127_15 > 0 and var_127_10 < var_127_15 then
					arg_124_1.talkMaxDuration = var_127_15

					if var_127_15 + var_127_9 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_15 + var_127_9
					end
				end

				arg_124_1.text_.text = var_127_12
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_10, arg_124_1.talkMaxDuration)

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_9) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_9 + var_127_16 and arg_124_1.time_ < var_127_9 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play322281031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322281031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play322281032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 1.05

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(322281031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 42
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play322281032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322281032
		arg_132_1.duration_ = 5.27

		local var_132_0 = {
			zh = 3.3,
			ja = 5.266
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play322281033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1089ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1089ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, -1.1, -6.17)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1089ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1089ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1089ui_story == nil then
				arg_132_1.var_.characterEffect1089ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect1089ui_story and not isNil(var_135_9) then
					arg_132_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1089ui_story then
				arg_132_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_135_14 = 0
			local var_135_15 = 0.4

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_16 = arg_132_1:FormatText(StoryNameCfg[1031].name)

				arg_132_1.leftNameTxt_.text = var_135_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_17 = arg_132_1:GetWordFromCfg(322281032)
				local var_135_18 = arg_132_1:FormatText(var_135_17.content)

				arg_132_1.text_.text = var_135_18

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_19 = 16
				local var_135_20 = utf8.len(var_135_18)
				local var_135_21 = var_135_19 <= 0 and var_135_15 or var_135_15 * (var_135_20 / var_135_19)

				if var_135_21 > 0 and var_135_15 < var_135_21 then
					arg_132_1.talkMaxDuration = var_135_21

					if var_135_21 + var_135_14 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_21 + var_135_14
					end
				end

				arg_132_1.text_.text = var_135_18
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281032", "story_v_out_322281.awb") ~= 0 then
					local var_135_22 = manager.audio:GetVoiceLength("story_v_out_322281", "322281032", "story_v_out_322281.awb") / 1000

					if var_135_22 + var_135_14 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_14
					end

					if var_135_17.prefab_name ~= "" and arg_132_1.actors_[var_135_17.prefab_name] ~= nil then
						local var_135_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_17.prefab_name].transform, "story_v_out_322281", "322281032", "story_v_out_322281.awb")

						arg_132_1:RecordAudio("322281032", var_135_23)
						arg_132_1:RecordAudio("322281032", var_135_23)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322281", "322281032", "story_v_out_322281.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322281", "322281032", "story_v_out_322281.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_24 = math.max(var_135_15, arg_132_1.talkMaxDuration)

			if var_135_14 <= arg_132_1.time_ and arg_132_1.time_ < var_135_14 + var_135_24 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_14) / var_135_24

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_14 + var_135_24 and arg_132_1.time_ < var_135_14 + var_135_24 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play322281033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322281033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play322281034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1089ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1089ui_story == nil then
				arg_136_1.var_.characterEffect1089ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1089ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1089ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1089ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1089ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.325

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(322281033)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 13
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play322281034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322281034
		arg_140_1.duration_ = 8.03

		local var_140_0 = {
			zh = 6.1,
			ja = 8.033
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play322281035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1089ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1089ui_story == nil then
				arg_140_1.var_.characterEffect1089ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1089ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1089ui_story then
				arg_140_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_143_4 = 0

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_143_5 = 0
			local var_143_6 = 0.725

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_7 = arg_140_1:FormatText(StoryNameCfg[1031].name)

				arg_140_1.leftNameTxt_.text = var_143_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(322281034)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_10 = 29
				local var_143_11 = utf8.len(var_143_9)
				local var_143_12 = var_143_10 <= 0 and var_143_6 or var_143_6 * (var_143_11 / var_143_10)

				if var_143_12 > 0 and var_143_6 < var_143_12 then
					arg_140_1.talkMaxDuration = var_143_12

					if var_143_12 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281034", "story_v_out_322281.awb") ~= 0 then
					local var_143_13 = manager.audio:GetVoiceLength("story_v_out_322281", "322281034", "story_v_out_322281.awb") / 1000

					if var_143_13 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_5
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_out_322281", "322281034", "story_v_out_322281.awb")

						arg_140_1:RecordAudio("322281034", var_143_14)
						arg_140_1:RecordAudio("322281034", var_143_14)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322281", "322281034", "story_v_out_322281.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322281", "322281034", "story_v_out_322281.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_15 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_15 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_15

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_15 and arg_140_1.time_ < var_143_5 + var_143_15 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322281035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322281035
		arg_144_1.duration_ = 15.83

		local var_144_0 = {
			zh = 10.9,
			ja = 15.833
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play322281036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.275

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[1031].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:GetWordFromCfg(322281035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 51
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281035", "story_v_out_322281.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281035", "story_v_out_322281.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_322281", "322281035", "story_v_out_322281.awb")

						arg_144_1:RecordAudio("322281035", var_147_9)
						arg_144_1:RecordAudio("322281035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322281", "322281035", "story_v_out_322281.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322281", "322281035", "story_v_out_322281.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play322281036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322281036
		arg_148_1.duration_ = 23.77

		local var_148_0 = {
			zh = 11.566,
			ja = 23.766
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322281037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_151_1 = 0
			local var_151_2 = 1.3

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_3 = arg_148_1:FormatText(StoryNameCfg[1031].name)

				arg_148_1.leftNameTxt_.text = var_151_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:GetWordFromCfg(322281036)
				local var_151_5 = arg_148_1:FormatText(var_151_4.content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 52
				local var_151_7 = utf8.len(var_151_5)
				local var_151_8 = var_151_6 <= 0 and var_151_2 or var_151_2 * (var_151_7 / var_151_6)

				if var_151_8 > 0 and var_151_2 < var_151_8 then
					arg_148_1.talkMaxDuration = var_151_8

					if var_151_8 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281036", "story_v_out_322281.awb") ~= 0 then
					local var_151_9 = manager.audio:GetVoiceLength("story_v_out_322281", "322281036", "story_v_out_322281.awb") / 1000

					if var_151_9 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_1
					end

					if var_151_4.prefab_name ~= "" and arg_148_1.actors_[var_151_4.prefab_name] ~= nil then
						local var_151_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_4.prefab_name].transform, "story_v_out_322281", "322281036", "story_v_out_322281.awb")

						arg_148_1:RecordAudio("322281036", var_151_10)
						arg_148_1:RecordAudio("322281036", var_151_10)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_322281", "322281036", "story_v_out_322281.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_322281", "322281036", "story_v_out_322281.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_11 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_11 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_11

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_11 and arg_148_1.time_ < var_151_1 + var_151_11 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play322281037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322281037
		arg_152_1.duration_ = 7.13

		local var_152_0 = {
			zh = 5.633,
			ja = 7.133
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play322281038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			local var_155_2 = 2

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			local var_155_3 = 0
			local var_155_4 = 0.625

			if var_155_3 < arg_152_1.time_ and arg_152_1.time_ <= var_155_3 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_5 = arg_152_1:FormatText(StoryNameCfg[1031].name)

				arg_152_1.leftNameTxt_.text = var_155_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(322281037)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_8 = 25
				local var_155_9 = utf8.len(var_155_7)
				local var_155_10 = var_155_8 <= 0 and var_155_4 or var_155_4 * (var_155_9 / var_155_8)

				if var_155_10 > 0 and var_155_4 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_3 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_3
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281037", "story_v_out_322281.awb") ~= 0 then
					local var_155_11 = manager.audio:GetVoiceLength("story_v_out_322281", "322281037", "story_v_out_322281.awb") / 1000

					if var_155_11 + var_155_3 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_3
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_322281", "322281037", "story_v_out_322281.awb")

						arg_152_1:RecordAudio("322281037", var_155_12)
						arg_152_1:RecordAudio("322281037", var_155_12)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322281", "322281037", "story_v_out_322281.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322281", "322281037", "story_v_out_322281.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_13 = math.max(var_155_4, arg_152_1.talkMaxDuration)

			if var_155_3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_3 + var_155_13 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_3) / var_155_13

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_3 + var_155_13 and arg_152_1.time_ < var_155_3 + var_155_13 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play322281038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322281038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322281039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1089ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1089ui_story == nil then
				arg_156_1.var_.characterEffect1089ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1089ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1089ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1089ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1089ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.25

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_9 = arg_156_1:GetWordFromCfg(322281038)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 10
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_7 or var_159_7 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_7 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play322281039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322281039
		arg_160_1.duration_ = 5.83

		local var_160_0 = {
			zh = 3.566,
			ja = 5.833
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322281040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1089ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1089ui_story == nil then
				arg_160_1.var_.characterEffect1089ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1089ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1089ui_story then
				arg_160_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_163_4 = 0
			local var_163_5 = 0.4

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_6 = arg_160_1:FormatText(StoryNameCfg[1031].name)

				arg_160_1.leftNameTxt_.text = var_163_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_7 = arg_160_1:GetWordFromCfg(322281039)
				local var_163_8 = arg_160_1:FormatText(var_163_7.content)

				arg_160_1.text_.text = var_163_8

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_9 = 16
				local var_163_10 = utf8.len(var_163_8)
				local var_163_11 = var_163_9 <= 0 and var_163_5 or var_163_5 * (var_163_10 / var_163_9)

				if var_163_11 > 0 and var_163_5 < var_163_11 then
					arg_160_1.talkMaxDuration = var_163_11

					if var_163_11 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_8
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281039", "story_v_out_322281.awb") ~= 0 then
					local var_163_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281039", "story_v_out_322281.awb") / 1000

					if var_163_12 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_4
					end

					if var_163_7.prefab_name ~= "" and arg_160_1.actors_[var_163_7.prefab_name] ~= nil then
						local var_163_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_7.prefab_name].transform, "story_v_out_322281", "322281039", "story_v_out_322281.awb")

						arg_160_1:RecordAudio("322281039", var_163_13)
						arg_160_1:RecordAudio("322281039", var_163_13)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322281", "322281039", "story_v_out_322281.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322281", "322281039", "story_v_out_322281.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_14 and arg_160_1.time_ < var_163_4 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322281040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322281040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322281041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1089ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1089ui_story == nil then
				arg_164_1.var_.characterEffect1089ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1089ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1089ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1089ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1089ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.2

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_9 = arg_164_1:GetWordFromCfg(322281040)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 8
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play322281041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 322281041
		arg_168_1.duration_ = 13

		local var_168_0 = {
			zh = 9.4,
			ja = 13
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play322281042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1089ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1089ui_story == nil then
				arg_168_1.var_.characterEffect1089ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1089ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1089ui_story then
				arg_168_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_1")
			end

			local var_171_5 = 2.13333333333333

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_2")
			end

			local var_171_6 = 0

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 then
				arg_168_1.allBtn_.enabled = false
			end

			local var_171_8 = 3.93333333333333

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 then
				arg_168_1.allBtn_.enabled = true
			end

			local var_171_9 = 0
			local var_171_10 = 0.825

			if var_171_9 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_11 = arg_168_1:FormatText(StoryNameCfg[1031].name)

				arg_168_1.leftNameTxt_.text = var_171_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_12 = arg_168_1:GetWordFromCfg(322281041)
				local var_171_13 = arg_168_1:FormatText(var_171_12.content)

				arg_168_1.text_.text = var_171_13

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_14 = 33
				local var_171_15 = utf8.len(var_171_13)
				local var_171_16 = var_171_14 <= 0 and var_171_10 or var_171_10 * (var_171_15 / var_171_14)

				if var_171_16 > 0 and var_171_10 < var_171_16 then
					arg_168_1.talkMaxDuration = var_171_16

					if var_171_16 + var_171_9 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_9
					end
				end

				arg_168_1.text_.text = var_171_13
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281041", "story_v_out_322281.awb") ~= 0 then
					local var_171_17 = manager.audio:GetVoiceLength("story_v_out_322281", "322281041", "story_v_out_322281.awb") / 1000

					if var_171_17 + var_171_9 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_17 + var_171_9
					end

					if var_171_12.prefab_name ~= "" and arg_168_1.actors_[var_171_12.prefab_name] ~= nil then
						local var_171_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_12.prefab_name].transform, "story_v_out_322281", "322281041", "story_v_out_322281.awb")

						arg_168_1:RecordAudio("322281041", var_171_18)
						arg_168_1:RecordAudio("322281041", var_171_18)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_322281", "322281041", "story_v_out_322281.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_322281", "322281041", "story_v_out_322281.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_19 = math.max(var_171_10, arg_168_1.talkMaxDuration)

			if var_171_9 <= arg_168_1.time_ and arg_168_1.time_ < var_171_9 + var_171_19 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_9) / var_171_19

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_9 + var_171_19 and arg_168_1.time_ < var_171_9 + var_171_19 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play322281042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322281042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play322281043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1089ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1089ui_story == nil then
				arg_172_1.var_.characterEffect1089ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1089ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1089ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1089ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1089ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.65

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(322281042)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 26
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play322281043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322281043
		arg_176_1.duration_ = 19.2

		local var_176_0 = {
			zh = 12.066,
			ja = 19.2
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322281044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1089ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1089ui_story == nil then
				arg_176_1.var_.characterEffect1089ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1089ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1089ui_story then
				arg_176_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_179_6 = 0
			local var_179_7 = 1.225

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[1031].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_9 = arg_176_1:GetWordFromCfg(322281043)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 49
				local var_179_12 = utf8.len(var_179_10)
				local var_179_13 = var_179_11 <= 0 and var_179_7 or var_179_7 * (var_179_12 / var_179_11)

				if var_179_13 > 0 and var_179_7 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_10
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281043", "story_v_out_322281.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281043", "story_v_out_322281.awb") / 1000

					if var_179_14 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_6
					end

					if var_179_9.prefab_name ~= "" and arg_176_1.actors_[var_179_9.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_9.prefab_name].transform, "story_v_out_322281", "322281043", "story_v_out_322281.awb")

						arg_176_1:RecordAudio("322281043", var_179_15)
						arg_176_1:RecordAudio("322281043", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_322281", "322281043", "story_v_out_322281.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_322281", "322281043", "story_v_out_322281.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_16 and arg_176_1.time_ < var_179_6 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play322281044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322281044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322281045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1089ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1089ui_story == nil then
				arg_180_1.var_.characterEffect1089ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1089ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1089ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1089ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1089ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.4

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[7].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(322281044)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 16
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play322281045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322281045
		arg_184_1.duration_ = 6.4

		local var_184_0 = {
			zh = 5.466,
			ja = 6.4
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322281046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1089ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1089ui_story == nil then
				arg_184_1.var_.characterEffect1089ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1089ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1089ui_story then
				arg_184_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_1")
			end

			local var_187_5 = 0
			local var_187_6 = 0.45

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_7 = arg_184_1:FormatText(StoryNameCfg[1031].name)

				arg_184_1.leftNameTxt_.text = var_187_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_8 = arg_184_1:GetWordFromCfg(322281045)
				local var_187_9 = arg_184_1:FormatText(var_187_8.content)

				arg_184_1.text_.text = var_187_9

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 18
				local var_187_11 = utf8.len(var_187_9)
				local var_187_12 = var_187_10 <= 0 and var_187_6 or var_187_6 * (var_187_11 / var_187_10)

				if var_187_12 > 0 and var_187_6 < var_187_12 then
					arg_184_1.talkMaxDuration = var_187_12

					if var_187_12 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_12 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_9
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281045", "story_v_out_322281.awb") ~= 0 then
					local var_187_13 = manager.audio:GetVoiceLength("story_v_out_322281", "322281045", "story_v_out_322281.awb") / 1000

					if var_187_13 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_5
					end

					if var_187_8.prefab_name ~= "" and arg_184_1.actors_[var_187_8.prefab_name] ~= nil then
						local var_187_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_8.prefab_name].transform, "story_v_out_322281", "322281045", "story_v_out_322281.awb")

						arg_184_1:RecordAudio("322281045", var_187_14)
						arg_184_1:RecordAudio("322281045", var_187_14)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_322281", "322281045", "story_v_out_322281.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_322281", "322281045", "story_v_out_322281.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_15 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_15 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_15

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_15 and arg_184_1.time_ < var_187_5 + var_187_15 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play322281046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322281046
		arg_188_1.duration_ = 9

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play322281047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 4

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			local var_191_1 = 0.3

			if arg_188_1.time_ >= var_191_0 + var_191_1 and arg_188_1.time_ < var_191_0 + var_191_1 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end

			local var_191_2 = "L01f"

			if arg_188_1.bgs_[var_191_2] == nil then
				local var_191_3 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_191_2)
				var_191_3.name = var_191_2
				var_191_3.transform.parent = arg_188_1.stage_.transform
				var_191_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_[var_191_2] = var_191_3
			end

			local var_191_4 = 1.999999999999

			if var_191_4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				local var_191_5 = manager.ui.mainCamera.transform.localPosition
				local var_191_6 = Vector3.New(0, 0, 10) + Vector3.New(var_191_5.x, var_191_5.y, 0)
				local var_191_7 = arg_188_1.bgs_.L01f

				var_191_7.transform.localPosition = var_191_6
				var_191_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_8 = var_191_7:GetComponent("SpriteRenderer")

				if var_191_8 and var_191_8.sprite then
					local var_191_9 = (var_191_7.transform.localPosition - var_191_5).z
					local var_191_10 = manager.ui.mainCameraCom_
					local var_191_11 = 2 * var_191_9 * Mathf.Tan(var_191_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_191_12 = var_191_11 * var_191_10.aspect
					local var_191_13 = var_191_8.sprite.bounds.size.x
					local var_191_14 = var_191_8.sprite.bounds.size.y
					local var_191_15 = var_191_12 / var_191_13
					local var_191_16 = var_191_11 / var_191_14
					local var_191_17 = var_191_16 < var_191_15 and var_191_15 or var_191_16

					var_191_7.transform.localScale = Vector3.New(var_191_17, var_191_17, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "L01f" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_18 = 0

			if var_191_18 < arg_188_1.time_ and arg_188_1.time_ <= var_191_18 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_19 = 2

			if var_191_18 <= arg_188_1.time_ and arg_188_1.time_ < var_191_18 + var_191_19 then
				local var_191_20 = (arg_188_1.time_ - var_191_18) / var_191_19
				local var_191_21 = Color.New(0, 0, 0)

				var_191_21.a = Mathf.Lerp(0, 1, var_191_20)
				arg_188_1.mask_.color = var_191_21
			end

			if arg_188_1.time_ >= var_191_18 + var_191_19 and arg_188_1.time_ < var_191_18 + var_191_19 + arg_191_0 then
				local var_191_22 = Color.New(0, 0, 0)

				var_191_22.a = 1
				arg_188_1.mask_.color = var_191_22
			end

			local var_191_23 = 2

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_24 = 2

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_24 then
				local var_191_25 = (arg_188_1.time_ - var_191_23) / var_191_24
				local var_191_26 = Color.New(0, 0, 0)

				var_191_26.a = Mathf.Lerp(1, 0, var_191_25)
				arg_188_1.mask_.color = var_191_26
			end

			if arg_188_1.time_ >= var_191_23 + var_191_24 and arg_188_1.time_ < var_191_23 + var_191_24 + arg_191_0 then
				local var_191_27 = Color.New(0, 0, 0)
				local var_191_28 = 0

				arg_188_1.mask_.enabled = false
				var_191_27.a = var_191_28
				arg_188_1.mask_.color = var_191_27
			end

			local var_191_29 = arg_188_1.actors_["1089ui_story"].transform
			local var_191_30 = 2

			if var_191_30 < arg_188_1.time_ and arg_188_1.time_ <= var_191_30 + arg_191_0 then
				arg_188_1.var_.moveOldPos1089ui_story = var_191_29.localPosition
			end

			local var_191_31 = 0.001

			if var_191_30 <= arg_188_1.time_ and arg_188_1.time_ < var_191_30 + var_191_31 then
				local var_191_32 = (arg_188_1.time_ - var_191_30) / var_191_31
				local var_191_33 = Vector3.New(0, 100, 0)

				var_191_29.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1089ui_story, var_191_33, var_191_32)

				local var_191_34 = manager.ui.mainCamera.transform.position - var_191_29.position

				var_191_29.forward = Vector3.New(var_191_34.x, var_191_34.y, var_191_34.z)

				local var_191_35 = var_191_29.localEulerAngles

				var_191_35.z = 0
				var_191_35.x = 0
				var_191_29.localEulerAngles = var_191_35
			end

			if arg_188_1.time_ >= var_191_30 + var_191_31 and arg_188_1.time_ < var_191_30 + var_191_31 + arg_191_0 then
				var_191_29.localPosition = Vector3.New(0, 100, 0)

				local var_191_36 = manager.ui.mainCamera.transform.position - var_191_29.position

				var_191_29.forward = Vector3.New(var_191_36.x, var_191_36.y, var_191_36.z)

				local var_191_37 = var_191_29.localEulerAngles

				var_191_37.z = 0
				var_191_37.x = 0
				var_191_29.localEulerAngles = var_191_37
			end

			local var_191_38 = 0.1
			local var_191_39 = 1

			if var_191_38 < arg_188_1.time_ and arg_188_1.time_ <= var_191_38 + arg_191_0 then
				local var_191_40 = "stop"
				local var_191_41 = "effect"

				arg_188_1:AudioAction(var_191_40, var_191_41, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			local var_191_42 = 1.66666666666667
			local var_191_43 = 1

			if var_191_42 < arg_188_1.time_ and arg_188_1.time_ <= var_191_42 + arg_191_0 then
				local var_191_44 = "play"
				local var_191_45 = "effect"

				arg_188_1:AudioAction(var_191_44, var_191_45, "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_46 = 4
			local var_191_47 = 1.025

			if var_191_46 < arg_188_1.time_ and arg_188_1.time_ <= var_191_46 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_48 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_48:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_49 = arg_188_1:GetWordFromCfg(322281046)
				local var_191_50 = arg_188_1:FormatText(var_191_49.content)

				arg_188_1.text_.text = var_191_50

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_51 = 41
				local var_191_52 = utf8.len(var_191_50)
				local var_191_53 = var_191_51 <= 0 and var_191_47 or var_191_47 * (var_191_52 / var_191_51)

				if var_191_53 > 0 and var_191_47 < var_191_53 then
					arg_188_1.talkMaxDuration = var_191_53
					var_191_46 = var_191_46 + 0.3

					if var_191_53 + var_191_46 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_53 + var_191_46
					end
				end

				arg_188_1.text_.text = var_191_50
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_54 = var_191_46 + 0.3
			local var_191_55 = math.max(var_191_47, arg_188_1.talkMaxDuration)

			if var_191_54 <= arg_188_1.time_ and arg_188_1.time_ < var_191_54 + var_191_55 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_54) / var_191_55

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_54 + var_191_55 and arg_188_1.time_ < var_191_54 + var_191_55 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play322281047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 322281047
		arg_194_1.duration_ = 6

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play322281048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.1
			local var_197_1 = 1

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				local var_197_2 = "play"
				local var_197_3 = "effect"

				arg_194_1:AudioAction(var_197_2, var_197_3, "se_story_1310", "se_story_1310_car01", "")
			end

			local var_197_4 = manager.ui.mainCamera.transform
			local var_197_5 = 0.366666666666667

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				local var_197_6 = arg_194_1.var_.effect1047
				local var_197_7
				local var_197_8 = var_197_4

				if not var_197_6 then
					var_197_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_197_8)
					var_197_6.name = "1047"
					arg_194_1.var_.effect1047 = var_197_6
				else
					var_197_6.transform:SetParent(var_197_8)
				end

				var_197_6.transform.localPosition = Vector3.New(0, 0, -2.86)
				var_197_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_197_9 = manager.ui.mainCameraCom_
				local var_197_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_197_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_197_11 = var_197_6.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_197_12 = 15
				local var_197_13 = 2 * var_197_12 * Mathf.Tan(var_197_9.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_197_9.aspect
				local var_197_14 = 1
				local var_197_15 = 1.7777777777777777

				if var_197_15 < var_197_9.aspect then
					var_197_14 = var_197_13 / (2 * var_197_12 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_197_15)
				end

				for iter_197_0, iter_197_1 in ipairs(var_197_11) do
					local var_197_16 = iter_197_1.transform.localScale

					iter_197_1.transform.localScale = Vector3.New(var_197_16.x / var_197_10 * var_197_14, var_197_16.y / var_197_10, var_197_16.z)
				end
			end

			local var_197_17 = arg_194_1.bgs_.L01f.transform
			local var_197_18 = 0.366666666666667

			if var_197_18 < arg_194_1.time_ and arg_194_1.time_ <= var_197_18 + arg_197_0 then
				arg_194_1.var_.moveOldPosL01f = var_197_17.localPosition
			end

			local var_197_19 = 0.833333333333333

			if var_197_18 <= arg_194_1.time_ and arg_194_1.time_ < var_197_18 + var_197_19 then
				local var_197_20 = (arg_194_1.time_ - var_197_18) / var_197_19
				local var_197_21 = Vector3.New(0, 1, 8)

				var_197_17.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPosL01f, var_197_21, var_197_20)
			end

			if arg_194_1.time_ >= var_197_18 + var_197_19 and arg_194_1.time_ < var_197_18 + var_197_19 + arg_197_0 then
				var_197_17.localPosition = Vector3.New(0, 1, 8)
			end

			local var_197_22 = 0

			if var_197_22 < arg_194_1.time_ and arg_194_1.time_ <= var_197_22 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			local var_197_23 = 2.13333333333333

			if arg_194_1.time_ >= var_197_22 + var_197_23 and arg_194_1.time_ < var_197_22 + var_197_23 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_24 = 1
			local var_197_25 = 1.4

			if var_197_24 < arg_194_1.time_ and arg_194_1.time_ <= var_197_24 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_26 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_26:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_194_1.dialogCg_.alpha = arg_198_0
				end))
				var_197_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_27 = arg_194_1:GetWordFromCfg(322281047)
				local var_197_28 = arg_194_1:FormatText(var_197_27.content)

				arg_194_1.text_.text = var_197_28

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_29 = 56
				local var_197_30 = utf8.len(var_197_28)
				local var_197_31 = var_197_29 <= 0 and var_197_25 or var_197_25 * (var_197_30 / var_197_29)

				if var_197_31 > 0 and var_197_25 < var_197_31 then
					arg_194_1.talkMaxDuration = var_197_31
					var_197_24 = var_197_24 + 0.3

					if var_197_31 + var_197_24 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_31 + var_197_24
					end
				end

				arg_194_1.text_.text = var_197_28
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_32 = var_197_24 + 0.3
			local var_197_33 = math.max(var_197_25, arg_194_1.talkMaxDuration)

			if var_197_32 <= arg_194_1.time_ and arg_194_1.time_ < var_197_32 + var_197_33 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_32) / var_197_33

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_32 + var_197_33 and arg_194_1.time_ < var_197_32 + var_197_33 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "L01f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.833333333333333,
				startTime = 0.366666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play322281048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 322281048
		arg_200_1.duration_ = 2.37

		local var_200_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play322281049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = "1211ui_story"

			if arg_200_1.actors_[var_203_0] == nil then
				local var_203_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_203_1) then
					local var_203_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_200_1.stage_.transform)

					var_203_2.name = var_203_0
					var_203_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_200_1.actors_[var_203_0] = var_203_2

					local var_203_3 = var_203_2:GetComponentInChildren(typeof(CharacterEffect))

					var_203_3.enabled = true

					local var_203_4 = GameObjectTools.GetOrAddComponent(var_203_2, typeof(DynamicBoneHelper))

					if var_203_4 then
						var_203_4:EnableDynamicBone(false)
					end

					arg_200_1:ShowWeapon(var_203_3.transform, false)

					arg_200_1.var_[var_203_0 .. "Animator"] = var_203_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_200_1.var_[var_203_0 .. "Animator"].applyRootMotion = true
					arg_200_1.var_[var_203_0 .. "LipSync"] = var_203_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_203_5 = arg_200_1.actors_["1211ui_story"].transform
			local var_203_6 = 0

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.var_.moveOldPos1211ui_story = var_203_5.localPosition

				local var_203_7 = "1211ui_story"

				arg_200_1:ShowWeapon(arg_200_1.var_[var_203_7 .. "Animator"].transform, false)
			end

			local var_203_8 = 0.001

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_8 then
				local var_203_9 = (arg_200_1.time_ - var_203_6) / var_203_8
				local var_203_10 = Vector3.New(0, -0.67, -6.07)

				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1211ui_story, var_203_10, var_203_9)

				local var_203_11 = manager.ui.mainCamera.transform.position - var_203_5.position

				var_203_5.forward = Vector3.New(var_203_11.x, var_203_11.y, var_203_11.z)

				local var_203_12 = var_203_5.localEulerAngles

				var_203_12.z = 0
				var_203_12.x = 0
				var_203_5.localEulerAngles = var_203_12
			end

			if arg_200_1.time_ >= var_203_6 + var_203_8 and arg_200_1.time_ < var_203_6 + var_203_8 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_203_13 = manager.ui.mainCamera.transform.position - var_203_5.position

				var_203_5.forward = Vector3.New(var_203_13.x, var_203_13.y, var_203_13.z)

				local var_203_14 = var_203_5.localEulerAngles

				var_203_14.z = 0
				var_203_14.x = 0
				var_203_5.localEulerAngles = var_203_14
			end

			local var_203_15 = arg_200_1.actors_["1211ui_story"]
			local var_203_16 = 0

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 and not isNil(var_203_15) and arg_200_1.var_.characterEffect1211ui_story == nil then
				arg_200_1.var_.characterEffect1211ui_story = var_203_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_17 = 0.200000002980232

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_17 and not isNil(var_203_15) then
				local var_203_18 = (arg_200_1.time_ - var_203_16) / var_203_17

				if arg_200_1.var_.characterEffect1211ui_story and not isNil(var_203_15) then
					arg_200_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_16 + var_203_17 and arg_200_1.time_ < var_203_16 + var_203_17 + arg_203_0 and not isNil(var_203_15) and arg_200_1.var_.characterEffect1211ui_story then
				arg_200_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_203_19 = 0

			if var_203_19 < arg_200_1.time_ and arg_200_1.time_ <= var_203_19 + arg_203_0 then
				arg_200_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action6_1")
			end

			local var_203_20 = 0

			if var_203_20 < arg_200_1.time_ and arg_200_1.time_ <= var_203_20 + arg_203_0 then
				arg_200_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_203_21 = manager.ui.mainCamera.transform
			local var_203_22 = 0

			if var_203_22 < arg_200_1.time_ and arg_200_1.time_ <= var_203_22 + arg_203_0 then
				local var_203_23 = arg_200_1.var_.effect1047

				if var_203_23 then
					Object.Destroy(var_203_23)

					arg_200_1.var_.effect1047 = nil
				end
			end

			local var_203_24 = 0
			local var_203_25 = 0.175

			if var_203_24 < arg_200_1.time_ and arg_200_1.time_ <= var_203_24 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_26 = arg_200_1:FormatText(StoryNameCfg[37].name)

				arg_200_1.leftNameTxt_.text = var_203_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_27 = arg_200_1:GetWordFromCfg(322281048)
				local var_203_28 = arg_200_1:FormatText(var_203_27.content)

				arg_200_1.text_.text = var_203_28

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_29 = 7
				local var_203_30 = utf8.len(var_203_28)
				local var_203_31 = var_203_29 <= 0 and var_203_25 or var_203_25 * (var_203_30 / var_203_29)

				if var_203_31 > 0 and var_203_25 < var_203_31 then
					arg_200_1.talkMaxDuration = var_203_31

					if var_203_31 + var_203_24 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_31 + var_203_24
					end
				end

				arg_200_1.text_.text = var_203_28
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281048", "story_v_out_322281.awb") ~= 0 then
					local var_203_32 = manager.audio:GetVoiceLength("story_v_out_322281", "322281048", "story_v_out_322281.awb") / 1000

					if var_203_32 + var_203_24 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_32 + var_203_24
					end

					if var_203_27.prefab_name ~= "" and arg_200_1.actors_[var_203_27.prefab_name] ~= nil then
						local var_203_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_27.prefab_name].transform, "story_v_out_322281", "322281048", "story_v_out_322281.awb")

						arg_200_1:RecordAudio("322281048", var_203_33)
						arg_200_1:RecordAudio("322281048", var_203_33)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_322281", "322281048", "story_v_out_322281.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_322281", "322281048", "story_v_out_322281.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_34 = math.max(var_203_25, arg_200_1.talkMaxDuration)

			if var_203_24 <= arg_200_1.time_ and arg_200_1.time_ < var_203_24 + var_203_34 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_24) / var_203_34

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_24 + var_203_34 and arg_200_1.time_ < var_203_24 + var_203_34 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play322281049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322281049
		arg_204_1.duration_ = 5.07

		local var_204_0 = {
			zh = 4.966,
			ja = 5.066
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322281050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = "1044ui_story"

			if arg_204_1.actors_[var_207_0] == nil then
				local var_207_1 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_207_1) then
					local var_207_2 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_204_1.stage_.transform)

					var_207_2.name = var_207_0
					var_207_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_204_1.actors_[var_207_0] = var_207_2

					local var_207_3 = var_207_2:GetComponentInChildren(typeof(CharacterEffect))

					var_207_3.enabled = true

					local var_207_4 = GameObjectTools.GetOrAddComponent(var_207_2, typeof(DynamicBoneHelper))

					if var_207_4 then
						var_207_4:EnableDynamicBone(false)
					end

					arg_204_1:ShowWeapon(var_207_3.transform, false)

					arg_204_1.var_[var_207_0 .. "Animator"] = var_207_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_204_1.var_[var_207_0 .. "Animator"].applyRootMotion = true
					arg_204_1.var_[var_207_0 .. "LipSync"] = var_207_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_207_5 = arg_204_1.actors_["1044ui_story"].transform
			local var_207_6 = 0

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.var_.moveOldPos1044ui_story = var_207_5.localPosition

				local var_207_7 = "1044ui_story"

				arg_204_1:ShowWeapon(arg_204_1.var_[var_207_7 .. "Animator"].transform, false)
			end

			local var_207_8 = 0.001

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_8 then
				local var_207_9 = (arg_204_1.time_ - var_207_6) / var_207_8
				local var_207_10 = Vector3.New(0.7, -1, -5.93)

				var_207_5.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1044ui_story, var_207_10, var_207_9)

				local var_207_11 = manager.ui.mainCamera.transform.position - var_207_5.position

				var_207_5.forward = Vector3.New(var_207_11.x, var_207_11.y, var_207_11.z)

				local var_207_12 = var_207_5.localEulerAngles

				var_207_12.z = 0
				var_207_12.x = 0
				var_207_5.localEulerAngles = var_207_12
			end

			if arg_204_1.time_ >= var_207_6 + var_207_8 and arg_204_1.time_ < var_207_6 + var_207_8 + arg_207_0 then
				var_207_5.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_207_13 = manager.ui.mainCamera.transform.position - var_207_5.position

				var_207_5.forward = Vector3.New(var_207_13.x, var_207_13.y, var_207_13.z)

				local var_207_14 = var_207_5.localEulerAngles

				var_207_14.z = 0
				var_207_14.x = 0
				var_207_5.localEulerAngles = var_207_14
			end

			local var_207_15 = arg_204_1.actors_["1044ui_story"]
			local var_207_16 = 0

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 and not isNil(var_207_15) and arg_204_1.var_.characterEffect1044ui_story == nil then
				arg_204_1.var_.characterEffect1044ui_story = var_207_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_17 = 0.200000002980232

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_17 and not isNil(var_207_15) then
				local var_207_18 = (arg_204_1.time_ - var_207_16) / var_207_17

				if arg_204_1.var_.characterEffect1044ui_story and not isNil(var_207_15) then
					arg_204_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_16 + var_207_17 and arg_204_1.time_ < var_207_16 + var_207_17 + arg_207_0 and not isNil(var_207_15) and arg_204_1.var_.characterEffect1044ui_story then
				arg_204_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_207_19 = 0

			if var_207_19 < arg_204_1.time_ and arg_204_1.time_ <= var_207_19 + arg_207_0 then
				arg_204_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_1")
			end

			local var_207_20 = 0

			if var_207_20 < arg_204_1.time_ and arg_204_1.time_ <= var_207_20 + arg_207_0 then
				arg_204_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_21 = arg_204_1.actors_["1211ui_story"]
			local var_207_22 = 0

			if var_207_22 < arg_204_1.time_ and arg_204_1.time_ <= var_207_22 + arg_207_0 and not isNil(var_207_21) and arg_204_1.var_.characterEffect1211ui_story == nil then
				arg_204_1.var_.characterEffect1211ui_story = var_207_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_23 = 0.200000002980232

			if var_207_22 <= arg_204_1.time_ and arg_204_1.time_ < var_207_22 + var_207_23 and not isNil(var_207_21) then
				local var_207_24 = (arg_204_1.time_ - var_207_22) / var_207_23

				if arg_204_1.var_.characterEffect1211ui_story and not isNil(var_207_21) then
					local var_207_25 = Mathf.Lerp(0, 0.5, var_207_24)

					arg_204_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1211ui_story.fillRatio = var_207_25
				end
			end

			if arg_204_1.time_ >= var_207_22 + var_207_23 and arg_204_1.time_ < var_207_22 + var_207_23 + arg_207_0 and not isNil(var_207_21) and arg_204_1.var_.characterEffect1211ui_story then
				local var_207_26 = 0.5

				arg_204_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1211ui_story.fillRatio = var_207_26
			end

			local var_207_27 = arg_204_1.actors_["1211ui_story"].transform
			local var_207_28 = 0

			if var_207_28 < arg_204_1.time_ and arg_204_1.time_ <= var_207_28 + arg_207_0 then
				arg_204_1.var_.moveOldPos1211ui_story = var_207_27.localPosition

				local var_207_29 = "1211ui_story"

				arg_204_1:ShowWeapon(arg_204_1.var_[var_207_29 .. "Animator"].transform, false)
			end

			local var_207_30 = 0.001

			if var_207_28 <= arg_204_1.time_ and arg_204_1.time_ < var_207_28 + var_207_30 then
				local var_207_31 = (arg_204_1.time_ - var_207_28) / var_207_30
				local var_207_32 = Vector3.New(-0.7, -0.67, -6.07)

				var_207_27.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1211ui_story, var_207_32, var_207_31)

				local var_207_33 = manager.ui.mainCamera.transform.position - var_207_27.position

				var_207_27.forward = Vector3.New(var_207_33.x, var_207_33.y, var_207_33.z)

				local var_207_34 = var_207_27.localEulerAngles

				var_207_34.z = 0
				var_207_34.x = 0
				var_207_27.localEulerAngles = var_207_34
			end

			if arg_204_1.time_ >= var_207_28 + var_207_30 and arg_204_1.time_ < var_207_28 + var_207_30 + arg_207_0 then
				var_207_27.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_207_35 = manager.ui.mainCamera.transform.position - var_207_27.position

				var_207_27.forward = Vector3.New(var_207_35.x, var_207_35.y, var_207_35.z)

				local var_207_36 = var_207_27.localEulerAngles

				var_207_36.z = 0
				var_207_36.x = 0
				var_207_27.localEulerAngles = var_207_36
			end

			local var_207_37 = 0
			local var_207_38 = 0.425

			if var_207_37 < arg_204_1.time_ and arg_204_1.time_ <= var_207_37 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_39 = arg_204_1:FormatText(StoryNameCfg[1367].name)

				arg_204_1.leftNameTxt_.text = var_207_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_40 = arg_204_1:GetWordFromCfg(322281049)
				local var_207_41 = arg_204_1:FormatText(var_207_40.content)

				arg_204_1.text_.text = var_207_41

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_42 = 17
				local var_207_43 = utf8.len(var_207_41)
				local var_207_44 = var_207_42 <= 0 and var_207_38 or var_207_38 * (var_207_43 / var_207_42)

				if var_207_44 > 0 and var_207_38 < var_207_44 then
					arg_204_1.talkMaxDuration = var_207_44

					if var_207_44 + var_207_37 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_44 + var_207_37
					end
				end

				arg_204_1.text_.text = var_207_41
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281049", "story_v_out_322281.awb") ~= 0 then
					local var_207_45 = manager.audio:GetVoiceLength("story_v_out_322281", "322281049", "story_v_out_322281.awb") / 1000

					if var_207_45 + var_207_37 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_45 + var_207_37
					end

					if var_207_40.prefab_name ~= "" and arg_204_1.actors_[var_207_40.prefab_name] ~= nil then
						local var_207_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_40.prefab_name].transform, "story_v_out_322281", "322281049", "story_v_out_322281.awb")

						arg_204_1:RecordAudio("322281049", var_207_46)
						arg_204_1:RecordAudio("322281049", var_207_46)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322281", "322281049", "story_v_out_322281.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322281", "322281049", "story_v_out_322281.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_47 = math.max(var_207_38, arg_204_1.talkMaxDuration)

			if var_207_37 <= arg_204_1.time_ and arg_204_1.time_ < var_207_37 + var_207_47 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_37) / var_207_47

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_37 + var_207_47 and arg_204_1.time_ < var_207_37 + var_207_47 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play322281050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 322281050
		arg_208_1.duration_ = 4.8

		local var_208_0 = {
			zh = 3,
			ja = 4.8
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play322281051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1044ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos1044ui_story = var_211_0.localPosition
			end

			local var_211_2 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2
				local var_211_4 = Vector3.New(0, 100, 0)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1044ui_story, var_211_4, var_211_3)

				local var_211_5 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_5.x, var_211_5.y, var_211_5.z)

				local var_211_6 = var_211_0.localEulerAngles

				var_211_6.z = 0
				var_211_6.x = 0
				var_211_0.localEulerAngles = var_211_6
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, 100, 0)

				local var_211_7 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_7.x, var_211_7.y, var_211_7.z)

				local var_211_8 = var_211_0.localEulerAngles

				var_211_8.z = 0
				var_211_8.x = 0
				var_211_0.localEulerAngles = var_211_8
			end

			local var_211_9 = arg_208_1.actors_["1211ui_story"].transform
			local var_211_10 = 0

			if var_211_10 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 then
				arg_208_1.var_.moveOldPos1211ui_story = var_211_9.localPosition
			end

			local var_211_11 = 0.001

			if var_211_10 <= arg_208_1.time_ and arg_208_1.time_ < var_211_10 + var_211_11 then
				local var_211_12 = (arg_208_1.time_ - var_211_10) / var_211_11
				local var_211_13 = Vector3.New(0, 100, 0)

				var_211_9.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1211ui_story, var_211_13, var_211_12)

				local var_211_14 = manager.ui.mainCamera.transform.position - var_211_9.position

				var_211_9.forward = Vector3.New(var_211_14.x, var_211_14.y, var_211_14.z)

				local var_211_15 = var_211_9.localEulerAngles

				var_211_15.z = 0
				var_211_15.x = 0
				var_211_9.localEulerAngles = var_211_15
			end

			if arg_208_1.time_ >= var_211_10 + var_211_11 and arg_208_1.time_ < var_211_10 + var_211_11 + arg_211_0 then
				var_211_9.localPosition = Vector3.New(0, 100, 0)

				local var_211_16 = manager.ui.mainCamera.transform.position - var_211_9.position

				var_211_9.forward = Vector3.New(var_211_16.x, var_211_16.y, var_211_16.z)

				local var_211_17 = var_211_9.localEulerAngles

				var_211_17.z = 0
				var_211_17.x = 0
				var_211_9.localEulerAngles = var_211_17
			end

			local var_211_18 = "10102ui_story"

			if arg_208_1.actors_[var_211_18] == nil then
				local var_211_19 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_211_19) then
					local var_211_20 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_208_1.stage_.transform)

					var_211_20.name = var_211_18
					var_211_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_208_1.actors_[var_211_18] = var_211_20

					local var_211_21 = var_211_20:GetComponentInChildren(typeof(CharacterEffect))

					var_211_21.enabled = true

					local var_211_22 = GameObjectTools.GetOrAddComponent(var_211_20, typeof(DynamicBoneHelper))

					if var_211_22 then
						var_211_22:EnableDynamicBone(false)
					end

					arg_208_1:ShowWeapon(var_211_21.transform, false)

					arg_208_1.var_[var_211_18 .. "Animator"] = var_211_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_208_1.var_[var_211_18 .. "Animator"].applyRootMotion = true
					arg_208_1.var_[var_211_18 .. "LipSync"] = var_211_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_211_23 = arg_208_1.actors_["10102ui_story"].transform
			local var_211_24 = 0

			if var_211_24 < arg_208_1.time_ and arg_208_1.time_ <= var_211_24 + arg_211_0 then
				arg_208_1.var_.moveOldPos10102ui_story = var_211_23.localPosition
			end

			local var_211_25 = 0.001

			if var_211_24 <= arg_208_1.time_ and arg_208_1.time_ < var_211_24 + var_211_25 then
				local var_211_26 = (arg_208_1.time_ - var_211_24) / var_211_25
				local var_211_27 = Vector3.New(0, -0.985, -6.275)

				var_211_23.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10102ui_story, var_211_27, var_211_26)

				local var_211_28 = manager.ui.mainCamera.transform.position - var_211_23.position

				var_211_23.forward = Vector3.New(var_211_28.x, var_211_28.y, var_211_28.z)

				local var_211_29 = var_211_23.localEulerAngles

				var_211_29.z = 0
				var_211_29.x = 0
				var_211_23.localEulerAngles = var_211_29
			end

			if arg_208_1.time_ >= var_211_24 + var_211_25 and arg_208_1.time_ < var_211_24 + var_211_25 + arg_211_0 then
				var_211_23.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_211_30 = manager.ui.mainCamera.transform.position - var_211_23.position

				var_211_23.forward = Vector3.New(var_211_30.x, var_211_30.y, var_211_30.z)

				local var_211_31 = var_211_23.localEulerAngles

				var_211_31.z = 0
				var_211_31.x = 0
				var_211_23.localEulerAngles = var_211_31
			end

			local var_211_32 = arg_208_1.actors_["10102ui_story"]
			local var_211_33 = 0

			if var_211_33 < arg_208_1.time_ and arg_208_1.time_ <= var_211_33 + arg_211_0 and not isNil(var_211_32) and arg_208_1.var_.characterEffect10102ui_story == nil then
				arg_208_1.var_.characterEffect10102ui_story = var_211_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_34 = 0.200000002980232

			if var_211_33 <= arg_208_1.time_ and arg_208_1.time_ < var_211_33 + var_211_34 and not isNil(var_211_32) then
				local var_211_35 = (arg_208_1.time_ - var_211_33) / var_211_34

				if arg_208_1.var_.characterEffect10102ui_story and not isNil(var_211_32) then
					arg_208_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_33 + var_211_34 and arg_208_1.time_ < var_211_33 + var_211_34 + arg_211_0 and not isNil(var_211_32) and arg_208_1.var_.characterEffect10102ui_story then
				arg_208_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_211_36 = 0

			if var_211_36 < arg_208_1.time_ and arg_208_1.time_ <= var_211_36 + arg_211_0 then
				arg_208_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			local var_211_37 = 0

			if var_211_37 < arg_208_1.time_ and arg_208_1.time_ <= var_211_37 + arg_211_0 then
				arg_208_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_211_38 = 0
			local var_211_39 = 0.425

			if var_211_38 < arg_208_1.time_ and arg_208_1.time_ <= var_211_38 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_40 = arg_208_1:FormatText(StoryNameCfg[6].name)

				arg_208_1.leftNameTxt_.text = var_211_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_41 = arg_208_1:GetWordFromCfg(322281050)
				local var_211_42 = arg_208_1:FormatText(var_211_41.content)

				arg_208_1.text_.text = var_211_42

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_43 = 17
				local var_211_44 = utf8.len(var_211_42)
				local var_211_45 = var_211_43 <= 0 and var_211_39 or var_211_39 * (var_211_44 / var_211_43)

				if var_211_45 > 0 and var_211_39 < var_211_45 then
					arg_208_1.talkMaxDuration = var_211_45

					if var_211_45 + var_211_38 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_45 + var_211_38
					end
				end

				arg_208_1.text_.text = var_211_42
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281050", "story_v_out_322281.awb") ~= 0 then
					local var_211_46 = manager.audio:GetVoiceLength("story_v_out_322281", "322281050", "story_v_out_322281.awb") / 1000

					if var_211_46 + var_211_38 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_46 + var_211_38
					end

					if var_211_41.prefab_name ~= "" and arg_208_1.actors_[var_211_41.prefab_name] ~= nil then
						local var_211_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_41.prefab_name].transform, "story_v_out_322281", "322281050", "story_v_out_322281.awb")

						arg_208_1:RecordAudio("322281050", var_211_47)
						arg_208_1:RecordAudio("322281050", var_211_47)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_322281", "322281050", "story_v_out_322281.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_322281", "322281050", "story_v_out_322281.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_48 = math.max(var_211_39, arg_208_1.talkMaxDuration)

			if var_211_38 <= arg_208_1.time_ and arg_208_1.time_ < var_211_38 + var_211_48 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_38) / var_211_48

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_38 + var_211_48 and arg_208_1.time_ < var_211_38 + var_211_48 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play322281051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 322281051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play322281052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10102ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos10102ui_story = var_215_0.localPosition
			end

			local var_215_2 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2
				local var_215_4 = Vector3.New(0, 100, 0)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10102ui_story, var_215_4, var_215_3)

				local var_215_5 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_5.x, var_215_5.y, var_215_5.z)

				local var_215_6 = var_215_0.localEulerAngles

				var_215_6.z = 0
				var_215_6.x = 0
				var_215_0.localEulerAngles = var_215_6
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, 100, 0)

				local var_215_7 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_7.x, var_215_7.y, var_215_7.z)

				local var_215_8 = var_215_0.localEulerAngles

				var_215_8.z = 0
				var_215_8.x = 0
				var_215_0.localEulerAngles = var_215_8
			end

			local var_215_9 = 0
			local var_215_10 = 1.4

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_11 = arg_212_1:GetWordFromCfg(322281051)
				local var_215_12 = arg_212_1:FormatText(var_215_11.content)

				arg_212_1.text_.text = var_215_12

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 56
				local var_215_14 = utf8.len(var_215_12)
				local var_215_15 = var_215_13 <= 0 and var_215_10 or var_215_10 * (var_215_14 / var_215_13)

				if var_215_15 > 0 and var_215_10 < var_215_15 then
					arg_212_1.talkMaxDuration = var_215_15

					if var_215_15 + var_215_9 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_15 + var_215_9
					end
				end

				arg_212_1.text_.text = var_215_12
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_10, arg_212_1.talkMaxDuration)

			if var_215_9 <= arg_212_1.time_ and arg_212_1.time_ < var_215_9 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_9) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_9 + var_215_16 and arg_212_1.time_ < var_215_9 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play322281052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 322281052
		arg_216_1.duration_ = 3.7

		local var_216_0 = {
			zh = 2.766,
			ja = 3.7
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play322281053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1089ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1089ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(0, -1.1, -6.17)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1089ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = arg_216_1.actors_["1089ui_story"]
			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1089ui_story == nil then
				arg_216_1.var_.characterEffect1089ui_story = var_219_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_11 = 0.200000002980232

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 and not isNil(var_219_9) then
				local var_219_12 = (arg_216_1.time_ - var_219_10) / var_219_11

				if arg_216_1.var_.characterEffect1089ui_story and not isNil(var_219_9) then
					arg_216_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1089ui_story then
				arg_216_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_219_13 = 0

			if var_219_13 < arg_216_1.time_ and arg_216_1.time_ <= var_219_13 + arg_219_0 then
				arg_216_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_219_14 = 0

			if var_219_14 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_219_15 = 0
			local var_219_16 = 0.25

			if var_219_15 < arg_216_1.time_ and arg_216_1.time_ <= var_219_15 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_17 = arg_216_1:FormatText(StoryNameCfg[1031].name)

				arg_216_1.leftNameTxt_.text = var_219_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_18 = arg_216_1:GetWordFromCfg(322281052)
				local var_219_19 = arg_216_1:FormatText(var_219_18.content)

				arg_216_1.text_.text = var_219_19

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_20 = 10
				local var_219_21 = utf8.len(var_219_19)
				local var_219_22 = var_219_20 <= 0 and var_219_16 or var_219_16 * (var_219_21 / var_219_20)

				if var_219_22 > 0 and var_219_16 < var_219_22 then
					arg_216_1.talkMaxDuration = var_219_22

					if var_219_22 + var_219_15 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_22 + var_219_15
					end
				end

				arg_216_1.text_.text = var_219_19
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281052", "story_v_out_322281.awb") ~= 0 then
					local var_219_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281052", "story_v_out_322281.awb") / 1000

					if var_219_23 + var_219_15 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_23 + var_219_15
					end

					if var_219_18.prefab_name ~= "" and arg_216_1.actors_[var_219_18.prefab_name] ~= nil then
						local var_219_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_18.prefab_name].transform, "story_v_out_322281", "322281052", "story_v_out_322281.awb")

						arg_216_1:RecordAudio("322281052", var_219_24)
						arg_216_1:RecordAudio("322281052", var_219_24)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_322281", "322281052", "story_v_out_322281.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_322281", "322281052", "story_v_out_322281.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_25 = math.max(var_219_16, arg_216_1.talkMaxDuration)

			if var_219_15 <= arg_216_1.time_ and arg_216_1.time_ < var_219_15 + var_219_25 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_15) / var_219_25

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_15 + var_219_25 and arg_216_1.time_ < var_219_15 + var_219_25 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play322281053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 322281053
		arg_220_1.duration_ = 4.9

		local var_220_0 = {
			zh = 3.8,
			ja = 4.9
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play322281054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1089ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1089ui_story = var_223_0.localPosition
			end

			local var_223_2 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2
				local var_223_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1089ui_story, var_223_4, var_223_3)

				local var_223_5 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_5.x, var_223_5.y, var_223_5.z)

				local var_223_6 = var_223_0.localEulerAngles

				var_223_6.z = 0
				var_223_6.x = 0
				var_223_0.localEulerAngles = var_223_6
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_223_7 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_7.x, var_223_7.y, var_223_7.z)

				local var_223_8 = var_223_0.localEulerAngles

				var_223_8.z = 0
				var_223_8.x = 0
				var_223_0.localEulerAngles = var_223_8
			end

			local var_223_9 = "1020ui_story"

			if arg_220_1.actors_[var_223_9] == nil then
				local var_223_10 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_223_10) then
					local var_223_11 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_220_1.stage_.transform)

					var_223_11.name = var_223_9
					var_223_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_220_1.actors_[var_223_9] = var_223_11

					local var_223_12 = var_223_11:GetComponentInChildren(typeof(CharacterEffect))

					var_223_12.enabled = true

					local var_223_13 = GameObjectTools.GetOrAddComponent(var_223_11, typeof(DynamicBoneHelper))

					if var_223_13 then
						var_223_13:EnableDynamicBone(false)
					end

					arg_220_1:ShowWeapon(var_223_12.transform, false)

					arg_220_1.var_[var_223_9 .. "Animator"] = var_223_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_220_1.var_[var_223_9 .. "Animator"].applyRootMotion = true
					arg_220_1.var_[var_223_9 .. "LipSync"] = var_223_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_223_14 = arg_220_1.actors_["1020ui_story"].transform
			local var_223_15 = 0

			if var_223_15 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 then
				arg_220_1.var_.moveOldPos1020ui_story = var_223_14.localPosition
			end

			local var_223_16 = 0.001

			if var_223_15 <= arg_220_1.time_ and arg_220_1.time_ < var_223_15 + var_223_16 then
				local var_223_17 = (arg_220_1.time_ - var_223_15) / var_223_16
				local var_223_18 = Vector3.New(0.7, -0.85, -6.25)

				var_223_14.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1020ui_story, var_223_18, var_223_17)

				local var_223_19 = manager.ui.mainCamera.transform.position - var_223_14.position

				var_223_14.forward = Vector3.New(var_223_19.x, var_223_19.y, var_223_19.z)

				local var_223_20 = var_223_14.localEulerAngles

				var_223_20.z = 0
				var_223_20.x = 0
				var_223_14.localEulerAngles = var_223_20
			end

			if arg_220_1.time_ >= var_223_15 + var_223_16 and arg_220_1.time_ < var_223_15 + var_223_16 + arg_223_0 then
				var_223_14.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_223_21 = manager.ui.mainCamera.transform.position - var_223_14.position

				var_223_14.forward = Vector3.New(var_223_21.x, var_223_21.y, var_223_21.z)

				local var_223_22 = var_223_14.localEulerAngles

				var_223_22.z = 0
				var_223_22.x = 0
				var_223_14.localEulerAngles = var_223_22
			end

			local var_223_23 = arg_220_1.actors_["1020ui_story"]
			local var_223_24 = 0

			if var_223_24 < arg_220_1.time_ and arg_220_1.time_ <= var_223_24 + arg_223_0 and not isNil(var_223_23) and arg_220_1.var_.characterEffect1020ui_story == nil then
				arg_220_1.var_.characterEffect1020ui_story = var_223_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_25 = 0.200000002980232

			if var_223_24 <= arg_220_1.time_ and arg_220_1.time_ < var_223_24 + var_223_25 and not isNil(var_223_23) then
				local var_223_26 = (arg_220_1.time_ - var_223_24) / var_223_25

				if arg_220_1.var_.characterEffect1020ui_story and not isNil(var_223_23) then
					arg_220_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_24 + var_223_25 and arg_220_1.time_ < var_223_24 + var_223_25 + arg_223_0 and not isNil(var_223_23) and arg_220_1.var_.characterEffect1020ui_story then
				arg_220_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_223_27 = arg_220_1.actors_["1089ui_story"]
			local var_223_28 = 0

			if var_223_28 < arg_220_1.time_ and arg_220_1.time_ <= var_223_28 + arg_223_0 and not isNil(var_223_27) and arg_220_1.var_.characterEffect1089ui_story == nil then
				arg_220_1.var_.characterEffect1089ui_story = var_223_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_29 = 0.200000002980232

			if var_223_28 <= arg_220_1.time_ and arg_220_1.time_ < var_223_28 + var_223_29 and not isNil(var_223_27) then
				local var_223_30 = (arg_220_1.time_ - var_223_28) / var_223_29

				if arg_220_1.var_.characterEffect1089ui_story and not isNil(var_223_27) then
					local var_223_31 = Mathf.Lerp(0, 0.5, var_223_30)

					arg_220_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1089ui_story.fillRatio = var_223_31
				end
			end

			if arg_220_1.time_ >= var_223_28 + var_223_29 and arg_220_1.time_ < var_223_28 + var_223_29 + arg_223_0 and not isNil(var_223_27) and arg_220_1.var_.characterEffect1089ui_story then
				local var_223_32 = 0.5

				arg_220_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1089ui_story.fillRatio = var_223_32
			end

			local var_223_33 = 0

			if var_223_33 < arg_220_1.time_ and arg_220_1.time_ <= var_223_33 + arg_223_0 then
				arg_220_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_223_34 = 0

			if var_223_34 < arg_220_1.time_ and arg_220_1.time_ <= var_223_34 + arg_223_0 then
				arg_220_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_223_35 = 0
			local var_223_36 = 0.525

			if var_223_35 < arg_220_1.time_ and arg_220_1.time_ <= var_223_35 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_37 = arg_220_1:FormatText(StoryNameCfg[613].name)

				arg_220_1.leftNameTxt_.text = var_223_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_38 = arg_220_1:GetWordFromCfg(322281053)
				local var_223_39 = arg_220_1:FormatText(var_223_38.content)

				arg_220_1.text_.text = var_223_39

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_40 = 21
				local var_223_41 = utf8.len(var_223_39)
				local var_223_42 = var_223_40 <= 0 and var_223_36 or var_223_36 * (var_223_41 / var_223_40)

				if var_223_42 > 0 and var_223_36 < var_223_42 then
					arg_220_1.talkMaxDuration = var_223_42

					if var_223_42 + var_223_35 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_42 + var_223_35
					end
				end

				arg_220_1.text_.text = var_223_39
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281053", "story_v_out_322281.awb") ~= 0 then
					local var_223_43 = manager.audio:GetVoiceLength("story_v_out_322281", "322281053", "story_v_out_322281.awb") / 1000

					if var_223_43 + var_223_35 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_43 + var_223_35
					end

					if var_223_38.prefab_name ~= "" and arg_220_1.actors_[var_223_38.prefab_name] ~= nil then
						local var_223_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_38.prefab_name].transform, "story_v_out_322281", "322281053", "story_v_out_322281.awb")

						arg_220_1:RecordAudio("322281053", var_223_44)
						arg_220_1:RecordAudio("322281053", var_223_44)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_322281", "322281053", "story_v_out_322281.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_322281", "322281053", "story_v_out_322281.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_45 = math.max(var_223_36, arg_220_1.talkMaxDuration)

			if var_223_35 <= arg_220_1.time_ and arg_220_1.time_ < var_223_35 + var_223_45 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_35) / var_223_45

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_35 + var_223_45 and arg_220_1.time_ < var_223_35 + var_223_45 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play322281054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 322281054
		arg_224_1.duration_ = 5.83

		local var_224_0 = {
			zh = 4.166,
			ja = 5.833
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play322281055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1089ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1089ui_story == nil then
				arg_224_1.var_.characterEffect1089ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1089ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1089ui_story then
				arg_224_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_227_4 = arg_224_1.actors_["1020ui_story"]
			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1020ui_story == nil then
				arg_224_1.var_.characterEffect1020ui_story = var_227_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.200000002980232

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_6 and not isNil(var_227_4) then
				local var_227_7 = (arg_224_1.time_ - var_227_5) / var_227_6

				if arg_224_1.var_.characterEffect1020ui_story and not isNil(var_227_4) then
					local var_227_8 = Mathf.Lerp(0, 0.5, var_227_7)

					arg_224_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1020ui_story.fillRatio = var_227_8
				end
			end

			if arg_224_1.time_ >= var_227_5 + var_227_6 and arg_224_1.time_ < var_227_5 + var_227_6 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1020ui_story then
				local var_227_9 = 0.5

				arg_224_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1020ui_story.fillRatio = var_227_9
			end

			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_227_11 = 0

			if var_227_11 < arg_224_1.time_ and arg_224_1.time_ <= var_227_11 + arg_227_0 then
				arg_224_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_227_12 = 0
			local var_227_13 = 0.425

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_14 = arg_224_1:FormatText(StoryNameCfg[1031].name)

				arg_224_1.leftNameTxt_.text = var_227_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_15 = arg_224_1:GetWordFromCfg(322281054)
				local var_227_16 = arg_224_1:FormatText(var_227_15.content)

				arg_224_1.text_.text = var_227_16

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_17 = 17
				local var_227_18 = utf8.len(var_227_16)
				local var_227_19 = var_227_17 <= 0 and var_227_13 or var_227_13 * (var_227_18 / var_227_17)

				if var_227_19 > 0 and var_227_13 < var_227_19 then
					arg_224_1.talkMaxDuration = var_227_19

					if var_227_19 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_16
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281054", "story_v_out_322281.awb") ~= 0 then
					local var_227_20 = manager.audio:GetVoiceLength("story_v_out_322281", "322281054", "story_v_out_322281.awb") / 1000

					if var_227_20 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_20 + var_227_12
					end

					if var_227_15.prefab_name ~= "" and arg_224_1.actors_[var_227_15.prefab_name] ~= nil then
						local var_227_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_15.prefab_name].transform, "story_v_out_322281", "322281054", "story_v_out_322281.awb")

						arg_224_1:RecordAudio("322281054", var_227_21)
						arg_224_1:RecordAudio("322281054", var_227_21)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_322281", "322281054", "story_v_out_322281.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_322281", "322281054", "story_v_out_322281.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_12) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_12 + var_227_22 and arg_224_1.time_ < var_227_12 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play322281055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 322281055
		arg_228_1.duration_ = 5.63

		local var_228_0 = {
			zh = 4.633,
			ja = 5.633
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play322281056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1020ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1020ui_story == nil then
				arg_228_1.var_.characterEffect1020ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1020ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1020ui_story then
				arg_228_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_231_4 = arg_228_1.actors_["1089ui_story"]
			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1089ui_story == nil then
				arg_228_1.var_.characterEffect1089ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_6 = 0.200000002980232

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 and not isNil(var_231_4) then
				local var_231_7 = (arg_228_1.time_ - var_231_5) / var_231_6

				if arg_228_1.var_.characterEffect1089ui_story and not isNil(var_231_4) then
					local var_231_8 = Mathf.Lerp(0, 0.5, var_231_7)

					arg_228_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1089ui_story.fillRatio = var_231_8
				end
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1089ui_story then
				local var_231_9 = 0.5

				arg_228_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1089ui_story.fillRatio = var_231_9
			end

			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 then
				arg_228_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_231_11 = 0
			local var_231_12 = 0.5

			if var_231_11 < arg_228_1.time_ and arg_228_1.time_ <= var_231_11 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_13 = arg_228_1:FormatText(StoryNameCfg[613].name)

				arg_228_1.leftNameTxt_.text = var_231_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_14 = arg_228_1:GetWordFromCfg(322281055)
				local var_231_15 = arg_228_1:FormatText(var_231_14.content)

				arg_228_1.text_.text = var_231_15

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_16 = 20
				local var_231_17 = utf8.len(var_231_15)
				local var_231_18 = var_231_16 <= 0 and var_231_12 or var_231_12 * (var_231_17 / var_231_16)

				if var_231_18 > 0 and var_231_12 < var_231_18 then
					arg_228_1.talkMaxDuration = var_231_18

					if var_231_18 + var_231_11 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_18 + var_231_11
					end
				end

				arg_228_1.text_.text = var_231_15
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281055", "story_v_out_322281.awb") ~= 0 then
					local var_231_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281055", "story_v_out_322281.awb") / 1000

					if var_231_19 + var_231_11 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_19 + var_231_11
					end

					if var_231_14.prefab_name ~= "" and arg_228_1.actors_[var_231_14.prefab_name] ~= nil then
						local var_231_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_14.prefab_name].transform, "story_v_out_322281", "322281055", "story_v_out_322281.awb")

						arg_228_1:RecordAudio("322281055", var_231_20)
						arg_228_1:RecordAudio("322281055", var_231_20)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_322281", "322281055", "story_v_out_322281.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_322281", "322281055", "story_v_out_322281.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_21 = math.max(var_231_12, arg_228_1.talkMaxDuration)

			if var_231_11 <= arg_228_1.time_ and arg_228_1.time_ < var_231_11 + var_231_21 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_11) / var_231_21

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_11 + var_231_21 and arg_228_1.time_ < var_231_11 + var_231_21 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play322281056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 322281056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play322281057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1089ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1089ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, 100, 0)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1089ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, 100, 0)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = arg_232_1.actors_["1020ui_story"].transform
			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				arg_232_1.var_.moveOldPos1020ui_story = var_235_9.localPosition
			end

			local var_235_11 = 0.001

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_11 then
				local var_235_12 = (arg_232_1.time_ - var_235_10) / var_235_11
				local var_235_13 = Vector3.New(0, 100, 0)

				var_235_9.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1020ui_story, var_235_13, var_235_12)

				local var_235_14 = manager.ui.mainCamera.transform.position - var_235_9.position

				var_235_9.forward = Vector3.New(var_235_14.x, var_235_14.y, var_235_14.z)

				local var_235_15 = var_235_9.localEulerAngles

				var_235_15.z = 0
				var_235_15.x = 0
				var_235_9.localEulerAngles = var_235_15
			end

			if arg_232_1.time_ >= var_235_10 + var_235_11 and arg_232_1.time_ < var_235_10 + var_235_11 + arg_235_0 then
				var_235_9.localPosition = Vector3.New(0, 100, 0)

				local var_235_16 = manager.ui.mainCamera.transform.position - var_235_9.position

				var_235_9.forward = Vector3.New(var_235_16.x, var_235_16.y, var_235_16.z)

				local var_235_17 = var_235_9.localEulerAngles

				var_235_17.z = 0
				var_235_17.x = 0
				var_235_9.localEulerAngles = var_235_17
			end

			local var_235_18 = 0
			local var_235_19 = 0.55

			if var_235_18 < arg_232_1.time_ and arg_232_1.time_ <= var_235_18 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_20 = arg_232_1:GetWordFromCfg(322281056)
				local var_235_21 = arg_232_1:FormatText(var_235_20.content)

				arg_232_1.text_.text = var_235_21

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_22 = 22
				local var_235_23 = utf8.len(var_235_21)
				local var_235_24 = var_235_22 <= 0 and var_235_19 or var_235_19 * (var_235_23 / var_235_22)

				if var_235_24 > 0 and var_235_19 < var_235_24 then
					arg_232_1.talkMaxDuration = var_235_24

					if var_235_24 + var_235_18 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_24 + var_235_18
					end
				end

				arg_232_1.text_.text = var_235_21
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_25 = math.max(var_235_19, arg_232_1.talkMaxDuration)

			if var_235_18 <= arg_232_1.time_ and arg_232_1.time_ < var_235_18 + var_235_25 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_18) / var_235_25

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_18 + var_235_25 and arg_232_1.time_ < var_235_18 + var_235_25 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play322281057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 322281057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play322281058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.1

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(322281057)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 4
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_8 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_8 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_8

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_8 and arg_236_1.time_ < var_239_0 + var_239_8 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play322281058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 322281058
		arg_240_1.duration_ = 12

		local var_240_0 = {
			zh = 8.233,
			ja = 12
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play322281059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1020ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos1020ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0, -0.85, -6.25)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1020ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = arg_240_1.actors_["1020ui_story"]
			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect1020ui_story == nil then
				arg_240_1.var_.characterEffect1020ui_story = var_243_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 and not isNil(var_243_9) then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11

				if arg_240_1.var_.characterEffect1020ui_story and not isNil(var_243_9) then
					arg_240_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect1020ui_story then
				arg_240_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_243_13 = 0

			if var_243_13 < arg_240_1.time_ and arg_240_1.time_ <= var_243_13 + arg_243_0 then
				arg_240_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_243_14 = 0

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				arg_240_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_15 = 0
			local var_243_16 = 0.925

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_17 = arg_240_1:FormatText(StoryNameCfg[613].name)

				arg_240_1.leftNameTxt_.text = var_243_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_18 = arg_240_1:GetWordFromCfg(322281058)
				local var_243_19 = arg_240_1:FormatText(var_243_18.content)

				arg_240_1.text_.text = var_243_19

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_20 = 37
				local var_243_21 = utf8.len(var_243_19)
				local var_243_22 = var_243_20 <= 0 and var_243_16 or var_243_16 * (var_243_21 / var_243_20)

				if var_243_22 > 0 and var_243_16 < var_243_22 then
					arg_240_1.talkMaxDuration = var_243_22

					if var_243_22 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_22 + var_243_15
					end
				end

				arg_240_1.text_.text = var_243_19
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281058", "story_v_out_322281.awb") ~= 0 then
					local var_243_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281058", "story_v_out_322281.awb") / 1000

					if var_243_23 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_23 + var_243_15
					end

					if var_243_18.prefab_name ~= "" and arg_240_1.actors_[var_243_18.prefab_name] ~= nil then
						local var_243_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_18.prefab_name].transform, "story_v_out_322281", "322281058", "story_v_out_322281.awb")

						arg_240_1:RecordAudio("322281058", var_243_24)
						arg_240_1:RecordAudio("322281058", var_243_24)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_322281", "322281058", "story_v_out_322281.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_322281", "322281058", "story_v_out_322281.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_25 = math.max(var_243_16, arg_240_1.talkMaxDuration)

			if var_243_15 <= arg_240_1.time_ and arg_240_1.time_ < var_243_15 + var_243_25 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_15) / var_243_25

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_15 + var_243_25 and arg_240_1.time_ < var_243_15 + var_243_25 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play322281059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 322281059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play322281060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1020ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1020ui_story == nil then
				arg_244_1.var_.characterEffect1020ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1020ui_story and not isNil(var_247_0) then
					local var_247_4 = Mathf.Lerp(0, 0.5, var_247_3)

					arg_244_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1020ui_story.fillRatio = var_247_4
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1020ui_story then
				local var_247_5 = 0.5

				arg_244_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1020ui_story.fillRatio = var_247_5
			end

			local var_247_6 = 0
			local var_247_7 = 0.725

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_9 = arg_244_1:GetWordFromCfg(322281059)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 29
				local var_247_12 = utf8.len(var_247_10)
				local var_247_13 = var_247_11 <= 0 and var_247_7 or var_247_7 * (var_247_12 / var_247_11)

				if var_247_13 > 0 and var_247_7 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_10
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play322281060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 322281060
		arg_248_1.duration_ = 7.97

		local var_248_0 = {
			zh = 5.9,
			ja = 7.966
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play322281061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1020ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1020ui_story == nil then
				arg_248_1.var_.characterEffect1020ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect1020ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1020ui_story then
				arg_248_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_251_4 = 0

			if var_251_4 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action428")
			end

			local var_251_5 = 0

			if var_251_5 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_251_6 = 0
			local var_251_7 = 0.625

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_8 = arg_248_1:FormatText(StoryNameCfg[613].name)

				arg_248_1.leftNameTxt_.text = var_251_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_9 = arg_248_1:GetWordFromCfg(322281060)
				local var_251_10 = arg_248_1:FormatText(var_251_9.content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 25
				local var_251_12 = utf8.len(var_251_10)
				local var_251_13 = var_251_11 <= 0 and var_251_7 or var_251_7 * (var_251_12 / var_251_11)

				if var_251_13 > 0 and var_251_7 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281060", "story_v_out_322281.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281060", "story_v_out_322281.awb") / 1000

					if var_251_14 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_6
					end

					if var_251_9.prefab_name ~= "" and arg_248_1.actors_[var_251_9.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_9.prefab_name].transform, "story_v_out_322281", "322281060", "story_v_out_322281.awb")

						arg_248_1:RecordAudio("322281060", var_251_15)
						arg_248_1:RecordAudio("322281060", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_322281", "322281060", "story_v_out_322281.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_322281", "322281060", "story_v_out_322281.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_16 and arg_248_1.time_ < var_251_6 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play322281061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322281061
		arg_252_1.duration_ = 1

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"

			SetActive(arg_252_1.choicesGo_, true)

			for iter_253_0, iter_253_1 in ipairs(arg_252_1.choices_) do
				local var_253_0 = iter_253_0 <= 2

				SetActive(iter_253_1.go, var_253_0)
			end

			arg_252_1.choices_[1].txt.text = arg_252_1:FormatText(StoryChoiceCfg[1423].name)
			arg_252_1.choices_[2].txt.text = arg_252_1:FormatText(StoryChoiceCfg[1424].name)
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322281062(arg_252_1)
			end

			if arg_254_0 == 2 then
				arg_252_0:Play322281063(arg_252_1)
			end

			arg_252_1:RecordChoiceLog(322281061, 1423, 1424)
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1020ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1020ui_story == nil then
				arg_252_1.var_.characterEffect1020ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1020ui_story and not isNil(var_255_0) then
					local var_255_4 = Mathf.Lerp(0, 0.5, var_255_3)

					arg_252_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1020ui_story.fillRatio = var_255_4
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1020ui_story then
				local var_255_5 = 0.5

				arg_252_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1020ui_story.fillRatio = var_255_5
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play322281062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 322281062
		arg_256_1.duration_ = 7.67

		local var_256_0 = {
			zh = 4.433,
			ja = 7.666
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play322281064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1020ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1020ui_story == nil then
				arg_256_1.var_.characterEffect1020ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1020ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1020ui_story then
				arg_256_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_259_4 = 0

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_259_5 = 0
			local var_259_6 = 0.45

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_7 = arg_256_1:FormatText(StoryNameCfg[613].name)

				arg_256_1.leftNameTxt_.text = var_259_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_8 = arg_256_1:GetWordFromCfg(322281062)
				local var_259_9 = arg_256_1:FormatText(var_259_8.content)

				arg_256_1.text_.text = var_259_9

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_10 = 18
				local var_259_11 = utf8.len(var_259_9)
				local var_259_12 = var_259_10 <= 0 and var_259_6 or var_259_6 * (var_259_11 / var_259_10)

				if var_259_12 > 0 and var_259_6 < var_259_12 then
					arg_256_1.talkMaxDuration = var_259_12

					if var_259_12 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_12 + var_259_5
					end
				end

				arg_256_1.text_.text = var_259_9
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281062", "story_v_out_322281.awb") ~= 0 then
					local var_259_13 = manager.audio:GetVoiceLength("story_v_out_322281", "322281062", "story_v_out_322281.awb") / 1000

					if var_259_13 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_5
					end

					if var_259_8.prefab_name ~= "" and arg_256_1.actors_[var_259_8.prefab_name] ~= nil then
						local var_259_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_8.prefab_name].transform, "story_v_out_322281", "322281062", "story_v_out_322281.awb")

						arg_256_1:RecordAudio("322281062", var_259_14)
						arg_256_1:RecordAudio("322281062", var_259_14)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_322281", "322281062", "story_v_out_322281.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_322281", "322281062", "story_v_out_322281.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_15 = math.max(var_259_6, arg_256_1.talkMaxDuration)

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_15 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_5) / var_259_15

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_5 + var_259_15 and arg_256_1.time_ < var_259_5 + var_259_15 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play322281064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322281064
		arg_260_1.duration_ = 12.63

		local var_260_0 = {
			zh = 8.366,
			ja = 12.633
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322281065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 1.125

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[613].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(322281064)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 45
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281064", "story_v_out_322281.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281064", "story_v_out_322281.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_322281", "322281064", "story_v_out_322281.awb")

						arg_260_1:RecordAudio("322281064", var_263_9)
						arg_260_1:RecordAudio("322281064", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322281", "322281064", "story_v_out_322281.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322281", "322281064", "story_v_out_322281.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play322281065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 322281065
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play322281066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1020ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1020ui_story == nil then
				arg_264_1.var_.characterEffect1020ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect1020ui_story and not isNil(var_267_0) then
					local var_267_4 = Mathf.Lerp(0, 0.5, var_267_3)

					arg_264_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1020ui_story.fillRatio = var_267_4
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1020ui_story then
				local var_267_5 = 0.5

				arg_264_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1020ui_story.fillRatio = var_267_5
			end

			local var_267_6 = 0
			local var_267_7 = 0.55

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_8 = arg_264_1:FormatText(StoryNameCfg[7].name)

				arg_264_1.leftNameTxt_.text = var_267_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_9 = arg_264_1:GetWordFromCfg(322281065)
				local var_267_10 = arg_264_1:FormatText(var_267_9.content)

				arg_264_1.text_.text = var_267_10

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 22
				local var_267_12 = utf8.len(var_267_10)
				local var_267_13 = var_267_11 <= 0 and var_267_7 or var_267_7 * (var_267_12 / var_267_11)

				if var_267_13 > 0 and var_267_7 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_10
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_14 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_14 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_14

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_14 and arg_264_1.time_ < var_267_6 + var_267_14 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play322281066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 322281066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play322281067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1020ui_story"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos1020ui_story = var_271_0.localPosition
			end

			local var_271_2 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2
				local var_271_4 = Vector3.New(0, 100, 0)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1020ui_story, var_271_4, var_271_3)

				local var_271_5 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_5.x, var_271_5.y, var_271_5.z)

				local var_271_6 = var_271_0.localEulerAngles

				var_271_6.z = 0
				var_271_6.x = 0
				var_271_0.localEulerAngles = var_271_6
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(0, 100, 0)

				local var_271_7 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_7.x, var_271_7.y, var_271_7.z)

				local var_271_8 = var_271_0.localEulerAngles

				var_271_8.z = 0
				var_271_8.x = 0
				var_271_0.localEulerAngles = var_271_8
			end

			local var_271_9 = 0
			local var_271_10 = 1.125

			if var_271_9 < arg_268_1.time_ and arg_268_1.time_ <= var_271_9 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_11 = arg_268_1:GetWordFromCfg(322281066)
				local var_271_12 = arg_268_1:FormatText(var_271_11.content)

				arg_268_1.text_.text = var_271_12

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_13 = 45
				local var_271_14 = utf8.len(var_271_12)
				local var_271_15 = var_271_13 <= 0 and var_271_10 or var_271_10 * (var_271_14 / var_271_13)

				if var_271_15 > 0 and var_271_10 < var_271_15 then
					arg_268_1.talkMaxDuration = var_271_15

					if var_271_15 + var_271_9 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_15 + var_271_9
					end
				end

				arg_268_1.text_.text = var_271_12
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_16 = math.max(var_271_10, arg_268_1.talkMaxDuration)

			if var_271_9 <= arg_268_1.time_ and arg_268_1.time_ < var_271_9 + var_271_16 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_9) / var_271_16

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_9 + var_271_16 and arg_268_1.time_ < var_271_9 + var_271_16 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play322281067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 322281067
		arg_272_1.duration_ = 2

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play322281068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1020ui_story"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos1020ui_story = var_275_0.localPosition
			end

			local var_275_2 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2
				local var_275_4 = Vector3.New(0, -0.85, -6.25)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1020ui_story, var_275_4, var_275_3)

				local var_275_5 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_5.x, var_275_5.y, var_275_5.z)

				local var_275_6 = var_275_0.localEulerAngles

				var_275_6.z = 0
				var_275_6.x = 0
				var_275_0.localEulerAngles = var_275_6
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_275_7 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_7.x, var_275_7.y, var_275_7.z)

				local var_275_8 = var_275_0.localEulerAngles

				var_275_8.z = 0
				var_275_8.x = 0
				var_275_0.localEulerAngles = var_275_8
			end

			local var_275_9 = arg_272_1.actors_["1020ui_story"]
			local var_275_10 = 0

			if var_275_10 < arg_272_1.time_ and arg_272_1.time_ <= var_275_10 + arg_275_0 and not isNil(var_275_9) and arg_272_1.var_.characterEffect1020ui_story == nil then
				arg_272_1.var_.characterEffect1020ui_story = var_275_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_11 = 0.200000002980232

			if var_275_10 <= arg_272_1.time_ and arg_272_1.time_ < var_275_10 + var_275_11 and not isNil(var_275_9) then
				local var_275_12 = (arg_272_1.time_ - var_275_10) / var_275_11

				if arg_272_1.var_.characterEffect1020ui_story and not isNil(var_275_9) then
					arg_272_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_10 + var_275_11 and arg_272_1.time_ < var_275_10 + var_275_11 + arg_275_0 and not isNil(var_275_9) and arg_272_1.var_.characterEffect1020ui_story then
				arg_272_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_275_13 = 0

			if var_275_13 < arg_272_1.time_ and arg_272_1.time_ <= var_275_13 + arg_275_0 then
				arg_272_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_275_14 = 0

			if var_275_14 < arg_272_1.time_ and arg_272_1.time_ <= var_275_14 + arg_275_0 then
				arg_272_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_275_15 = 0
			local var_275_16 = 0.1

			if var_275_15 < arg_272_1.time_ and arg_272_1.time_ <= var_275_15 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_17 = arg_272_1:FormatText(StoryNameCfg[613].name)

				arg_272_1.leftNameTxt_.text = var_275_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_18 = arg_272_1:GetWordFromCfg(322281067)
				local var_275_19 = arg_272_1:FormatText(var_275_18.content)

				arg_272_1.text_.text = var_275_19

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_20 = 4
				local var_275_21 = utf8.len(var_275_19)
				local var_275_22 = var_275_20 <= 0 and var_275_16 or var_275_16 * (var_275_21 / var_275_20)

				if var_275_22 > 0 and var_275_16 < var_275_22 then
					arg_272_1.talkMaxDuration = var_275_22

					if var_275_22 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_22 + var_275_15
					end
				end

				arg_272_1.text_.text = var_275_19
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281067", "story_v_out_322281.awb") ~= 0 then
					local var_275_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281067", "story_v_out_322281.awb") / 1000

					if var_275_23 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_23 + var_275_15
					end

					if var_275_18.prefab_name ~= "" and arg_272_1.actors_[var_275_18.prefab_name] ~= nil then
						local var_275_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_18.prefab_name].transform, "story_v_out_322281", "322281067", "story_v_out_322281.awb")

						arg_272_1:RecordAudio("322281067", var_275_24)
						arg_272_1:RecordAudio("322281067", var_275_24)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_322281", "322281067", "story_v_out_322281.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_322281", "322281067", "story_v_out_322281.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_25 = math.max(var_275_16, arg_272_1.talkMaxDuration)

			if var_275_15 <= arg_272_1.time_ and arg_272_1.time_ < var_275_15 + var_275_25 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_15) / var_275_25

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_15 + var_275_25 and arg_272_1.time_ < var_275_15 + var_275_25 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play322281068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 322281068
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play322281069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1020ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1020ui_story == nil then
				arg_276_1.var_.characterEffect1020ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect1020ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1020ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1020ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1020ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 0.325

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_8 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_9 = arg_276_1:GetWordFromCfg(322281068)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 13
				local var_279_12 = utf8.len(var_279_10)
				local var_279_13 = var_279_11 <= 0 and var_279_7 or var_279_7 * (var_279_12 / var_279_11)

				if var_279_13 > 0 and var_279_7 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_14 and arg_276_1.time_ < var_279_6 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play322281069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 322281069
		arg_280_1.duration_ = 7.9

		local var_280_0 = {
			zh = 6.4,
			ja = 7.9
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play322281070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1020ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1020ui_story == nil then
				arg_280_1.var_.characterEffect1020ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1020ui_story and not isNil(var_283_0) then
					arg_280_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1020ui_story then
				arg_280_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_283_4 = 0

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			local var_283_5 = 0

			if var_283_5 < arg_280_1.time_ and arg_280_1.time_ <= var_283_5 + arg_283_0 then
				arg_280_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_283_6 = 0
			local var_283_7 = 1

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[613].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_9 = arg_280_1:GetWordFromCfg(322281069)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 40
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281069", "story_v_out_322281.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281069", "story_v_out_322281.awb") / 1000

					if var_283_14 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_6
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_out_322281", "322281069", "story_v_out_322281.awb")

						arg_280_1:RecordAudio("322281069", var_283_15)
						arg_280_1:RecordAudio("322281069", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_322281", "322281069", "story_v_out_322281.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_322281", "322281069", "story_v_out_322281.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_16 and arg_280_1.time_ < var_283_6 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play322281070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 322281070
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play322281071(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1020ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1020ui_story == nil then
				arg_284_1.var_.characterEffect1020ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1020ui_story and not isNil(var_287_0) then
					local var_287_4 = Mathf.Lerp(0, 0.5, var_287_3)

					arg_284_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1020ui_story.fillRatio = var_287_4
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1020ui_story then
				local var_287_5 = 0.5

				arg_284_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1020ui_story.fillRatio = var_287_5
			end

			local var_287_6 = 0
			local var_287_7 = 0.3

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[7].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_9 = arg_284_1:GetWordFromCfg(322281070)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 12
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_14 and arg_284_1.time_ < var_287_6 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play322281071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 322281071
		arg_288_1.duration_ = 9.87

		local var_288_0 = {
			zh = 7.4,
			ja = 9.866
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play322281072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1020ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1020ui_story == nil then
				arg_288_1.var_.characterEffect1020ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1020ui_story and not isNil(var_291_0) then
					arg_288_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1020ui_story then
				arg_288_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_291_4 = 0
			local var_291_5 = 0.95

			if var_291_4 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_6 = arg_288_1:FormatText(StoryNameCfg[613].name)

				arg_288_1.leftNameTxt_.text = var_291_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_7 = arg_288_1:GetWordFromCfg(322281071)
				local var_291_8 = arg_288_1:FormatText(var_291_7.content)

				arg_288_1.text_.text = var_291_8

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 38
				local var_291_10 = utf8.len(var_291_8)
				local var_291_11 = var_291_9 <= 0 and var_291_5 or var_291_5 * (var_291_10 / var_291_9)

				if var_291_11 > 0 and var_291_5 < var_291_11 then
					arg_288_1.talkMaxDuration = var_291_11

					if var_291_11 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_11 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_8
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281071", "story_v_out_322281.awb") ~= 0 then
					local var_291_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281071", "story_v_out_322281.awb") / 1000

					if var_291_12 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_12 + var_291_4
					end

					if var_291_7.prefab_name ~= "" and arg_288_1.actors_[var_291_7.prefab_name] ~= nil then
						local var_291_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_7.prefab_name].transform, "story_v_out_322281", "322281071", "story_v_out_322281.awb")

						arg_288_1:RecordAudio("322281071", var_291_13)
						arg_288_1:RecordAudio("322281071", var_291_13)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_322281", "322281071", "story_v_out_322281.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_322281", "322281071", "story_v_out_322281.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_14 and arg_288_1.time_ < var_291_4 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play322281072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 322281072
		arg_292_1.duration_ = 13.77

		local var_292_0 = {
			zh = 10.2,
			ja = 13.766
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play322281073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 1.2

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[613].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_3 = arg_292_1:GetWordFromCfg(322281072)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 48
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281072", "story_v_out_322281.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281072", "story_v_out_322281.awb") / 1000

					if var_295_8 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_0
					end

					if var_295_3.prefab_name ~= "" and arg_292_1.actors_[var_295_3.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_3.prefab_name].transform, "story_v_out_322281", "322281072", "story_v_out_322281.awb")

						arg_292_1:RecordAudio("322281072", var_295_9)
						arg_292_1:RecordAudio("322281072", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_322281", "322281072", "story_v_out_322281.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_322281", "322281072", "story_v_out_322281.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_10 and arg_292_1.time_ < var_295_0 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play322281073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 322281073
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play322281074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1020ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1020ui_story == nil then
				arg_296_1.var_.characterEffect1020ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect1020ui_story and not isNil(var_299_0) then
					local var_299_4 = Mathf.Lerp(0, 0.5, var_299_3)

					arg_296_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1020ui_story.fillRatio = var_299_4
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1020ui_story then
				local var_299_5 = 0.5

				arg_296_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1020ui_story.fillRatio = var_299_5
			end

			local var_299_6 = 0
			local var_299_7 = 0.7

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_8 = arg_296_1:FormatText(StoryNameCfg[7].name)

				arg_296_1.leftNameTxt_.text = var_299_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_9 = arg_296_1:GetWordFromCfg(322281073)
				local var_299_10 = arg_296_1:FormatText(var_299_9.content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 28
				local var_299_12 = utf8.len(var_299_10)
				local var_299_13 = var_299_11 <= 0 and var_299_7 or var_299_7 * (var_299_12 / var_299_11)

				if var_299_13 > 0 and var_299_7 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_14 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_14 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_14

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_14 and arg_296_1.time_ < var_299_6 + var_299_14 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play322281074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 322281074
		arg_300_1.duration_ = 4.1

		local var_300_0 = {
			zh = 2.6,
			ja = 4.1
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play322281075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1020ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos1020ui_story = var_303_0.localPosition
			end

			local var_303_2 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2
				local var_303_4 = Vector3.New(0, 100, 0)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1020ui_story, var_303_4, var_303_3)

				local var_303_5 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_5.x, var_303_5.y, var_303_5.z)

				local var_303_6 = var_303_0.localEulerAngles

				var_303_6.z = 0
				var_303_6.x = 0
				var_303_0.localEulerAngles = var_303_6
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, 100, 0)

				local var_303_7 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_7.x, var_303_7.y, var_303_7.z)

				local var_303_8 = var_303_0.localEulerAngles

				var_303_8.z = 0
				var_303_8.x = 0
				var_303_0.localEulerAngles = var_303_8
			end

			local var_303_9 = arg_300_1.actors_["1044ui_story"].transform
			local var_303_10 = 0

			if var_303_10 < arg_300_1.time_ and arg_300_1.time_ <= var_303_10 + arg_303_0 then
				arg_300_1.var_.moveOldPos1044ui_story = var_303_9.localPosition

				local var_303_11 = "1044ui_story"

				arg_300_1:ShowWeapon(arg_300_1.var_[var_303_11 .. "Animator"].transform, false)
			end

			local var_303_12 = 0.001

			if var_303_10 <= arg_300_1.time_ and arg_300_1.time_ < var_303_10 + var_303_12 then
				local var_303_13 = (arg_300_1.time_ - var_303_10) / var_303_12
				local var_303_14 = Vector3.New(0, -1, -5.93)

				var_303_9.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1044ui_story, var_303_14, var_303_13)

				local var_303_15 = manager.ui.mainCamera.transform.position - var_303_9.position

				var_303_9.forward = Vector3.New(var_303_15.x, var_303_15.y, var_303_15.z)

				local var_303_16 = var_303_9.localEulerAngles

				var_303_16.z = 0
				var_303_16.x = 0
				var_303_9.localEulerAngles = var_303_16
			end

			if arg_300_1.time_ >= var_303_10 + var_303_12 and arg_300_1.time_ < var_303_10 + var_303_12 + arg_303_0 then
				var_303_9.localPosition = Vector3.New(0, -1, -5.93)

				local var_303_17 = manager.ui.mainCamera.transform.position - var_303_9.position

				var_303_9.forward = Vector3.New(var_303_17.x, var_303_17.y, var_303_17.z)

				local var_303_18 = var_303_9.localEulerAngles

				var_303_18.z = 0
				var_303_18.x = 0
				var_303_9.localEulerAngles = var_303_18
			end

			local var_303_19 = arg_300_1.actors_["1044ui_story"]
			local var_303_20 = 0

			if var_303_20 < arg_300_1.time_ and arg_300_1.time_ <= var_303_20 + arg_303_0 and not isNil(var_303_19) and arg_300_1.var_.characterEffect1044ui_story == nil then
				arg_300_1.var_.characterEffect1044ui_story = var_303_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_21 = 0.200000002980232

			if var_303_20 <= arg_300_1.time_ and arg_300_1.time_ < var_303_20 + var_303_21 and not isNil(var_303_19) then
				local var_303_22 = (arg_300_1.time_ - var_303_20) / var_303_21

				if arg_300_1.var_.characterEffect1044ui_story and not isNil(var_303_19) then
					arg_300_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_20 + var_303_21 and arg_300_1.time_ < var_303_20 + var_303_21 + arg_303_0 and not isNil(var_303_19) and arg_300_1.var_.characterEffect1044ui_story then
				arg_300_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_303_23 = 0

			if var_303_23 < arg_300_1.time_ and arg_300_1.time_ <= var_303_23 + arg_303_0 then
				arg_300_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			local var_303_24 = 0

			if var_303_24 < arg_300_1.time_ and arg_300_1.time_ <= var_303_24 + arg_303_0 then
				arg_300_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_303_25 = 0
			local var_303_26 = 0.375

			if var_303_25 < arg_300_1.time_ and arg_300_1.time_ <= var_303_25 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_27 = arg_300_1:FormatText(StoryNameCfg[1367].name)

				arg_300_1.leftNameTxt_.text = var_303_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_28 = arg_300_1:GetWordFromCfg(322281074)
				local var_303_29 = arg_300_1:FormatText(var_303_28.content)

				arg_300_1.text_.text = var_303_29

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_30 = 15
				local var_303_31 = utf8.len(var_303_29)
				local var_303_32 = var_303_30 <= 0 and var_303_26 or var_303_26 * (var_303_31 / var_303_30)

				if var_303_32 > 0 and var_303_26 < var_303_32 then
					arg_300_1.talkMaxDuration = var_303_32

					if var_303_32 + var_303_25 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_32 + var_303_25
					end
				end

				arg_300_1.text_.text = var_303_29
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281074", "story_v_out_322281.awb") ~= 0 then
					local var_303_33 = manager.audio:GetVoiceLength("story_v_out_322281", "322281074", "story_v_out_322281.awb") / 1000

					if var_303_33 + var_303_25 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_33 + var_303_25
					end

					if var_303_28.prefab_name ~= "" and arg_300_1.actors_[var_303_28.prefab_name] ~= nil then
						local var_303_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_28.prefab_name].transform, "story_v_out_322281", "322281074", "story_v_out_322281.awb")

						arg_300_1:RecordAudio("322281074", var_303_34)
						arg_300_1:RecordAudio("322281074", var_303_34)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_322281", "322281074", "story_v_out_322281.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_322281", "322281074", "story_v_out_322281.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_35 = math.max(var_303_26, arg_300_1.talkMaxDuration)

			if var_303_25 <= arg_300_1.time_ and arg_300_1.time_ < var_303_25 + var_303_35 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_25) / var_303_35

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_25 + var_303_35 and arg_300_1.time_ < var_303_25 + var_303_35 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play322281075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 322281075
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play322281076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1044ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1044ui_story == nil then
				arg_304_1.var_.characterEffect1044ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1044ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1044ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1044ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1044ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.225

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_8 = arg_304_1:FormatText(StoryNameCfg[7].name)

				arg_304_1.leftNameTxt_.text = var_307_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_9 = arg_304_1:GetWordFromCfg(322281075)
				local var_307_10 = arg_304_1:FormatText(var_307_9.content)

				arg_304_1.text_.text = var_307_10

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 9
				local var_307_12 = utf8.len(var_307_10)
				local var_307_13 = var_307_11 <= 0 and var_307_7 or var_307_7 * (var_307_12 / var_307_11)

				if var_307_13 > 0 and var_307_7 < var_307_13 then
					arg_304_1.talkMaxDuration = var_307_13

					if var_307_13 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_13 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_10
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_14 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_14 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_14

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_14 and arg_304_1.time_ < var_307_6 + var_307_14 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play322281076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 322281076
		arg_308_1.duration_ = 2.63

		local var_308_0 = {
			zh = 2.633,
			ja = 1.999999999999
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play322281077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1044ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1044ui_story == nil then
				arg_308_1.var_.characterEffect1044ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect1044ui_story and not isNil(var_311_0) then
					arg_308_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1044ui_story then
				arg_308_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_311_4 = 0

			if var_311_4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_2")
			end

			local var_311_5 = 0

			if var_311_5 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 then
				arg_308_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_311_6 = 0
			local var_311_7 = 0.15

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_8 = arg_308_1:FormatText(StoryNameCfg[1367].name)

				arg_308_1.leftNameTxt_.text = var_311_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_9 = arg_308_1:GetWordFromCfg(322281076)
				local var_311_10 = arg_308_1:FormatText(var_311_9.content)

				arg_308_1.text_.text = var_311_10

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_11 = 6
				local var_311_12 = utf8.len(var_311_10)
				local var_311_13 = var_311_11 <= 0 and var_311_7 or var_311_7 * (var_311_12 / var_311_11)

				if var_311_13 > 0 and var_311_7 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_10
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281076", "story_v_out_322281.awb") ~= 0 then
					local var_311_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281076", "story_v_out_322281.awb") / 1000

					if var_311_14 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_14 + var_311_6
					end

					if var_311_9.prefab_name ~= "" and arg_308_1.actors_[var_311_9.prefab_name] ~= nil then
						local var_311_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_9.prefab_name].transform, "story_v_out_322281", "322281076", "story_v_out_322281.awb")

						arg_308_1:RecordAudio("322281076", var_311_15)
						arg_308_1:RecordAudio("322281076", var_311_15)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_322281", "322281076", "story_v_out_322281.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_322281", "322281076", "story_v_out_322281.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_16 and arg_308_1.time_ < var_311_6 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play322281077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 322281077
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play322281078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.15
			local var_315_1 = 1

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				local var_315_2 = "play"
				local var_315_3 = "effect"

				arg_312_1:AudioAction(var_315_2, var_315_3, "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_315_4 = arg_312_1.actors_["1044ui_story"].transform
			local var_315_5 = 0

			if var_315_5 < arg_312_1.time_ and arg_312_1.time_ <= var_315_5 + arg_315_0 then
				arg_312_1.var_.moveOldPos1044ui_story = var_315_4.localPosition

				local var_315_6 = "1044ui_story"

				arg_312_1:ShowWeapon(arg_312_1.var_[var_315_6 .. "Animator"].transform, false)
			end

			local var_315_7 = 0.001

			if var_315_5 <= arg_312_1.time_ and arg_312_1.time_ < var_315_5 + var_315_7 then
				local var_315_8 = (arg_312_1.time_ - var_315_5) / var_315_7
				local var_315_9 = Vector3.New(0, 100, 0)

				var_315_4.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1044ui_story, var_315_9, var_315_8)

				local var_315_10 = manager.ui.mainCamera.transform.position - var_315_4.position

				var_315_4.forward = Vector3.New(var_315_10.x, var_315_10.y, var_315_10.z)

				local var_315_11 = var_315_4.localEulerAngles

				var_315_11.z = 0
				var_315_11.x = 0
				var_315_4.localEulerAngles = var_315_11
			end

			if arg_312_1.time_ >= var_315_5 + var_315_7 and arg_312_1.time_ < var_315_5 + var_315_7 + arg_315_0 then
				var_315_4.localPosition = Vector3.New(0, 100, 0)

				local var_315_12 = manager.ui.mainCamera.transform.position - var_315_4.position

				var_315_4.forward = Vector3.New(var_315_12.x, var_315_12.y, var_315_12.z)

				local var_315_13 = var_315_4.localEulerAngles

				var_315_13.z = 0
				var_315_13.x = 0
				var_315_4.localEulerAngles = var_315_13
			end

			local var_315_14 = 0
			local var_315_15 = 1.15

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_16 = arg_312_1:GetWordFromCfg(322281077)
				local var_315_17 = arg_312_1:FormatText(var_315_16.content)

				arg_312_1.text_.text = var_315_17

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_18 = 46
				local var_315_19 = utf8.len(var_315_17)
				local var_315_20 = var_315_18 <= 0 and var_315_15 or var_315_15 * (var_315_19 / var_315_18)

				if var_315_20 > 0 and var_315_15 < var_315_20 then
					arg_312_1.talkMaxDuration = var_315_20

					if var_315_20 + var_315_14 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_20 + var_315_14
					end
				end

				arg_312_1.text_.text = var_315_17
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_21 = math.max(var_315_15, arg_312_1.talkMaxDuration)

			if var_315_14 <= arg_312_1.time_ and arg_312_1.time_ < var_315_14 + var_315_21 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_14) / var_315_21

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_14 + var_315_21 and arg_312_1.time_ < var_315_14 + var_315_21 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play322281078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 322281078
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play322281079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 1.35

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_2 = arg_316_1:GetWordFromCfg(322281078)
				local var_319_3 = arg_316_1:FormatText(var_319_2.content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 54
				local var_319_5 = utf8.len(var_319_3)
				local var_319_6 = var_319_4 <= 0 and var_319_1 or var_319_1 * (var_319_5 / var_319_4)

				if var_319_6 > 0 and var_319_1 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_7 and arg_316_1.time_ < var_319_0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play322281079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 322281079
		arg_320_1.duration_ = 4.5

		local var_320_0 = {
			zh = 3.133,
			ja = 4.5
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play322281080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1044ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos1044ui_story = var_323_0.localPosition

				local var_323_2 = "1044ui_story"

				arg_320_1:ShowWeapon(arg_320_1.var_[var_323_2 .. "Animator"].transform, false)
			end

			local var_323_3 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_3 then
				local var_323_4 = (arg_320_1.time_ - var_323_1) / var_323_3
				local var_323_5 = Vector3.New(0, -1, -5.93)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1044ui_story, var_323_5, var_323_4)

				local var_323_6 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_6.x, var_323_6.y, var_323_6.z)

				local var_323_7 = var_323_0.localEulerAngles

				var_323_7.z = 0
				var_323_7.x = 0
				var_323_0.localEulerAngles = var_323_7
			end

			if arg_320_1.time_ >= var_323_1 + var_323_3 and arg_320_1.time_ < var_323_1 + var_323_3 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_323_8 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_8.x, var_323_8.y, var_323_8.z)

				local var_323_9 = var_323_0.localEulerAngles

				var_323_9.z = 0
				var_323_9.x = 0
				var_323_0.localEulerAngles = var_323_9
			end

			local var_323_10 = arg_320_1.actors_["1044ui_story"]
			local var_323_11 = 0

			if var_323_11 < arg_320_1.time_ and arg_320_1.time_ <= var_323_11 + arg_323_0 and not isNil(var_323_10) and arg_320_1.var_.characterEffect1044ui_story == nil then
				arg_320_1.var_.characterEffect1044ui_story = var_323_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_12 = 0.200000002980232

			if var_323_11 <= arg_320_1.time_ and arg_320_1.time_ < var_323_11 + var_323_12 and not isNil(var_323_10) then
				local var_323_13 = (arg_320_1.time_ - var_323_11) / var_323_12

				if arg_320_1.var_.characterEffect1044ui_story and not isNil(var_323_10) then
					arg_320_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_11 + var_323_12 and arg_320_1.time_ < var_323_11 + var_323_12 + arg_323_0 and not isNil(var_323_10) and arg_320_1.var_.characterEffect1044ui_story then
				arg_320_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_323_14 = 0

			if var_323_14 < arg_320_1.time_ and arg_320_1.time_ <= var_323_14 + arg_323_0 then
				arg_320_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_323_15 = 0

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_323_16 = 0
			local var_323_17 = 0.325

			if var_323_16 < arg_320_1.time_ and arg_320_1.time_ <= var_323_16 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_18 = arg_320_1:FormatText(StoryNameCfg[1367].name)

				arg_320_1.leftNameTxt_.text = var_323_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_19 = arg_320_1:GetWordFromCfg(322281079)
				local var_323_20 = arg_320_1:FormatText(var_323_19.content)

				arg_320_1.text_.text = var_323_20

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_21 = 13
				local var_323_22 = utf8.len(var_323_20)
				local var_323_23 = var_323_21 <= 0 and var_323_17 or var_323_17 * (var_323_22 / var_323_21)

				if var_323_23 > 0 and var_323_17 < var_323_23 then
					arg_320_1.talkMaxDuration = var_323_23

					if var_323_23 + var_323_16 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_23 + var_323_16
					end
				end

				arg_320_1.text_.text = var_323_20
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281079", "story_v_out_322281.awb") ~= 0 then
					local var_323_24 = manager.audio:GetVoiceLength("story_v_out_322281", "322281079", "story_v_out_322281.awb") / 1000

					if var_323_24 + var_323_16 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_24 + var_323_16
					end

					if var_323_19.prefab_name ~= "" and arg_320_1.actors_[var_323_19.prefab_name] ~= nil then
						local var_323_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_19.prefab_name].transform, "story_v_out_322281", "322281079", "story_v_out_322281.awb")

						arg_320_1:RecordAudio("322281079", var_323_25)
						arg_320_1:RecordAudio("322281079", var_323_25)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_322281", "322281079", "story_v_out_322281.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_322281", "322281079", "story_v_out_322281.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_26 = math.max(var_323_17, arg_320_1.talkMaxDuration)

			if var_323_16 <= arg_320_1.time_ and arg_320_1.time_ < var_323_16 + var_323_26 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_16) / var_323_26

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_16 + var_323_26 and arg_320_1.time_ < var_323_16 + var_323_26 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play322281080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 322281080
		arg_324_1.duration_ = 9.47

		local var_324_0 = {
			zh = 5.766,
			ja = 9.466
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play322281081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1089ui_story"].transform
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.var_.moveOldPos1089ui_story = var_327_0.localPosition

				local var_327_2 = "1089ui_story"

				arg_324_1:ShowWeapon(arg_324_1.var_[var_327_2 .. "Animator"].transform, false)
			end

			local var_327_3 = 0.001

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_3 then
				local var_327_4 = (arg_324_1.time_ - var_327_1) / var_327_3
				local var_327_5 = Vector3.New(0.7, -1.1, -6.17)

				var_327_0.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1089ui_story, var_327_5, var_327_4)

				local var_327_6 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_6.x, var_327_6.y, var_327_6.z)

				local var_327_7 = var_327_0.localEulerAngles

				var_327_7.z = 0
				var_327_7.x = 0
				var_327_0.localEulerAngles = var_327_7
			end

			if arg_324_1.time_ >= var_327_1 + var_327_3 and arg_324_1.time_ < var_327_1 + var_327_3 + arg_327_0 then
				var_327_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_327_8 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_8.x, var_327_8.y, var_327_8.z)

				local var_327_9 = var_327_0.localEulerAngles

				var_327_9.z = 0
				var_327_9.x = 0
				var_327_0.localEulerAngles = var_327_9
			end

			local var_327_10 = arg_324_1.actors_["1089ui_story"]
			local var_327_11 = 0

			if var_327_11 < arg_324_1.time_ and arg_324_1.time_ <= var_327_11 + arg_327_0 and not isNil(var_327_10) and arg_324_1.var_.characterEffect1089ui_story == nil then
				arg_324_1.var_.characterEffect1089ui_story = var_327_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_12 = 0.200000002980232

			if var_327_11 <= arg_324_1.time_ and arg_324_1.time_ < var_327_11 + var_327_12 and not isNil(var_327_10) then
				local var_327_13 = (arg_324_1.time_ - var_327_11) / var_327_12

				if arg_324_1.var_.characterEffect1089ui_story and not isNil(var_327_10) then
					arg_324_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_11 + var_327_12 and arg_324_1.time_ < var_327_11 + var_327_12 + arg_327_0 and not isNil(var_327_10) and arg_324_1.var_.characterEffect1089ui_story then
				arg_324_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_327_14 = 0

			if var_327_14 < arg_324_1.time_ and arg_324_1.time_ <= var_327_14 + arg_327_0 then
				arg_324_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_327_15 = 0

			if var_327_15 < arg_324_1.time_ and arg_324_1.time_ <= var_327_15 + arg_327_0 then
				arg_324_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_327_16 = arg_324_1.actors_["1044ui_story"].transform
			local var_327_17 = 0

			if var_327_17 < arg_324_1.time_ and arg_324_1.time_ <= var_327_17 + arg_327_0 then
				arg_324_1.var_.moveOldPos1044ui_story = var_327_16.localPosition

				local var_327_18 = "1044ui_story"

				arg_324_1:ShowWeapon(arg_324_1.var_[var_327_18 .. "Animator"].transform, false)
			end

			local var_327_19 = 0.001

			if var_327_17 <= arg_324_1.time_ and arg_324_1.time_ < var_327_17 + var_327_19 then
				local var_327_20 = (arg_324_1.time_ - var_327_17) / var_327_19
				local var_327_21 = Vector3.New(-0.7, -1, -5.93)

				var_327_16.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1044ui_story, var_327_21, var_327_20)

				local var_327_22 = manager.ui.mainCamera.transform.position - var_327_16.position

				var_327_16.forward = Vector3.New(var_327_22.x, var_327_22.y, var_327_22.z)

				local var_327_23 = var_327_16.localEulerAngles

				var_327_23.z = 0
				var_327_23.x = 0
				var_327_16.localEulerAngles = var_327_23
			end

			if arg_324_1.time_ >= var_327_17 + var_327_19 and arg_324_1.time_ < var_327_17 + var_327_19 + arg_327_0 then
				var_327_16.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_327_24 = manager.ui.mainCamera.transform.position - var_327_16.position

				var_327_16.forward = Vector3.New(var_327_24.x, var_327_24.y, var_327_24.z)

				local var_327_25 = var_327_16.localEulerAngles

				var_327_25.z = 0
				var_327_25.x = 0
				var_327_16.localEulerAngles = var_327_25
			end

			local var_327_26 = arg_324_1.actors_["1044ui_story"]
			local var_327_27 = 0

			if var_327_27 < arg_324_1.time_ and arg_324_1.time_ <= var_327_27 + arg_327_0 and not isNil(var_327_26) and arg_324_1.var_.characterEffect1044ui_story == nil then
				arg_324_1.var_.characterEffect1044ui_story = var_327_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_28 = 0.200000002980232

			if var_327_27 <= arg_324_1.time_ and arg_324_1.time_ < var_327_27 + var_327_28 and not isNil(var_327_26) then
				local var_327_29 = (arg_324_1.time_ - var_327_27) / var_327_28

				if arg_324_1.var_.characterEffect1044ui_story and not isNil(var_327_26) then
					local var_327_30 = Mathf.Lerp(0, 0.5, var_327_29)

					arg_324_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1044ui_story.fillRatio = var_327_30
				end
			end

			if arg_324_1.time_ >= var_327_27 + var_327_28 and arg_324_1.time_ < var_327_27 + var_327_28 + arg_327_0 and not isNil(var_327_26) and arg_324_1.var_.characterEffect1044ui_story then
				local var_327_31 = 0.5

				arg_324_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1044ui_story.fillRatio = var_327_31
			end

			local var_327_32 = 0
			local var_327_33 = 0.6

			if var_327_32 < arg_324_1.time_ and arg_324_1.time_ <= var_327_32 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_34 = arg_324_1:FormatText(StoryNameCfg[1031].name)

				arg_324_1.leftNameTxt_.text = var_327_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_35 = arg_324_1:GetWordFromCfg(322281080)
				local var_327_36 = arg_324_1:FormatText(var_327_35.content)

				arg_324_1.text_.text = var_327_36

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_37 = 24
				local var_327_38 = utf8.len(var_327_36)
				local var_327_39 = var_327_37 <= 0 and var_327_33 or var_327_33 * (var_327_38 / var_327_37)

				if var_327_39 > 0 and var_327_33 < var_327_39 then
					arg_324_1.talkMaxDuration = var_327_39

					if var_327_39 + var_327_32 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_39 + var_327_32
					end
				end

				arg_324_1.text_.text = var_327_36
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281080", "story_v_out_322281.awb") ~= 0 then
					local var_327_40 = manager.audio:GetVoiceLength("story_v_out_322281", "322281080", "story_v_out_322281.awb") / 1000

					if var_327_40 + var_327_32 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_40 + var_327_32
					end

					if var_327_35.prefab_name ~= "" and arg_324_1.actors_[var_327_35.prefab_name] ~= nil then
						local var_327_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_35.prefab_name].transform, "story_v_out_322281", "322281080", "story_v_out_322281.awb")

						arg_324_1:RecordAudio("322281080", var_327_41)
						arg_324_1:RecordAudio("322281080", var_327_41)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_322281", "322281080", "story_v_out_322281.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_322281", "322281080", "story_v_out_322281.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_42 = math.max(var_327_33, arg_324_1.talkMaxDuration)

			if var_327_32 <= arg_324_1.time_ and arg_324_1.time_ < var_327_32 + var_327_42 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_32) / var_327_42

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_32 + var_327_42 and arg_324_1.time_ < var_327_32 + var_327_42 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play322281081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 322281081
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play322281082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1089ui_story"].transform
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.var_.moveOldPos1089ui_story = var_331_0.localPosition
			end

			local var_331_2 = 0.001

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2
				local var_331_4 = Vector3.New(0, 100, 0)

				var_331_0.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1089ui_story, var_331_4, var_331_3)

				local var_331_5 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_5.x, var_331_5.y, var_331_5.z)

				local var_331_6 = var_331_0.localEulerAngles

				var_331_6.z = 0
				var_331_6.x = 0
				var_331_0.localEulerAngles = var_331_6
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 then
				var_331_0.localPosition = Vector3.New(0, 100, 0)

				local var_331_7 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_7.x, var_331_7.y, var_331_7.z)

				local var_331_8 = var_331_0.localEulerAngles

				var_331_8.z = 0
				var_331_8.x = 0
				var_331_0.localEulerAngles = var_331_8
			end

			local var_331_9 = 0.133333333333333
			local var_331_10 = 1

			if var_331_9 < arg_328_1.time_ and arg_328_1.time_ <= var_331_9 + arg_331_0 then
				local var_331_11 = "play"
				local var_331_12 = "effect"

				arg_328_1:AudioAction(var_331_11, var_331_12, "se_story_1310", "se_story_1310_car01", "")
			end

			local var_331_13 = arg_328_1.actors_["1044ui_story"].transform
			local var_331_14 = 0

			if var_331_14 < arg_328_1.time_ and arg_328_1.time_ <= var_331_14 + arg_331_0 then
				arg_328_1.var_.moveOldPos1044ui_story = var_331_13.localPosition

				local var_331_15 = "1044ui_story"

				arg_328_1:ShowWeapon(arg_328_1.var_[var_331_15 .. "Animator"].transform, false)
			end

			local var_331_16 = 0.001

			if var_331_14 <= arg_328_1.time_ and arg_328_1.time_ < var_331_14 + var_331_16 then
				local var_331_17 = (arg_328_1.time_ - var_331_14) / var_331_16
				local var_331_18 = Vector3.New(0, 100, 0)

				var_331_13.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1044ui_story, var_331_18, var_331_17)

				local var_331_19 = manager.ui.mainCamera.transform.position - var_331_13.position

				var_331_13.forward = Vector3.New(var_331_19.x, var_331_19.y, var_331_19.z)

				local var_331_20 = var_331_13.localEulerAngles

				var_331_20.z = 0
				var_331_20.x = 0
				var_331_13.localEulerAngles = var_331_20
			end

			if arg_328_1.time_ >= var_331_14 + var_331_16 and arg_328_1.time_ < var_331_14 + var_331_16 + arg_331_0 then
				var_331_13.localPosition = Vector3.New(0, 100, 0)

				local var_331_21 = manager.ui.mainCamera.transform.position - var_331_13.position

				var_331_13.forward = Vector3.New(var_331_21.x, var_331_21.y, var_331_21.z)

				local var_331_22 = var_331_13.localEulerAngles

				var_331_22.z = 0
				var_331_22.x = 0
				var_331_13.localEulerAngles = var_331_22
			end

			local var_331_23 = 0
			local var_331_24 = 1.375

			if var_331_23 < arg_328_1.time_ and arg_328_1.time_ <= var_331_23 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_25 = arg_328_1:GetWordFromCfg(322281081)
				local var_331_26 = arg_328_1:FormatText(var_331_25.content)

				arg_328_1.text_.text = var_331_26

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_27 = 55
				local var_331_28 = utf8.len(var_331_26)
				local var_331_29 = var_331_27 <= 0 and var_331_24 or var_331_24 * (var_331_28 / var_331_27)

				if var_331_29 > 0 and var_331_24 < var_331_29 then
					arg_328_1.talkMaxDuration = var_331_29

					if var_331_29 + var_331_23 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_29 + var_331_23
					end
				end

				arg_328_1.text_.text = var_331_26
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_30 = math.max(var_331_24, arg_328_1.talkMaxDuration)

			if var_331_23 <= arg_328_1.time_ and arg_328_1.time_ < var_331_23 + var_331_30 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_23) / var_331_30

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_23 + var_331_30 and arg_328_1.time_ < var_331_23 + var_331_30 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play322281082 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 322281082
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play322281083(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.833333333333333
			local var_335_1 = 1

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				local var_335_2 = "play"
				local var_335_3 = "effect"

				arg_332_1:AudioAction(var_335_2, var_335_3, "se_story_side_1096", "se_story_1096_brake", "")
			end

			local var_335_4 = manager.ui.mainCamera.transform
			local var_335_5 = 0.833333333333333

			if var_335_5 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				local var_335_6 = arg_332_1.var_.effect1082
				local var_335_7
				local var_335_8 = var_335_4

				if not var_335_6 then
					var_335_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_335_8)
					var_335_6.name = "1082"
					arg_332_1.var_.effect1082 = var_335_6
				else
					var_335_6.transform:SetParent(var_335_8)
				end

				var_335_6.transform.localPosition = Vector3.New(0, 0, -2.49)
				var_335_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_335_9 = arg_332_1.bgs_.L01f.transform
			local var_335_10 = 0.833333333333334

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 then
				arg_332_1.var_.moveOldPosL01f = var_335_9.localPosition
			end

			local var_335_11 = 1

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 then
				local var_335_12 = (arg_332_1.time_ - var_335_10) / var_335_11
				local var_335_13 = Vector3.New(0, 1, 7)

				var_335_9.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPosL01f, var_335_13, var_335_12)
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 then
				var_335_9.localPosition = Vector3.New(0, 1, 7)
			end

			local var_335_14 = 0

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1.allBtn_.enabled = false
			end

			local var_335_15 = 1.83333333333333

			if arg_332_1.time_ >= var_335_14 + var_335_15 and arg_332_1.time_ < var_335_14 + var_335_15 + arg_335_0 then
				arg_332_1.allBtn_.enabled = true
			end

			local var_335_16 = 0
			local var_335_17 = 1.35

			if var_335_16 < arg_332_1.time_ and arg_332_1.time_ <= var_335_16 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_18 = arg_332_1:GetWordFromCfg(322281082)
				local var_335_19 = arg_332_1:FormatText(var_335_18.content)

				arg_332_1.text_.text = var_335_19

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_20 = 54
				local var_335_21 = utf8.len(var_335_19)
				local var_335_22 = var_335_20 <= 0 and var_335_17 or var_335_17 * (var_335_21 / var_335_20)

				if var_335_22 > 0 and var_335_17 < var_335_22 then
					arg_332_1.talkMaxDuration = var_335_22

					if var_335_22 + var_335_16 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_22 + var_335_16
					end
				end

				arg_332_1.text_.text = var_335_19
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_23 = math.max(var_335_17, arg_332_1.talkMaxDuration)

			if var_335_16 <= arg_332_1.time_ and arg_332_1.time_ < var_335_16 + var_335_23 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_16) / var_335_23

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_16 + var_335_23 and arg_332_1.time_ < var_335_16 + var_335_23 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "L01f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0.833333333333334,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 1, 7),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play322281083 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 322281083
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play322281084(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = manager.ui.mainCamera.transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				local var_339_2 = arg_336_1.var_.effect1082

				if var_339_2 then
					Object.Destroy(var_339_2)

					arg_336_1.var_.effect1082 = nil
				end
			end

			local var_339_3 = 0
			local var_339_4 = 0.325

			if var_339_3 < arg_336_1.time_ and arg_336_1.time_ <= var_339_3 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_5 = arg_336_1:FormatText(StoryNameCfg[7].name)

				arg_336_1.leftNameTxt_.text = var_339_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_6 = arg_336_1:GetWordFromCfg(322281083)
				local var_339_7 = arg_336_1:FormatText(var_339_6.content)

				arg_336_1.text_.text = var_339_7

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_8 = 13
				local var_339_9 = utf8.len(var_339_7)
				local var_339_10 = var_339_8 <= 0 and var_339_4 or var_339_4 * (var_339_9 / var_339_8)

				if var_339_10 > 0 and var_339_4 < var_339_10 then
					arg_336_1.talkMaxDuration = var_339_10

					if var_339_10 + var_339_3 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_3
					end
				end

				arg_336_1.text_.text = var_339_7
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_11 = math.max(var_339_4, arg_336_1.talkMaxDuration)

			if var_339_3 <= arg_336_1.time_ and arg_336_1.time_ < var_339_3 + var_339_11 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_3) / var_339_11

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_3 + var_339_11 and arg_336_1.time_ < var_339_3 + var_339_11 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play322281084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 322281084
		arg_340_1.duration_ = 7.37

		local var_340_0 = {
			zh = 4.466,
			ja = 7.366
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play322281085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = "1085ui_story"

			if arg_340_1.actors_[var_343_0] == nil then
				local var_343_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_343_1) then
					local var_343_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_340_1.stage_.transform)

					var_343_2.name = var_343_0
					var_343_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_340_1.actors_[var_343_0] = var_343_2

					local var_343_3 = var_343_2:GetComponentInChildren(typeof(CharacterEffect))

					var_343_3.enabled = true

					local var_343_4 = GameObjectTools.GetOrAddComponent(var_343_2, typeof(DynamicBoneHelper))

					if var_343_4 then
						var_343_4:EnableDynamicBone(false)
					end

					arg_340_1:ShowWeapon(var_343_3.transform, false)

					arg_340_1.var_[var_343_0 .. "Animator"] = var_343_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_340_1.var_[var_343_0 .. "Animator"].applyRootMotion = true
					arg_340_1.var_[var_343_0 .. "LipSync"] = var_343_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_343_5 = arg_340_1.actors_["1085ui_story"].transform
			local var_343_6 = 0

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.var_.moveOldPos1085ui_story = var_343_5.localPosition
			end

			local var_343_7 = 0.001

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_7 then
				local var_343_8 = (arg_340_1.time_ - var_343_6) / var_343_7
				local var_343_9 = Vector3.New(0, -1.01, -5.83)

				var_343_5.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1085ui_story, var_343_9, var_343_8)

				local var_343_10 = manager.ui.mainCamera.transform.position - var_343_5.position

				var_343_5.forward = Vector3.New(var_343_10.x, var_343_10.y, var_343_10.z)

				local var_343_11 = var_343_5.localEulerAngles

				var_343_11.z = 0
				var_343_11.x = 0
				var_343_5.localEulerAngles = var_343_11
			end

			if arg_340_1.time_ >= var_343_6 + var_343_7 and arg_340_1.time_ < var_343_6 + var_343_7 + arg_343_0 then
				var_343_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_343_12 = manager.ui.mainCamera.transform.position - var_343_5.position

				var_343_5.forward = Vector3.New(var_343_12.x, var_343_12.y, var_343_12.z)

				local var_343_13 = var_343_5.localEulerAngles

				var_343_13.z = 0
				var_343_13.x = 0
				var_343_5.localEulerAngles = var_343_13
			end

			local var_343_14 = arg_340_1.actors_["1085ui_story"]
			local var_343_15 = 0

			if var_343_15 < arg_340_1.time_ and arg_340_1.time_ <= var_343_15 + arg_343_0 and not isNil(var_343_14) and arg_340_1.var_.characterEffect1085ui_story == nil then
				arg_340_1.var_.characterEffect1085ui_story = var_343_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_16 = 0.200000002980232

			if var_343_15 <= arg_340_1.time_ and arg_340_1.time_ < var_343_15 + var_343_16 and not isNil(var_343_14) then
				local var_343_17 = (arg_340_1.time_ - var_343_15) / var_343_16

				if arg_340_1.var_.characterEffect1085ui_story and not isNil(var_343_14) then
					arg_340_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_15 + var_343_16 and arg_340_1.time_ < var_343_15 + var_343_16 + arg_343_0 and not isNil(var_343_14) and arg_340_1.var_.characterEffect1085ui_story then
				arg_340_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_343_18 = 0

			if var_343_18 < arg_340_1.time_ and arg_340_1.time_ <= var_343_18 + arg_343_0 then
				arg_340_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_343_19 = 0

			if var_343_19 < arg_340_1.time_ and arg_340_1.time_ <= var_343_19 + arg_343_0 then
				arg_340_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_343_20 = 0
			local var_343_21 = 0.475

			if var_343_20 < arg_340_1.time_ and arg_340_1.time_ <= var_343_20 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_22 = arg_340_1:FormatText(StoryNameCfg[328].name)

				arg_340_1.leftNameTxt_.text = var_343_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_23 = arg_340_1:GetWordFromCfg(322281084)
				local var_343_24 = arg_340_1:FormatText(var_343_23.content)

				arg_340_1.text_.text = var_343_24

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_25 = 19
				local var_343_26 = utf8.len(var_343_24)
				local var_343_27 = var_343_25 <= 0 and var_343_21 or var_343_21 * (var_343_26 / var_343_25)

				if var_343_27 > 0 and var_343_21 < var_343_27 then
					arg_340_1.talkMaxDuration = var_343_27

					if var_343_27 + var_343_20 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_27 + var_343_20
					end
				end

				arg_340_1.text_.text = var_343_24
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281084", "story_v_out_322281.awb") ~= 0 then
					local var_343_28 = manager.audio:GetVoiceLength("story_v_out_322281", "322281084", "story_v_out_322281.awb") / 1000

					if var_343_28 + var_343_20 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_28 + var_343_20
					end

					if var_343_23.prefab_name ~= "" and arg_340_1.actors_[var_343_23.prefab_name] ~= nil then
						local var_343_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_23.prefab_name].transform, "story_v_out_322281", "322281084", "story_v_out_322281.awb")

						arg_340_1:RecordAudio("322281084", var_343_29)
						arg_340_1:RecordAudio("322281084", var_343_29)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_322281", "322281084", "story_v_out_322281.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_322281", "322281084", "story_v_out_322281.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_30 = math.max(var_343_21, arg_340_1.talkMaxDuration)

			if var_343_20 <= arg_340_1.time_ and arg_340_1.time_ < var_343_20 + var_343_30 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_20) / var_343_30

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_20 + var_343_30 and arg_340_1.time_ < var_343_20 + var_343_30 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play322281085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 322281085
		arg_344_1.duration_ = 5.13

		local var_344_0 = {
			zh = 4.9,
			ja = 5.133
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play322281086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1044ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos1044ui_story = var_347_0.localPosition
			end

			local var_347_2 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(0.7, -1, -5.93)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1044ui_story, var_347_4, var_347_3)

				local var_347_5 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_5.x, var_347_5.y, var_347_5.z)

				local var_347_6 = var_347_0.localEulerAngles

				var_347_6.z = 0
				var_347_6.x = 0
				var_347_0.localEulerAngles = var_347_6
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_347_7 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_7.x, var_347_7.y, var_347_7.z)

				local var_347_8 = var_347_0.localEulerAngles

				var_347_8.z = 0
				var_347_8.x = 0
				var_347_0.localEulerAngles = var_347_8
			end

			local var_347_9 = arg_344_1.actors_["1044ui_story"]
			local var_347_10 = 0

			if var_347_10 < arg_344_1.time_ and arg_344_1.time_ <= var_347_10 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1044ui_story == nil then
				arg_344_1.var_.characterEffect1044ui_story = var_347_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_11 = 0.200000002980232

			if var_347_10 <= arg_344_1.time_ and arg_344_1.time_ < var_347_10 + var_347_11 and not isNil(var_347_9) then
				local var_347_12 = (arg_344_1.time_ - var_347_10) / var_347_11

				if arg_344_1.var_.characterEffect1044ui_story and not isNil(var_347_9) then
					arg_344_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_10 + var_347_11 and arg_344_1.time_ < var_347_10 + var_347_11 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1044ui_story then
				arg_344_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_347_13 = 0

			if var_347_13 < arg_344_1.time_ and arg_344_1.time_ <= var_347_13 + arg_347_0 then
				arg_344_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_347_14 = 0

			if var_347_14 < arg_344_1.time_ and arg_344_1.time_ <= var_347_14 + arg_347_0 then
				arg_344_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_347_15 = arg_344_1.actors_["1085ui_story"]
			local var_347_16 = 0

			if var_347_16 < arg_344_1.time_ and arg_344_1.time_ <= var_347_16 + arg_347_0 and not isNil(var_347_15) and arg_344_1.var_.characterEffect1085ui_story == nil then
				arg_344_1.var_.characterEffect1085ui_story = var_347_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_17 = 0.200000002980232

			if var_347_16 <= arg_344_1.time_ and arg_344_1.time_ < var_347_16 + var_347_17 and not isNil(var_347_15) then
				local var_347_18 = (arg_344_1.time_ - var_347_16) / var_347_17

				if arg_344_1.var_.characterEffect1085ui_story and not isNil(var_347_15) then
					local var_347_19 = Mathf.Lerp(0, 0.5, var_347_18)

					arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1085ui_story.fillRatio = var_347_19
				end
			end

			if arg_344_1.time_ >= var_347_16 + var_347_17 and arg_344_1.time_ < var_347_16 + var_347_17 + arg_347_0 and not isNil(var_347_15) and arg_344_1.var_.characterEffect1085ui_story then
				local var_347_20 = 0.5

				arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1085ui_story.fillRatio = var_347_20
			end

			local var_347_21 = arg_344_1.actors_["1085ui_story"].transform
			local var_347_22 = 0

			if var_347_22 < arg_344_1.time_ and arg_344_1.time_ <= var_347_22 + arg_347_0 then
				arg_344_1.var_.moveOldPos1085ui_story = var_347_21.localPosition
			end

			local var_347_23 = 0.001

			if var_347_22 <= arg_344_1.time_ and arg_344_1.time_ < var_347_22 + var_347_23 then
				local var_347_24 = (arg_344_1.time_ - var_347_22) / var_347_23
				local var_347_25 = Vector3.New(-0.75, -1.01, -5.83)

				var_347_21.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1085ui_story, var_347_25, var_347_24)

				local var_347_26 = manager.ui.mainCamera.transform.position - var_347_21.position

				var_347_21.forward = Vector3.New(var_347_26.x, var_347_26.y, var_347_26.z)

				local var_347_27 = var_347_21.localEulerAngles

				var_347_27.z = 0
				var_347_27.x = 0
				var_347_21.localEulerAngles = var_347_27
			end

			if arg_344_1.time_ >= var_347_22 + var_347_23 and arg_344_1.time_ < var_347_22 + var_347_23 + arg_347_0 then
				var_347_21.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_347_28 = manager.ui.mainCamera.transform.position - var_347_21.position

				var_347_21.forward = Vector3.New(var_347_28.x, var_347_28.y, var_347_28.z)

				local var_347_29 = var_347_21.localEulerAngles

				var_347_29.z = 0
				var_347_29.x = 0
				var_347_21.localEulerAngles = var_347_29
			end

			local var_347_30 = 0
			local var_347_31 = 0.475

			if var_347_30 < arg_344_1.time_ and arg_344_1.time_ <= var_347_30 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_32 = arg_344_1:FormatText(StoryNameCfg[1367].name)

				arg_344_1.leftNameTxt_.text = var_347_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_33 = arg_344_1:GetWordFromCfg(322281085)
				local var_347_34 = arg_344_1:FormatText(var_347_33.content)

				arg_344_1.text_.text = var_347_34

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_35 = 19
				local var_347_36 = utf8.len(var_347_34)
				local var_347_37 = var_347_35 <= 0 and var_347_31 or var_347_31 * (var_347_36 / var_347_35)

				if var_347_37 > 0 and var_347_31 < var_347_37 then
					arg_344_1.talkMaxDuration = var_347_37

					if var_347_37 + var_347_30 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_37 + var_347_30
					end
				end

				arg_344_1.text_.text = var_347_34
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281085", "story_v_out_322281.awb") ~= 0 then
					local var_347_38 = manager.audio:GetVoiceLength("story_v_out_322281", "322281085", "story_v_out_322281.awb") / 1000

					if var_347_38 + var_347_30 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_38 + var_347_30
					end

					if var_347_33.prefab_name ~= "" and arg_344_1.actors_[var_347_33.prefab_name] ~= nil then
						local var_347_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_33.prefab_name].transform, "story_v_out_322281", "322281085", "story_v_out_322281.awb")

						arg_344_1:RecordAudio("322281085", var_347_39)
						arg_344_1:RecordAudio("322281085", var_347_39)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_322281", "322281085", "story_v_out_322281.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_322281", "322281085", "story_v_out_322281.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_40 = math.max(var_347_31, arg_344_1.talkMaxDuration)

			if var_347_30 <= arg_344_1.time_ and arg_344_1.time_ < var_347_30 + var_347_40 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_30) / var_347_40

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_30 + var_347_40 and arg_344_1.time_ < var_347_30 + var_347_40 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play322281086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 322281086
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play322281087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1044ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1044ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, 100, 0)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1044ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, 100, 0)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["1085ui_story"].transform
			local var_351_10 = 0

			if var_351_10 < arg_348_1.time_ and arg_348_1.time_ <= var_351_10 + arg_351_0 then
				arg_348_1.var_.moveOldPos1085ui_story = var_351_9.localPosition
			end

			local var_351_11 = 0.001

			if var_351_10 <= arg_348_1.time_ and arg_348_1.time_ < var_351_10 + var_351_11 then
				local var_351_12 = (arg_348_1.time_ - var_351_10) / var_351_11
				local var_351_13 = Vector3.New(0, 100, 0)

				var_351_9.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1085ui_story, var_351_13, var_351_12)

				local var_351_14 = manager.ui.mainCamera.transform.position - var_351_9.position

				var_351_9.forward = Vector3.New(var_351_14.x, var_351_14.y, var_351_14.z)

				local var_351_15 = var_351_9.localEulerAngles

				var_351_15.z = 0
				var_351_15.x = 0
				var_351_9.localEulerAngles = var_351_15
			end

			if arg_348_1.time_ >= var_351_10 + var_351_11 and arg_348_1.time_ < var_351_10 + var_351_11 + arg_351_0 then
				var_351_9.localPosition = Vector3.New(0, 100, 0)

				local var_351_16 = manager.ui.mainCamera.transform.position - var_351_9.position

				var_351_9.forward = Vector3.New(var_351_16.x, var_351_16.y, var_351_16.z)

				local var_351_17 = var_351_9.localEulerAngles

				var_351_17.z = 0
				var_351_17.x = 0
				var_351_9.localEulerAngles = var_351_17
			end

			local var_351_18 = 0
			local var_351_19 = 1.375

			if var_351_18 < arg_348_1.time_ and arg_348_1.time_ <= var_351_18 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_20 = arg_348_1:GetWordFromCfg(322281086)
				local var_351_21 = arg_348_1:FormatText(var_351_20.content)

				arg_348_1.text_.text = var_351_21

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_22 = 55
				local var_351_23 = utf8.len(var_351_21)
				local var_351_24 = var_351_22 <= 0 and var_351_19 or var_351_19 * (var_351_23 / var_351_22)

				if var_351_24 > 0 and var_351_19 < var_351_24 then
					arg_348_1.talkMaxDuration = var_351_24

					if var_351_24 + var_351_18 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_24 + var_351_18
					end
				end

				arg_348_1.text_.text = var_351_21
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_25 = math.max(var_351_19, arg_348_1.talkMaxDuration)

			if var_351_18 <= arg_348_1.time_ and arg_348_1.time_ < var_351_18 + var_351_25 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_18) / var_351_25

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_18 + var_351_25 and arg_348_1.time_ < var_351_18 + var_351_25 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play322281087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 322281087
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play322281088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.375

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(322281087)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 15
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_8 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_8 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_8

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_8 and arg_352_1.time_ < var_355_0 + var_355_8 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play322281088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 322281088
		arg_356_1.duration_ = 4

		local var_356_0 = {
			zh = 2.333,
			ja = 4
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play322281089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1085ui_story"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos1085ui_story = var_359_0.localPosition
			end

			local var_359_2 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2
				local var_359_4 = Vector3.New(0, -1.01, -5.83)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1085ui_story, var_359_4, var_359_3)

				local var_359_5 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_5.x, var_359_5.y, var_359_5.z)

				local var_359_6 = var_359_0.localEulerAngles

				var_359_6.z = 0
				var_359_6.x = 0
				var_359_0.localEulerAngles = var_359_6
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_359_7 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_7.x, var_359_7.y, var_359_7.z)

				local var_359_8 = var_359_0.localEulerAngles

				var_359_8.z = 0
				var_359_8.x = 0
				var_359_0.localEulerAngles = var_359_8
			end

			local var_359_9 = arg_356_1.actors_["1085ui_story"]
			local var_359_10 = 0

			if var_359_10 < arg_356_1.time_ and arg_356_1.time_ <= var_359_10 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect1085ui_story == nil then
				arg_356_1.var_.characterEffect1085ui_story = var_359_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_11 = 0.200000002980232

			if var_359_10 <= arg_356_1.time_ and arg_356_1.time_ < var_359_10 + var_359_11 and not isNil(var_359_9) then
				local var_359_12 = (arg_356_1.time_ - var_359_10) / var_359_11

				if arg_356_1.var_.characterEffect1085ui_story and not isNil(var_359_9) then
					arg_356_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_10 + var_359_11 and arg_356_1.time_ < var_359_10 + var_359_11 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect1085ui_story then
				arg_356_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_359_13 = 0

			if var_359_13 < arg_356_1.time_ and arg_356_1.time_ <= var_359_13 + arg_359_0 then
				arg_356_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_359_14 = 0

			if var_359_14 < arg_356_1.time_ and arg_356_1.time_ <= var_359_14 + arg_359_0 then
				arg_356_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_359_15 = 0
			local var_359_16 = 0.275

			if var_359_15 < arg_356_1.time_ and arg_356_1.time_ <= var_359_15 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_17 = arg_356_1:FormatText(StoryNameCfg[328].name)

				arg_356_1.leftNameTxt_.text = var_359_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_18 = arg_356_1:GetWordFromCfg(322281088)
				local var_359_19 = arg_356_1:FormatText(var_359_18.content)

				arg_356_1.text_.text = var_359_19

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_20 = 11
				local var_359_21 = utf8.len(var_359_19)
				local var_359_22 = var_359_20 <= 0 and var_359_16 or var_359_16 * (var_359_21 / var_359_20)

				if var_359_22 > 0 and var_359_16 < var_359_22 then
					arg_356_1.talkMaxDuration = var_359_22

					if var_359_22 + var_359_15 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_22 + var_359_15
					end
				end

				arg_356_1.text_.text = var_359_19
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281088", "story_v_out_322281.awb") ~= 0 then
					local var_359_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281088", "story_v_out_322281.awb") / 1000

					if var_359_23 + var_359_15 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_23 + var_359_15
					end

					if var_359_18.prefab_name ~= "" and arg_356_1.actors_[var_359_18.prefab_name] ~= nil then
						local var_359_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_18.prefab_name].transform, "story_v_out_322281", "322281088", "story_v_out_322281.awb")

						arg_356_1:RecordAudio("322281088", var_359_24)
						arg_356_1:RecordAudio("322281088", var_359_24)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_322281", "322281088", "story_v_out_322281.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_322281", "322281088", "story_v_out_322281.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_25 = math.max(var_359_16, arg_356_1.talkMaxDuration)

			if var_359_15 <= arg_356_1.time_ and arg_356_1.time_ < var_359_15 + var_359_25 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_15) / var_359_25

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_15 + var_359_25 and arg_356_1.time_ < var_359_15 + var_359_25 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play322281089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 322281089
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play322281090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1085ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1085ui_story == nil then
				arg_360_1.var_.characterEffect1085ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect1085ui_story and not isNil(var_363_0) then
					local var_363_4 = Mathf.Lerp(0, 0.5, var_363_3)

					arg_360_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1085ui_story.fillRatio = var_363_4
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1085ui_story then
				local var_363_5 = 0.5

				arg_360_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1085ui_story.fillRatio = var_363_5
			end

			local var_363_6 = 0
			local var_363_7 = 0.55

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_8 = arg_360_1:FormatText(StoryNameCfg[7].name)

				arg_360_1.leftNameTxt_.text = var_363_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_9 = arg_360_1:GetWordFromCfg(322281089)
				local var_363_10 = arg_360_1:FormatText(var_363_9.content)

				arg_360_1.text_.text = var_363_10

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_11 = 22
				local var_363_12 = utf8.len(var_363_10)
				local var_363_13 = var_363_11 <= 0 and var_363_7 or var_363_7 * (var_363_12 / var_363_11)

				if var_363_13 > 0 and var_363_7 < var_363_13 then
					arg_360_1.talkMaxDuration = var_363_13

					if var_363_13 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_10
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_14 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_14 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_14

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_14 and arg_360_1.time_ < var_363_6 + var_363_14 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play322281090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 322281090
		arg_364_1.duration_ = 3.33

		local var_364_0 = {
			zh = 2.733,
			ja = 3.333
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play322281091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1085ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect1085ui_story == nil then
				arg_364_1.var_.characterEffect1085ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect1085ui_story and not isNil(var_367_0) then
					arg_364_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect1085ui_story then
				arg_364_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_367_4 = 0

			if var_367_4 < arg_364_1.time_ and arg_364_1.time_ <= var_367_4 + arg_367_0 then
				arg_364_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_2")
			end

			local var_367_5 = 0

			if var_367_5 < arg_364_1.time_ and arg_364_1.time_ <= var_367_5 + arg_367_0 then
				arg_364_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_367_6 = 0
			local var_367_7 = 0.225

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[328].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_9 = arg_364_1:GetWordFromCfg(322281090)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 9
				local var_367_12 = utf8.len(var_367_10)
				local var_367_13 = var_367_11 <= 0 and var_367_7 or var_367_7 * (var_367_12 / var_367_11)

				if var_367_13 > 0 and var_367_7 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_10
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281090", "story_v_out_322281.awb") ~= 0 then
					local var_367_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281090", "story_v_out_322281.awb") / 1000

					if var_367_14 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_6
					end

					if var_367_9.prefab_name ~= "" and arg_364_1.actors_[var_367_9.prefab_name] ~= nil then
						local var_367_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_9.prefab_name].transform, "story_v_out_322281", "322281090", "story_v_out_322281.awb")

						arg_364_1:RecordAudio("322281090", var_367_15)
						arg_364_1:RecordAudio("322281090", var_367_15)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_322281", "322281090", "story_v_out_322281.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_322281", "322281090", "story_v_out_322281.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_16 and arg_364_1.time_ < var_367_6 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play322281091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322281091
		arg_368_1.duration_ = 15.93

		local var_368_0 = {
			zh = 14.333,
			ja = 15.933
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play322281092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 4

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.allBtn_.enabled = false
			end

			local var_371_1 = 0.3

			if arg_368_1.time_ >= var_371_0 + var_371_1 and arg_368_1.time_ < var_371_0 + var_371_1 + arg_371_0 then
				arg_368_1.allBtn_.enabled = true
			end

			local var_371_2 = "ST0505"

			if arg_368_1.bgs_[var_371_2] == nil then
				local var_371_3 = Object.Instantiate(arg_368_1.paintGo_)

				var_371_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_371_2)
				var_371_3.name = var_371_2
				var_371_3.transform.parent = arg_368_1.stage_.transform
				var_371_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.bgs_[var_371_2] = var_371_3
			end

			local var_371_4 = 2

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				local var_371_5 = manager.ui.mainCamera.transform.localPosition
				local var_371_6 = Vector3.New(0, 0, 10) + Vector3.New(var_371_5.x, var_371_5.y, 0)
				local var_371_7 = arg_368_1.bgs_.ST0505

				var_371_7.transform.localPosition = var_371_6
				var_371_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_8 = var_371_7:GetComponent("SpriteRenderer")

				if var_371_8 and var_371_8.sprite then
					local var_371_9 = (var_371_7.transform.localPosition - var_371_5).z
					local var_371_10 = manager.ui.mainCameraCom_
					local var_371_11 = 2 * var_371_9 * Mathf.Tan(var_371_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_371_12 = var_371_11 * var_371_10.aspect
					local var_371_13 = var_371_8.sprite.bounds.size.x
					local var_371_14 = var_371_8.sprite.bounds.size.y
					local var_371_15 = var_371_12 / var_371_13
					local var_371_16 = var_371_11 / var_371_14
					local var_371_17 = var_371_16 < var_371_15 and var_371_15 or var_371_16

					var_371_7.transform.localScale = Vector3.New(var_371_17, var_371_17, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "ST0505" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_18 = 0

			if var_371_18 < arg_368_1.time_ and arg_368_1.time_ <= var_371_18 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_19 = 2

			if var_371_18 <= arg_368_1.time_ and arg_368_1.time_ < var_371_18 + var_371_19 then
				local var_371_20 = (arg_368_1.time_ - var_371_18) / var_371_19
				local var_371_21 = Color.New(0, 0, 0)

				var_371_21.a = Mathf.Lerp(0, 1, var_371_20)
				arg_368_1.mask_.color = var_371_21
			end

			if arg_368_1.time_ >= var_371_18 + var_371_19 and arg_368_1.time_ < var_371_18 + var_371_19 + arg_371_0 then
				local var_371_22 = Color.New(0, 0, 0)

				var_371_22.a = 1
				arg_368_1.mask_.color = var_371_22
			end

			local var_371_23 = 2

			if var_371_23 < arg_368_1.time_ and arg_368_1.time_ <= var_371_23 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_24 = 2

			if var_371_23 <= arg_368_1.time_ and arg_368_1.time_ < var_371_23 + var_371_24 then
				local var_371_25 = (arg_368_1.time_ - var_371_23) / var_371_24
				local var_371_26 = Color.New(0, 0, 0)

				var_371_26.a = Mathf.Lerp(1, 0, var_371_25)
				arg_368_1.mask_.color = var_371_26
			end

			if arg_368_1.time_ >= var_371_23 + var_371_24 and arg_368_1.time_ < var_371_23 + var_371_24 + arg_371_0 then
				local var_371_27 = Color.New(0, 0, 0)
				local var_371_28 = 0

				arg_368_1.mask_.enabled = false
				var_371_27.a = var_371_28
				arg_368_1.mask_.color = var_371_27
			end

			local var_371_29 = "404001ui_story"

			if arg_368_1.actors_[var_371_29] == nil then
				local var_371_30 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_371_30) then
					local var_371_31 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_368_1.stage_.transform)

					var_371_31.name = var_371_29
					var_371_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_368_1.actors_[var_371_29] = var_371_31

					local var_371_32 = var_371_31:GetComponentInChildren(typeof(CharacterEffect))

					var_371_32.enabled = true

					local var_371_33 = GameObjectTools.GetOrAddComponent(var_371_31, typeof(DynamicBoneHelper))

					if var_371_33 then
						var_371_33:EnableDynamicBone(false)
					end

					arg_368_1:ShowWeapon(var_371_32.transform, false)

					arg_368_1.var_[var_371_29 .. "Animator"] = var_371_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_368_1.var_[var_371_29 .. "Animator"].applyRootMotion = true
					arg_368_1.var_[var_371_29 .. "LipSync"] = var_371_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_371_34 = arg_368_1.actors_["404001ui_story"].transform
			local var_371_35 = 4

			if var_371_35 < arg_368_1.time_ and arg_368_1.time_ <= var_371_35 + arg_371_0 then
				arg_368_1.var_.moveOldPos404001ui_story = var_371_34.localPosition
			end

			local var_371_36 = 0.001

			if var_371_35 <= arg_368_1.time_ and arg_368_1.time_ < var_371_35 + var_371_36 then
				local var_371_37 = (arg_368_1.time_ - var_371_35) / var_371_36
				local var_371_38 = Vector3.New(0, -1.55, -5.5)

				var_371_34.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos404001ui_story, var_371_38, var_371_37)

				local var_371_39 = manager.ui.mainCamera.transform.position - var_371_34.position

				var_371_34.forward = Vector3.New(var_371_39.x, var_371_39.y, var_371_39.z)

				local var_371_40 = var_371_34.localEulerAngles

				var_371_40.z = 0
				var_371_40.x = 0
				var_371_34.localEulerAngles = var_371_40
			end

			if arg_368_1.time_ >= var_371_35 + var_371_36 and arg_368_1.time_ < var_371_35 + var_371_36 + arg_371_0 then
				var_371_34.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_371_41 = manager.ui.mainCamera.transform.position - var_371_34.position

				var_371_34.forward = Vector3.New(var_371_41.x, var_371_41.y, var_371_41.z)

				local var_371_42 = var_371_34.localEulerAngles

				var_371_42.z = 0
				var_371_42.x = 0
				var_371_34.localEulerAngles = var_371_42
			end

			local var_371_43 = arg_368_1.actors_["404001ui_story"]
			local var_371_44 = 4

			if var_371_44 < arg_368_1.time_ and arg_368_1.time_ <= var_371_44 + arg_371_0 and not isNil(var_371_43) and arg_368_1.var_.characterEffect404001ui_story == nil then
				arg_368_1.var_.characterEffect404001ui_story = var_371_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_45 = 0.200000002980232

			if var_371_44 <= arg_368_1.time_ and arg_368_1.time_ < var_371_44 + var_371_45 and not isNil(var_371_43) then
				local var_371_46 = (arg_368_1.time_ - var_371_44) / var_371_45

				if arg_368_1.var_.characterEffect404001ui_story and not isNil(var_371_43) then
					arg_368_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_44 + var_371_45 and arg_368_1.time_ < var_371_44 + var_371_45 + arg_371_0 and not isNil(var_371_43) and arg_368_1.var_.characterEffect404001ui_story then
				arg_368_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_371_47 = 4

			if var_371_47 < arg_368_1.time_ and arg_368_1.time_ <= var_371_47 + arg_371_0 then
				arg_368_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_371_48 = 4

			if var_371_48 < arg_368_1.time_ and arg_368_1.time_ <= var_371_48 + arg_371_0 then
				arg_368_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_371_49 = arg_368_1.actors_["1085ui_story"].transform
			local var_371_50 = 2

			if var_371_50 < arg_368_1.time_ and arg_368_1.time_ <= var_371_50 + arg_371_0 then
				arg_368_1.var_.moveOldPos1085ui_story = var_371_49.localPosition
			end

			local var_371_51 = 0.001

			if var_371_50 <= arg_368_1.time_ and arg_368_1.time_ < var_371_50 + var_371_51 then
				local var_371_52 = (arg_368_1.time_ - var_371_50) / var_371_51
				local var_371_53 = Vector3.New(0, 100, 0)

				var_371_49.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1085ui_story, var_371_53, var_371_52)

				local var_371_54 = manager.ui.mainCamera.transform.position - var_371_49.position

				var_371_49.forward = Vector3.New(var_371_54.x, var_371_54.y, var_371_54.z)

				local var_371_55 = var_371_49.localEulerAngles

				var_371_55.z = 0
				var_371_55.x = 0
				var_371_49.localEulerAngles = var_371_55
			end

			if arg_368_1.time_ >= var_371_50 + var_371_51 and arg_368_1.time_ < var_371_50 + var_371_51 + arg_371_0 then
				var_371_49.localPosition = Vector3.New(0, 100, 0)

				local var_371_56 = manager.ui.mainCamera.transform.position - var_371_49.position

				var_371_49.forward = Vector3.New(var_371_56.x, var_371_56.y, var_371_56.z)

				local var_371_57 = var_371_49.localEulerAngles

				var_371_57.z = 0
				var_371_57.x = 0
				var_371_49.localEulerAngles = var_371_57
			end

			local var_371_58 = 0.1
			local var_371_59 = 1

			if var_371_58 < arg_368_1.time_ and arg_368_1.time_ <= var_371_58 + arg_371_0 then
				local var_371_60 = "stop"
				local var_371_61 = "effect"

				arg_368_1:AudioAction(var_371_60, var_371_61, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_371_62 = 1.66666666666667
			local var_371_63 = 1

			if var_371_62 < arg_368_1.time_ and arg_368_1.time_ <= var_371_62 + arg_371_0 then
				local var_371_64 = "play"
				local var_371_65 = "effect"

				arg_368_1:AudioAction(var_371_64, var_371_65, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_371_66 = 2

			arg_368_1.isInRecall_ = false

			if var_371_66 < arg_368_1.time_ and arg_368_1.time_ <= var_371_66 + arg_371_0 then
				arg_368_1.screenFilterGo_:SetActive(true)

				arg_368_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_371_2, iter_371_3 in pairs(arg_368_1.actors_) do
					local var_371_67 = iter_371_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_371_4, iter_371_5 in ipairs(var_371_67) do
						if iter_371_5.color.r > 0.51 then
							iter_371_5.color = Color.New(1, 1, 1)
						else
							iter_371_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_371_68 = 0.0166666666666667

			if var_371_66 <= arg_368_1.time_ and arg_368_1.time_ < var_371_66 + var_371_68 then
				local var_371_69 = (arg_368_1.time_ - var_371_66) / var_371_68

				arg_368_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_371_69)
			end

			if arg_368_1.time_ >= var_371_66 + var_371_68 and arg_368_1.time_ < var_371_66 + var_371_68 + arg_371_0 then
				arg_368_1.screenFilterEffect_.weight = 1
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_70 = 4
			local var_371_71 = 1.15

			if var_371_70 < arg_368_1.time_ and arg_368_1.time_ <= var_371_70 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_72 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_72:setOnUpdate(LuaHelper.FloatAction(function(arg_372_0)
					arg_368_1.dialogCg_.alpha = arg_372_0
				end))
				var_371_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_73 = arg_368_1:FormatText(StoryNameCfg[668].name)

				arg_368_1.leftNameTxt_.text = var_371_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_74 = arg_368_1:GetWordFromCfg(322281091)
				local var_371_75 = arg_368_1:FormatText(var_371_74.content)

				arg_368_1.text_.text = var_371_75

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_76 = 46
				local var_371_77 = utf8.len(var_371_75)
				local var_371_78 = var_371_76 <= 0 and var_371_71 or var_371_71 * (var_371_77 / var_371_76)

				if var_371_78 > 0 and var_371_71 < var_371_78 then
					arg_368_1.talkMaxDuration = var_371_78
					var_371_70 = var_371_70 + 0.3

					if var_371_78 + var_371_70 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_78 + var_371_70
					end
				end

				arg_368_1.text_.text = var_371_75
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281091", "story_v_out_322281.awb") ~= 0 then
					local var_371_79 = manager.audio:GetVoiceLength("story_v_out_322281", "322281091", "story_v_out_322281.awb") / 1000

					if var_371_79 + var_371_70 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_79 + var_371_70
					end

					if var_371_74.prefab_name ~= "" and arg_368_1.actors_[var_371_74.prefab_name] ~= nil then
						local var_371_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_74.prefab_name].transform, "story_v_out_322281", "322281091", "story_v_out_322281.awb")

						arg_368_1:RecordAudio("322281091", var_371_80)
						arg_368_1:RecordAudio("322281091", var_371_80)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_322281", "322281091", "story_v_out_322281.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_322281", "322281091", "story_v_out_322281.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_81 = var_371_70 + 0.3
			local var_371_82 = math.max(var_371_71, arg_368_1.talkMaxDuration)

			if var_371_81 <= arg_368_1.time_ and arg_368_1.time_ < var_371_81 + var_371_82 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_81) / var_371_82

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_81 + var_371_82 and arg_368_1.time_ < var_371_81 + var_371_82 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play322281092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 322281092
		arg_374_1.duration_ = 10.37

		local var_374_0 = {
			zh = 8.166,
			ja = 10.366
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play322281093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.95

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_2 = arg_374_1:FormatText(StoryNameCfg[668].name)

				arg_374_1.leftNameTxt_.text = var_377_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_3 = arg_374_1:GetWordFromCfg(322281092)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 38
				local var_377_6 = utf8.len(var_377_4)
				local var_377_7 = var_377_5 <= 0 and var_377_1 or var_377_1 * (var_377_6 / var_377_5)

				if var_377_7 > 0 and var_377_1 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_4
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281092", "story_v_out_322281.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281092", "story_v_out_322281.awb") / 1000

					if var_377_8 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_0
					end

					if var_377_3.prefab_name ~= "" and arg_374_1.actors_[var_377_3.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_3.prefab_name].transform, "story_v_out_322281", "322281092", "story_v_out_322281.awb")

						arg_374_1:RecordAudio("322281092", var_377_9)
						arg_374_1:RecordAudio("322281092", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_322281", "322281092", "story_v_out_322281.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_322281", "322281092", "story_v_out_322281.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_10 and arg_374_1.time_ < var_377_0 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play322281093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 322281093
		arg_378_1.duration_ = 7.33

		local var_378_0 = {
			zh = 6.7,
			ja = 7.333
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play322281094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_381_2 = 0
			local var_381_3 = 0.75

			if var_381_2 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_4 = arg_378_1:FormatText(StoryNameCfg[668].name)

				arg_378_1.leftNameTxt_.text = var_381_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_5 = arg_378_1:GetWordFromCfg(322281093)
				local var_381_6 = arg_378_1:FormatText(var_381_5.content)

				arg_378_1.text_.text = var_381_6

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 30
				local var_381_8 = utf8.len(var_381_6)
				local var_381_9 = var_381_7 <= 0 and var_381_3 or var_381_3 * (var_381_8 / var_381_7)

				if var_381_9 > 0 and var_381_3 < var_381_9 then
					arg_378_1.talkMaxDuration = var_381_9

					if var_381_9 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_9 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_6
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281093", "story_v_out_322281.awb") ~= 0 then
					local var_381_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281093", "story_v_out_322281.awb") / 1000

					if var_381_10 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_10 + var_381_2
					end

					if var_381_5.prefab_name ~= "" and arg_378_1.actors_[var_381_5.prefab_name] ~= nil then
						local var_381_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_5.prefab_name].transform, "story_v_out_322281", "322281093", "story_v_out_322281.awb")

						arg_378_1:RecordAudio("322281093", var_381_11)
						arg_378_1:RecordAudio("322281093", var_381_11)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_322281", "322281093", "story_v_out_322281.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_322281", "322281093", "story_v_out_322281.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_12 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_12 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_12

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_12 and arg_378_1.time_ < var_381_2 + var_381_12 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play322281094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 322281094
		arg_382_1.duration_ = 12.43

		local var_382_0 = {
			zh = 9.966,
			ja = 12.433
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play322281095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 1.225

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[668].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_3 = arg_382_1:GetWordFromCfg(322281094)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 49
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281094", "story_v_out_322281.awb") ~= 0 then
					local var_385_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281094", "story_v_out_322281.awb") / 1000

					if var_385_8 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_8 + var_385_0
					end

					if var_385_3.prefab_name ~= "" and arg_382_1.actors_[var_385_3.prefab_name] ~= nil then
						local var_385_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_3.prefab_name].transform, "story_v_out_322281", "322281094", "story_v_out_322281.awb")

						arg_382_1:RecordAudio("322281094", var_385_9)
						arg_382_1:RecordAudio("322281094", var_385_9)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_322281", "322281094", "story_v_out_322281.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_322281", "322281094", "story_v_out_322281.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_10 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_10 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_10

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_10 and arg_382_1.time_ < var_385_0 + var_385_10 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play322281095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 322281095
		arg_386_1.duration_ = 6.37

		local var_386_0 = {
			zh = 4.233,
			ja = 6.366
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play322281096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			local var_389_1 = 0
			local var_389_2 = 0.475

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_3 = arg_386_1:FormatText(StoryNameCfg[668].name)

				arg_386_1.leftNameTxt_.text = var_389_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_4 = arg_386_1:GetWordFromCfg(322281095)
				local var_389_5 = arg_386_1:FormatText(var_389_4.content)

				arg_386_1.text_.text = var_389_5

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_6 = 19
				local var_389_7 = utf8.len(var_389_5)
				local var_389_8 = var_389_6 <= 0 and var_389_2 or var_389_2 * (var_389_7 / var_389_6)

				if var_389_8 > 0 and var_389_2 < var_389_8 then
					arg_386_1.talkMaxDuration = var_389_8

					if var_389_8 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_5
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281095", "story_v_out_322281.awb") ~= 0 then
					local var_389_9 = manager.audio:GetVoiceLength("story_v_out_322281", "322281095", "story_v_out_322281.awb") / 1000

					if var_389_9 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_9 + var_389_1
					end

					if var_389_4.prefab_name ~= "" and arg_386_1.actors_[var_389_4.prefab_name] ~= nil then
						local var_389_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_4.prefab_name].transform, "story_v_out_322281", "322281095", "story_v_out_322281.awb")

						arg_386_1:RecordAudio("322281095", var_389_10)
						arg_386_1:RecordAudio("322281095", var_389_10)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_322281", "322281095", "story_v_out_322281.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_322281", "322281095", "story_v_out_322281.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_11 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_11 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_11

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_11 and arg_386_1.time_ < var_389_1 + var_389_11 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play322281096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 322281096
		arg_390_1.duration_ = 6

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play322281097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 3.999999999999

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.allBtn_.enabled = false
			end

			local var_393_1 = 0.125

			if arg_390_1.time_ >= var_393_0 + var_393_1 and arg_390_1.time_ < var_393_0 + var_393_1 + arg_393_0 then
				arg_390_1.allBtn_.enabled = true
			end

			local var_393_2 = 1.999999999999

			if var_393_2 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				local var_393_3 = manager.ui.mainCamera.transform.localPosition
				local var_393_4 = Vector3.New(0, 0, 10) + Vector3.New(var_393_3.x, var_393_3.y, 0)
				local var_393_5 = arg_390_1.bgs_.L01f

				var_393_5.transform.localPosition = var_393_4
				var_393_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_393_6 = var_393_5:GetComponent("SpriteRenderer")

				if var_393_6 and var_393_6.sprite then
					local var_393_7 = (var_393_5.transform.localPosition - var_393_3).z
					local var_393_8 = manager.ui.mainCameraCom_
					local var_393_9 = 2 * var_393_7 * Mathf.Tan(var_393_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_393_10 = var_393_9 * var_393_8.aspect
					local var_393_11 = var_393_6.sprite.bounds.size.x
					local var_393_12 = var_393_6.sprite.bounds.size.y
					local var_393_13 = var_393_10 / var_393_11
					local var_393_14 = var_393_9 / var_393_12
					local var_393_15 = var_393_14 < var_393_13 and var_393_13 or var_393_14

					var_393_5.transform.localScale = Vector3.New(var_393_15, var_393_15, 0)
				end

				for iter_393_0, iter_393_1 in pairs(arg_390_1.bgs_) do
					if iter_393_0 ~= "L01f" then
						iter_393_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_393_16 = 0

			if var_393_16 < arg_390_1.time_ and arg_390_1.time_ <= var_393_16 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_17 = 2

			if var_393_16 <= arg_390_1.time_ and arg_390_1.time_ < var_393_16 + var_393_17 then
				local var_393_18 = (arg_390_1.time_ - var_393_16) / var_393_17
				local var_393_19 = Color.New(0, 0, 0)

				var_393_19.a = Mathf.Lerp(0, 1, var_393_18)
				arg_390_1.mask_.color = var_393_19
			end

			if arg_390_1.time_ >= var_393_16 + var_393_17 and arg_390_1.time_ < var_393_16 + var_393_17 + arg_393_0 then
				local var_393_20 = Color.New(0, 0, 0)

				var_393_20.a = 1
				arg_390_1.mask_.color = var_393_20
			end

			local var_393_21 = 2

			if var_393_21 < arg_390_1.time_ and arg_390_1.time_ <= var_393_21 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_22 = 2

			if var_393_21 <= arg_390_1.time_ and arg_390_1.time_ < var_393_21 + var_393_22 then
				local var_393_23 = (arg_390_1.time_ - var_393_21) / var_393_22
				local var_393_24 = Color.New(0, 0, 0)

				var_393_24.a = Mathf.Lerp(1, 0, var_393_23)
				arg_390_1.mask_.color = var_393_24
			end

			if arg_390_1.time_ >= var_393_21 + var_393_22 and arg_390_1.time_ < var_393_21 + var_393_22 + arg_393_0 then
				local var_393_25 = Color.New(0, 0, 0)
				local var_393_26 = 0

				arg_390_1.mask_.enabled = false
				var_393_25.a = var_393_26
				arg_390_1.mask_.color = var_393_25
			end

			local var_393_27 = arg_390_1.actors_["404001ui_story"].transform
			local var_393_28 = 1.96599999815126

			if var_393_28 < arg_390_1.time_ and arg_390_1.time_ <= var_393_28 + arg_393_0 then
				arg_390_1.var_.moveOldPos404001ui_story = var_393_27.localPosition
			end

			local var_393_29 = 0.001

			if var_393_28 <= arg_390_1.time_ and arg_390_1.time_ < var_393_28 + var_393_29 then
				local var_393_30 = (arg_390_1.time_ - var_393_28) / var_393_29
				local var_393_31 = Vector3.New(0, 100, 0)

				var_393_27.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos404001ui_story, var_393_31, var_393_30)

				local var_393_32 = manager.ui.mainCamera.transform.position - var_393_27.position

				var_393_27.forward = Vector3.New(var_393_32.x, var_393_32.y, var_393_32.z)

				local var_393_33 = var_393_27.localEulerAngles

				var_393_33.z = 0
				var_393_33.x = 0
				var_393_27.localEulerAngles = var_393_33
			end

			if arg_390_1.time_ >= var_393_28 + var_393_29 and arg_390_1.time_ < var_393_28 + var_393_29 + arg_393_0 then
				var_393_27.localPosition = Vector3.New(0, 100, 0)

				local var_393_34 = manager.ui.mainCamera.transform.position - var_393_27.position

				var_393_27.forward = Vector3.New(var_393_34.x, var_393_34.y, var_393_34.z)

				local var_393_35 = var_393_27.localEulerAngles

				var_393_35.z = 0
				var_393_35.x = 0
				var_393_27.localEulerAngles = var_393_35
			end

			local var_393_36 = arg_390_1.actors_["10102ui_story"]
			local var_393_37 = 3.999999999999

			if var_393_37 < arg_390_1.time_ and arg_390_1.time_ <= var_393_37 + arg_393_0 and not isNil(var_393_36) and arg_390_1.var_.characterEffect10102ui_story == nil then
				arg_390_1.var_.characterEffect10102ui_story = var_393_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_38 = 0.125

			if var_393_37 <= arg_390_1.time_ and arg_390_1.time_ < var_393_37 + var_393_38 and not isNil(var_393_36) then
				local var_393_39 = (arg_390_1.time_ - var_393_37) / var_393_38

				if arg_390_1.var_.characterEffect10102ui_story and not isNil(var_393_36) then
					arg_390_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_37 + var_393_38 and arg_390_1.time_ < var_393_37 + var_393_38 + arg_393_0 and not isNil(var_393_36) and arg_390_1.var_.characterEffect10102ui_story then
				arg_390_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_393_40 = arg_390_1.actors_["10102ui_story"].transform
			local var_393_41 = 4.01733333518008

			if var_393_41 < arg_390_1.time_ and arg_390_1.time_ <= var_393_41 + arg_393_0 then
				arg_390_1.var_.moveOldPos10102ui_story = var_393_40.localPosition
			end

			local var_393_42 = 0.001

			if var_393_41 <= arg_390_1.time_ and arg_390_1.time_ < var_393_41 + var_393_42 then
				local var_393_43 = (arg_390_1.time_ - var_393_41) / var_393_42
				local var_393_44 = Vector3.New(0, -0.985, -6.275)

				var_393_40.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10102ui_story, var_393_44, var_393_43)

				local var_393_45 = manager.ui.mainCamera.transform.position - var_393_40.position

				var_393_40.forward = Vector3.New(var_393_45.x, var_393_45.y, var_393_45.z)

				local var_393_46 = var_393_40.localEulerAngles

				var_393_46.z = 0
				var_393_46.x = 0
				var_393_40.localEulerAngles = var_393_46
			end

			if arg_390_1.time_ >= var_393_41 + var_393_42 and arg_390_1.time_ < var_393_41 + var_393_42 + arg_393_0 then
				var_393_40.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_393_47 = manager.ui.mainCamera.transform.position - var_393_40.position

				var_393_40.forward = Vector3.New(var_393_47.x, var_393_47.y, var_393_47.z)

				local var_393_48 = var_393_40.localEulerAngles

				var_393_48.z = 0
				var_393_48.x = 0
				var_393_40.localEulerAngles = var_393_48
			end

			local var_393_49 = 3.999999999999

			if var_393_49 < arg_390_1.time_ and arg_390_1.time_ <= var_393_49 + arg_393_0 then
				arg_390_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_393_50 = 3.999999999999

			if var_393_50 < arg_390_1.time_ and arg_390_1.time_ <= var_393_50 + arg_393_0 then
				arg_390_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_393_51 = 0.233333333333333
			local var_393_52 = 1

			if var_393_51 < arg_390_1.time_ and arg_390_1.time_ <= var_393_51 + arg_393_0 then
				local var_393_53 = "stop"
				local var_393_54 = "effect"

				arg_390_1:AudioAction(var_393_53, var_393_54, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_393_55 = 1.53333333333333
			local var_393_56 = 1

			if var_393_55 < arg_390_1.time_ and arg_390_1.time_ <= var_393_55 + arg_393_0 then
				local var_393_57 = "play"
				local var_393_58 = "effect"

				arg_390_1:AudioAction(var_393_57, var_393_58, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_393_59 = 2

			arg_390_1.isInRecall_ = false

			if var_393_59 < arg_390_1.time_ and arg_390_1.time_ <= var_393_59 + arg_393_0 then
				arg_390_1.screenFilterGo_:SetActive(false)

				for iter_393_2, iter_393_3 in pairs(arg_390_1.actors_) do
					local var_393_60 = iter_393_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_393_4, iter_393_5 in ipairs(var_393_60) do
						if iter_393_5.color.r > 0.51 then
							iter_393_5.color = Color.New(1, 1, 1)
						else
							iter_393_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_393_61 = 0.0166666666666667

			if var_393_59 <= arg_390_1.time_ and arg_390_1.time_ < var_393_59 + var_393_61 then
				local var_393_62 = (arg_390_1.time_ - var_393_59) / var_393_61

				arg_390_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_393_62)
			end

			if arg_390_1.time_ >= var_393_59 + var_393_61 and arg_390_1.time_ < var_393_59 + var_393_61 + arg_393_0 then
				arg_390_1.screenFilterEffect_.weight = 0
			end

			if arg_390_1.frameCnt_ <= 1 then
				arg_390_1.dialog_:SetActive(false)
			end

			local var_393_63 = 3.999999999999
			local var_393_64 = 0.125

			if var_393_63 < arg_390_1.time_ and arg_390_1.time_ <= var_393_63 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0

				arg_390_1.dialog_:SetActive(true)

				arg_390_1.dialogCg_.alpha = 0

				local var_393_65 = LeanTween.value(arg_390_1.dialog_, 0, 1, 0.3)

				var_393_65:setOnUpdate(LuaHelper.FloatAction(function(arg_394_0)
					arg_390_1.dialogCg_.alpha = arg_394_0
				end))
				var_393_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_390_1.dialog_)
					var_393_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_390_1.duration_ = arg_390_1.duration_ + 0.3

				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_66 = arg_390_1:FormatText(StoryNameCfg[6].name)

				arg_390_1.leftNameTxt_.text = var_393_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_67 = arg_390_1:GetWordFromCfg(322281096)
				local var_393_68 = arg_390_1:FormatText(var_393_67.content)

				arg_390_1.text_.text = var_393_68

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_69 = 5
				local var_393_70 = utf8.len(var_393_68)
				local var_393_71 = var_393_69 <= 0 and var_393_64 or var_393_64 * (var_393_70 / var_393_69)

				if var_393_71 > 0 and var_393_64 < var_393_71 then
					arg_390_1.talkMaxDuration = var_393_71
					var_393_63 = var_393_63 + 0.3

					if var_393_71 + var_393_63 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_71 + var_393_63
					end
				end

				arg_390_1.text_.text = var_393_68
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281096", "story_v_out_322281.awb") ~= 0 then
					local var_393_72 = manager.audio:GetVoiceLength("story_v_out_322281", "322281096", "story_v_out_322281.awb") / 1000

					if var_393_72 + var_393_63 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_72 + var_393_63
					end

					if var_393_67.prefab_name ~= "" and arg_390_1.actors_[var_393_67.prefab_name] ~= nil then
						local var_393_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_67.prefab_name].transform, "story_v_out_322281", "322281096", "story_v_out_322281.awb")

						arg_390_1:RecordAudio("322281096", var_393_73)
						arg_390_1:RecordAudio("322281096", var_393_73)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_322281", "322281096", "story_v_out_322281.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_322281", "322281096", "story_v_out_322281.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_74 = var_393_63 + 0.3
			local var_393_75 = math.max(var_393_64, arg_390_1.talkMaxDuration)

			if var_393_74 <= arg_390_1.time_ and arg_390_1.time_ < var_393_74 + var_393_75 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_74) / var_393_75

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_74 + var_393_75 and arg_390_1.time_ < var_393_74 + var_393_75 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.01733333518008,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play322281097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322281097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play322281098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["10102ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos10102ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0, 100, 0)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10102ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, 100, 0)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = 0
			local var_399_10 = 0.5

			if var_399_9 < arg_396_1.time_ and arg_396_1.time_ <= var_399_9 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_11 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_12 = arg_396_1:GetWordFromCfg(322281097)
				local var_399_13 = arg_396_1:FormatText(var_399_12.content)

				arg_396_1.text_.text = var_399_13

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_14 = 20
				local var_399_15 = utf8.len(var_399_13)
				local var_399_16 = var_399_14 <= 0 and var_399_10 or var_399_10 * (var_399_15 / var_399_14)

				if var_399_16 > 0 and var_399_10 < var_399_16 then
					arg_396_1.talkMaxDuration = var_399_16

					if var_399_16 + var_399_9 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_16 + var_399_9
					end
				end

				arg_396_1.text_.text = var_399_13
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_17 = math.max(var_399_10, arg_396_1.talkMaxDuration)

			if var_399_9 <= arg_396_1.time_ and arg_396_1.time_ < var_399_9 + var_399_17 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_9) / var_399_17

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_9 + var_399_17 and arg_396_1.time_ < var_399_9 + var_399_17 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play322281098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 322281098
		arg_400_1.duration_ = 6.8

		local var_400_0 = {
			zh = 4.833,
			ja = 6.8
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play322281099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["10102ui_story"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos10102ui_story = var_403_0.localPosition
			end

			local var_403_2 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2
				local var_403_4 = Vector3.New(0, 100, 0)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10102ui_story, var_403_4, var_403_3)

				local var_403_5 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_5.x, var_403_5.y, var_403_5.z)

				local var_403_6 = var_403_0.localEulerAngles

				var_403_6.z = 0
				var_403_6.x = 0
				var_403_0.localEulerAngles = var_403_6
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(0, 100, 0)

				local var_403_7 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_7.x, var_403_7.y, var_403_7.z)

				local var_403_8 = var_403_0.localEulerAngles

				var_403_8.z = 0
				var_403_8.x = 0
				var_403_0.localEulerAngles = var_403_8
			end

			local var_403_9 = arg_400_1.actors_["1044ui_story"].transform
			local var_403_10 = 0

			if var_403_10 < arg_400_1.time_ and arg_400_1.time_ <= var_403_10 + arg_403_0 then
				arg_400_1.var_.moveOldPos1044ui_story = var_403_9.localPosition

				local var_403_11 = "1044ui_story"

				arg_400_1:ShowWeapon(arg_400_1.var_[var_403_11 .. "Animator"].transform, false)
			end

			local var_403_12 = 0.001

			if var_403_10 <= arg_400_1.time_ and arg_400_1.time_ < var_403_10 + var_403_12 then
				local var_403_13 = (arg_400_1.time_ - var_403_10) / var_403_12
				local var_403_14 = Vector3.New(0, -1, -5.93)

				var_403_9.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1044ui_story, var_403_14, var_403_13)

				local var_403_15 = manager.ui.mainCamera.transform.position - var_403_9.position

				var_403_9.forward = Vector3.New(var_403_15.x, var_403_15.y, var_403_15.z)

				local var_403_16 = var_403_9.localEulerAngles

				var_403_16.z = 0
				var_403_16.x = 0
				var_403_9.localEulerAngles = var_403_16
			end

			if arg_400_1.time_ >= var_403_10 + var_403_12 and arg_400_1.time_ < var_403_10 + var_403_12 + arg_403_0 then
				var_403_9.localPosition = Vector3.New(0, -1, -5.93)

				local var_403_17 = manager.ui.mainCamera.transform.position - var_403_9.position

				var_403_9.forward = Vector3.New(var_403_17.x, var_403_17.y, var_403_17.z)

				local var_403_18 = var_403_9.localEulerAngles

				var_403_18.z = 0
				var_403_18.x = 0
				var_403_9.localEulerAngles = var_403_18
			end

			local var_403_19 = arg_400_1.actors_["1044ui_story"]
			local var_403_20 = 0

			if var_403_20 < arg_400_1.time_ and arg_400_1.time_ <= var_403_20 + arg_403_0 and not isNil(var_403_19) and arg_400_1.var_.characterEffect1044ui_story == nil then
				arg_400_1.var_.characterEffect1044ui_story = var_403_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_21 = 0.200000002980232

			if var_403_20 <= arg_400_1.time_ and arg_400_1.time_ < var_403_20 + var_403_21 and not isNil(var_403_19) then
				local var_403_22 = (arg_400_1.time_ - var_403_20) / var_403_21

				if arg_400_1.var_.characterEffect1044ui_story and not isNil(var_403_19) then
					arg_400_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_20 + var_403_21 and arg_400_1.time_ < var_403_20 + var_403_21 + arg_403_0 and not isNil(var_403_19) and arg_400_1.var_.characterEffect1044ui_story then
				arg_400_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_403_23 = 0

			if var_403_23 < arg_400_1.time_ and arg_400_1.time_ <= var_403_23 + arg_403_0 then
				arg_400_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_403_24 = 0

			if var_403_24 < arg_400_1.time_ and arg_400_1.time_ <= var_403_24 + arg_403_0 then
				arg_400_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_403_25 = 0
			local var_403_26 = 0.575

			if var_403_25 < arg_400_1.time_ and arg_400_1.time_ <= var_403_25 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_27 = arg_400_1:FormatText(StoryNameCfg[1367].name)

				arg_400_1.leftNameTxt_.text = var_403_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_28 = arg_400_1:GetWordFromCfg(322281098)
				local var_403_29 = arg_400_1:FormatText(var_403_28.content)

				arg_400_1.text_.text = var_403_29

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_30 = 22
				local var_403_31 = utf8.len(var_403_29)
				local var_403_32 = var_403_30 <= 0 and var_403_26 or var_403_26 * (var_403_31 / var_403_30)

				if var_403_32 > 0 and var_403_26 < var_403_32 then
					arg_400_1.talkMaxDuration = var_403_32

					if var_403_32 + var_403_25 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_32 + var_403_25
					end
				end

				arg_400_1.text_.text = var_403_29
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281098", "story_v_out_322281.awb") ~= 0 then
					local var_403_33 = manager.audio:GetVoiceLength("story_v_out_322281", "322281098", "story_v_out_322281.awb") / 1000

					if var_403_33 + var_403_25 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_33 + var_403_25
					end

					if var_403_28.prefab_name ~= "" and arg_400_1.actors_[var_403_28.prefab_name] ~= nil then
						local var_403_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_28.prefab_name].transform, "story_v_out_322281", "322281098", "story_v_out_322281.awb")

						arg_400_1:RecordAudio("322281098", var_403_34)
						arg_400_1:RecordAudio("322281098", var_403_34)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_322281", "322281098", "story_v_out_322281.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_322281", "322281098", "story_v_out_322281.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_35 = math.max(var_403_26, arg_400_1.talkMaxDuration)

			if var_403_25 <= arg_400_1.time_ and arg_400_1.time_ < var_403_25 + var_403_35 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_25) / var_403_35

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_25 + var_403_35 and arg_400_1.time_ < var_403_25 + var_403_35 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play322281099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 322281099
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play322281100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1044ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos1044ui_story = var_407_0.localPosition

				local var_407_2 = "1044ui_story"

				arg_404_1:ShowWeapon(arg_404_1.var_[var_407_2 .. "Animator"].transform, false)
			end

			local var_407_3 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_3 then
				local var_407_4 = (arg_404_1.time_ - var_407_1) / var_407_3
				local var_407_5 = Vector3.New(0, 100, 0)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1044ui_story, var_407_5, var_407_4)

				local var_407_6 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_6.x, var_407_6.y, var_407_6.z)

				local var_407_7 = var_407_0.localEulerAngles

				var_407_7.z = 0
				var_407_7.x = 0
				var_407_0.localEulerAngles = var_407_7
			end

			if arg_404_1.time_ >= var_407_1 + var_407_3 and arg_404_1.time_ < var_407_1 + var_407_3 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(0, 100, 0)

				local var_407_8 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_8.x, var_407_8.y, var_407_8.z)

				local var_407_9 = var_407_0.localEulerAngles

				var_407_9.z = 0
				var_407_9.x = 0
				var_407_0.localEulerAngles = var_407_9
			end

			local var_407_10 = 0
			local var_407_11 = 1.15

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_12 = arg_404_1:FormatText(StoryNameCfg[7].name)

				arg_404_1.leftNameTxt_.text = var_407_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_13 = arg_404_1:GetWordFromCfg(322281099)
				local var_407_14 = arg_404_1:FormatText(var_407_13.content)

				arg_404_1.text_.text = var_407_14

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_15 = 46
				local var_407_16 = utf8.len(var_407_14)
				local var_407_17 = var_407_15 <= 0 and var_407_11 or var_407_11 * (var_407_16 / var_407_15)

				if var_407_17 > 0 and var_407_11 < var_407_17 then
					arg_404_1.talkMaxDuration = var_407_17

					if var_407_17 + var_407_10 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_17 + var_407_10
					end
				end

				arg_404_1.text_.text = var_407_14
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_18 = math.max(var_407_11, arg_404_1.talkMaxDuration)

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_18 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_10) / var_407_18

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_10 + var_407_18 and arg_404_1.time_ < var_407_10 + var_407_18 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play322281100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 322281100
		arg_408_1.duration_ = 5.73

		local var_408_0 = {
			zh = 3.733,
			ja = 5.733
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play322281101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1020ui_story"].transform
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.var_.moveOldPos1020ui_story = var_411_0.localPosition
			end

			local var_411_2 = 0.001

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2
				local var_411_4 = Vector3.New(0, -0.85, -6.25)

				var_411_0.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1020ui_story, var_411_4, var_411_3)

				local var_411_5 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_5.x, var_411_5.y, var_411_5.z)

				local var_411_6 = var_411_0.localEulerAngles

				var_411_6.z = 0
				var_411_6.x = 0
				var_411_0.localEulerAngles = var_411_6
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 then
				var_411_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_411_7 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_7.x, var_411_7.y, var_411_7.z)

				local var_411_8 = var_411_0.localEulerAngles

				var_411_8.z = 0
				var_411_8.x = 0
				var_411_0.localEulerAngles = var_411_8
			end

			local var_411_9 = arg_408_1.actors_["1020ui_story"]
			local var_411_10 = 0

			if var_411_10 < arg_408_1.time_ and arg_408_1.time_ <= var_411_10 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect1020ui_story == nil then
				arg_408_1.var_.characterEffect1020ui_story = var_411_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_11 = 0.200000002980232

			if var_411_10 <= arg_408_1.time_ and arg_408_1.time_ < var_411_10 + var_411_11 and not isNil(var_411_9) then
				local var_411_12 = (arg_408_1.time_ - var_411_10) / var_411_11

				if arg_408_1.var_.characterEffect1020ui_story and not isNil(var_411_9) then
					arg_408_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_10 + var_411_11 and arg_408_1.time_ < var_411_10 + var_411_11 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect1020ui_story then
				arg_408_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_411_13 = 0

			if var_411_13 < arg_408_1.time_ and arg_408_1.time_ <= var_411_13 + arg_411_0 then
				arg_408_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_411_14 = 0

			if var_411_14 < arg_408_1.time_ and arg_408_1.time_ <= var_411_14 + arg_411_0 then
				arg_408_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_411_15 = 0
			local var_411_16 = 0.45

			if var_411_15 < arg_408_1.time_ and arg_408_1.time_ <= var_411_15 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_17 = arg_408_1:FormatText(StoryNameCfg[613].name)

				arg_408_1.leftNameTxt_.text = var_411_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_18 = arg_408_1:GetWordFromCfg(322281100)
				local var_411_19 = arg_408_1:FormatText(var_411_18.content)

				arg_408_1.text_.text = var_411_19

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_20 = 18
				local var_411_21 = utf8.len(var_411_19)
				local var_411_22 = var_411_20 <= 0 and var_411_16 or var_411_16 * (var_411_21 / var_411_20)

				if var_411_22 > 0 and var_411_16 < var_411_22 then
					arg_408_1.talkMaxDuration = var_411_22

					if var_411_22 + var_411_15 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_22 + var_411_15
					end
				end

				arg_408_1.text_.text = var_411_19
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281100", "story_v_out_322281.awb") ~= 0 then
					local var_411_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281100", "story_v_out_322281.awb") / 1000

					if var_411_23 + var_411_15 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_23 + var_411_15
					end

					if var_411_18.prefab_name ~= "" and arg_408_1.actors_[var_411_18.prefab_name] ~= nil then
						local var_411_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_18.prefab_name].transform, "story_v_out_322281", "322281100", "story_v_out_322281.awb")

						arg_408_1:RecordAudio("322281100", var_411_24)
						arg_408_1:RecordAudio("322281100", var_411_24)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_322281", "322281100", "story_v_out_322281.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_322281", "322281100", "story_v_out_322281.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_25 = math.max(var_411_16, arg_408_1.talkMaxDuration)

			if var_411_15 <= arg_408_1.time_ and arg_408_1.time_ < var_411_15 + var_411_25 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_15) / var_411_25

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_15 + var_411_25 and arg_408_1.time_ < var_411_15 + var_411_25 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play322281101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 322281101
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play322281102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1020ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1020ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, 100, 0)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1020ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, 100, 0)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = 0.963863093405962
			local var_415_10 = 1

			if var_415_9 < arg_412_1.time_ and arg_412_1.time_ <= var_415_9 + arg_415_0 then
				local var_415_11 = "play"
				local var_415_12 = "effect"

				arg_412_1:AudioAction(var_415_11, var_415_12, "se_story_1310", "se_story_1310_cardoor02", "")
			end

			local var_415_13 = 0
			local var_415_14 = 1.4

			if var_415_13 < arg_412_1.time_ and arg_412_1.time_ <= var_415_13 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_15 = arg_412_1:GetWordFromCfg(322281101)
				local var_415_16 = arg_412_1:FormatText(var_415_15.content)

				arg_412_1.text_.text = var_415_16

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_17 = 56
				local var_415_18 = utf8.len(var_415_16)
				local var_415_19 = var_415_17 <= 0 and var_415_14 or var_415_14 * (var_415_18 / var_415_17)

				if var_415_19 > 0 and var_415_14 < var_415_19 then
					arg_412_1.talkMaxDuration = var_415_19

					if var_415_19 + var_415_13 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_19 + var_415_13
					end
				end

				arg_412_1.text_.text = var_415_16
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_20 = math.max(var_415_14, arg_412_1.talkMaxDuration)

			if var_415_13 <= arg_412_1.time_ and arg_412_1.time_ < var_415_13 + var_415_20 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_13) / var_415_20

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_13 + var_415_20 and arg_412_1.time_ < var_415_13 + var_415_20 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play322281102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 322281102
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play322281103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.325

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(322281102)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 13
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_8 and arg_416_1.time_ < var_419_0 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play322281103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 322281103
		arg_420_1.duration_ = 8.33

		local var_420_0 = {
			zh = 6.566,
			ja = 8.333
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play322281104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1089ui_story"].transform
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.var_.moveOldPos1089ui_story = var_423_0.localPosition

				local var_423_2 = "1089ui_story"

				arg_420_1:ShowWeapon(arg_420_1.var_[var_423_2 .. "Animator"].transform, false)
			end

			local var_423_3 = 0.001

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_3 then
				local var_423_4 = (arg_420_1.time_ - var_423_1) / var_423_3
				local var_423_5 = Vector3.New(0, -1.1, -6.17)

				var_423_0.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1089ui_story, var_423_5, var_423_4)

				local var_423_6 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_6.x, var_423_6.y, var_423_6.z)

				local var_423_7 = var_423_0.localEulerAngles

				var_423_7.z = 0
				var_423_7.x = 0
				var_423_0.localEulerAngles = var_423_7
			end

			if arg_420_1.time_ >= var_423_1 + var_423_3 and arg_420_1.time_ < var_423_1 + var_423_3 + arg_423_0 then
				var_423_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_423_8 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_8.x, var_423_8.y, var_423_8.z)

				local var_423_9 = var_423_0.localEulerAngles

				var_423_9.z = 0
				var_423_9.x = 0
				var_423_0.localEulerAngles = var_423_9
			end

			local var_423_10 = arg_420_1.actors_["1089ui_story"]
			local var_423_11 = 0

			if var_423_11 < arg_420_1.time_ and arg_420_1.time_ <= var_423_11 + arg_423_0 and not isNil(var_423_10) and arg_420_1.var_.characterEffect1089ui_story == nil then
				arg_420_1.var_.characterEffect1089ui_story = var_423_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_12 = 0.200000002980232

			if var_423_11 <= arg_420_1.time_ and arg_420_1.time_ < var_423_11 + var_423_12 and not isNil(var_423_10) then
				local var_423_13 = (arg_420_1.time_ - var_423_11) / var_423_12

				if arg_420_1.var_.characterEffect1089ui_story and not isNil(var_423_10) then
					arg_420_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_11 + var_423_12 and arg_420_1.time_ < var_423_11 + var_423_12 + arg_423_0 and not isNil(var_423_10) and arg_420_1.var_.characterEffect1089ui_story then
				arg_420_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_423_14 = 0

			if var_423_14 < arg_420_1.time_ and arg_420_1.time_ <= var_423_14 + arg_423_0 then
				arg_420_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_423_15 = 0

			if var_423_15 < arg_420_1.time_ and arg_420_1.time_ <= var_423_15 + arg_423_0 then
				arg_420_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_423_16 = 0
			local var_423_17 = 0.7

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_18 = arg_420_1:FormatText(StoryNameCfg[1031].name)

				arg_420_1.leftNameTxt_.text = var_423_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_19 = arg_420_1:GetWordFromCfg(322281103)
				local var_423_20 = arg_420_1:FormatText(var_423_19.content)

				arg_420_1.text_.text = var_423_20

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_21 = 28
				local var_423_22 = utf8.len(var_423_20)
				local var_423_23 = var_423_21 <= 0 and var_423_17 or var_423_17 * (var_423_22 / var_423_21)

				if var_423_23 > 0 and var_423_17 < var_423_23 then
					arg_420_1.talkMaxDuration = var_423_23

					if var_423_23 + var_423_16 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_23 + var_423_16
					end
				end

				arg_420_1.text_.text = var_423_20
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281103", "story_v_out_322281.awb") ~= 0 then
					local var_423_24 = manager.audio:GetVoiceLength("story_v_out_322281", "322281103", "story_v_out_322281.awb") / 1000

					if var_423_24 + var_423_16 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_24 + var_423_16
					end

					if var_423_19.prefab_name ~= "" and arg_420_1.actors_[var_423_19.prefab_name] ~= nil then
						local var_423_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_19.prefab_name].transform, "story_v_out_322281", "322281103", "story_v_out_322281.awb")

						arg_420_1:RecordAudio("322281103", var_423_25)
						arg_420_1:RecordAudio("322281103", var_423_25)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_322281", "322281103", "story_v_out_322281.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_322281", "322281103", "story_v_out_322281.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_26 = math.max(var_423_17, arg_420_1.talkMaxDuration)

			if var_423_16 <= arg_420_1.time_ and arg_420_1.time_ < var_423_16 + var_423_26 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_16) / var_423_26

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_16 + var_423_26 and arg_420_1.time_ < var_423_16 + var_423_26 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play322281104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 322281104
		arg_424_1.duration_ = 4.57

		local var_424_0 = {
			zh = 3.333,
			ja = 4.566
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play322281105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1089ui_story"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos1089ui_story = var_427_0.localPosition
			end

			local var_427_2 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2
				local var_427_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1089ui_story, var_427_4, var_427_3)

				local var_427_5 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_5.x, var_427_5.y, var_427_5.z)

				local var_427_6 = var_427_0.localEulerAngles

				var_427_6.z = 0
				var_427_6.x = 0
				var_427_0.localEulerAngles = var_427_6
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_427_7 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_7.x, var_427_7.y, var_427_7.z)

				local var_427_8 = var_427_0.localEulerAngles

				var_427_8.z = 0
				var_427_8.x = 0
				var_427_0.localEulerAngles = var_427_8
			end

			local var_427_9 = arg_424_1.actors_["1044ui_story"].transform
			local var_427_10 = 0

			if var_427_10 < arg_424_1.time_ and arg_424_1.time_ <= var_427_10 + arg_427_0 then
				arg_424_1.var_.moveOldPos1044ui_story = var_427_9.localPosition

				local var_427_11 = "1044ui_story"

				arg_424_1:ShowWeapon(arg_424_1.var_[var_427_11 .. "Animator"].transform, false)
			end

			local var_427_12 = 0.001

			if var_427_10 <= arg_424_1.time_ and arg_424_1.time_ < var_427_10 + var_427_12 then
				local var_427_13 = (arg_424_1.time_ - var_427_10) / var_427_12
				local var_427_14 = Vector3.New(0.7, -1, -5.93)

				var_427_9.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1044ui_story, var_427_14, var_427_13)

				local var_427_15 = manager.ui.mainCamera.transform.position - var_427_9.position

				var_427_9.forward = Vector3.New(var_427_15.x, var_427_15.y, var_427_15.z)

				local var_427_16 = var_427_9.localEulerAngles

				var_427_16.z = 0
				var_427_16.x = 0
				var_427_9.localEulerAngles = var_427_16
			end

			if arg_424_1.time_ >= var_427_10 + var_427_12 and arg_424_1.time_ < var_427_10 + var_427_12 + arg_427_0 then
				var_427_9.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_427_17 = manager.ui.mainCamera.transform.position - var_427_9.position

				var_427_9.forward = Vector3.New(var_427_17.x, var_427_17.y, var_427_17.z)

				local var_427_18 = var_427_9.localEulerAngles

				var_427_18.z = 0
				var_427_18.x = 0
				var_427_9.localEulerAngles = var_427_18
			end

			local var_427_19 = arg_424_1.actors_["1044ui_story"]
			local var_427_20 = 0

			if var_427_20 < arg_424_1.time_ and arg_424_1.time_ <= var_427_20 + arg_427_0 and not isNil(var_427_19) and arg_424_1.var_.characterEffect1044ui_story == nil then
				arg_424_1.var_.characterEffect1044ui_story = var_427_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_21 = 0.200000002980232

			if var_427_20 <= arg_424_1.time_ and arg_424_1.time_ < var_427_20 + var_427_21 and not isNil(var_427_19) then
				local var_427_22 = (arg_424_1.time_ - var_427_20) / var_427_21

				if arg_424_1.var_.characterEffect1044ui_story and not isNil(var_427_19) then
					arg_424_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_20 + var_427_21 and arg_424_1.time_ < var_427_20 + var_427_21 + arg_427_0 and not isNil(var_427_19) and arg_424_1.var_.characterEffect1044ui_story then
				arg_424_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_427_23 = 0

			if var_427_23 < arg_424_1.time_ and arg_424_1.time_ <= var_427_23 + arg_427_0 then
				arg_424_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			local var_427_24 = 0

			if var_427_24 < arg_424_1.time_ and arg_424_1.time_ <= var_427_24 + arg_427_0 then
				arg_424_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_427_25 = arg_424_1.actors_["1089ui_story"]
			local var_427_26 = 0

			if var_427_26 < arg_424_1.time_ and arg_424_1.time_ <= var_427_26 + arg_427_0 and not isNil(var_427_25) and arg_424_1.var_.characterEffect1089ui_story == nil then
				arg_424_1.var_.characterEffect1089ui_story = var_427_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_27 = 0.200000002980232

			if var_427_26 <= arg_424_1.time_ and arg_424_1.time_ < var_427_26 + var_427_27 and not isNil(var_427_25) then
				local var_427_28 = (arg_424_1.time_ - var_427_26) / var_427_27

				if arg_424_1.var_.characterEffect1089ui_story and not isNil(var_427_25) then
					local var_427_29 = Mathf.Lerp(0, 0.5, var_427_28)

					arg_424_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1089ui_story.fillRatio = var_427_29
				end
			end

			if arg_424_1.time_ >= var_427_26 + var_427_27 and arg_424_1.time_ < var_427_26 + var_427_27 + arg_427_0 and not isNil(var_427_25) and arg_424_1.var_.characterEffect1089ui_story then
				local var_427_30 = 0.5

				arg_424_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1089ui_story.fillRatio = var_427_30
			end

			local var_427_31 = 0
			local var_427_32 = 0.3

			if var_427_31 < arg_424_1.time_ and arg_424_1.time_ <= var_427_31 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_33 = arg_424_1:FormatText(StoryNameCfg[1367].name)

				arg_424_1.leftNameTxt_.text = var_427_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_34 = arg_424_1:GetWordFromCfg(322281104)
				local var_427_35 = arg_424_1:FormatText(var_427_34.content)

				arg_424_1.text_.text = var_427_35

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_36 = 12
				local var_427_37 = utf8.len(var_427_35)
				local var_427_38 = var_427_36 <= 0 and var_427_32 or var_427_32 * (var_427_37 / var_427_36)

				if var_427_38 > 0 and var_427_32 < var_427_38 then
					arg_424_1.talkMaxDuration = var_427_38

					if var_427_38 + var_427_31 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_38 + var_427_31
					end
				end

				arg_424_1.text_.text = var_427_35
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281104", "story_v_out_322281.awb") ~= 0 then
					local var_427_39 = manager.audio:GetVoiceLength("story_v_out_322281", "322281104", "story_v_out_322281.awb") / 1000

					if var_427_39 + var_427_31 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_39 + var_427_31
					end

					if var_427_34.prefab_name ~= "" and arg_424_1.actors_[var_427_34.prefab_name] ~= nil then
						local var_427_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_34.prefab_name].transform, "story_v_out_322281", "322281104", "story_v_out_322281.awb")

						arg_424_1:RecordAudio("322281104", var_427_40)
						arg_424_1:RecordAudio("322281104", var_427_40)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_322281", "322281104", "story_v_out_322281.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_322281", "322281104", "story_v_out_322281.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_41 = math.max(var_427_32, arg_424_1.talkMaxDuration)

			if var_427_31 <= arg_424_1.time_ and arg_424_1.time_ < var_427_31 + var_427_41 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_31) / var_427_41

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_31 + var_427_41 and arg_424_1.time_ < var_427_31 + var_427_41 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play322281105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 322281105
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play322281106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1089ui_story"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos1089ui_story = var_431_0.localPosition
			end

			local var_431_2 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2
				local var_431_4 = Vector3.New(0, 100, 0)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1089ui_story, var_431_4, var_431_3)

				local var_431_5 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_5.x, var_431_5.y, var_431_5.z)

				local var_431_6 = var_431_0.localEulerAngles

				var_431_6.z = 0
				var_431_6.x = 0
				var_431_0.localEulerAngles = var_431_6
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0, 100, 0)

				local var_431_7 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_7.x, var_431_7.y, var_431_7.z)

				local var_431_8 = var_431_0.localEulerAngles

				var_431_8.z = 0
				var_431_8.x = 0
				var_431_0.localEulerAngles = var_431_8
			end

			local var_431_9 = 0.533333333333333
			local var_431_10 = 1

			if var_431_9 < arg_428_1.time_ and arg_428_1.time_ <= var_431_9 + arg_431_0 then
				local var_431_11 = "play"
				local var_431_12 = "effect"

				arg_428_1:AudioAction(var_431_11, var_431_12, "se_story_140", "se_story_140_safety belt", "")
			end

			local var_431_13 = arg_428_1.actors_["1044ui_story"].transform
			local var_431_14 = 0

			if var_431_14 < arg_428_1.time_ and arg_428_1.time_ <= var_431_14 + arg_431_0 then
				arg_428_1.var_.moveOldPos1044ui_story = var_431_13.localPosition

				local var_431_15 = "1044ui_story"

				arg_428_1:ShowWeapon(arg_428_1.var_[var_431_15 .. "Animator"].transform, false)
			end

			local var_431_16 = 0.001

			if var_431_14 <= arg_428_1.time_ and arg_428_1.time_ < var_431_14 + var_431_16 then
				local var_431_17 = (arg_428_1.time_ - var_431_14) / var_431_16
				local var_431_18 = Vector3.New(0, 100, 0)

				var_431_13.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1044ui_story, var_431_18, var_431_17)

				local var_431_19 = manager.ui.mainCamera.transform.position - var_431_13.position

				var_431_13.forward = Vector3.New(var_431_19.x, var_431_19.y, var_431_19.z)

				local var_431_20 = var_431_13.localEulerAngles

				var_431_20.z = 0
				var_431_20.x = 0
				var_431_13.localEulerAngles = var_431_20
			end

			if arg_428_1.time_ >= var_431_14 + var_431_16 and arg_428_1.time_ < var_431_14 + var_431_16 + arg_431_0 then
				var_431_13.localPosition = Vector3.New(0, 100, 0)

				local var_431_21 = manager.ui.mainCamera.transform.position - var_431_13.position

				var_431_13.forward = Vector3.New(var_431_21.x, var_431_21.y, var_431_21.z)

				local var_431_22 = var_431_13.localEulerAngles

				var_431_22.z = 0
				var_431_22.x = 0
				var_431_13.localEulerAngles = var_431_22
			end

			local var_431_23 = 0
			local var_431_24 = 1.15

			if var_431_23 < arg_428_1.time_ and arg_428_1.time_ <= var_431_23 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_25 = arg_428_1:GetWordFromCfg(322281105)
				local var_431_26 = arg_428_1:FormatText(var_431_25.content)

				arg_428_1.text_.text = var_431_26

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_27 = 46
				local var_431_28 = utf8.len(var_431_26)
				local var_431_29 = var_431_27 <= 0 and var_431_24 or var_431_24 * (var_431_28 / var_431_27)

				if var_431_29 > 0 and var_431_24 < var_431_29 then
					arg_428_1.talkMaxDuration = var_431_29

					if var_431_29 + var_431_23 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_29 + var_431_23
					end
				end

				arg_428_1.text_.text = var_431_26
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_30 = math.max(var_431_24, arg_428_1.talkMaxDuration)

			if var_431_23 <= arg_428_1.time_ and arg_428_1.time_ < var_431_23 + var_431_30 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_23) / var_431_30

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_23 + var_431_30 and arg_428_1.time_ < var_431_23 + var_431_30 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play322281106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 322281106
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play322281107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.9

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_2 = arg_432_1:GetWordFromCfg(322281106)
				local var_435_3 = arg_432_1:FormatText(var_435_2.content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 36
				local var_435_5 = utf8.len(var_435_3)
				local var_435_6 = var_435_4 <= 0 and var_435_1 or var_435_1 * (var_435_5 / var_435_4)

				if var_435_6 > 0 and var_435_1 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_7 and arg_432_1.time_ < var_435_0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play322281107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 322281107
		arg_436_1.duration_ = 3.33

		local var_436_0 = {
			zh = 2.566,
			ja = 3.333
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play322281108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1020ui_story"].transform
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.var_.moveOldPos1020ui_story = var_439_0.localPosition
			end

			local var_439_2 = 0.001

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2
				local var_439_4 = Vector3.New(0, -0.85, -6.25)

				var_439_0.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1020ui_story, var_439_4, var_439_3)

				local var_439_5 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_5.x, var_439_5.y, var_439_5.z)

				local var_439_6 = var_439_0.localEulerAngles

				var_439_6.z = 0
				var_439_6.x = 0
				var_439_0.localEulerAngles = var_439_6
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 then
				var_439_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_439_7 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_7.x, var_439_7.y, var_439_7.z)

				local var_439_8 = var_439_0.localEulerAngles

				var_439_8.z = 0
				var_439_8.x = 0
				var_439_0.localEulerAngles = var_439_8
			end

			local var_439_9 = arg_436_1.actors_["1020ui_story"]
			local var_439_10 = 0

			if var_439_10 < arg_436_1.time_ and arg_436_1.time_ <= var_439_10 + arg_439_0 and not isNil(var_439_9) and arg_436_1.var_.characterEffect1020ui_story == nil then
				arg_436_1.var_.characterEffect1020ui_story = var_439_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_11 = 0.200000002980232

			if var_439_10 <= arg_436_1.time_ and arg_436_1.time_ < var_439_10 + var_439_11 and not isNil(var_439_9) then
				local var_439_12 = (arg_436_1.time_ - var_439_10) / var_439_11

				if arg_436_1.var_.characterEffect1020ui_story and not isNil(var_439_9) then
					arg_436_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_10 + var_439_11 and arg_436_1.time_ < var_439_10 + var_439_11 + arg_439_0 and not isNil(var_439_9) and arg_436_1.var_.characterEffect1020ui_story then
				arg_436_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_439_13 = 0

			if var_439_13 < arg_436_1.time_ and arg_436_1.time_ <= var_439_13 + arg_439_0 then
				arg_436_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_439_14 = 0

			if var_439_14 < arg_436_1.time_ and arg_436_1.time_ <= var_439_14 + arg_439_0 then
				arg_436_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_439_15 = 0
			local var_439_16 = 0.3

			if var_439_15 < arg_436_1.time_ and arg_436_1.time_ <= var_439_15 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_17 = arg_436_1:FormatText(StoryNameCfg[613].name)

				arg_436_1.leftNameTxt_.text = var_439_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_18 = arg_436_1:GetWordFromCfg(322281107)
				local var_439_19 = arg_436_1:FormatText(var_439_18.content)

				arg_436_1.text_.text = var_439_19

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_20 = 12
				local var_439_21 = utf8.len(var_439_19)
				local var_439_22 = var_439_20 <= 0 and var_439_16 or var_439_16 * (var_439_21 / var_439_20)

				if var_439_22 > 0 and var_439_16 < var_439_22 then
					arg_436_1.talkMaxDuration = var_439_22

					if var_439_22 + var_439_15 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_22 + var_439_15
					end
				end

				arg_436_1.text_.text = var_439_19
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281107", "story_v_out_322281.awb") ~= 0 then
					local var_439_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281107", "story_v_out_322281.awb") / 1000

					if var_439_23 + var_439_15 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_23 + var_439_15
					end

					if var_439_18.prefab_name ~= "" and arg_436_1.actors_[var_439_18.prefab_name] ~= nil then
						local var_439_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_18.prefab_name].transform, "story_v_out_322281", "322281107", "story_v_out_322281.awb")

						arg_436_1:RecordAudio("322281107", var_439_24)
						arg_436_1:RecordAudio("322281107", var_439_24)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_322281", "322281107", "story_v_out_322281.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_322281", "322281107", "story_v_out_322281.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_25 = math.max(var_439_16, arg_436_1.talkMaxDuration)

			if var_439_15 <= arg_436_1.time_ and arg_436_1.time_ < var_439_15 + var_439_25 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_15) / var_439_25

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_15 + var_439_25 and arg_436_1.time_ < var_439_15 + var_439_25 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play322281108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 322281108
		arg_440_1.duration_ = 3.83

		local var_440_0 = {
			zh = 3.133,
			ja = 3.833
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play322281109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1020ui_story"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1020ui_story = var_443_0.localPosition
			end

			local var_443_2 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2
				local var_443_4 = Vector3.New(-0.7, -0.85, -6.25)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1020ui_story, var_443_4, var_443_3)

				local var_443_5 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_5.x, var_443_5.y, var_443_5.z)

				local var_443_6 = var_443_0.localEulerAngles

				var_443_6.z = 0
				var_443_6.x = 0
				var_443_0.localEulerAngles = var_443_6
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(-0.7, -0.85, -6.25)

				local var_443_7 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_7.x, var_443_7.y, var_443_7.z)

				local var_443_8 = var_443_0.localEulerAngles

				var_443_8.z = 0
				var_443_8.x = 0
				var_443_0.localEulerAngles = var_443_8
			end

			local var_443_9 = arg_440_1.actors_["1020ui_story"]
			local var_443_10 = 0

			if var_443_10 < arg_440_1.time_ and arg_440_1.time_ <= var_443_10 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1020ui_story == nil then
				arg_440_1.var_.characterEffect1020ui_story = var_443_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_11 = 0.200000002980232

			if var_443_10 <= arg_440_1.time_ and arg_440_1.time_ < var_443_10 + var_443_11 and not isNil(var_443_9) then
				local var_443_12 = (arg_440_1.time_ - var_443_10) / var_443_11

				if arg_440_1.var_.characterEffect1020ui_story and not isNil(var_443_9) then
					local var_443_13 = Mathf.Lerp(0, 0.5, var_443_12)

					arg_440_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1020ui_story.fillRatio = var_443_13
				end
			end

			if arg_440_1.time_ >= var_443_10 + var_443_11 and arg_440_1.time_ < var_443_10 + var_443_11 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1020ui_story then
				local var_443_14 = 0.5

				arg_440_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1020ui_story.fillRatio = var_443_14
			end

			local var_443_15 = arg_440_1.actors_["1044ui_story"].transform
			local var_443_16 = 0

			if var_443_16 < arg_440_1.time_ and arg_440_1.time_ <= var_443_16 + arg_443_0 then
				arg_440_1.var_.moveOldPos1044ui_story = var_443_15.localPosition

				local var_443_17 = "1044ui_story"

				arg_440_1:ShowWeapon(arg_440_1.var_[var_443_17 .. "Animator"].transform, false)
			end

			local var_443_18 = 0.001

			if var_443_16 <= arg_440_1.time_ and arg_440_1.time_ < var_443_16 + var_443_18 then
				local var_443_19 = (arg_440_1.time_ - var_443_16) / var_443_18
				local var_443_20 = Vector3.New(0.7, -1, -5.93)

				var_443_15.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1044ui_story, var_443_20, var_443_19)

				local var_443_21 = manager.ui.mainCamera.transform.position - var_443_15.position

				var_443_15.forward = Vector3.New(var_443_21.x, var_443_21.y, var_443_21.z)

				local var_443_22 = var_443_15.localEulerAngles

				var_443_22.z = 0
				var_443_22.x = 0
				var_443_15.localEulerAngles = var_443_22
			end

			if arg_440_1.time_ >= var_443_16 + var_443_18 and arg_440_1.time_ < var_443_16 + var_443_18 + arg_443_0 then
				var_443_15.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_443_23 = manager.ui.mainCamera.transform.position - var_443_15.position

				var_443_15.forward = Vector3.New(var_443_23.x, var_443_23.y, var_443_23.z)

				local var_443_24 = var_443_15.localEulerAngles

				var_443_24.z = 0
				var_443_24.x = 0
				var_443_15.localEulerAngles = var_443_24
			end

			local var_443_25 = arg_440_1.actors_["1044ui_story"]
			local var_443_26 = 0

			if var_443_26 < arg_440_1.time_ and arg_440_1.time_ <= var_443_26 + arg_443_0 and not isNil(var_443_25) and arg_440_1.var_.characterEffect1044ui_story == nil then
				arg_440_1.var_.characterEffect1044ui_story = var_443_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_27 = 0.200000002980232

			if var_443_26 <= arg_440_1.time_ and arg_440_1.time_ < var_443_26 + var_443_27 and not isNil(var_443_25) then
				local var_443_28 = (arg_440_1.time_ - var_443_26) / var_443_27

				if arg_440_1.var_.characterEffect1044ui_story and not isNil(var_443_25) then
					arg_440_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_26 + var_443_27 and arg_440_1.time_ < var_443_26 + var_443_27 + arg_443_0 and not isNil(var_443_25) and arg_440_1.var_.characterEffect1044ui_story then
				arg_440_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_443_29 = 0

			if var_443_29 < arg_440_1.time_ and arg_440_1.time_ <= var_443_29 + arg_443_0 then
				arg_440_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_1")
			end

			local var_443_30 = 0

			if var_443_30 < arg_440_1.time_ and arg_440_1.time_ <= var_443_30 + arg_443_0 then
				arg_440_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_443_31 = 0
			local var_443_32 = 0.325

			if var_443_31 < arg_440_1.time_ and arg_440_1.time_ <= var_443_31 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_33 = arg_440_1:FormatText(StoryNameCfg[1367].name)

				arg_440_1.leftNameTxt_.text = var_443_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_34 = arg_440_1:GetWordFromCfg(322281108)
				local var_443_35 = arg_440_1:FormatText(var_443_34.content)

				arg_440_1.text_.text = var_443_35

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_36 = 13
				local var_443_37 = utf8.len(var_443_35)
				local var_443_38 = var_443_36 <= 0 and var_443_32 or var_443_32 * (var_443_37 / var_443_36)

				if var_443_38 > 0 and var_443_32 < var_443_38 then
					arg_440_1.talkMaxDuration = var_443_38

					if var_443_38 + var_443_31 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_38 + var_443_31
					end
				end

				arg_440_1.text_.text = var_443_35
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281108", "story_v_out_322281.awb") ~= 0 then
					local var_443_39 = manager.audio:GetVoiceLength("story_v_out_322281", "322281108", "story_v_out_322281.awb") / 1000

					if var_443_39 + var_443_31 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_39 + var_443_31
					end

					if var_443_34.prefab_name ~= "" and arg_440_1.actors_[var_443_34.prefab_name] ~= nil then
						local var_443_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_34.prefab_name].transform, "story_v_out_322281", "322281108", "story_v_out_322281.awb")

						arg_440_1:RecordAudio("322281108", var_443_40)
						arg_440_1:RecordAudio("322281108", var_443_40)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_322281", "322281108", "story_v_out_322281.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_322281", "322281108", "story_v_out_322281.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_41 = math.max(var_443_32, arg_440_1.talkMaxDuration)

			if var_443_31 <= arg_440_1.time_ and arg_440_1.time_ < var_443_31 + var_443_41 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_31) / var_443_41

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_31 + var_443_41 and arg_440_1.time_ < var_443_31 + var_443_41 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play322281109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 322281109
		arg_444_1.duration_ = 1.6

		local var_444_0 = {
			zh = 0.999999999999,
			ja = 1.6
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play322281110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1020ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1020ui_story == nil then
				arg_444_1.var_.characterEffect1020ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect1020ui_story and not isNil(var_447_0) then
					arg_444_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1020ui_story then
				arg_444_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_447_4 = arg_444_1.actors_["1044ui_story"]
			local var_447_5 = 0

			if var_447_5 < arg_444_1.time_ and arg_444_1.time_ <= var_447_5 + arg_447_0 and not isNil(var_447_4) and arg_444_1.var_.characterEffect1044ui_story == nil then
				arg_444_1.var_.characterEffect1044ui_story = var_447_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_6 = 0.200000002980232

			if var_447_5 <= arg_444_1.time_ and arg_444_1.time_ < var_447_5 + var_447_6 and not isNil(var_447_4) then
				local var_447_7 = (arg_444_1.time_ - var_447_5) / var_447_6

				if arg_444_1.var_.characterEffect1044ui_story and not isNil(var_447_4) then
					local var_447_8 = Mathf.Lerp(0, 0.5, var_447_7)

					arg_444_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1044ui_story.fillRatio = var_447_8
				end
			end

			if arg_444_1.time_ >= var_447_5 + var_447_6 and arg_444_1.time_ < var_447_5 + var_447_6 + arg_447_0 and not isNil(var_447_4) and arg_444_1.var_.characterEffect1044ui_story then
				local var_447_9 = 0.5

				arg_444_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1044ui_story.fillRatio = var_447_9
			end

			local var_447_10 = 0
			local var_447_11 = 0.075

			if var_447_10 < arg_444_1.time_ and arg_444_1.time_ <= var_447_10 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_12 = arg_444_1:FormatText(StoryNameCfg[613].name)

				arg_444_1.leftNameTxt_.text = var_447_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_13 = arg_444_1:GetWordFromCfg(322281109)
				local var_447_14 = arg_444_1:FormatText(var_447_13.content)

				arg_444_1.text_.text = var_447_14

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_15 = 3
				local var_447_16 = utf8.len(var_447_14)
				local var_447_17 = var_447_15 <= 0 and var_447_11 or var_447_11 * (var_447_16 / var_447_15)

				if var_447_17 > 0 and var_447_11 < var_447_17 then
					arg_444_1.talkMaxDuration = var_447_17

					if var_447_17 + var_447_10 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_17 + var_447_10
					end
				end

				arg_444_1.text_.text = var_447_14
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281109", "story_v_out_322281.awb") ~= 0 then
					local var_447_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281109", "story_v_out_322281.awb") / 1000

					if var_447_18 + var_447_10 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_18 + var_447_10
					end

					if var_447_13.prefab_name ~= "" and arg_444_1.actors_[var_447_13.prefab_name] ~= nil then
						local var_447_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_13.prefab_name].transform, "story_v_out_322281", "322281109", "story_v_out_322281.awb")

						arg_444_1:RecordAudio("322281109", var_447_19)
						arg_444_1:RecordAudio("322281109", var_447_19)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_322281", "322281109", "story_v_out_322281.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_322281", "322281109", "story_v_out_322281.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_20 = math.max(var_447_11, arg_444_1.talkMaxDuration)

			if var_447_10 <= arg_444_1.time_ and arg_444_1.time_ < var_447_10 + var_447_20 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_10) / var_447_20

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_10 + var_447_20 and arg_444_1.time_ < var_447_10 + var_447_20 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play322281110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 322281110
		arg_448_1.duration_ = 2.87

		local var_448_0 = {
			zh = 2.866,
			ja = 1.999999999999
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play322281111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1020ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1020ui_story == nil then
				arg_448_1.var_.characterEffect1020ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect1020ui_story and not isNil(var_451_0) then
					local var_451_4 = Mathf.Lerp(0, 0.5, var_451_3)

					arg_448_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1020ui_story.fillRatio = var_451_4
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1020ui_story then
				local var_451_5 = 0.5

				arg_448_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1020ui_story.fillRatio = var_451_5
			end

			local var_451_6 = arg_448_1.actors_["1044ui_story"]
			local var_451_7 = 0

			if var_451_7 < arg_448_1.time_ and arg_448_1.time_ <= var_451_7 + arg_451_0 and not isNil(var_451_6) and arg_448_1.var_.characterEffect1044ui_story == nil then
				arg_448_1.var_.characterEffect1044ui_story = var_451_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_8 = 0.200000002980232

			if var_451_7 <= arg_448_1.time_ and arg_448_1.time_ < var_451_7 + var_451_8 and not isNil(var_451_6) then
				local var_451_9 = (arg_448_1.time_ - var_451_7) / var_451_8

				if arg_448_1.var_.characterEffect1044ui_story and not isNil(var_451_6) then
					arg_448_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= var_451_7 + var_451_8 and arg_448_1.time_ < var_451_7 + var_451_8 + arg_451_0 and not isNil(var_451_6) and arg_448_1.var_.characterEffect1044ui_story then
				arg_448_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_451_10 = 0

			if var_451_10 < arg_448_1.time_ and arg_448_1.time_ <= var_451_10 + arg_451_0 then
				arg_448_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_2")
			end

			local var_451_11 = 0
			local var_451_12 = 0.15

			if var_451_11 < arg_448_1.time_ and arg_448_1.time_ <= var_451_11 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_13 = arg_448_1:FormatText(StoryNameCfg[1367].name)

				arg_448_1.leftNameTxt_.text = var_451_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_14 = arg_448_1:GetWordFromCfg(322281110)
				local var_451_15 = arg_448_1:FormatText(var_451_14.content)

				arg_448_1.text_.text = var_451_15

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_16 = 6
				local var_451_17 = utf8.len(var_451_15)
				local var_451_18 = var_451_16 <= 0 and var_451_12 or var_451_12 * (var_451_17 / var_451_16)

				if var_451_18 > 0 and var_451_12 < var_451_18 then
					arg_448_1.talkMaxDuration = var_451_18

					if var_451_18 + var_451_11 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_18 + var_451_11
					end
				end

				arg_448_1.text_.text = var_451_15
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281110", "story_v_out_322281.awb") ~= 0 then
					local var_451_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281110", "story_v_out_322281.awb") / 1000

					if var_451_19 + var_451_11 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_19 + var_451_11
					end

					if var_451_14.prefab_name ~= "" and arg_448_1.actors_[var_451_14.prefab_name] ~= nil then
						local var_451_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_14.prefab_name].transform, "story_v_out_322281", "322281110", "story_v_out_322281.awb")

						arg_448_1:RecordAudio("322281110", var_451_20)
						arg_448_1:RecordAudio("322281110", var_451_20)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_322281", "322281110", "story_v_out_322281.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_322281", "322281110", "story_v_out_322281.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_21 = math.max(var_451_12, arg_448_1.talkMaxDuration)

			if var_451_11 <= arg_448_1.time_ and arg_448_1.time_ < var_451_11 + var_451_21 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_11) / var_451_21

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_11 + var_451_21 and arg_448_1.time_ < var_451_11 + var_451_21 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play322281111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 322281111
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play322281112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1020ui_story"].transform
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.var_.moveOldPos1020ui_story = var_455_0.localPosition
			end

			local var_455_2 = 0.001

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2
				local var_455_4 = Vector3.New(0, 100, 0)

				var_455_0.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1020ui_story, var_455_4, var_455_3)

				local var_455_5 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_5.x, var_455_5.y, var_455_5.z)

				local var_455_6 = var_455_0.localEulerAngles

				var_455_6.z = 0
				var_455_6.x = 0
				var_455_0.localEulerAngles = var_455_6
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 then
				var_455_0.localPosition = Vector3.New(0, 100, 0)

				local var_455_7 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_7.x, var_455_7.y, var_455_7.z)

				local var_455_8 = var_455_0.localEulerAngles

				var_455_8.z = 0
				var_455_8.x = 0
				var_455_0.localEulerAngles = var_455_8
			end

			local var_455_9 = arg_452_1.actors_["1044ui_story"].transform
			local var_455_10 = 0

			if var_455_10 < arg_452_1.time_ and arg_452_1.time_ <= var_455_10 + arg_455_0 then
				arg_452_1.var_.moveOldPos1044ui_story = var_455_9.localPosition

				local var_455_11 = "1044ui_story"

				arg_452_1:ShowWeapon(arg_452_1.var_[var_455_11 .. "Animator"].transform, false)
			end

			local var_455_12 = 0.001

			if var_455_10 <= arg_452_1.time_ and arg_452_1.time_ < var_455_10 + var_455_12 then
				local var_455_13 = (arg_452_1.time_ - var_455_10) / var_455_12
				local var_455_14 = Vector3.New(0, 100, 0)

				var_455_9.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1044ui_story, var_455_14, var_455_13)

				local var_455_15 = manager.ui.mainCamera.transform.position - var_455_9.position

				var_455_9.forward = Vector3.New(var_455_15.x, var_455_15.y, var_455_15.z)

				local var_455_16 = var_455_9.localEulerAngles

				var_455_16.z = 0
				var_455_16.x = 0
				var_455_9.localEulerAngles = var_455_16
			end

			if arg_452_1.time_ >= var_455_10 + var_455_12 and arg_452_1.time_ < var_455_10 + var_455_12 + arg_455_0 then
				var_455_9.localPosition = Vector3.New(0, 100, 0)

				local var_455_17 = manager.ui.mainCamera.transform.position - var_455_9.position

				var_455_9.forward = Vector3.New(var_455_17.x, var_455_17.y, var_455_17.z)

				local var_455_18 = var_455_9.localEulerAngles

				var_455_18.z = 0
				var_455_18.x = 0
				var_455_9.localEulerAngles = var_455_18
			end

			local var_455_19 = 0
			local var_455_20 = 1.725

			if var_455_19 < arg_452_1.time_ and arg_452_1.time_ <= var_455_19 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_21 = arg_452_1:GetWordFromCfg(322281111)
				local var_455_22 = arg_452_1:FormatText(var_455_21.content)

				arg_452_1.text_.text = var_455_22

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_23 = 69
				local var_455_24 = utf8.len(var_455_22)
				local var_455_25 = var_455_23 <= 0 and var_455_20 or var_455_20 * (var_455_24 / var_455_23)

				if var_455_25 > 0 and var_455_20 < var_455_25 then
					arg_452_1.talkMaxDuration = var_455_25

					if var_455_25 + var_455_19 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_25 + var_455_19
					end
				end

				arg_452_1.text_.text = var_455_22
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_26 = math.max(var_455_20, arg_452_1.talkMaxDuration)

			if var_455_19 <= arg_452_1.time_ and arg_452_1.time_ < var_455_19 + var_455_26 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_19) / var_455_26

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_19 + var_455_26 and arg_452_1.time_ < var_455_19 + var_455_26 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play322281112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 322281112
		arg_456_1.duration_ = 2.33

		local var_456_0 = {
			zh = 1.999999999999,
			ja = 2.333
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play322281113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1044ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos1044ui_story = var_459_0.localPosition

				local var_459_2 = "1044ui_story"

				arg_456_1:ShowWeapon(arg_456_1.var_[var_459_2 .. "Animator"].transform, false)
			end

			local var_459_3 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_3 then
				local var_459_4 = (arg_456_1.time_ - var_459_1) / var_459_3
				local var_459_5 = Vector3.New(0, -1, -5.93)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1044ui_story, var_459_5, var_459_4)

				local var_459_6 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_6.x, var_459_6.y, var_459_6.z)

				local var_459_7 = var_459_0.localEulerAngles

				var_459_7.z = 0
				var_459_7.x = 0
				var_459_0.localEulerAngles = var_459_7
			end

			if arg_456_1.time_ >= var_459_1 + var_459_3 and arg_456_1.time_ < var_459_1 + var_459_3 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_459_8 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_8.x, var_459_8.y, var_459_8.z)

				local var_459_9 = var_459_0.localEulerAngles

				var_459_9.z = 0
				var_459_9.x = 0
				var_459_0.localEulerAngles = var_459_9
			end

			local var_459_10 = arg_456_1.actors_["1044ui_story"]
			local var_459_11 = 0

			if var_459_11 < arg_456_1.time_ and arg_456_1.time_ <= var_459_11 + arg_459_0 and not isNil(var_459_10) and arg_456_1.var_.characterEffect1044ui_story == nil then
				arg_456_1.var_.characterEffect1044ui_story = var_459_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_12 = 0.200000002980232

			if var_459_11 <= arg_456_1.time_ and arg_456_1.time_ < var_459_11 + var_459_12 and not isNil(var_459_10) then
				local var_459_13 = (arg_456_1.time_ - var_459_11) / var_459_12

				if arg_456_1.var_.characterEffect1044ui_story and not isNil(var_459_10) then
					arg_456_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_11 + var_459_12 and arg_456_1.time_ < var_459_11 + var_459_12 + arg_459_0 and not isNil(var_459_10) and arg_456_1.var_.characterEffect1044ui_story then
				arg_456_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_459_14 = 0

			if var_459_14 < arg_456_1.time_ and arg_456_1.time_ <= var_459_14 + arg_459_0 then
				arg_456_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_459_15 = 0
			local var_459_16 = 0.125

			if var_459_15 < arg_456_1.time_ and arg_456_1.time_ <= var_459_15 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_17 = arg_456_1:FormatText(StoryNameCfg[1367].name)

				arg_456_1.leftNameTxt_.text = var_459_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_18 = arg_456_1:GetWordFromCfg(322281112)
				local var_459_19 = arg_456_1:FormatText(var_459_18.content)

				arg_456_1.text_.text = var_459_19

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_20 = 5
				local var_459_21 = utf8.len(var_459_19)
				local var_459_22 = var_459_20 <= 0 and var_459_16 or var_459_16 * (var_459_21 / var_459_20)

				if var_459_22 > 0 and var_459_16 < var_459_22 then
					arg_456_1.talkMaxDuration = var_459_22

					if var_459_22 + var_459_15 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_22 + var_459_15
					end
				end

				arg_456_1.text_.text = var_459_19
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281112", "story_v_out_322281.awb") ~= 0 then
					local var_459_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281112", "story_v_out_322281.awb") / 1000

					if var_459_23 + var_459_15 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_23 + var_459_15
					end

					if var_459_18.prefab_name ~= "" and arg_456_1.actors_[var_459_18.prefab_name] ~= nil then
						local var_459_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_18.prefab_name].transform, "story_v_out_322281", "322281112", "story_v_out_322281.awb")

						arg_456_1:RecordAudio("322281112", var_459_24)
						arg_456_1:RecordAudio("322281112", var_459_24)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_322281", "322281112", "story_v_out_322281.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_322281", "322281112", "story_v_out_322281.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_25 = math.max(var_459_16, arg_456_1.talkMaxDuration)

			if var_459_15 <= arg_456_1.time_ and arg_456_1.time_ < var_459_15 + var_459_25 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_15) / var_459_25

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_15 + var_459_25 and arg_456_1.time_ < var_459_15 + var_459_25 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play322281113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 322281113
		arg_460_1.duration_ = 3.83

		local var_460_0 = {
			zh = 2.5,
			ja = 3.833
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play322281114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1020ui_story"].transform
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.var_.moveOldPos1020ui_story = var_463_0.localPosition
			end

			local var_463_2 = 0.001

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2
				local var_463_4 = Vector3.New(0.7, -0.85, -6.25)

				var_463_0.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1020ui_story, var_463_4, var_463_3)

				local var_463_5 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_5.x, var_463_5.y, var_463_5.z)

				local var_463_6 = var_463_0.localEulerAngles

				var_463_6.z = 0
				var_463_6.x = 0
				var_463_0.localEulerAngles = var_463_6
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 then
				var_463_0.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_463_7 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_7.x, var_463_7.y, var_463_7.z)

				local var_463_8 = var_463_0.localEulerAngles

				var_463_8.z = 0
				var_463_8.x = 0
				var_463_0.localEulerAngles = var_463_8
			end

			local var_463_9 = arg_460_1.actors_["1020ui_story"]
			local var_463_10 = 0

			if var_463_10 < arg_460_1.time_ and arg_460_1.time_ <= var_463_10 + arg_463_0 and not isNil(var_463_9) and arg_460_1.var_.characterEffect1020ui_story == nil then
				arg_460_1.var_.characterEffect1020ui_story = var_463_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_11 = 0.200000002980232

			if var_463_10 <= arg_460_1.time_ and arg_460_1.time_ < var_463_10 + var_463_11 and not isNil(var_463_9) then
				local var_463_12 = (arg_460_1.time_ - var_463_10) / var_463_11

				if arg_460_1.var_.characterEffect1020ui_story and not isNil(var_463_9) then
					arg_460_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= var_463_10 + var_463_11 and arg_460_1.time_ < var_463_10 + var_463_11 + arg_463_0 and not isNil(var_463_9) and arg_460_1.var_.characterEffect1020ui_story then
				arg_460_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_463_13 = 0

			if var_463_13 < arg_460_1.time_ and arg_460_1.time_ <= var_463_13 + arg_463_0 then
				arg_460_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_463_14 = arg_460_1.actors_["1044ui_story"]
			local var_463_15 = 0

			if var_463_15 < arg_460_1.time_ and arg_460_1.time_ <= var_463_15 + arg_463_0 and not isNil(var_463_14) and arg_460_1.var_.characterEffect1044ui_story == nil then
				arg_460_1.var_.characterEffect1044ui_story = var_463_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_16 = 0.200000002980232

			if var_463_15 <= arg_460_1.time_ and arg_460_1.time_ < var_463_15 + var_463_16 and not isNil(var_463_14) then
				local var_463_17 = (arg_460_1.time_ - var_463_15) / var_463_16

				if arg_460_1.var_.characterEffect1044ui_story and not isNil(var_463_14) then
					local var_463_18 = Mathf.Lerp(0, 0.5, var_463_17)

					arg_460_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1044ui_story.fillRatio = var_463_18
				end
			end

			if arg_460_1.time_ >= var_463_15 + var_463_16 and arg_460_1.time_ < var_463_15 + var_463_16 + arg_463_0 and not isNil(var_463_14) and arg_460_1.var_.characterEffect1044ui_story then
				local var_463_19 = 0.5

				arg_460_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1044ui_story.fillRatio = var_463_19
			end

			local var_463_20 = arg_460_1.actors_["1044ui_story"].transform
			local var_463_21 = 0

			if var_463_21 < arg_460_1.time_ and arg_460_1.time_ <= var_463_21 + arg_463_0 then
				arg_460_1.var_.moveOldPos1044ui_story = var_463_20.localPosition

				local var_463_22 = "1044ui_story"

				arg_460_1:ShowWeapon(arg_460_1.var_[var_463_22 .. "Animator"].transform, false)
			end

			local var_463_23 = 0.001

			if var_463_21 <= arg_460_1.time_ and arg_460_1.time_ < var_463_21 + var_463_23 then
				local var_463_24 = (arg_460_1.time_ - var_463_21) / var_463_23
				local var_463_25 = Vector3.New(-0.7, -1, -5.93)

				var_463_20.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1044ui_story, var_463_25, var_463_24)

				local var_463_26 = manager.ui.mainCamera.transform.position - var_463_20.position

				var_463_20.forward = Vector3.New(var_463_26.x, var_463_26.y, var_463_26.z)

				local var_463_27 = var_463_20.localEulerAngles

				var_463_27.z = 0
				var_463_27.x = 0
				var_463_20.localEulerAngles = var_463_27
			end

			if arg_460_1.time_ >= var_463_21 + var_463_23 and arg_460_1.time_ < var_463_21 + var_463_23 + arg_463_0 then
				var_463_20.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_463_28 = manager.ui.mainCamera.transform.position - var_463_20.position

				var_463_20.forward = Vector3.New(var_463_28.x, var_463_28.y, var_463_28.z)

				local var_463_29 = var_463_20.localEulerAngles

				var_463_29.z = 0
				var_463_29.x = 0
				var_463_20.localEulerAngles = var_463_29
			end

			local var_463_30 = 0
			local var_463_31 = 0.275

			if var_463_30 < arg_460_1.time_ and arg_460_1.time_ <= var_463_30 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_32 = arg_460_1:FormatText(StoryNameCfg[613].name)

				arg_460_1.leftNameTxt_.text = var_463_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_33 = arg_460_1:GetWordFromCfg(322281113)
				local var_463_34 = arg_460_1:FormatText(var_463_33.content)

				arg_460_1.text_.text = var_463_34

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_35 = 11
				local var_463_36 = utf8.len(var_463_34)
				local var_463_37 = var_463_35 <= 0 and var_463_31 or var_463_31 * (var_463_36 / var_463_35)

				if var_463_37 > 0 and var_463_31 < var_463_37 then
					arg_460_1.talkMaxDuration = var_463_37

					if var_463_37 + var_463_30 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_37 + var_463_30
					end
				end

				arg_460_1.text_.text = var_463_34
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281113", "story_v_out_322281.awb") ~= 0 then
					local var_463_38 = manager.audio:GetVoiceLength("story_v_out_322281", "322281113", "story_v_out_322281.awb") / 1000

					if var_463_38 + var_463_30 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_38 + var_463_30
					end

					if var_463_33.prefab_name ~= "" and arg_460_1.actors_[var_463_33.prefab_name] ~= nil then
						local var_463_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_33.prefab_name].transform, "story_v_out_322281", "322281113", "story_v_out_322281.awb")

						arg_460_1:RecordAudio("322281113", var_463_39)
						arg_460_1:RecordAudio("322281113", var_463_39)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_322281", "322281113", "story_v_out_322281.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_322281", "322281113", "story_v_out_322281.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_40 = math.max(var_463_31, arg_460_1.talkMaxDuration)

			if var_463_30 <= arg_460_1.time_ and arg_460_1.time_ < var_463_30 + var_463_40 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_30) / var_463_40

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_30 + var_463_40 and arg_460_1.time_ < var_463_30 + var_463_40 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play322281114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 322281114
		arg_464_1.duration_ = 8.3

		local var_464_0 = {
			zh = 6.3,
			ja = 8.3
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play322281115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1020ui_story"].transform
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.var_.moveOldPos1020ui_story = var_467_0.localPosition
			end

			local var_467_2 = 0.001

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2
				local var_467_4 = Vector3.New(0.7, -0.85, -6.25)

				var_467_0.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1020ui_story, var_467_4, var_467_3)

				local var_467_5 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_5.x, var_467_5.y, var_467_5.z)

				local var_467_6 = var_467_0.localEulerAngles

				var_467_6.z = 0
				var_467_6.x = 0
				var_467_0.localEulerAngles = var_467_6
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 then
				var_467_0.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_467_7 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_7.x, var_467_7.y, var_467_7.z)

				local var_467_8 = var_467_0.localEulerAngles

				var_467_8.z = 0
				var_467_8.x = 0
				var_467_0.localEulerAngles = var_467_8
			end

			local var_467_9 = arg_464_1.actors_["1044ui_story"].transform
			local var_467_10 = 0

			if var_467_10 < arg_464_1.time_ and arg_464_1.time_ <= var_467_10 + arg_467_0 then
				arg_464_1.var_.moveOldPos1044ui_story = var_467_9.localPosition

				local var_467_11 = "1044ui_story"

				arg_464_1:ShowWeapon(arg_464_1.var_[var_467_11 .. "Animator"].transform, false)
			end

			local var_467_12 = 0.001

			if var_467_10 <= arg_464_1.time_ and arg_464_1.time_ < var_467_10 + var_467_12 then
				local var_467_13 = (arg_464_1.time_ - var_467_10) / var_467_12
				local var_467_14 = Vector3.New(-0.7, -1, -5.93)

				var_467_9.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1044ui_story, var_467_14, var_467_13)

				local var_467_15 = manager.ui.mainCamera.transform.position - var_467_9.position

				var_467_9.forward = Vector3.New(var_467_15.x, var_467_15.y, var_467_15.z)

				local var_467_16 = var_467_9.localEulerAngles

				var_467_16.z = 0
				var_467_16.x = 0
				var_467_9.localEulerAngles = var_467_16
			end

			if arg_464_1.time_ >= var_467_10 + var_467_12 and arg_464_1.time_ < var_467_10 + var_467_12 + arg_467_0 then
				var_467_9.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_467_17 = manager.ui.mainCamera.transform.position - var_467_9.position

				var_467_9.forward = Vector3.New(var_467_17.x, var_467_17.y, var_467_17.z)

				local var_467_18 = var_467_9.localEulerAngles

				var_467_18.z = 0
				var_467_18.x = 0
				var_467_9.localEulerAngles = var_467_18
			end

			local var_467_19 = arg_464_1.actors_["1044ui_story"]
			local var_467_20 = 0

			if var_467_20 < arg_464_1.time_ and arg_464_1.time_ <= var_467_20 + arg_467_0 and not isNil(var_467_19) and arg_464_1.var_.characterEffect1044ui_story == nil then
				arg_464_1.var_.characterEffect1044ui_story = var_467_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_21 = 0.200000002980232

			if var_467_20 <= arg_464_1.time_ and arg_464_1.time_ < var_467_20 + var_467_21 and not isNil(var_467_19) then
				local var_467_22 = (arg_464_1.time_ - var_467_20) / var_467_21

				if arg_464_1.var_.characterEffect1044ui_story and not isNil(var_467_19) then
					arg_464_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= var_467_20 + var_467_21 and arg_464_1.time_ < var_467_20 + var_467_21 + arg_467_0 and not isNil(var_467_19) and arg_464_1.var_.characterEffect1044ui_story then
				arg_464_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_467_23 = 0

			if var_467_23 < arg_464_1.time_ and arg_464_1.time_ <= var_467_23 + arg_467_0 then
				arg_464_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_467_24 = 0

			if var_467_24 < arg_464_1.time_ and arg_464_1.time_ <= var_467_24 + arg_467_0 then
				arg_464_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_467_25 = 0
			local var_467_26 = 0.625

			if var_467_25 < arg_464_1.time_ and arg_464_1.time_ <= var_467_25 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_27 = arg_464_1:FormatText(StoryNameCfg[1367].name)

				arg_464_1.leftNameTxt_.text = var_467_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_28 = arg_464_1:GetWordFromCfg(322281114)
				local var_467_29 = arg_464_1:FormatText(var_467_28.content)

				arg_464_1.text_.text = var_467_29

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_30 = 25
				local var_467_31 = utf8.len(var_467_29)
				local var_467_32 = var_467_30 <= 0 and var_467_26 or var_467_26 * (var_467_31 / var_467_30)

				if var_467_32 > 0 and var_467_26 < var_467_32 then
					arg_464_1.talkMaxDuration = var_467_32

					if var_467_32 + var_467_25 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_32 + var_467_25
					end
				end

				arg_464_1.text_.text = var_467_29
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281114", "story_v_out_322281.awb") ~= 0 then
					local var_467_33 = manager.audio:GetVoiceLength("story_v_out_322281", "322281114", "story_v_out_322281.awb") / 1000

					if var_467_33 + var_467_25 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_33 + var_467_25
					end

					if var_467_28.prefab_name ~= "" and arg_464_1.actors_[var_467_28.prefab_name] ~= nil then
						local var_467_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_28.prefab_name].transform, "story_v_out_322281", "322281114", "story_v_out_322281.awb")

						arg_464_1:RecordAudio("322281114", var_467_34)
						arg_464_1:RecordAudio("322281114", var_467_34)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_322281", "322281114", "story_v_out_322281.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_322281", "322281114", "story_v_out_322281.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_35 = math.max(var_467_26, arg_464_1.talkMaxDuration)

			if var_467_25 <= arg_464_1.time_ and arg_464_1.time_ < var_467_25 + var_467_35 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_25) / var_467_35

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_25 + var_467_35 and arg_464_1.time_ < var_467_25 + var_467_35 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play322281115 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 322281115
		arg_468_1.duration_ = 2.2

		local var_468_0 = {
			zh = 2,
			ja = 2.2
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play322281116(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1020ui_story"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1020ui_story == nil then
				arg_468_1.var_.characterEffect1020ui_story = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect1020ui_story and not isNil(var_471_0) then
					arg_468_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1020ui_story then
				arg_468_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_471_4 = arg_468_1.actors_["1044ui_story"]
			local var_471_5 = 0

			if var_471_5 < arg_468_1.time_ and arg_468_1.time_ <= var_471_5 + arg_471_0 and not isNil(var_471_4) and arg_468_1.var_.characterEffect1044ui_story == nil then
				arg_468_1.var_.characterEffect1044ui_story = var_471_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_6 = 0.200000002980232

			if var_471_5 <= arg_468_1.time_ and arg_468_1.time_ < var_471_5 + var_471_6 and not isNil(var_471_4) then
				local var_471_7 = (arg_468_1.time_ - var_471_5) / var_471_6

				if arg_468_1.var_.characterEffect1044ui_story and not isNil(var_471_4) then
					local var_471_8 = Mathf.Lerp(0, 0.5, var_471_7)

					arg_468_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1044ui_story.fillRatio = var_471_8
				end
			end

			if arg_468_1.time_ >= var_471_5 + var_471_6 and arg_468_1.time_ < var_471_5 + var_471_6 + arg_471_0 and not isNil(var_471_4) and arg_468_1.var_.characterEffect1044ui_story then
				local var_471_9 = 0.5

				arg_468_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1044ui_story.fillRatio = var_471_9
			end

			local var_471_10 = 0
			local var_471_11 = 0.325

			if var_471_10 < arg_468_1.time_ and arg_468_1.time_ <= var_471_10 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_12 = arg_468_1:FormatText(StoryNameCfg[613].name)

				arg_468_1.leftNameTxt_.text = var_471_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_13 = arg_468_1:GetWordFromCfg(322281115)
				local var_471_14 = arg_468_1:FormatText(var_471_13.content)

				arg_468_1.text_.text = var_471_14

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_15 = 13
				local var_471_16 = utf8.len(var_471_14)
				local var_471_17 = var_471_15 <= 0 and var_471_11 or var_471_11 * (var_471_16 / var_471_15)

				if var_471_17 > 0 and var_471_11 < var_471_17 then
					arg_468_1.talkMaxDuration = var_471_17

					if var_471_17 + var_471_10 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_17 + var_471_10
					end
				end

				arg_468_1.text_.text = var_471_14
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281115", "story_v_out_322281.awb") ~= 0 then
					local var_471_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281115", "story_v_out_322281.awb") / 1000

					if var_471_18 + var_471_10 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_18 + var_471_10
					end

					if var_471_13.prefab_name ~= "" and arg_468_1.actors_[var_471_13.prefab_name] ~= nil then
						local var_471_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_13.prefab_name].transform, "story_v_out_322281", "322281115", "story_v_out_322281.awb")

						arg_468_1:RecordAudio("322281115", var_471_19)
						arg_468_1:RecordAudio("322281115", var_471_19)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_322281", "322281115", "story_v_out_322281.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_322281", "322281115", "story_v_out_322281.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_20 = math.max(var_471_11, arg_468_1.talkMaxDuration)

			if var_471_10 <= arg_468_1.time_ and arg_468_1.time_ < var_471_10 + var_471_20 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_10) / var_471_20

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_10 + var_471_20 and arg_468_1.time_ < var_471_10 + var_471_20 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play322281116 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 322281116
		arg_472_1.duration_ = 7.2

		local var_472_0 = {
			zh = 7.2,
			ja = 7
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play322281117(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1020ui_story"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1020ui_story == nil then
				arg_472_1.var_.characterEffect1020ui_story = var_475_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.characterEffect1020ui_story and not isNil(var_475_0) then
					local var_475_4 = Mathf.Lerp(0, 0.5, var_475_3)

					arg_472_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_472_1.var_.characterEffect1020ui_story.fillRatio = var_475_4
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1020ui_story then
				local var_475_5 = 0.5

				arg_472_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_472_1.var_.characterEffect1020ui_story.fillRatio = var_475_5
			end

			local var_475_6 = arg_472_1.actors_["1044ui_story"].transform
			local var_475_7 = 0

			if var_475_7 < arg_472_1.time_ and arg_472_1.time_ <= var_475_7 + arg_475_0 then
				arg_472_1.var_.moveOldPos1044ui_story = var_475_6.localPosition

				local var_475_8 = "1044ui_story"

				arg_472_1:ShowWeapon(arg_472_1.var_[var_475_8 .. "Animator"].transform, false)
			end

			local var_475_9 = 0.001

			if var_475_7 <= arg_472_1.time_ and arg_472_1.time_ < var_475_7 + var_475_9 then
				local var_475_10 = (arg_472_1.time_ - var_475_7) / var_475_9
				local var_475_11 = Vector3.New(-0.7, -1, -5.93)

				var_475_6.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1044ui_story, var_475_11, var_475_10)

				local var_475_12 = manager.ui.mainCamera.transform.position - var_475_6.position

				var_475_6.forward = Vector3.New(var_475_12.x, var_475_12.y, var_475_12.z)

				local var_475_13 = var_475_6.localEulerAngles

				var_475_13.z = 0
				var_475_13.x = 0
				var_475_6.localEulerAngles = var_475_13
			end

			if arg_472_1.time_ >= var_475_7 + var_475_9 and arg_472_1.time_ < var_475_7 + var_475_9 + arg_475_0 then
				var_475_6.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_475_14 = manager.ui.mainCamera.transform.position - var_475_6.position

				var_475_6.forward = Vector3.New(var_475_14.x, var_475_14.y, var_475_14.z)

				local var_475_15 = var_475_6.localEulerAngles

				var_475_15.z = 0
				var_475_15.x = 0
				var_475_6.localEulerAngles = var_475_15
			end

			local var_475_16 = arg_472_1.actors_["1044ui_story"]
			local var_475_17 = 0

			if var_475_17 < arg_472_1.time_ and arg_472_1.time_ <= var_475_17 + arg_475_0 and not isNil(var_475_16) and arg_472_1.var_.characterEffect1044ui_story == nil then
				arg_472_1.var_.characterEffect1044ui_story = var_475_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_18 = 0.200000002980232

			if var_475_17 <= arg_472_1.time_ and arg_472_1.time_ < var_475_17 + var_475_18 and not isNil(var_475_16) then
				local var_475_19 = (arg_472_1.time_ - var_475_17) / var_475_18

				if arg_472_1.var_.characterEffect1044ui_story and not isNil(var_475_16) then
					arg_472_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_17 + var_475_18 and arg_472_1.time_ < var_475_17 + var_475_18 + arg_475_0 and not isNil(var_475_16) and arg_472_1.var_.characterEffect1044ui_story then
				arg_472_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_475_20 = 0

			if var_475_20 < arg_472_1.time_ and arg_472_1.time_ <= var_475_20 + arg_475_0 then
				arg_472_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_1")
			end

			local var_475_21 = 0

			if var_475_21 < arg_472_1.time_ and arg_472_1.time_ <= var_475_21 + arg_475_0 then
				arg_472_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_475_22 = 0
			local var_475_23 = 0.725

			if var_475_22 < arg_472_1.time_ and arg_472_1.time_ <= var_475_22 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_24 = arg_472_1:FormatText(StoryNameCfg[1367].name)

				arg_472_1.leftNameTxt_.text = var_475_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_25 = arg_472_1:GetWordFromCfg(322281116)
				local var_475_26 = arg_472_1:FormatText(var_475_25.content)

				arg_472_1.text_.text = var_475_26

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_27 = 29
				local var_475_28 = utf8.len(var_475_26)
				local var_475_29 = var_475_27 <= 0 and var_475_23 or var_475_23 * (var_475_28 / var_475_27)

				if var_475_29 > 0 and var_475_23 < var_475_29 then
					arg_472_1.talkMaxDuration = var_475_29

					if var_475_29 + var_475_22 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_29 + var_475_22
					end
				end

				arg_472_1.text_.text = var_475_26
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281116", "story_v_out_322281.awb") ~= 0 then
					local var_475_30 = manager.audio:GetVoiceLength("story_v_out_322281", "322281116", "story_v_out_322281.awb") / 1000

					if var_475_30 + var_475_22 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_30 + var_475_22
					end

					if var_475_25.prefab_name ~= "" and arg_472_1.actors_[var_475_25.prefab_name] ~= nil then
						local var_475_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_25.prefab_name].transform, "story_v_out_322281", "322281116", "story_v_out_322281.awb")

						arg_472_1:RecordAudio("322281116", var_475_31)
						arg_472_1:RecordAudio("322281116", var_475_31)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_322281", "322281116", "story_v_out_322281.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_322281", "322281116", "story_v_out_322281.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_32 = math.max(var_475_23, arg_472_1.talkMaxDuration)

			if var_475_22 <= arg_472_1.time_ and arg_472_1.time_ < var_475_22 + var_475_32 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_22) / var_475_32

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_22 + var_475_32 and arg_472_1.time_ < var_475_22 + var_475_32 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play322281117 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 322281117
		arg_476_1.duration_ = 10.83

		local var_476_0 = {
			zh = 7.8,
			ja = 10.833
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play322281118(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1020ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1020ui_story == nil then
				arg_476_1.var_.characterEffect1020ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect1020ui_story and not isNil(var_479_0) then
					arg_476_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1020ui_story then
				arg_476_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_479_4 = 0

			if var_479_4 < arg_476_1.time_ and arg_476_1.time_ <= var_479_4 + arg_479_0 then
				arg_476_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_479_5 = arg_476_1.actors_["1044ui_story"]
			local var_479_6 = 0

			if var_479_6 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 and not isNil(var_479_5) and arg_476_1.var_.characterEffect1044ui_story == nil then
				arg_476_1.var_.characterEffect1044ui_story = var_479_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_7 = 0.200000002980232

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_7 and not isNil(var_479_5) then
				local var_479_8 = (arg_476_1.time_ - var_479_6) / var_479_7

				if arg_476_1.var_.characterEffect1044ui_story and not isNil(var_479_5) then
					local var_479_9 = Mathf.Lerp(0, 0.5, var_479_8)

					arg_476_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1044ui_story.fillRatio = var_479_9
				end
			end

			if arg_476_1.time_ >= var_479_6 + var_479_7 and arg_476_1.time_ < var_479_6 + var_479_7 + arg_479_0 and not isNil(var_479_5) and arg_476_1.var_.characterEffect1044ui_story then
				local var_479_10 = 0.5

				arg_476_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1044ui_story.fillRatio = var_479_10
			end

			local var_479_11 = 0
			local var_479_12 = 1

			if var_479_11 < arg_476_1.time_ and arg_476_1.time_ <= var_479_11 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_13 = arg_476_1:FormatText(StoryNameCfg[613].name)

				arg_476_1.leftNameTxt_.text = var_479_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_14 = arg_476_1:GetWordFromCfg(322281117)
				local var_479_15 = arg_476_1:FormatText(var_479_14.content)

				arg_476_1.text_.text = var_479_15

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_16 = 40
				local var_479_17 = utf8.len(var_479_15)
				local var_479_18 = var_479_16 <= 0 and var_479_12 or var_479_12 * (var_479_17 / var_479_16)

				if var_479_18 > 0 and var_479_12 < var_479_18 then
					arg_476_1.talkMaxDuration = var_479_18

					if var_479_18 + var_479_11 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_18 + var_479_11
					end
				end

				arg_476_1.text_.text = var_479_15
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281117", "story_v_out_322281.awb") ~= 0 then
					local var_479_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281117", "story_v_out_322281.awb") / 1000

					if var_479_19 + var_479_11 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_19 + var_479_11
					end

					if var_479_14.prefab_name ~= "" and arg_476_1.actors_[var_479_14.prefab_name] ~= nil then
						local var_479_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_14.prefab_name].transform, "story_v_out_322281", "322281117", "story_v_out_322281.awb")

						arg_476_1:RecordAudio("322281117", var_479_20)
						arg_476_1:RecordAudio("322281117", var_479_20)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_322281", "322281117", "story_v_out_322281.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_322281", "322281117", "story_v_out_322281.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_21 = math.max(var_479_12, arg_476_1.talkMaxDuration)

			if var_479_11 <= arg_476_1.time_ and arg_476_1.time_ < var_479_11 + var_479_21 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_11) / var_479_21

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_11 + var_479_21 and arg_476_1.time_ < var_479_11 + var_479_21 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play322281118 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 322281118
		arg_480_1.duration_ = 12.67

		local var_480_0 = {
			zh = 8.6,
			ja = 12.666
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play322281119(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 1.075

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[613].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_3 = arg_480_1:GetWordFromCfg(322281118)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 43
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281118", "story_v_out_322281.awb") ~= 0 then
					local var_483_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281118", "story_v_out_322281.awb") / 1000

					if var_483_8 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_8 + var_483_0
					end

					if var_483_3.prefab_name ~= "" and arg_480_1.actors_[var_483_3.prefab_name] ~= nil then
						local var_483_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_3.prefab_name].transform, "story_v_out_322281", "322281118", "story_v_out_322281.awb")

						arg_480_1:RecordAudio("322281118", var_483_9)
						arg_480_1:RecordAudio("322281118", var_483_9)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_322281", "322281118", "story_v_out_322281.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_322281", "322281118", "story_v_out_322281.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_10 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_10 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_10

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_10 and arg_480_1.time_ < var_483_0 + var_483_10 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play322281119 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 322281119
		arg_484_1.duration_ = 14.37

		local var_484_0 = {
			zh = 7.7,
			ja = 14.366
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play322281120(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_1")
			end

			local var_487_1 = 0
			local var_487_2 = 0.875

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_3 = arg_484_1:FormatText(StoryNameCfg[613].name)

				arg_484_1.leftNameTxt_.text = var_487_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_4 = arg_484_1:GetWordFromCfg(322281119)
				local var_487_5 = arg_484_1:FormatText(var_487_4.content)

				arg_484_1.text_.text = var_487_5

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_6 = 35
				local var_487_7 = utf8.len(var_487_5)
				local var_487_8 = var_487_6 <= 0 and var_487_2 or var_487_2 * (var_487_7 / var_487_6)

				if var_487_8 > 0 and var_487_2 < var_487_8 then
					arg_484_1.talkMaxDuration = var_487_8

					if var_487_8 + var_487_1 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_1
					end
				end

				arg_484_1.text_.text = var_487_5
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281119", "story_v_out_322281.awb") ~= 0 then
					local var_487_9 = manager.audio:GetVoiceLength("story_v_out_322281", "322281119", "story_v_out_322281.awb") / 1000

					if var_487_9 + var_487_1 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_9 + var_487_1
					end

					if var_487_4.prefab_name ~= "" and arg_484_1.actors_[var_487_4.prefab_name] ~= nil then
						local var_487_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_4.prefab_name].transform, "story_v_out_322281", "322281119", "story_v_out_322281.awb")

						arg_484_1:RecordAudio("322281119", var_487_10)
						arg_484_1:RecordAudio("322281119", var_487_10)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_322281", "322281119", "story_v_out_322281.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_322281", "322281119", "story_v_out_322281.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_11 = math.max(var_487_2, arg_484_1.talkMaxDuration)

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_11 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_1) / var_487_11

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_1 + var_487_11 and arg_484_1.time_ < var_487_1 + var_487_11 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play322281120 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 322281120
		arg_488_1.duration_ = 4.77

		local var_488_0 = {
			zh = 4.633,
			ja = 4.766
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play322281121(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1020ui_story"]
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1020ui_story == nil then
				arg_488_1.var_.characterEffect1020ui_story = var_491_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.200000002980232

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 and not isNil(var_491_0) then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2

				if arg_488_1.var_.characterEffect1020ui_story and not isNil(var_491_0) then
					local var_491_4 = Mathf.Lerp(0, 0.5, var_491_3)

					arg_488_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1020ui_story.fillRatio = var_491_4
				end
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1020ui_story then
				local var_491_5 = 0.5

				arg_488_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1020ui_story.fillRatio = var_491_5
			end

			local var_491_6 = arg_488_1.actors_["1044ui_story"]
			local var_491_7 = 0

			if var_491_7 < arg_488_1.time_ and arg_488_1.time_ <= var_491_7 + arg_491_0 and not isNil(var_491_6) and arg_488_1.var_.characterEffect1044ui_story == nil then
				arg_488_1.var_.characterEffect1044ui_story = var_491_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_8 = 0.200000002980232

			if var_491_7 <= arg_488_1.time_ and arg_488_1.time_ < var_491_7 + var_491_8 and not isNil(var_491_6) then
				local var_491_9 = (arg_488_1.time_ - var_491_7) / var_491_8

				if arg_488_1.var_.characterEffect1044ui_story and not isNil(var_491_6) then
					arg_488_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_7 + var_491_8 and arg_488_1.time_ < var_491_7 + var_491_8 + arg_491_0 and not isNil(var_491_6) and arg_488_1.var_.characterEffect1044ui_story then
				arg_488_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 then
				arg_488_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_2")
			end

			local var_491_11 = 0

			if var_491_11 < arg_488_1.time_ and arg_488_1.time_ <= var_491_11 + arg_491_0 then
				arg_488_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_491_12 = 0
			local var_491_13 = 0.6

			if var_491_12 < arg_488_1.time_ and arg_488_1.time_ <= var_491_12 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_14 = arg_488_1:FormatText(StoryNameCfg[1367].name)

				arg_488_1.leftNameTxt_.text = var_491_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_15 = arg_488_1:GetWordFromCfg(322281120)
				local var_491_16 = arg_488_1:FormatText(var_491_15.content)

				arg_488_1.text_.text = var_491_16

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_17 = 24
				local var_491_18 = utf8.len(var_491_16)
				local var_491_19 = var_491_17 <= 0 and var_491_13 or var_491_13 * (var_491_18 / var_491_17)

				if var_491_19 > 0 and var_491_13 < var_491_19 then
					arg_488_1.talkMaxDuration = var_491_19

					if var_491_19 + var_491_12 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_19 + var_491_12
					end
				end

				arg_488_1.text_.text = var_491_16
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281120", "story_v_out_322281.awb") ~= 0 then
					local var_491_20 = manager.audio:GetVoiceLength("story_v_out_322281", "322281120", "story_v_out_322281.awb") / 1000

					if var_491_20 + var_491_12 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_20 + var_491_12
					end

					if var_491_15.prefab_name ~= "" and arg_488_1.actors_[var_491_15.prefab_name] ~= nil then
						local var_491_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_15.prefab_name].transform, "story_v_out_322281", "322281120", "story_v_out_322281.awb")

						arg_488_1:RecordAudio("322281120", var_491_21)
						arg_488_1:RecordAudio("322281120", var_491_21)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_322281", "322281120", "story_v_out_322281.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_322281", "322281120", "story_v_out_322281.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_22 = math.max(var_491_13, arg_488_1.talkMaxDuration)

			if var_491_12 <= arg_488_1.time_ and arg_488_1.time_ < var_491_12 + var_491_22 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_12) / var_491_22

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_12 + var_491_22 and arg_488_1.time_ < var_491_12 + var_491_22 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play322281121 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 322281121
		arg_492_1.duration_ = 11.33

		local var_492_0 = {
			zh = 9.433,
			ja = 11.333
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play322281122(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 1.125

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_2 = arg_492_1:FormatText(StoryNameCfg[1367].name)

				arg_492_1.leftNameTxt_.text = var_495_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_3 = arg_492_1:GetWordFromCfg(322281121)
				local var_495_4 = arg_492_1:FormatText(var_495_3.content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 45
				local var_495_6 = utf8.len(var_495_4)
				local var_495_7 = var_495_5 <= 0 and var_495_1 or var_495_1 * (var_495_6 / var_495_5)

				if var_495_7 > 0 and var_495_1 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_4
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281121", "story_v_out_322281.awb") ~= 0 then
					local var_495_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281121", "story_v_out_322281.awb") / 1000

					if var_495_8 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_8 + var_495_0
					end

					if var_495_3.prefab_name ~= "" and arg_492_1.actors_[var_495_3.prefab_name] ~= nil then
						local var_495_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_3.prefab_name].transform, "story_v_out_322281", "322281121", "story_v_out_322281.awb")

						arg_492_1:RecordAudio("322281121", var_495_9)
						arg_492_1:RecordAudio("322281121", var_495_9)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_322281", "322281121", "story_v_out_322281.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_322281", "322281121", "story_v_out_322281.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_10 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_10 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_10

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_10 and arg_492_1.time_ < var_495_0 + var_495_10 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play322281122 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 322281122
		arg_496_1.duration_ = 3.67

		local var_496_0 = {
			zh = 3.366,
			ja = 3.666
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play322281123(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1020ui_story"]
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.characterEffect1020ui_story == nil then
				arg_496_1.var_.characterEffect1020ui_story = var_499_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_2 = 0.200000002980232

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 and not isNil(var_499_0) then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2

				if arg_496_1.var_.characterEffect1020ui_story and not isNil(var_499_0) then
					arg_496_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.characterEffect1020ui_story then
				arg_496_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_499_4 = arg_496_1.actors_["1044ui_story"]
			local var_499_5 = 0

			if var_499_5 < arg_496_1.time_ and arg_496_1.time_ <= var_499_5 + arg_499_0 and not isNil(var_499_4) and arg_496_1.var_.characterEffect1044ui_story == nil then
				arg_496_1.var_.characterEffect1044ui_story = var_499_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_6 = 0.200000002980232

			if var_499_5 <= arg_496_1.time_ and arg_496_1.time_ < var_499_5 + var_499_6 and not isNil(var_499_4) then
				local var_499_7 = (arg_496_1.time_ - var_499_5) / var_499_6

				if arg_496_1.var_.characterEffect1044ui_story and not isNil(var_499_4) then
					local var_499_8 = Mathf.Lerp(0, 0.5, var_499_7)

					arg_496_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_496_1.var_.characterEffect1044ui_story.fillRatio = var_499_8
				end
			end

			if arg_496_1.time_ >= var_499_5 + var_499_6 and arg_496_1.time_ < var_499_5 + var_499_6 + arg_499_0 and not isNil(var_499_4) and arg_496_1.var_.characterEffect1044ui_story then
				local var_499_9 = 0.5

				arg_496_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_496_1.var_.characterEffect1044ui_story.fillRatio = var_499_9
			end

			local var_499_10 = 0

			if var_499_10 < arg_496_1.time_ and arg_496_1.time_ <= var_499_10 + arg_499_0 then
				arg_496_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_499_11 = 0
			local var_499_12 = 0.425

			if var_499_11 < arg_496_1.time_ and arg_496_1.time_ <= var_499_11 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_13 = arg_496_1:FormatText(StoryNameCfg[613].name)

				arg_496_1.leftNameTxt_.text = var_499_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_14 = arg_496_1:GetWordFromCfg(322281122)
				local var_499_15 = arg_496_1:FormatText(var_499_14.content)

				arg_496_1.text_.text = var_499_15

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_16 = 16
				local var_499_17 = utf8.len(var_499_15)
				local var_499_18 = var_499_16 <= 0 and var_499_12 or var_499_12 * (var_499_17 / var_499_16)

				if var_499_18 > 0 and var_499_12 < var_499_18 then
					arg_496_1.talkMaxDuration = var_499_18

					if var_499_18 + var_499_11 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_18 + var_499_11
					end
				end

				arg_496_1.text_.text = var_499_15
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281122", "story_v_out_322281.awb") ~= 0 then
					local var_499_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281122", "story_v_out_322281.awb") / 1000

					if var_499_19 + var_499_11 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_19 + var_499_11
					end

					if var_499_14.prefab_name ~= "" and arg_496_1.actors_[var_499_14.prefab_name] ~= nil then
						local var_499_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_14.prefab_name].transform, "story_v_out_322281", "322281122", "story_v_out_322281.awb")

						arg_496_1:RecordAudio("322281122", var_499_20)
						arg_496_1:RecordAudio("322281122", var_499_20)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_322281", "322281122", "story_v_out_322281.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_322281", "322281122", "story_v_out_322281.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_21 = math.max(var_499_12, arg_496_1.talkMaxDuration)

			if var_499_11 <= arg_496_1.time_ and arg_496_1.time_ < var_499_11 + var_499_21 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_11) / var_499_21

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_11 + var_499_21 and arg_496_1.time_ < var_499_11 + var_499_21 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play322281123 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 322281123
		arg_500_1.duration_ = 2

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play322281124(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["1020ui_story"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1020ui_story == nil then
				arg_500_1.var_.characterEffect1020ui_story = var_503_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.200000002980232

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.characterEffect1020ui_story and not isNil(var_503_0) then
					local var_503_4 = Mathf.Lerp(0, 0.5, var_503_3)

					arg_500_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_500_1.var_.characterEffect1020ui_story.fillRatio = var_503_4
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1020ui_story then
				local var_503_5 = 0.5

				arg_500_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_500_1.var_.characterEffect1020ui_story.fillRatio = var_503_5
			end

			local var_503_6 = arg_500_1.actors_["1044ui_story"]
			local var_503_7 = 0

			if var_503_7 < arg_500_1.time_ and arg_500_1.time_ <= var_503_7 + arg_503_0 and not isNil(var_503_6) and arg_500_1.var_.characterEffect1044ui_story == nil then
				arg_500_1.var_.characterEffect1044ui_story = var_503_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_8 = 0.200000002980232

			if var_503_7 <= arg_500_1.time_ and arg_500_1.time_ < var_503_7 + var_503_8 and not isNil(var_503_6) then
				local var_503_9 = (arg_500_1.time_ - var_503_7) / var_503_8

				if arg_500_1.var_.characterEffect1044ui_story and not isNil(var_503_6) then
					arg_500_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= var_503_7 + var_503_8 and arg_500_1.time_ < var_503_7 + var_503_8 + arg_503_0 and not isNil(var_503_6) and arg_500_1.var_.characterEffect1044ui_story then
				arg_500_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_503_10 = 0

			if var_503_10 < arg_500_1.time_ and arg_500_1.time_ <= var_503_10 + arg_503_0 then
				arg_500_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_503_11 = 0

			if var_503_11 < arg_500_1.time_ and arg_500_1.time_ <= var_503_11 + arg_503_0 then
				arg_500_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_503_12 = 0
			local var_503_13 = 0.05

			if var_503_12 < arg_500_1.time_ and arg_500_1.time_ <= var_503_12 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_14 = arg_500_1:FormatText(StoryNameCfg[1367].name)

				arg_500_1.leftNameTxt_.text = var_503_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_15 = arg_500_1:GetWordFromCfg(322281123)
				local var_503_16 = arg_500_1:FormatText(var_503_15.content)

				arg_500_1.text_.text = var_503_16

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_17 = 2
				local var_503_18 = utf8.len(var_503_16)
				local var_503_19 = var_503_17 <= 0 and var_503_13 or var_503_13 * (var_503_18 / var_503_17)

				if var_503_19 > 0 and var_503_13 < var_503_19 then
					arg_500_1.talkMaxDuration = var_503_19

					if var_503_19 + var_503_12 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_19 + var_503_12
					end
				end

				arg_500_1.text_.text = var_503_16
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281123", "story_v_out_322281.awb") ~= 0 then
					local var_503_20 = manager.audio:GetVoiceLength("story_v_out_322281", "322281123", "story_v_out_322281.awb") / 1000

					if var_503_20 + var_503_12 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_20 + var_503_12
					end

					if var_503_15.prefab_name ~= "" and arg_500_1.actors_[var_503_15.prefab_name] ~= nil then
						local var_503_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_15.prefab_name].transform, "story_v_out_322281", "322281123", "story_v_out_322281.awb")

						arg_500_1:RecordAudio("322281123", var_503_21)
						arg_500_1:RecordAudio("322281123", var_503_21)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_322281", "322281123", "story_v_out_322281.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_322281", "322281123", "story_v_out_322281.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_22 = math.max(var_503_13, arg_500_1.talkMaxDuration)

			if var_503_12 <= arg_500_1.time_ and arg_500_1.time_ < var_503_12 + var_503_22 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_12) / var_503_22

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_12 + var_503_22 and arg_500_1.time_ < var_503_12 + var_503_22 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play322281124 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 322281124
		arg_504_1.duration_ = 4.43

		local var_504_0 = {
			zh = 3.6,
			ja = 4.433
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play322281125(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["1020ui_story"]
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1020ui_story == nil then
				arg_504_1.var_.characterEffect1020ui_story = var_507_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_2 = 0.200000002980232

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 and not isNil(var_507_0) then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2

				if arg_504_1.var_.characterEffect1020ui_story and not isNil(var_507_0) then
					arg_504_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1020ui_story then
				arg_504_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_507_4 = arg_504_1.actors_["1044ui_story"]
			local var_507_5 = 0

			if var_507_5 < arg_504_1.time_ and arg_504_1.time_ <= var_507_5 + arg_507_0 and not isNil(var_507_4) and arg_504_1.var_.characterEffect1044ui_story == nil then
				arg_504_1.var_.characterEffect1044ui_story = var_507_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_6 = 0.200000002980232

			if var_507_5 <= arg_504_1.time_ and arg_504_1.time_ < var_507_5 + var_507_6 and not isNil(var_507_4) then
				local var_507_7 = (arg_504_1.time_ - var_507_5) / var_507_6

				if arg_504_1.var_.characterEffect1044ui_story and not isNil(var_507_4) then
					local var_507_8 = Mathf.Lerp(0, 0.5, var_507_7)

					arg_504_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_504_1.var_.characterEffect1044ui_story.fillRatio = var_507_8
				end
			end

			if arg_504_1.time_ >= var_507_5 + var_507_6 and arg_504_1.time_ < var_507_5 + var_507_6 + arg_507_0 and not isNil(var_507_4) and arg_504_1.var_.characterEffect1044ui_story then
				local var_507_9 = 0.5

				arg_504_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_504_1.var_.characterEffect1044ui_story.fillRatio = var_507_9
			end

			local var_507_10 = 0

			if var_507_10 < arg_504_1.time_ and arg_504_1.time_ <= var_507_10 + arg_507_0 then
				arg_504_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_507_11 = 0
			local var_507_12 = 0.425

			if var_507_11 < arg_504_1.time_ and arg_504_1.time_ <= var_507_11 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_13 = arg_504_1:FormatText(StoryNameCfg[613].name)

				arg_504_1.leftNameTxt_.text = var_507_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_14 = arg_504_1:GetWordFromCfg(322281124)
				local var_507_15 = arg_504_1:FormatText(var_507_14.content)

				arg_504_1.text_.text = var_507_15

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_16 = 17
				local var_507_17 = utf8.len(var_507_15)
				local var_507_18 = var_507_16 <= 0 and var_507_12 or var_507_12 * (var_507_17 / var_507_16)

				if var_507_18 > 0 and var_507_12 < var_507_18 then
					arg_504_1.talkMaxDuration = var_507_18

					if var_507_18 + var_507_11 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_18 + var_507_11
					end
				end

				arg_504_1.text_.text = var_507_15
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281124", "story_v_out_322281.awb") ~= 0 then
					local var_507_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281124", "story_v_out_322281.awb") / 1000

					if var_507_19 + var_507_11 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_19 + var_507_11
					end

					if var_507_14.prefab_name ~= "" and arg_504_1.actors_[var_507_14.prefab_name] ~= nil then
						local var_507_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_14.prefab_name].transform, "story_v_out_322281", "322281124", "story_v_out_322281.awb")

						arg_504_1:RecordAudio("322281124", var_507_20)
						arg_504_1:RecordAudio("322281124", var_507_20)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_322281", "322281124", "story_v_out_322281.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_322281", "322281124", "story_v_out_322281.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_21 = math.max(var_507_12, arg_504_1.talkMaxDuration)

			if var_507_11 <= arg_504_1.time_ and arg_504_1.time_ < var_507_11 + var_507_21 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_11) / var_507_21

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_11 + var_507_21 and arg_504_1.time_ < var_507_11 + var_507_21 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play322281125 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 322281125
		arg_508_1.duration_ = 2.87

		local var_508_0 = {
			zh = 2.166,
			ja = 2.866
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play322281126(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.3

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[613].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_3 = arg_508_1:GetWordFromCfg(322281125)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 12
				local var_511_6 = utf8.len(var_511_4)
				local var_511_7 = var_511_5 <= 0 and var_511_1 or var_511_1 * (var_511_6 / var_511_5)

				if var_511_7 > 0 and var_511_1 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_4
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281125", "story_v_out_322281.awb") ~= 0 then
					local var_511_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281125", "story_v_out_322281.awb") / 1000

					if var_511_8 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_8 + var_511_0
					end

					if var_511_3.prefab_name ~= "" and arg_508_1.actors_[var_511_3.prefab_name] ~= nil then
						local var_511_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_3.prefab_name].transform, "story_v_out_322281", "322281125", "story_v_out_322281.awb")

						arg_508_1:RecordAudio("322281125", var_511_9)
						arg_508_1:RecordAudio("322281125", var_511_9)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_322281", "322281125", "story_v_out_322281.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_322281", "322281125", "story_v_out_322281.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_10 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_10 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_10

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_10 and arg_508_1.time_ < var_511_0 + var_511_10 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play322281126 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 322281126
		arg_512_1.duration_ = 2.53

		local var_512_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play322281127(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["1020ui_story"]
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect1020ui_story == nil then
				arg_512_1.var_.characterEffect1020ui_story = var_515_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_2 = 0.200000002980232

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 and not isNil(var_515_0) then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2

				if arg_512_1.var_.characterEffect1020ui_story and not isNil(var_515_0) then
					local var_515_4 = Mathf.Lerp(0, 0.5, var_515_3)

					arg_512_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_512_1.var_.characterEffect1020ui_story.fillRatio = var_515_4
				end
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect1020ui_story then
				local var_515_5 = 0.5

				arg_512_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_512_1.var_.characterEffect1020ui_story.fillRatio = var_515_5
			end

			local var_515_6 = arg_512_1.actors_["1044ui_story"]
			local var_515_7 = 0

			if var_515_7 < arg_512_1.time_ and arg_512_1.time_ <= var_515_7 + arg_515_0 and not isNil(var_515_6) and arg_512_1.var_.characterEffect1044ui_story == nil then
				arg_512_1.var_.characterEffect1044ui_story = var_515_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_8 = 0.200000002980232

			if var_515_7 <= arg_512_1.time_ and arg_512_1.time_ < var_515_7 + var_515_8 and not isNil(var_515_6) then
				local var_515_9 = (arg_512_1.time_ - var_515_7) / var_515_8

				if arg_512_1.var_.characterEffect1044ui_story and not isNil(var_515_6) then
					arg_512_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= var_515_7 + var_515_8 and arg_512_1.time_ < var_515_7 + var_515_8 + arg_515_0 and not isNil(var_515_6) and arg_512_1.var_.characterEffect1044ui_story then
				arg_512_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_515_10 = 0

			if var_515_10 < arg_512_1.time_ and arg_512_1.time_ <= var_515_10 + arg_515_0 then
				arg_512_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_515_11 = 0

			if var_515_11 < arg_512_1.time_ and arg_512_1.time_ <= var_515_11 + arg_515_0 then
				arg_512_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_515_12 = 0
			local var_515_13 = 0.175

			if var_515_12 < arg_512_1.time_ and arg_512_1.time_ <= var_515_12 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_14 = arg_512_1:FormatText(StoryNameCfg[1367].name)

				arg_512_1.leftNameTxt_.text = var_515_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_15 = arg_512_1:GetWordFromCfg(322281126)
				local var_515_16 = arg_512_1:FormatText(var_515_15.content)

				arg_512_1.text_.text = var_515_16

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_17 = 7
				local var_515_18 = utf8.len(var_515_16)
				local var_515_19 = var_515_17 <= 0 and var_515_13 or var_515_13 * (var_515_18 / var_515_17)

				if var_515_19 > 0 and var_515_13 < var_515_19 then
					arg_512_1.talkMaxDuration = var_515_19

					if var_515_19 + var_515_12 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_19 + var_515_12
					end
				end

				arg_512_1.text_.text = var_515_16
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281126", "story_v_out_322281.awb") ~= 0 then
					local var_515_20 = manager.audio:GetVoiceLength("story_v_out_322281", "322281126", "story_v_out_322281.awb") / 1000

					if var_515_20 + var_515_12 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_20 + var_515_12
					end

					if var_515_15.prefab_name ~= "" and arg_512_1.actors_[var_515_15.prefab_name] ~= nil then
						local var_515_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_15.prefab_name].transform, "story_v_out_322281", "322281126", "story_v_out_322281.awb")

						arg_512_1:RecordAudio("322281126", var_515_21)
						arg_512_1:RecordAudio("322281126", var_515_21)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_322281", "322281126", "story_v_out_322281.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_322281", "322281126", "story_v_out_322281.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_22 = math.max(var_515_13, arg_512_1.talkMaxDuration)

			if var_515_12 <= arg_512_1.time_ and arg_512_1.time_ < var_515_12 + var_515_22 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_12) / var_515_22

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_12 + var_515_22 and arg_512_1.time_ < var_515_12 + var_515_22 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play322281127 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 322281127
		arg_516_1.duration_ = 3.6

		local var_516_0 = {
			zh = 2.433,
			ja = 3.6
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play322281128(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["1020ui_story"]
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = var_519_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_2 = 0.200000002980232

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 and not isNil(var_519_0) then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2

				if arg_516_1.var_.characterEffect1020ui_story and not isNil(var_519_0) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_519_4 = 0

			if var_519_4 < arg_516_1.time_ and arg_516_1.time_ <= var_519_4 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_519_5 = 0

			if var_519_5 < arg_516_1.time_ and arg_516_1.time_ <= var_519_5 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_519_6 = arg_516_1.actors_["1044ui_story"]
			local var_519_7 = 0

			if var_519_7 < arg_516_1.time_ and arg_516_1.time_ <= var_519_7 + arg_519_0 and not isNil(var_519_6) and arg_516_1.var_.characterEffect1044ui_story == nil then
				arg_516_1.var_.characterEffect1044ui_story = var_519_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_8 = 0.200000002980232

			if var_519_7 <= arg_516_1.time_ and arg_516_1.time_ < var_519_7 + var_519_8 and not isNil(var_519_6) then
				local var_519_9 = (arg_516_1.time_ - var_519_7) / var_519_8

				if arg_516_1.var_.characterEffect1044ui_story and not isNil(var_519_6) then
					local var_519_10 = Mathf.Lerp(0, 0.5, var_519_9)

					arg_516_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1044ui_story.fillRatio = var_519_10
				end
			end

			if arg_516_1.time_ >= var_519_7 + var_519_8 and arg_516_1.time_ < var_519_7 + var_519_8 + arg_519_0 and not isNil(var_519_6) and arg_516_1.var_.characterEffect1044ui_story then
				local var_519_11 = 0.5

				arg_516_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1044ui_story.fillRatio = var_519_11
			end

			local var_519_12 = 0
			local var_519_13 = 0.275

			if var_519_12 < arg_516_1.time_ and arg_516_1.time_ <= var_519_12 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_14 = arg_516_1:FormatText(StoryNameCfg[613].name)

				arg_516_1.leftNameTxt_.text = var_519_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_15 = arg_516_1:GetWordFromCfg(322281127)
				local var_519_16 = arg_516_1:FormatText(var_519_15.content)

				arg_516_1.text_.text = var_519_16

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_17 = 11
				local var_519_18 = utf8.len(var_519_16)
				local var_519_19 = var_519_17 <= 0 and var_519_13 or var_519_13 * (var_519_18 / var_519_17)

				if var_519_19 > 0 and var_519_13 < var_519_19 then
					arg_516_1.talkMaxDuration = var_519_19

					if var_519_19 + var_519_12 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_19 + var_519_12
					end
				end

				arg_516_1.text_.text = var_519_16
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281127", "story_v_out_322281.awb") ~= 0 then
					local var_519_20 = manager.audio:GetVoiceLength("story_v_out_322281", "322281127", "story_v_out_322281.awb") / 1000

					if var_519_20 + var_519_12 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_20 + var_519_12
					end

					if var_519_15.prefab_name ~= "" and arg_516_1.actors_[var_519_15.prefab_name] ~= nil then
						local var_519_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_15.prefab_name].transform, "story_v_out_322281", "322281127", "story_v_out_322281.awb")

						arg_516_1:RecordAudio("322281127", var_519_21)
						arg_516_1:RecordAudio("322281127", var_519_21)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_322281", "322281127", "story_v_out_322281.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_322281", "322281127", "story_v_out_322281.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_22 = math.max(var_519_13, arg_516_1.talkMaxDuration)

			if var_519_12 <= arg_516_1.time_ and arg_516_1.time_ < var_519_12 + var_519_22 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_12) / var_519_22

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_12 + var_519_22 and arg_516_1.time_ < var_519_12 + var_519_22 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play322281128 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 322281128
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play322281129(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["1020ui_story"].transform
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 then
				arg_520_1.var_.moveOldPos1020ui_story = var_523_0.localPosition
			end

			local var_523_2 = 0.001

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2
				local var_523_4 = Vector3.New(0, 100, 0)

				var_523_0.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1020ui_story, var_523_4, var_523_3)

				local var_523_5 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_5.x, var_523_5.y, var_523_5.z)

				local var_523_6 = var_523_0.localEulerAngles

				var_523_6.z = 0
				var_523_6.x = 0
				var_523_0.localEulerAngles = var_523_6
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 then
				var_523_0.localPosition = Vector3.New(0, 100, 0)

				local var_523_7 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_7.x, var_523_7.y, var_523_7.z)

				local var_523_8 = var_523_0.localEulerAngles

				var_523_8.z = 0
				var_523_8.x = 0
				var_523_0.localEulerAngles = var_523_8
			end

			local var_523_9 = 0.333333333333333
			local var_523_10 = 1

			if var_523_9 < arg_520_1.time_ and arg_520_1.time_ <= var_523_9 + arg_523_0 then
				local var_523_11 = "play"
				local var_523_12 = "effect"

				arg_520_1:AudioAction(var_523_11, var_523_12, "se_story_1310", "se_story_1310_car02", "")
			end

			local var_523_13 = arg_520_1.actors_["1044ui_story"].transform
			local var_523_14 = 0

			if var_523_14 < arg_520_1.time_ and arg_520_1.time_ <= var_523_14 + arg_523_0 then
				arg_520_1.var_.moveOldPos1044ui_story = var_523_13.localPosition

				local var_523_15 = "1044ui_story"

				arg_520_1:ShowWeapon(arg_520_1.var_[var_523_15 .. "Animator"].transform, false)
			end

			local var_523_16 = 0.001

			if var_523_14 <= arg_520_1.time_ and arg_520_1.time_ < var_523_14 + var_523_16 then
				local var_523_17 = (arg_520_1.time_ - var_523_14) / var_523_16
				local var_523_18 = Vector3.New(0, 100, 0)

				var_523_13.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1044ui_story, var_523_18, var_523_17)

				local var_523_19 = manager.ui.mainCamera.transform.position - var_523_13.position

				var_523_13.forward = Vector3.New(var_523_19.x, var_523_19.y, var_523_19.z)

				local var_523_20 = var_523_13.localEulerAngles

				var_523_20.z = 0
				var_523_20.x = 0
				var_523_13.localEulerAngles = var_523_20
			end

			if arg_520_1.time_ >= var_523_14 + var_523_16 and arg_520_1.time_ < var_523_14 + var_523_16 + arg_523_0 then
				var_523_13.localPosition = Vector3.New(0, 100, 0)

				local var_523_21 = manager.ui.mainCamera.transform.position - var_523_13.position

				var_523_13.forward = Vector3.New(var_523_21.x, var_523_21.y, var_523_21.z)

				local var_523_22 = var_523_13.localEulerAngles

				var_523_22.z = 0
				var_523_22.x = 0
				var_523_13.localEulerAngles = var_523_22
			end

			local var_523_23 = 0
			local var_523_24 = 1.1

			if var_523_23 < arg_520_1.time_ and arg_520_1.time_ <= var_523_23 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, false)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_25 = arg_520_1:GetWordFromCfg(322281128)
				local var_523_26 = arg_520_1:FormatText(var_523_25.content)

				arg_520_1.text_.text = var_523_26

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_27 = 44
				local var_523_28 = utf8.len(var_523_26)
				local var_523_29 = var_523_27 <= 0 and var_523_24 or var_523_24 * (var_523_28 / var_523_27)

				if var_523_29 > 0 and var_523_24 < var_523_29 then
					arg_520_1.talkMaxDuration = var_523_29

					if var_523_29 + var_523_23 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_29 + var_523_23
					end
				end

				arg_520_1.text_.text = var_523_26
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_30 = math.max(var_523_24, arg_520_1.talkMaxDuration)

			if var_523_23 <= arg_520_1.time_ and arg_520_1.time_ < var_523_23 + var_523_30 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_23) / var_523_30

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_23 + var_523_30 and arg_520_1.time_ < var_523_23 + var_523_30 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_520_1:InitPlayNodeList()
	end,
	Play322281129 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 322281129
		arg_524_1.duration_ = 6

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play322281130(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = "L01f"

			if arg_524_1.bgs_[var_527_0] == nil then
				local var_527_1 = Object.Instantiate(arg_524_1.blurPaintGo_)
				local var_527_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_527_0)

				var_527_1:GetComponent("SpriteRenderer").sprite = var_527_2
				var_527_1.name = var_527_0
				var_527_1.transform.parent = arg_524_1.stage_.transform
				var_527_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_524_1.bgs_[var_527_0] = var_527_1
			end

			local var_527_3 = 0
			local var_527_4 = arg_524_1.bgs_[var_527_0]

			if var_527_3 < arg_524_1.time_ and arg_524_1.time_ <= var_527_3 + arg_527_0 then
				local var_527_5 = manager.ui.mainCamera.transform.localPosition
				local var_527_6 = Vector3.New(0, 0, 10) + Vector3.New(var_527_5.x, var_527_5.y, 0)

				var_527_4.transform.localPosition = var_527_6
				var_527_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_527_7 = var_527_4:GetComponent("SpriteRenderer")

				if var_527_7 and var_527_7.sprite then
					local var_527_8 = (var_527_4.transform.localPosition - var_527_5).z
					local var_527_9 = manager.ui.mainCameraCom_
					local var_527_10 = 2 * var_527_8 * Mathf.Tan(var_527_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_527_11 = var_527_10 * var_527_9.aspect
					local var_527_12 = var_527_7.sprite.bounds.size.x
					local var_527_13 = var_527_7.sprite.bounds.size.y
					local var_527_14 = var_527_11 / var_527_12
					local var_527_15 = var_527_10 / var_527_13
					local var_527_16 = var_527_15 < var_527_14 and var_527_14 or var_527_15

					var_527_4.transform.localScale = Vector3.New(var_527_16, var_527_16, 0)
				end
			end

			local var_527_17 = 1

			if var_527_3 <= arg_524_1.time_ and arg_524_1.time_ < var_527_3 + var_527_17 then
				local var_527_18 = (arg_524_1.time_ - var_527_3) / var_527_17
				local var_527_19 = Color.New(1, 1, 1)

				var_527_19.a = Mathf.Lerp(0, 2, var_527_18)

				var_527_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_527_19)
			end

			if arg_524_1.frameCnt_ <= 1 then
				arg_524_1.dialog_:SetActive(false)
			end

			local var_527_20 = 1
			local var_527_21 = 1.75

			if var_527_20 < arg_524_1.time_ and arg_524_1.time_ <= var_527_20 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0

				arg_524_1.dialog_:SetActive(true)

				arg_524_1.dialogCg_.alpha = 0

				local var_527_22 = LeanTween.value(arg_524_1.dialog_, 0, 1, 0.3)

				var_527_22:setOnUpdate(LuaHelper.FloatAction(function(arg_528_0)
					arg_524_1.dialogCg_.alpha = arg_528_0
				end))
				var_527_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_524_1.dialog_)
					var_527_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_524_1.duration_ = arg_524_1.duration_ + 0.3

				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_23 = arg_524_1:GetWordFromCfg(322281129)
				local var_527_24 = arg_524_1:FormatText(var_527_23.content)

				arg_524_1.text_.text = var_527_24

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_25 = 70
				local var_527_26 = utf8.len(var_527_24)
				local var_527_27 = var_527_25 <= 0 and var_527_21 or var_527_21 * (var_527_26 / var_527_25)

				if var_527_27 > 0 and var_527_21 < var_527_27 then
					arg_524_1.talkMaxDuration = var_527_27
					var_527_20 = var_527_20 + 0.3

					if var_527_27 + var_527_20 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_27 + var_527_20
					end
				end

				arg_524_1.text_.text = var_527_24
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_28 = var_527_20 + 0.3
			local var_527_29 = math.max(var_527_21, arg_524_1.talkMaxDuration)

			if var_527_28 <= arg_524_1.time_ and arg_524_1.time_ < var_527_28 + var_527_29 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_28) / var_527_29

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_28 + var_527_29 and arg_524_1.time_ < var_527_28 + var_527_29 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play322281130 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 322281130
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play322281131(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["233"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				local var_533_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_533_2 then
					var_533_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_533_2.radialBlurScale = 1
					var_533_2.radialBlurGradient = 1
					var_533_2.radialBlurIntensity = 1

					if var_533_0 then
						var_533_2.radialBlurTarget = var_533_0.transform
					end
				end
			end

			local var_533_3 = 3.53333333333333

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_3 then
				local var_533_4 = (arg_530_1.time_ - var_533_1) / var_533_3
				local var_533_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_533_5 then
					var_533_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_533_5.radialBlurScale = Mathf.Lerp(1, 0.512, var_533_4)
					var_533_5.radialBlurGradient = Mathf.Lerp(1, 1, var_533_4)
					var_533_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_533_4)
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_3 and arg_530_1.time_ < var_533_1 + var_533_3 + arg_533_0 then
				local var_533_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_533_6 then
					var_533_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_533_6.radialBlurScale = 0.512
					var_533_6.radialBlurGradient = 1
					var_533_6.radialBlurIntensity = 1
				end
			end

			local var_533_7 = 0
			local var_533_8 = 1.25

			if var_533_7 < arg_530_1.time_ and arg_530_1.time_ <= var_533_7 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_9 = arg_530_1:GetWordFromCfg(322281130)
				local var_533_10 = arg_530_1:FormatText(var_533_9.content)

				arg_530_1.text_.text = var_533_10

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_11 = 50
				local var_533_12 = utf8.len(var_533_10)
				local var_533_13 = var_533_11 <= 0 and var_533_8 or var_533_8 * (var_533_12 / var_533_11)

				if var_533_13 > 0 and var_533_8 < var_533_13 then
					arg_530_1.talkMaxDuration = var_533_13

					if var_533_13 + var_533_7 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_13 + var_533_7
					end
				end

				arg_530_1.text_.text = var_533_10
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_14 = math.max(var_533_8, arg_530_1.talkMaxDuration)

			if var_533_7 <= arg_530_1.time_ and arg_530_1.time_ < var_533_7 + var_533_14 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_7) / var_533_14

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_7 + var_533_14 and arg_530_1.time_ < var_533_7 + var_533_14 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play322281131 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 322281131
		arg_534_1.duration_ = 5.7

		local var_534_0 = {
			zh = 4.466,
			ja = 5.7
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play322281132(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1020ui_story"].transform
			local var_537_1 = 0.2

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 then
				arg_534_1.var_.moveOldPos1020ui_story = var_537_0.localPosition
			end

			local var_537_2 = 0.001

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2
				local var_537_4 = Vector3.New(0, -0.85, -6.25)

				var_537_0.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1020ui_story, var_537_4, var_537_3)

				local var_537_5 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_5.x, var_537_5.y, var_537_5.z)

				local var_537_6 = var_537_0.localEulerAngles

				var_537_6.z = 0
				var_537_6.x = 0
				var_537_0.localEulerAngles = var_537_6
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 then
				var_537_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_537_7 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_7.x, var_537_7.y, var_537_7.z)

				local var_537_8 = var_537_0.localEulerAngles

				var_537_8.z = 0
				var_537_8.x = 0
				var_537_0.localEulerAngles = var_537_8
			end

			local var_537_9 = arg_534_1.actors_["1020ui_story"]
			local var_537_10 = 0.2

			if var_537_10 < arg_534_1.time_ and arg_534_1.time_ <= var_537_10 + arg_537_0 and not isNil(var_537_9) and arg_534_1.var_.characterEffect1020ui_story == nil then
				arg_534_1.var_.characterEffect1020ui_story = var_537_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_11 = 0.200000002980232

			if var_537_10 <= arg_534_1.time_ and arg_534_1.time_ < var_537_10 + var_537_11 and not isNil(var_537_9) then
				local var_537_12 = (arg_534_1.time_ - var_537_10) / var_537_11

				if arg_534_1.var_.characterEffect1020ui_story and not isNil(var_537_9) then
					arg_534_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= var_537_10 + var_537_11 and arg_534_1.time_ < var_537_10 + var_537_11 + arg_537_0 and not isNil(var_537_9) and arg_534_1.var_.characterEffect1020ui_story then
				arg_534_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_537_13 = 0.2

			if var_537_13 < arg_534_1.time_ and arg_534_1.time_ <= var_537_13 + arg_537_0 then
				arg_534_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			local var_537_14 = 0.2

			if var_537_14 < arg_534_1.time_ and arg_534_1.time_ <= var_537_14 + arg_537_0 then
				arg_534_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_537_15
			local var_537_16 = 0

			if var_537_16 < arg_534_1.time_ and arg_534_1.time_ <= var_537_16 + arg_537_0 then
				local var_537_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_537_17 then
					var_537_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_537_17.radialBlurScale = 0
					var_537_17.radialBlurGradient = 1
					var_537_17.radialBlurIntensity = 1

					if var_537_15 then
						var_537_17.radialBlurTarget = var_537_15.transform
					end
				end
			end

			local var_537_18 = 0.333333333333333

			if var_537_16 <= arg_534_1.time_ and arg_534_1.time_ < var_537_16 + var_537_18 then
				local var_537_19 = (arg_534_1.time_ - var_537_16) / var_537_18
				local var_537_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_537_20 then
					var_537_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_537_20.radialBlurScale = Mathf.Lerp(0, 0, var_537_19)
					var_537_20.radialBlurGradient = Mathf.Lerp(1, 1, var_537_19)
					var_537_20.radialBlurIntensity = Mathf.Lerp(1, 1, var_537_19)
				end
			end

			if arg_534_1.time_ >= var_537_16 + var_537_18 and arg_534_1.time_ < var_537_16 + var_537_18 + arg_537_0 then
				local var_537_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_537_21 then
					var_537_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_537_21.radialBlurScale = 0
					var_537_21.radialBlurGradient = 1
					var_537_21.radialBlurIntensity = 1
				end
			end

			if arg_534_1.frameCnt_ <= 1 then
				arg_534_1.dialog_:SetActive(false)
			end

			local var_537_22 = 0.2
			local var_537_23 = 0.525

			if var_537_22 < arg_534_1.time_ and arg_534_1.time_ <= var_537_22 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0

				arg_534_1.dialog_:SetActive(true)

				arg_534_1.dialogCg_.alpha = 0

				local var_537_24 = LeanTween.value(arg_534_1.dialog_, 0, 1, 0.3)

				var_537_24:setOnUpdate(LuaHelper.FloatAction(function(arg_538_0)
					arg_534_1.dialogCg_.alpha = arg_538_0
				end))
				var_537_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_534_1.dialog_)
					var_537_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_534_1.duration_ = arg_534_1.duration_ + 0.3

				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_25 = arg_534_1:FormatText(StoryNameCfg[613].name)

				arg_534_1.leftNameTxt_.text = var_537_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_26 = arg_534_1:GetWordFromCfg(322281131)
				local var_537_27 = arg_534_1:FormatText(var_537_26.content)

				arg_534_1.text_.text = var_537_27

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_28 = 21
				local var_537_29 = utf8.len(var_537_27)
				local var_537_30 = var_537_28 <= 0 and var_537_23 or var_537_23 * (var_537_29 / var_537_28)

				if var_537_30 > 0 and var_537_23 < var_537_30 then
					arg_534_1.talkMaxDuration = var_537_30
					var_537_22 = var_537_22 + 0.3

					if var_537_30 + var_537_22 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_30 + var_537_22
					end
				end

				arg_534_1.text_.text = var_537_27
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281131", "story_v_out_322281.awb") ~= 0 then
					local var_537_31 = manager.audio:GetVoiceLength("story_v_out_322281", "322281131", "story_v_out_322281.awb") / 1000

					if var_537_31 + var_537_22 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_31 + var_537_22
					end

					if var_537_26.prefab_name ~= "" and arg_534_1.actors_[var_537_26.prefab_name] ~= nil then
						local var_537_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_26.prefab_name].transform, "story_v_out_322281", "322281131", "story_v_out_322281.awb")

						arg_534_1:RecordAudio("322281131", var_537_32)
						arg_534_1:RecordAudio("322281131", var_537_32)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_322281", "322281131", "story_v_out_322281.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_322281", "322281131", "story_v_out_322281.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_33 = var_537_22 + 0.3
			local var_537_34 = math.max(var_537_23, arg_534_1.talkMaxDuration)

			if var_537_33 <= arg_534_1.time_ and arg_534_1.time_ < var_537_33 + var_537_34 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_33) / var_537_34

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_33 + var_537_34 and arg_534_1.time_ < var_537_33 + var_537_34 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play322281132 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 322281132
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play322281133(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1020ui_story"].transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.var_.moveOldPos1020ui_story = var_543_0.localPosition
			end

			local var_543_2 = 0.001

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2
				local var_543_4 = Vector3.New(0, 100, 0)

				var_543_0.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1020ui_story, var_543_4, var_543_3)

				local var_543_5 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_5.x, var_543_5.y, var_543_5.z)

				local var_543_6 = var_543_0.localEulerAngles

				var_543_6.z = 0
				var_543_6.x = 0
				var_543_0.localEulerAngles = var_543_6
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 then
				var_543_0.localPosition = Vector3.New(0, 100, 0)

				local var_543_7 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_7.x, var_543_7.y, var_543_7.z)

				local var_543_8 = var_543_0.localEulerAngles

				var_543_8.z = 0
				var_543_8.x = 0
				var_543_0.localEulerAngles = var_543_8
			end

			local var_543_9 = 0
			local var_543_10 = 0.625

			if var_543_9 < arg_540_1.time_ and arg_540_1.time_ <= var_543_9 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_11 = arg_540_1:GetWordFromCfg(322281132)
				local var_543_12 = arg_540_1:FormatText(var_543_11.content)

				arg_540_1.text_.text = var_543_12

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_13 = 25
				local var_543_14 = utf8.len(var_543_12)
				local var_543_15 = var_543_13 <= 0 and var_543_10 or var_543_10 * (var_543_14 / var_543_13)

				if var_543_15 > 0 and var_543_10 < var_543_15 then
					arg_540_1.talkMaxDuration = var_543_15

					if var_543_15 + var_543_9 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_15 + var_543_9
					end
				end

				arg_540_1.text_.text = var_543_12
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_16 = math.max(var_543_10, arg_540_1.talkMaxDuration)

			if var_543_9 <= arg_540_1.time_ and arg_540_1.time_ < var_543_9 + var_543_16 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_9) / var_543_16

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_9 + var_543_16 and arg_540_1.time_ < var_543_9 + var_543_16 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_540_1:InitPlayNodeList()
	end,
	Play322281133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 322281133
		arg_544_1.duration_ = 5.8

		local var_544_0 = {
			zh = 5.1,
			ja = 5.8
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play322281134(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["1020ui_story"]
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1020ui_story == nil then
				arg_544_1.var_.characterEffect1020ui_story = var_547_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_2 = 0.200000002980232

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 and not isNil(var_547_0) then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2

				if arg_544_1.var_.characterEffect1020ui_story and not isNil(var_547_0) then
					arg_544_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1020ui_story then
				arg_544_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_547_4 = arg_544_1.actors_["1020ui_story"].transform
			local var_547_5 = 0

			if var_547_5 < arg_544_1.time_ and arg_544_1.time_ <= var_547_5 + arg_547_0 then
				arg_544_1.var_.moveOldPos1020ui_story = var_547_4.localPosition
			end

			local var_547_6 = 0.001

			if var_547_5 <= arg_544_1.time_ and arg_544_1.time_ < var_547_5 + var_547_6 then
				local var_547_7 = (arg_544_1.time_ - var_547_5) / var_547_6
				local var_547_8 = Vector3.New(0, -0.85, -6.25)

				var_547_4.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1020ui_story, var_547_8, var_547_7)

				local var_547_9 = manager.ui.mainCamera.transform.position - var_547_4.position

				var_547_4.forward = Vector3.New(var_547_9.x, var_547_9.y, var_547_9.z)

				local var_547_10 = var_547_4.localEulerAngles

				var_547_10.z = 0
				var_547_10.x = 0
				var_547_4.localEulerAngles = var_547_10
			end

			if arg_544_1.time_ >= var_547_5 + var_547_6 and arg_544_1.time_ < var_547_5 + var_547_6 + arg_547_0 then
				var_547_4.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_547_11 = manager.ui.mainCamera.transform.position - var_547_4.position

				var_547_4.forward = Vector3.New(var_547_11.x, var_547_11.y, var_547_11.z)

				local var_547_12 = var_547_4.localEulerAngles

				var_547_12.z = 0
				var_547_12.x = 0
				var_547_4.localEulerAngles = var_547_12
			end

			local var_547_13 = 0

			if var_547_13 < arg_544_1.time_ and arg_544_1.time_ <= var_547_13 + arg_547_0 then
				arg_544_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			local var_547_14 = 0

			if var_547_14 < arg_544_1.time_ and arg_544_1.time_ <= var_547_14 + arg_547_0 then
				arg_544_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_547_15 = 0
			local var_547_16 = 0.5

			if var_547_15 < arg_544_1.time_ and arg_544_1.time_ <= var_547_15 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_17 = arg_544_1:FormatText(StoryNameCfg[613].name)

				arg_544_1.leftNameTxt_.text = var_547_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_18 = arg_544_1:GetWordFromCfg(322281133)
				local var_547_19 = arg_544_1:FormatText(var_547_18.content)

				arg_544_1.text_.text = var_547_19

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_20 = 20
				local var_547_21 = utf8.len(var_547_19)
				local var_547_22 = var_547_20 <= 0 and var_547_16 or var_547_16 * (var_547_21 / var_547_20)

				if var_547_22 > 0 and var_547_16 < var_547_22 then
					arg_544_1.talkMaxDuration = var_547_22

					if var_547_22 + var_547_15 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_22 + var_547_15
					end
				end

				arg_544_1.text_.text = var_547_19
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281133", "story_v_out_322281.awb") ~= 0 then
					local var_547_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281133", "story_v_out_322281.awb") / 1000

					if var_547_23 + var_547_15 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_23 + var_547_15
					end

					if var_547_18.prefab_name ~= "" and arg_544_1.actors_[var_547_18.prefab_name] ~= nil then
						local var_547_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_18.prefab_name].transform, "story_v_out_322281", "322281133", "story_v_out_322281.awb")

						arg_544_1:RecordAudio("322281133", var_547_24)
						arg_544_1:RecordAudio("322281133", var_547_24)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_322281", "322281133", "story_v_out_322281.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_322281", "322281133", "story_v_out_322281.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_25 = math.max(var_547_16, arg_544_1.talkMaxDuration)

			if var_547_15 <= arg_544_1.time_ and arg_544_1.time_ < var_547_15 + var_547_25 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_15) / var_547_25

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_15 + var_547_25 and arg_544_1.time_ < var_547_15 + var_547_25 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play322281134 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 322281134
		arg_548_1.duration_ = 9

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play322281135(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 4

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.allBtn_.enabled = false
			end

			local var_551_1 = 1.23333333333333

			if arg_548_1.time_ >= var_551_0 + var_551_1 and arg_548_1.time_ < var_551_0 + var_551_1 + arg_551_0 then
				arg_548_1.allBtn_.enabled = true
			end

			local var_551_2 = "L10i"

			if arg_548_1.bgs_[var_551_2] == nil then
				local var_551_3 = Object.Instantiate(arg_548_1.paintGo_)

				var_551_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_551_2)
				var_551_3.name = var_551_2
				var_551_3.transform.parent = arg_548_1.stage_.transform
				var_551_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_548_1.bgs_[var_551_2] = var_551_3
			end

			local var_551_4 = 2

			if var_551_4 < arg_548_1.time_ and arg_548_1.time_ <= var_551_4 + arg_551_0 then
				local var_551_5 = manager.ui.mainCamera.transform.localPosition
				local var_551_6 = Vector3.New(0, 0, 10) + Vector3.New(var_551_5.x, var_551_5.y, 0)
				local var_551_7 = arg_548_1.bgs_.L10i

				var_551_7.transform.localPosition = var_551_6
				var_551_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_551_8 = var_551_7:GetComponent("SpriteRenderer")

				if var_551_8 and var_551_8.sprite then
					local var_551_9 = (var_551_7.transform.localPosition - var_551_5).z
					local var_551_10 = manager.ui.mainCameraCom_
					local var_551_11 = 2 * var_551_9 * Mathf.Tan(var_551_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_551_12 = var_551_11 * var_551_10.aspect
					local var_551_13 = var_551_8.sprite.bounds.size.x
					local var_551_14 = var_551_8.sprite.bounds.size.y
					local var_551_15 = var_551_12 / var_551_13
					local var_551_16 = var_551_11 / var_551_14
					local var_551_17 = var_551_16 < var_551_15 and var_551_15 or var_551_16

					var_551_7.transform.localScale = Vector3.New(var_551_17, var_551_17, 0)
				end

				for iter_551_0, iter_551_1 in pairs(arg_548_1.bgs_) do
					if iter_551_0 ~= "L10i" then
						iter_551_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_551_18 = 0

			if var_551_18 < arg_548_1.time_ and arg_548_1.time_ <= var_551_18 + arg_551_0 then
				arg_548_1.mask_.enabled = true
				arg_548_1.mask_.raycastTarget = true

				arg_548_1:SetGaussion(false)
			end

			local var_551_19 = 2

			if var_551_18 <= arg_548_1.time_ and arg_548_1.time_ < var_551_18 + var_551_19 then
				local var_551_20 = (arg_548_1.time_ - var_551_18) / var_551_19
				local var_551_21 = Color.New(0, 0, 0)

				var_551_21.a = Mathf.Lerp(0, 1, var_551_20)
				arg_548_1.mask_.color = var_551_21
			end

			if arg_548_1.time_ >= var_551_18 + var_551_19 and arg_548_1.time_ < var_551_18 + var_551_19 + arg_551_0 then
				local var_551_22 = Color.New(0, 0, 0)

				var_551_22.a = 1
				arg_548_1.mask_.color = var_551_22
			end

			local var_551_23 = 2

			if var_551_23 < arg_548_1.time_ and arg_548_1.time_ <= var_551_23 + arg_551_0 then
				arg_548_1.mask_.enabled = true
				arg_548_1.mask_.raycastTarget = true

				arg_548_1:SetGaussion(false)
			end

			local var_551_24 = 2

			if var_551_23 <= arg_548_1.time_ and arg_548_1.time_ < var_551_23 + var_551_24 then
				local var_551_25 = (arg_548_1.time_ - var_551_23) / var_551_24
				local var_551_26 = Color.New(0, 0, 0)

				var_551_26.a = Mathf.Lerp(1, 0, var_551_25)
				arg_548_1.mask_.color = var_551_26
			end

			if arg_548_1.time_ >= var_551_23 + var_551_24 and arg_548_1.time_ < var_551_23 + var_551_24 + arg_551_0 then
				local var_551_27 = Color.New(0, 0, 0)
				local var_551_28 = 0

				arg_548_1.mask_.enabled = false
				var_551_27.a = var_551_28
				arg_548_1.mask_.color = var_551_27
			end

			local var_551_29 = arg_548_1.actors_["1020ui_story"].transform
			local var_551_30 = 2

			if var_551_30 < arg_548_1.time_ and arg_548_1.time_ <= var_551_30 + arg_551_0 then
				arg_548_1.var_.moveOldPos1020ui_story = var_551_29.localPosition
			end

			local var_551_31 = 0.001

			if var_551_30 <= arg_548_1.time_ and arg_548_1.time_ < var_551_30 + var_551_31 then
				local var_551_32 = (arg_548_1.time_ - var_551_30) / var_551_31
				local var_551_33 = Vector3.New(0, 100, 0)

				var_551_29.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1020ui_story, var_551_33, var_551_32)

				local var_551_34 = manager.ui.mainCamera.transform.position - var_551_29.position

				var_551_29.forward = Vector3.New(var_551_34.x, var_551_34.y, var_551_34.z)

				local var_551_35 = var_551_29.localEulerAngles

				var_551_35.z = 0
				var_551_35.x = 0
				var_551_29.localEulerAngles = var_551_35
			end

			if arg_548_1.time_ >= var_551_30 + var_551_31 and arg_548_1.time_ < var_551_30 + var_551_31 + arg_551_0 then
				var_551_29.localPosition = Vector3.New(0, 100, 0)

				local var_551_36 = manager.ui.mainCamera.transform.position - var_551_29.position

				var_551_29.forward = Vector3.New(var_551_36.x, var_551_36.y, var_551_36.z)

				local var_551_37 = var_551_29.localEulerAngles

				var_551_37.z = 0
				var_551_37.x = 0
				var_551_29.localEulerAngles = var_551_37
			end

			local var_551_38 = 0.2
			local var_551_39 = 1

			if var_551_38 < arg_548_1.time_ and arg_548_1.time_ <= var_551_38 + arg_551_0 then
				local var_551_40 = "stop"
				local var_551_41 = "effect"

				arg_548_1:AudioAction(var_551_40, var_551_41, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_551_42 = 1.56666666666667
			local var_551_43 = 1

			if var_551_42 < arg_548_1.time_ and arg_548_1.time_ <= var_551_42 + arg_551_0 then
				local var_551_44 = "play"
				local var_551_45 = "effect"

				arg_548_1:AudioAction(var_551_44, var_551_45, "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			local var_551_46 = "L01f"

			if arg_548_1.bgs_[var_551_46] == nil then
				local var_551_47 = Object.Instantiate(arg_548_1.blurPaintGo_)
				local var_551_48 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_551_46)

				var_551_47:GetComponent("SpriteRenderer").sprite = var_551_48
				var_551_47.name = var_551_46
				var_551_47.transform.parent = arg_548_1.stage_.transform
				var_551_47.transform.localPosition = Vector3.New(0, 100, 0)
				arg_548_1.bgs_[var_551_46] = var_551_47
			end

			local var_551_49 = 2
			local var_551_50 = arg_548_1.bgs_[var_551_46]

			if var_551_49 < arg_548_1.time_ and arg_548_1.time_ <= var_551_49 + arg_551_0 then
				local var_551_51 = manager.ui.mainCamera.transform.localPosition
				local var_551_52 = Vector3.New(0, 0, 10) + Vector3.New(var_551_51.x, var_551_51.y, 0)

				var_551_50.transform.localPosition = var_551_52
				var_551_50.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_551_53 = var_551_50:GetComponent("SpriteRenderer")

				if var_551_53 and var_551_53.sprite then
					local var_551_54 = (var_551_50.transform.localPosition - var_551_51).z
					local var_551_55 = manager.ui.mainCameraCom_
					local var_551_56 = 2 * var_551_54 * Mathf.Tan(var_551_55.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_551_57 = var_551_56 * var_551_55.aspect
					local var_551_58 = var_551_53.sprite.bounds.size.x
					local var_551_59 = var_551_53.sprite.bounds.size.y
					local var_551_60 = var_551_57 / var_551_58
					local var_551_61 = var_551_56 / var_551_59
					local var_551_62 = var_551_61 < var_551_60 and var_551_60 or var_551_61

					var_551_50.transform.localScale = Vector3.New(var_551_62, var_551_62, 0)
				end
			end

			local var_551_63 = 0.0166666666666667

			if var_551_49 <= arg_548_1.time_ and arg_548_1.time_ < var_551_49 + var_551_63 then
				local var_551_64 = (arg_548_1.time_ - var_551_49) / var_551_63
				local var_551_65 = Color.New(1, 1, 1)

				var_551_65.a = Mathf.Lerp(0, 0, var_551_64)

				var_551_50:GetComponent("SpriteRenderer").material:SetColor("_Color", var_551_65)
			end

			if arg_548_1.frameCnt_ <= 1 then
				arg_548_1.dialog_:SetActive(false)
			end

			local var_551_66 = 4
			local var_551_67 = 1.475

			if var_551_66 < arg_548_1.time_ and arg_548_1.time_ <= var_551_66 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0

				arg_548_1.dialog_:SetActive(true)

				arg_548_1.dialogCg_.alpha = 0

				local var_551_68 = LeanTween.value(arg_548_1.dialog_, 0, 1, 0.3)

				var_551_68:setOnUpdate(LuaHelper.FloatAction(function(arg_552_0)
					arg_548_1.dialogCg_.alpha = arg_552_0
				end))
				var_551_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_548_1.dialog_)
					var_551_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_548_1.duration_ = arg_548_1.duration_ + 0.3

				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_69 = arg_548_1:GetWordFromCfg(322281134)
				local var_551_70 = arg_548_1:FormatText(var_551_69.content)

				arg_548_1.text_.text = var_551_70

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_71 = 59
				local var_551_72 = utf8.len(var_551_70)
				local var_551_73 = var_551_71 <= 0 and var_551_67 or var_551_67 * (var_551_72 / var_551_71)

				if var_551_73 > 0 and var_551_67 < var_551_73 then
					arg_548_1.talkMaxDuration = var_551_73
					var_551_66 = var_551_66 + 0.3

					if var_551_73 + var_551_66 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_73 + var_551_66
					end
				end

				arg_548_1.text_.text = var_551_70
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_74 = var_551_66 + 0.3
			local var_551_75 = math.max(var_551_67, arg_548_1.talkMaxDuration)

			if var_551_74 <= arg_548_1.time_ and arg_548_1.time_ < var_551_74 + var_551_75 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_74) / var_551_75

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_74 + var_551_75 and arg_548_1.time_ < var_551_74 + var_551_75 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play322281135 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 322281135
		arg_554_1.duration_ = 5

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play322281136(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 1.225

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, false)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_2 = arg_554_1:GetWordFromCfg(322281135)
				local var_557_3 = arg_554_1:FormatText(var_557_2.content)

				arg_554_1.text_.text = var_557_3

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_4 = 49
				local var_557_5 = utf8.len(var_557_3)
				local var_557_6 = var_557_4 <= 0 and var_557_1 or var_557_1 * (var_557_5 / var_557_4)

				if var_557_6 > 0 and var_557_1 < var_557_6 then
					arg_554_1.talkMaxDuration = var_557_6

					if var_557_6 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_6 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_3
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_7 and arg_554_1.time_ < var_557_0 + var_557_7 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play322281136 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 322281136
		arg_558_1.duration_ = 2.73

		local var_558_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play322281137(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = "6056ui_story"

			if arg_558_1.actors_[var_561_0] == nil then
				local var_561_1 = Asset.Load("Char/" .. "6056ui_story")

				if not isNil(var_561_1) then
					local var_561_2 = Object.Instantiate(Asset.Load("Char/" .. "6056ui_story"), arg_558_1.stage_.transform)

					var_561_2.name = var_561_0
					var_561_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_558_1.actors_[var_561_0] = var_561_2

					local var_561_3 = var_561_2:GetComponentInChildren(typeof(CharacterEffect))

					var_561_3.enabled = true

					local var_561_4 = GameObjectTools.GetOrAddComponent(var_561_2, typeof(DynamicBoneHelper))

					if var_561_4 then
						var_561_4:EnableDynamicBone(false)
					end

					arg_558_1:ShowWeapon(var_561_3.transform, false)

					arg_558_1.var_[var_561_0 .. "Animator"] = var_561_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_558_1.var_[var_561_0 .. "Animator"].applyRootMotion = true
					arg_558_1.var_[var_561_0 .. "LipSync"] = var_561_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_561_5 = arg_558_1.actors_["6056ui_story"].transform
			local var_561_6 = 0

			if var_561_6 < arg_558_1.time_ and arg_558_1.time_ <= var_561_6 + arg_561_0 then
				arg_558_1.var_.moveOldPos6056ui_story = var_561_5.localPosition
			end

			local var_561_7 = 0.001

			if var_561_6 <= arg_558_1.time_ and arg_558_1.time_ < var_561_6 + var_561_7 then
				local var_561_8 = (arg_558_1.time_ - var_561_6) / var_561_7
				local var_561_9 = Vector3.New(0.15, -1.16, -6.15)

				var_561_5.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos6056ui_story, var_561_9, var_561_8)

				local var_561_10 = manager.ui.mainCamera.transform.position - var_561_5.position

				var_561_5.forward = Vector3.New(var_561_10.x, var_561_10.y, var_561_10.z)

				local var_561_11 = var_561_5.localEulerAngles

				var_561_11.z = 0
				var_561_11.x = 0
				var_561_5.localEulerAngles = var_561_11
			end

			if arg_558_1.time_ >= var_561_6 + var_561_7 and arg_558_1.time_ < var_561_6 + var_561_7 + arg_561_0 then
				var_561_5.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_561_12 = manager.ui.mainCamera.transform.position - var_561_5.position

				var_561_5.forward = Vector3.New(var_561_12.x, var_561_12.y, var_561_12.z)

				local var_561_13 = var_561_5.localEulerAngles

				var_561_13.z = 0
				var_561_13.x = 0
				var_561_5.localEulerAngles = var_561_13
			end

			local var_561_14 = arg_558_1.actors_["6056ui_story"]
			local var_561_15 = 0

			if var_561_15 < arg_558_1.time_ and arg_558_1.time_ <= var_561_15 + arg_561_0 and not isNil(var_561_14) and arg_558_1.var_.characterEffect6056ui_story == nil then
				arg_558_1.var_.characterEffect6056ui_story = var_561_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_16 = 0.200000002980232

			if var_561_15 <= arg_558_1.time_ and arg_558_1.time_ < var_561_15 + var_561_16 and not isNil(var_561_14) then
				local var_561_17 = (arg_558_1.time_ - var_561_15) / var_561_16

				if arg_558_1.var_.characterEffect6056ui_story and not isNil(var_561_14) then
					arg_558_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_558_1.time_ >= var_561_15 + var_561_16 and arg_558_1.time_ < var_561_15 + var_561_16 + arg_561_0 and not isNil(var_561_14) and arg_558_1.var_.characterEffect6056ui_story then
				arg_558_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_561_18 = 0

			if var_561_18 < arg_558_1.time_ and arg_558_1.time_ <= var_561_18 + arg_561_0 then
				arg_558_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			local var_561_19 = 0

			if var_561_19 < arg_558_1.time_ and arg_558_1.time_ <= var_561_19 + arg_561_0 then
				arg_558_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_561_20 = 0
			local var_561_21 = 0.2

			if var_561_20 < arg_558_1.time_ and arg_558_1.time_ <= var_561_20 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_22 = arg_558_1:FormatText(StoryNameCfg[613].name)

				arg_558_1.leftNameTxt_.text = var_561_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_23 = arg_558_1:GetWordFromCfg(322281136)
				local var_561_24 = arg_558_1:FormatText(var_561_23.content)

				arg_558_1.text_.text = var_561_24

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_25 = 8
				local var_561_26 = utf8.len(var_561_24)
				local var_561_27 = var_561_25 <= 0 and var_561_21 or var_561_21 * (var_561_26 / var_561_25)

				if var_561_27 > 0 and var_561_21 < var_561_27 then
					arg_558_1.talkMaxDuration = var_561_27

					if var_561_27 + var_561_20 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_27 + var_561_20
					end
				end

				arg_558_1.text_.text = var_561_24
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281136", "story_v_out_322281.awb") ~= 0 then
					local var_561_28 = manager.audio:GetVoiceLength("story_v_out_322281", "322281136", "story_v_out_322281.awb") / 1000

					if var_561_28 + var_561_20 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_28 + var_561_20
					end

					if var_561_23.prefab_name ~= "" and arg_558_1.actors_[var_561_23.prefab_name] ~= nil then
						local var_561_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_23.prefab_name].transform, "story_v_out_322281", "322281136", "story_v_out_322281.awb")

						arg_558_1:RecordAudio("322281136", var_561_29)
						arg_558_1:RecordAudio("322281136", var_561_29)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_322281", "322281136", "story_v_out_322281.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_322281", "322281136", "story_v_out_322281.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_30 = math.max(var_561_21, arg_558_1.talkMaxDuration)

			if var_561_20 <= arg_558_1.time_ and arg_558_1.time_ < var_561_20 + var_561_30 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_20) / var_561_30

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_20 + var_561_30 and arg_558_1.time_ < var_561_20 + var_561_30 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_558_1:InitPlayNodeList()
	end,
	Play322281137 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 322281137
		arg_562_1.duration_ = 3.4

		local var_562_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play322281138(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = "10131ui_story"

			if arg_562_1.actors_[var_565_0] == nil then
				local var_565_1 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_565_1) then
					local var_565_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_562_1.stage_.transform)

					var_565_2.name = var_565_0
					var_565_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_562_1.actors_[var_565_0] = var_565_2

					local var_565_3 = var_565_2:GetComponentInChildren(typeof(CharacterEffect))

					var_565_3.enabled = true

					local var_565_4 = GameObjectTools.GetOrAddComponent(var_565_2, typeof(DynamicBoneHelper))

					if var_565_4 then
						var_565_4:EnableDynamicBone(false)
					end

					arg_562_1:ShowWeapon(var_565_3.transform, false)

					arg_562_1.var_[var_565_0 .. "Animator"] = var_565_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_562_1.var_[var_565_0 .. "Animator"].applyRootMotion = true
					arg_562_1.var_[var_565_0 .. "LipSync"] = var_565_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_565_5 = arg_562_1.actors_["10131ui_story"].transform
			local var_565_6 = 0

			if var_565_6 < arg_562_1.time_ and arg_562_1.time_ <= var_565_6 + arg_565_0 then
				arg_562_1.var_.moveOldPos10131ui_story = var_565_5.localPosition
			end

			local var_565_7 = 0.001

			if var_565_6 <= arg_562_1.time_ and arg_562_1.time_ < var_565_6 + var_565_7 then
				local var_565_8 = (arg_562_1.time_ - var_565_6) / var_565_7
				local var_565_9 = Vector3.New(0.83, -0.96, -5.8)

				var_565_5.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos10131ui_story, var_565_9, var_565_8)

				local var_565_10 = manager.ui.mainCamera.transform.position - var_565_5.position

				var_565_5.forward = Vector3.New(var_565_10.x, var_565_10.y, var_565_10.z)

				local var_565_11 = var_565_5.localEulerAngles

				var_565_11.z = 0
				var_565_11.x = 0
				var_565_5.localEulerAngles = var_565_11
			end

			if arg_562_1.time_ >= var_565_6 + var_565_7 and arg_562_1.time_ < var_565_6 + var_565_7 + arg_565_0 then
				var_565_5.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_565_12 = manager.ui.mainCamera.transform.position - var_565_5.position

				var_565_5.forward = Vector3.New(var_565_12.x, var_565_12.y, var_565_12.z)

				local var_565_13 = var_565_5.localEulerAngles

				var_565_13.z = 0
				var_565_13.x = 0
				var_565_5.localEulerAngles = var_565_13
			end

			local var_565_14 = arg_562_1.actors_["6056ui_story"].transform
			local var_565_15 = 0

			if var_565_15 < arg_562_1.time_ and arg_562_1.time_ <= var_565_15 + arg_565_0 then
				arg_562_1.var_.moveOldPos6056ui_story = var_565_14.localPosition
			end

			local var_565_16 = 0.001

			if var_565_15 <= arg_562_1.time_ and arg_562_1.time_ < var_565_15 + var_565_16 then
				local var_565_17 = (arg_562_1.time_ - var_565_15) / var_565_16
				local var_565_18 = Vector3.New(-0.85, -1.16, -6.15)

				var_565_14.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos6056ui_story, var_565_18, var_565_17)

				local var_565_19 = manager.ui.mainCamera.transform.position - var_565_14.position

				var_565_14.forward = Vector3.New(var_565_19.x, var_565_19.y, var_565_19.z)

				local var_565_20 = var_565_14.localEulerAngles

				var_565_20.z = 0
				var_565_20.x = 0
				var_565_14.localEulerAngles = var_565_20
			end

			if arg_562_1.time_ >= var_565_15 + var_565_16 and arg_562_1.time_ < var_565_15 + var_565_16 + arg_565_0 then
				var_565_14.localPosition = Vector3.New(-0.85, -1.16, -6.15)

				local var_565_21 = manager.ui.mainCamera.transform.position - var_565_14.position

				var_565_14.forward = Vector3.New(var_565_21.x, var_565_21.y, var_565_21.z)

				local var_565_22 = var_565_14.localEulerAngles

				var_565_22.z = 0
				var_565_22.x = 0
				var_565_14.localEulerAngles = var_565_22
			end

			local var_565_23 = arg_562_1.actors_["10131ui_story"]
			local var_565_24 = 0

			if var_565_24 < arg_562_1.time_ and arg_562_1.time_ <= var_565_24 + arg_565_0 and not isNil(var_565_23) and arg_562_1.var_.characterEffect10131ui_story == nil then
				arg_562_1.var_.characterEffect10131ui_story = var_565_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_25 = 0.200000002980232

			if var_565_24 <= arg_562_1.time_ and arg_562_1.time_ < var_565_24 + var_565_25 and not isNil(var_565_23) then
				local var_565_26 = (arg_562_1.time_ - var_565_24) / var_565_25

				if arg_562_1.var_.characterEffect10131ui_story and not isNil(var_565_23) then
					arg_562_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= var_565_24 + var_565_25 and arg_562_1.time_ < var_565_24 + var_565_25 + arg_565_0 and not isNil(var_565_23) and arg_562_1.var_.characterEffect10131ui_story then
				arg_562_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_565_27 = arg_562_1.actors_["6056ui_story"]
			local var_565_28 = 0

			if var_565_28 < arg_562_1.time_ and arg_562_1.time_ <= var_565_28 + arg_565_0 and not isNil(var_565_27) and arg_562_1.var_.characterEffect6056ui_story == nil then
				arg_562_1.var_.characterEffect6056ui_story = var_565_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_29 = 0.200000002980232

			if var_565_28 <= arg_562_1.time_ and arg_562_1.time_ < var_565_28 + var_565_29 and not isNil(var_565_27) then
				local var_565_30 = (arg_562_1.time_ - var_565_28) / var_565_29

				if arg_562_1.var_.characterEffect6056ui_story and not isNil(var_565_27) then
					local var_565_31 = Mathf.Lerp(0, 0.5, var_565_30)

					arg_562_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_562_1.var_.characterEffect6056ui_story.fillRatio = var_565_31
				end
			end

			if arg_562_1.time_ >= var_565_28 + var_565_29 and arg_562_1.time_ < var_565_28 + var_565_29 + arg_565_0 and not isNil(var_565_27) and arg_562_1.var_.characterEffect6056ui_story then
				local var_565_32 = 0.5

				arg_562_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_562_1.var_.characterEffect6056ui_story.fillRatio = var_565_32
			end

			local var_565_33 = 0

			if var_565_33 < arg_562_1.time_ and arg_562_1.time_ <= var_565_33 + arg_565_0 then
				arg_562_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_565_34 = 0
			local var_565_35 = 0.175

			if var_565_34 < arg_562_1.time_ and arg_562_1.time_ <= var_565_34 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_36 = arg_562_1:FormatText(StoryNameCfg[1366].name)

				arg_562_1.leftNameTxt_.text = var_565_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_37 = arg_562_1:GetWordFromCfg(322281137)
				local var_565_38 = arg_562_1:FormatText(var_565_37.content)

				arg_562_1.text_.text = var_565_38

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_39 = 7
				local var_565_40 = utf8.len(var_565_38)
				local var_565_41 = var_565_39 <= 0 and var_565_35 or var_565_35 * (var_565_40 / var_565_39)

				if var_565_41 > 0 and var_565_35 < var_565_41 then
					arg_562_1.talkMaxDuration = var_565_41

					if var_565_41 + var_565_34 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_41 + var_565_34
					end
				end

				arg_562_1.text_.text = var_565_38
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281137", "story_v_out_322281.awb") ~= 0 then
					local var_565_42 = manager.audio:GetVoiceLength("story_v_out_322281", "322281137", "story_v_out_322281.awb") / 1000

					if var_565_42 + var_565_34 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_42 + var_565_34
					end

					if var_565_37.prefab_name ~= "" and arg_562_1.actors_[var_565_37.prefab_name] ~= nil then
						local var_565_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_37.prefab_name].transform, "story_v_out_322281", "322281137", "story_v_out_322281.awb")

						arg_562_1:RecordAudio("322281137", var_565_43)
						arg_562_1:RecordAudio("322281137", var_565_43)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_322281", "322281137", "story_v_out_322281.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_322281", "322281137", "story_v_out_322281.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_44 = math.max(var_565_35, arg_562_1.talkMaxDuration)

			if var_565_34 <= arg_562_1.time_ and arg_562_1.time_ < var_565_34 + var_565_44 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_34) / var_565_44

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_34 + var_565_44 and arg_562_1.time_ < var_565_34 + var_565_44 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play322281138 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 322281138
		arg_566_1.duration_ = 11.43

		local var_566_0 = {
			zh = 7.3,
			ja = 11.433
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play322281139(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = arg_566_1.actors_["6056ui_story"]
			local var_569_1 = 0

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 and not isNil(var_569_0) and arg_566_1.var_.characterEffect6056ui_story == nil then
				arg_566_1.var_.characterEffect6056ui_story = var_569_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_2 = 0.200000002980232

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_2 and not isNil(var_569_0) then
				local var_569_3 = (arg_566_1.time_ - var_569_1) / var_569_2

				if arg_566_1.var_.characterEffect6056ui_story and not isNil(var_569_0) then
					arg_566_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= var_569_1 + var_569_2 and arg_566_1.time_ < var_569_1 + var_569_2 + arg_569_0 and not isNil(var_569_0) and arg_566_1.var_.characterEffect6056ui_story then
				arg_566_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_569_4 = arg_566_1.actors_["10131ui_story"]
			local var_569_5 = 0

			if var_569_5 < arg_566_1.time_ and arg_566_1.time_ <= var_569_5 + arg_569_0 and not isNil(var_569_4) and arg_566_1.var_.characterEffect10131ui_story == nil then
				arg_566_1.var_.characterEffect10131ui_story = var_569_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_6 = 0.200000002980232

			if var_569_5 <= arg_566_1.time_ and arg_566_1.time_ < var_569_5 + var_569_6 and not isNil(var_569_4) then
				local var_569_7 = (arg_566_1.time_ - var_569_5) / var_569_6

				if arg_566_1.var_.characterEffect10131ui_story and not isNil(var_569_4) then
					local var_569_8 = Mathf.Lerp(0, 0.5, var_569_7)

					arg_566_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_566_1.var_.characterEffect10131ui_story.fillRatio = var_569_8
				end
			end

			if arg_566_1.time_ >= var_569_5 + var_569_6 and arg_566_1.time_ < var_569_5 + var_569_6 + arg_569_0 and not isNil(var_569_4) and arg_566_1.var_.characterEffect10131ui_story then
				local var_569_9 = 0.5

				arg_566_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_566_1.var_.characterEffect10131ui_story.fillRatio = var_569_9
			end

			local var_569_10 = 0

			if var_569_10 < arg_566_1.time_ and arg_566_1.time_ <= var_569_10 + arg_569_0 then
				arg_566_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action5_1")
			end

			local var_569_11 = 0
			local var_569_12 = 0.725

			if var_569_11 < arg_566_1.time_ and arg_566_1.time_ <= var_569_11 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_13 = arg_566_1:FormatText(StoryNameCfg[613].name)

				arg_566_1.leftNameTxt_.text = var_569_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_14 = arg_566_1:GetWordFromCfg(322281138)
				local var_569_15 = arg_566_1:FormatText(var_569_14.content)

				arg_566_1.text_.text = var_569_15

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_16 = 29
				local var_569_17 = utf8.len(var_569_15)
				local var_569_18 = var_569_16 <= 0 and var_569_12 or var_569_12 * (var_569_17 / var_569_16)

				if var_569_18 > 0 and var_569_12 < var_569_18 then
					arg_566_1.talkMaxDuration = var_569_18

					if var_569_18 + var_569_11 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_18 + var_569_11
					end
				end

				arg_566_1.text_.text = var_569_15
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281138", "story_v_out_322281.awb") ~= 0 then
					local var_569_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281138", "story_v_out_322281.awb") / 1000

					if var_569_19 + var_569_11 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_19 + var_569_11
					end

					if var_569_14.prefab_name ~= "" and arg_566_1.actors_[var_569_14.prefab_name] ~= nil then
						local var_569_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_14.prefab_name].transform, "story_v_out_322281", "322281138", "story_v_out_322281.awb")

						arg_566_1:RecordAudio("322281138", var_569_20)
						arg_566_1:RecordAudio("322281138", var_569_20)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_322281", "322281138", "story_v_out_322281.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_322281", "322281138", "story_v_out_322281.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_21 = math.max(var_569_12, arg_566_1.talkMaxDuration)

			if var_569_11 <= arg_566_1.time_ and arg_566_1.time_ < var_569_11 + var_569_21 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_11) / var_569_21

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_11 + var_569_21 and arg_566_1.time_ < var_569_11 + var_569_21 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play322281139 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 322281139
		arg_570_1.duration_ = 4.83

		local var_570_0 = {
			zh = 3.266,
			ja = 4.833
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play322281140(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_573_1 = 0
			local var_573_2 = 0.35

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_3 = arg_570_1:FormatText(StoryNameCfg[613].name)

				arg_570_1.leftNameTxt_.text = var_573_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_4 = arg_570_1:GetWordFromCfg(322281139)
				local var_573_5 = arg_570_1:FormatText(var_573_4.content)

				arg_570_1.text_.text = var_573_5

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_6 = 14
				local var_573_7 = utf8.len(var_573_5)
				local var_573_8 = var_573_6 <= 0 and var_573_2 or var_573_2 * (var_573_7 / var_573_6)

				if var_573_8 > 0 and var_573_2 < var_573_8 then
					arg_570_1.talkMaxDuration = var_573_8

					if var_573_8 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_8 + var_573_1
					end
				end

				arg_570_1.text_.text = var_573_5
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281139", "story_v_out_322281.awb") ~= 0 then
					local var_573_9 = manager.audio:GetVoiceLength("story_v_out_322281", "322281139", "story_v_out_322281.awb") / 1000

					if var_573_9 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_9 + var_573_1
					end

					if var_573_4.prefab_name ~= "" and arg_570_1.actors_[var_573_4.prefab_name] ~= nil then
						local var_573_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_4.prefab_name].transform, "story_v_out_322281", "322281139", "story_v_out_322281.awb")

						arg_570_1:RecordAudio("322281139", var_573_10)
						arg_570_1:RecordAudio("322281139", var_573_10)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_322281", "322281139", "story_v_out_322281.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_322281", "322281139", "story_v_out_322281.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_11 = math.max(var_573_2, arg_570_1.talkMaxDuration)

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_11 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_1) / var_573_11

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_1 + var_573_11 and arg_570_1.time_ < var_573_1 + var_573_11 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play322281140 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 322281140
		arg_574_1.duration_ = 5.07

		local var_574_0 = {
			zh = 3.7,
			ja = 5.066
		}
		local var_574_1 = manager.audio:GetLocalizationFlag()

		if var_574_0[var_574_1] ~= nil then
			arg_574_1.duration_ = var_574_0[var_574_1]
		end

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play322281141(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["10131ui_story"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect10131ui_story == nil then
				arg_574_1.var_.characterEffect10131ui_story = var_577_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_2 = 0.200000002980232

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.characterEffect10131ui_story and not isNil(var_577_0) then
					arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect10131ui_story then
				arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_577_4 = arg_574_1.actors_["6056ui_story"]
			local var_577_5 = 0

			if var_577_5 < arg_574_1.time_ and arg_574_1.time_ <= var_577_5 + arg_577_0 and not isNil(var_577_4) and arg_574_1.var_.characterEffect6056ui_story == nil then
				arg_574_1.var_.characterEffect6056ui_story = var_577_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_6 = 0.200000002980232

			if var_577_5 <= arg_574_1.time_ and arg_574_1.time_ < var_577_5 + var_577_6 and not isNil(var_577_4) then
				local var_577_7 = (arg_574_1.time_ - var_577_5) / var_577_6

				if arg_574_1.var_.characterEffect6056ui_story and not isNil(var_577_4) then
					local var_577_8 = Mathf.Lerp(0, 0.5, var_577_7)

					arg_574_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_574_1.var_.characterEffect6056ui_story.fillRatio = var_577_8
				end
			end

			if arg_574_1.time_ >= var_577_5 + var_577_6 and arg_574_1.time_ < var_577_5 + var_577_6 + arg_577_0 and not isNil(var_577_4) and arg_574_1.var_.characterEffect6056ui_story then
				local var_577_9 = 0.5

				arg_574_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_574_1.var_.characterEffect6056ui_story.fillRatio = var_577_9
			end

			local var_577_10 = 0

			if var_577_10 < arg_574_1.time_ and arg_574_1.time_ <= var_577_10 + arg_577_0 then
				arg_574_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			local var_577_11 = 0

			if var_577_11 < arg_574_1.time_ and arg_574_1.time_ <= var_577_11 + arg_577_0 then
				arg_574_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_577_12 = 0
			local var_577_13 = 0.325

			if var_577_12 < arg_574_1.time_ and arg_574_1.time_ <= var_577_12 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_14 = arg_574_1:FormatText(StoryNameCfg[1366].name)

				arg_574_1.leftNameTxt_.text = var_577_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_15 = arg_574_1:GetWordFromCfg(322281140)
				local var_577_16 = arg_574_1:FormatText(var_577_15.content)

				arg_574_1.text_.text = var_577_16

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_17 = 13
				local var_577_18 = utf8.len(var_577_16)
				local var_577_19 = var_577_17 <= 0 and var_577_13 or var_577_13 * (var_577_18 / var_577_17)

				if var_577_19 > 0 and var_577_13 < var_577_19 then
					arg_574_1.talkMaxDuration = var_577_19

					if var_577_19 + var_577_12 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_19 + var_577_12
					end
				end

				arg_574_1.text_.text = var_577_16
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281140", "story_v_out_322281.awb") ~= 0 then
					local var_577_20 = manager.audio:GetVoiceLength("story_v_out_322281", "322281140", "story_v_out_322281.awb") / 1000

					if var_577_20 + var_577_12 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_20 + var_577_12
					end

					if var_577_15.prefab_name ~= "" and arg_574_1.actors_[var_577_15.prefab_name] ~= nil then
						local var_577_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_15.prefab_name].transform, "story_v_out_322281", "322281140", "story_v_out_322281.awb")

						arg_574_1:RecordAudio("322281140", var_577_21)
						arg_574_1:RecordAudio("322281140", var_577_21)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_out_322281", "322281140", "story_v_out_322281.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_out_322281", "322281140", "story_v_out_322281.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_22 = math.max(var_577_13, arg_574_1.talkMaxDuration)

			if var_577_12 <= arg_574_1.time_ and arg_574_1.time_ < var_577_12 + var_577_22 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_12) / var_577_22

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_12 + var_577_22 and arg_574_1.time_ < var_577_12 + var_577_22 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play322281141 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 322281141
		arg_578_1.duration_ = 4.67

		local var_578_0 = {
			zh = 1.999999999999,
			ja = 4.666
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play322281142(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["6056ui_story"]
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect6056ui_story == nil then
				arg_578_1.var_.characterEffect6056ui_story = var_581_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.200000002980232

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 and not isNil(var_581_0) then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2

				if arg_578_1.var_.characterEffect6056ui_story and not isNil(var_581_0) then
					arg_578_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect6056ui_story then
				arg_578_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_581_4 = arg_578_1.actors_["10131ui_story"]
			local var_581_5 = 0

			if var_581_5 < arg_578_1.time_ and arg_578_1.time_ <= var_581_5 + arg_581_0 and not isNil(var_581_4) and arg_578_1.var_.characterEffect10131ui_story == nil then
				arg_578_1.var_.characterEffect10131ui_story = var_581_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_6 = 0.200000002980232

			if var_581_5 <= arg_578_1.time_ and arg_578_1.time_ < var_581_5 + var_581_6 and not isNil(var_581_4) then
				local var_581_7 = (arg_578_1.time_ - var_581_5) / var_581_6

				if arg_578_1.var_.characterEffect10131ui_story and not isNil(var_581_4) then
					local var_581_8 = Mathf.Lerp(0, 0.5, var_581_7)

					arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_578_1.var_.characterEffect10131ui_story.fillRatio = var_581_8
				end
			end

			if arg_578_1.time_ >= var_581_5 + var_581_6 and arg_578_1.time_ < var_581_5 + var_581_6 + arg_581_0 and not isNil(var_581_4) and arg_578_1.var_.characterEffect10131ui_story then
				local var_581_9 = 0.5

				arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_578_1.var_.characterEffect10131ui_story.fillRatio = var_581_9
			end

			local var_581_10 = 0

			if var_581_10 < arg_578_1.time_ and arg_578_1.time_ <= var_581_10 + arg_581_0 then
				arg_578_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action5_2")
			end

			local var_581_11 = 0
			local var_581_12 = 0.225

			if var_581_11 < arg_578_1.time_ and arg_578_1.time_ <= var_581_11 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_13 = arg_578_1:FormatText(StoryNameCfg[613].name)

				arg_578_1.leftNameTxt_.text = var_581_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_14 = arg_578_1:GetWordFromCfg(322281141)
				local var_581_15 = arg_578_1:FormatText(var_581_14.content)

				arg_578_1.text_.text = var_581_15

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_16 = 9
				local var_581_17 = utf8.len(var_581_15)
				local var_581_18 = var_581_16 <= 0 and var_581_12 or var_581_12 * (var_581_17 / var_581_16)

				if var_581_18 > 0 and var_581_12 < var_581_18 then
					arg_578_1.talkMaxDuration = var_581_18

					if var_581_18 + var_581_11 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_18 + var_581_11
					end
				end

				arg_578_1.text_.text = var_581_15
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281141", "story_v_out_322281.awb") ~= 0 then
					local var_581_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281141", "story_v_out_322281.awb") / 1000

					if var_581_19 + var_581_11 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_19 + var_581_11
					end

					if var_581_14.prefab_name ~= "" and arg_578_1.actors_[var_581_14.prefab_name] ~= nil then
						local var_581_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_14.prefab_name].transform, "story_v_out_322281", "322281141", "story_v_out_322281.awb")

						arg_578_1:RecordAudio("322281141", var_581_20)
						arg_578_1:RecordAudio("322281141", var_581_20)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_322281", "322281141", "story_v_out_322281.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_322281", "322281141", "story_v_out_322281.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_21 = math.max(var_581_12, arg_578_1.talkMaxDuration)

			if var_581_11 <= arg_578_1.time_ and arg_578_1.time_ < var_581_11 + var_581_21 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_11) / var_581_21

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_11 + var_581_21 and arg_578_1.time_ < var_581_11 + var_581_21 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play322281142 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 322281142
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play322281143(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["6056ui_story"].transform
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.var_.moveOldPos6056ui_story = var_585_0.localPosition
			end

			local var_585_2 = 0.001

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2
				local var_585_4 = Vector3.New(0, 100, 0)

				var_585_0.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos6056ui_story, var_585_4, var_585_3)

				local var_585_5 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_5.x, var_585_5.y, var_585_5.z)

				local var_585_6 = var_585_0.localEulerAngles

				var_585_6.z = 0
				var_585_6.x = 0
				var_585_0.localEulerAngles = var_585_6
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 then
				var_585_0.localPosition = Vector3.New(0, 100, 0)

				local var_585_7 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_7.x, var_585_7.y, var_585_7.z)

				local var_585_8 = var_585_0.localEulerAngles

				var_585_8.z = 0
				var_585_8.x = 0
				var_585_0.localEulerAngles = var_585_8
			end

			local var_585_9 = arg_582_1.actors_["10131ui_story"].transform
			local var_585_10 = 0

			if var_585_10 < arg_582_1.time_ and arg_582_1.time_ <= var_585_10 + arg_585_0 then
				arg_582_1.var_.moveOldPos10131ui_story = var_585_9.localPosition
			end

			local var_585_11 = 0.001

			if var_585_10 <= arg_582_1.time_ and arg_582_1.time_ < var_585_10 + var_585_11 then
				local var_585_12 = (arg_582_1.time_ - var_585_10) / var_585_11
				local var_585_13 = Vector3.New(0, 100, 0)

				var_585_9.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos10131ui_story, var_585_13, var_585_12)

				local var_585_14 = manager.ui.mainCamera.transform.position - var_585_9.position

				var_585_9.forward = Vector3.New(var_585_14.x, var_585_14.y, var_585_14.z)

				local var_585_15 = var_585_9.localEulerAngles

				var_585_15.z = 0
				var_585_15.x = 0
				var_585_9.localEulerAngles = var_585_15
			end

			if arg_582_1.time_ >= var_585_10 + var_585_11 and arg_582_1.time_ < var_585_10 + var_585_11 + arg_585_0 then
				var_585_9.localPosition = Vector3.New(0, 100, 0)

				local var_585_16 = manager.ui.mainCamera.transform.position - var_585_9.position

				var_585_9.forward = Vector3.New(var_585_16.x, var_585_16.y, var_585_16.z)

				local var_585_17 = var_585_9.localEulerAngles

				var_585_17.z = 0
				var_585_17.x = 0
				var_585_9.localEulerAngles = var_585_17
			end

			local var_585_18 = 0
			local var_585_19 = 1.475

			if var_585_18 < arg_582_1.time_ and arg_582_1.time_ <= var_585_18 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_20 = arg_582_1:GetWordFromCfg(322281142)
				local var_585_21 = arg_582_1:FormatText(var_585_20.content)

				arg_582_1.text_.text = var_585_21

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_22 = 59
				local var_585_23 = utf8.len(var_585_21)
				local var_585_24 = var_585_22 <= 0 and var_585_19 or var_585_19 * (var_585_23 / var_585_22)

				if var_585_24 > 0 and var_585_19 < var_585_24 then
					arg_582_1.talkMaxDuration = var_585_24

					if var_585_24 + var_585_18 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_24 + var_585_18
					end
				end

				arg_582_1.text_.text = var_585_21
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_25 = math.max(var_585_19, arg_582_1.talkMaxDuration)

			if var_585_18 <= arg_582_1.time_ and arg_582_1.time_ < var_585_18 + var_585_25 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_18) / var_585_25

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_18 + var_585_25 and arg_582_1.time_ < var_585_18 + var_585_25 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play322281143 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 322281143
		arg_586_1.duration_ = 3.1

		local var_586_0 = {
			zh = 3,
			ja = 3.1
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play322281144(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["10131ui_story"]
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect10131ui_story == nil then
				arg_586_1.var_.characterEffect10131ui_story = var_589_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_2 = 0.200000002980232

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 and not isNil(var_589_0) then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2

				if arg_586_1.var_.characterEffect10131ui_story and not isNil(var_589_0) then
					arg_586_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect10131ui_story then
				arg_586_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_589_4 = arg_586_1.actors_["10131ui_story"].transform
			local var_589_5 = 0

			if var_589_5 < arg_586_1.time_ and arg_586_1.time_ <= var_589_5 + arg_589_0 then
				arg_586_1.var_.moveOldPos10131ui_story = var_589_4.localPosition
			end

			local var_589_6 = 0.001

			if var_589_5 <= arg_586_1.time_ and arg_586_1.time_ < var_589_5 + var_589_6 then
				local var_589_7 = (arg_586_1.time_ - var_589_5) / var_589_6
				local var_589_8 = Vector3.New(0.05, -0.96, -5.8)

				var_589_4.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos10131ui_story, var_589_8, var_589_7)

				local var_589_9 = manager.ui.mainCamera.transform.position - var_589_4.position

				var_589_4.forward = Vector3.New(var_589_9.x, var_589_9.y, var_589_9.z)

				local var_589_10 = var_589_4.localEulerAngles

				var_589_10.z = 0
				var_589_10.x = 0
				var_589_4.localEulerAngles = var_589_10
			end

			if arg_586_1.time_ >= var_589_5 + var_589_6 and arg_586_1.time_ < var_589_5 + var_589_6 + arg_589_0 then
				var_589_4.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_589_11 = manager.ui.mainCamera.transform.position - var_589_4.position

				var_589_4.forward = Vector3.New(var_589_11.x, var_589_11.y, var_589_11.z)

				local var_589_12 = var_589_4.localEulerAngles

				var_589_12.z = 0
				var_589_12.x = 0
				var_589_4.localEulerAngles = var_589_12
			end

			local var_589_13 = 0

			if var_589_13 < arg_586_1.time_ and arg_586_1.time_ <= var_589_13 + arg_589_0 then
				arg_586_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_589_14 = 0

			if var_589_14 < arg_586_1.time_ and arg_586_1.time_ <= var_589_14 + arg_589_0 then
				arg_586_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_589_15 = 0
			local var_589_16 = 0.2

			if var_589_15 < arg_586_1.time_ and arg_586_1.time_ <= var_589_15 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_17 = arg_586_1:FormatText(StoryNameCfg[1366].name)

				arg_586_1.leftNameTxt_.text = var_589_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_18 = arg_586_1:GetWordFromCfg(322281143)
				local var_589_19 = arg_586_1:FormatText(var_589_18.content)

				arg_586_1.text_.text = var_589_19

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_20 = 8
				local var_589_21 = utf8.len(var_589_19)
				local var_589_22 = var_589_20 <= 0 and var_589_16 or var_589_16 * (var_589_21 / var_589_20)

				if var_589_22 > 0 and var_589_16 < var_589_22 then
					arg_586_1.talkMaxDuration = var_589_22

					if var_589_22 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_22 + var_589_15
					end
				end

				arg_586_1.text_.text = var_589_19
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281143", "story_v_out_322281.awb") ~= 0 then
					local var_589_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281143", "story_v_out_322281.awb") / 1000

					if var_589_23 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_23 + var_589_15
					end

					if var_589_18.prefab_name ~= "" and arg_586_1.actors_[var_589_18.prefab_name] ~= nil then
						local var_589_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_18.prefab_name].transform, "story_v_out_322281", "322281143", "story_v_out_322281.awb")

						arg_586_1:RecordAudio("322281143", var_589_24)
						arg_586_1:RecordAudio("322281143", var_589_24)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_322281", "322281143", "story_v_out_322281.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_322281", "322281143", "story_v_out_322281.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_25 = math.max(var_589_16, arg_586_1.talkMaxDuration)

			if var_589_15 <= arg_586_1.time_ and arg_586_1.time_ < var_589_15 + var_589_25 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_15) / var_589_25

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_15 + var_589_25 and arg_586_1.time_ < var_589_15 + var_589_25 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play322281144 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 322281144
		arg_590_1.duration_ = 2

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play322281145(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = arg_590_1.actors_["6056ui_story"]
			local var_593_1 = 0

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect6056ui_story == nil then
				arg_590_1.var_.characterEffect6056ui_story = var_593_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_2 = 0.200000002980232

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_2 and not isNil(var_593_0) then
				local var_593_3 = (arg_590_1.time_ - var_593_1) / var_593_2

				if arg_590_1.var_.characterEffect6056ui_story and not isNil(var_593_0) then
					arg_590_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_590_1.time_ >= var_593_1 + var_593_2 and arg_590_1.time_ < var_593_1 + var_593_2 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect6056ui_story then
				arg_590_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_593_4 = arg_590_1.actors_["10131ui_story"]
			local var_593_5 = 0

			if var_593_5 < arg_590_1.time_ and arg_590_1.time_ <= var_593_5 + arg_593_0 and not isNil(var_593_4) and arg_590_1.var_.characterEffect10131ui_story == nil then
				arg_590_1.var_.characterEffect10131ui_story = var_593_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_6 = 0.200000002980232

			if var_593_5 <= arg_590_1.time_ and arg_590_1.time_ < var_593_5 + var_593_6 and not isNil(var_593_4) then
				local var_593_7 = (arg_590_1.time_ - var_593_5) / var_593_6

				if arg_590_1.var_.characterEffect10131ui_story and not isNil(var_593_4) then
					local var_593_8 = Mathf.Lerp(0, 0.5, var_593_7)

					arg_590_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_590_1.var_.characterEffect10131ui_story.fillRatio = var_593_8
				end
			end

			if arg_590_1.time_ >= var_593_5 + var_593_6 and arg_590_1.time_ < var_593_5 + var_593_6 + arg_593_0 and not isNil(var_593_4) and arg_590_1.var_.characterEffect10131ui_story then
				local var_593_9 = 0.5

				arg_590_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_590_1.var_.characterEffect10131ui_story.fillRatio = var_593_9
			end

			local var_593_10 = arg_590_1.actors_["6056ui_story"].transform
			local var_593_11 = 0

			if var_593_11 < arg_590_1.time_ and arg_590_1.time_ <= var_593_11 + arg_593_0 then
				arg_590_1.var_.moveOldPos6056ui_story = var_593_10.localPosition
			end

			local var_593_12 = 0.001

			if var_593_11 <= arg_590_1.time_ and arg_590_1.time_ < var_593_11 + var_593_12 then
				local var_593_13 = (arg_590_1.time_ - var_593_11) / var_593_12
				local var_593_14 = Vector3.New(0.95, -1.16, -6.15)

				var_593_10.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos6056ui_story, var_593_14, var_593_13)

				local var_593_15 = manager.ui.mainCamera.transform.position - var_593_10.position

				var_593_10.forward = Vector3.New(var_593_15.x, var_593_15.y, var_593_15.z)

				local var_593_16 = var_593_10.localEulerAngles

				var_593_16.z = 0
				var_593_16.x = 0
				var_593_10.localEulerAngles = var_593_16
			end

			if arg_590_1.time_ >= var_593_11 + var_593_12 and arg_590_1.time_ < var_593_11 + var_593_12 + arg_593_0 then
				var_593_10.localPosition = Vector3.New(0.95, -1.16, -6.15)

				local var_593_17 = manager.ui.mainCamera.transform.position - var_593_10.position

				var_593_10.forward = Vector3.New(var_593_17.x, var_593_17.y, var_593_17.z)

				local var_593_18 = var_593_10.localEulerAngles

				var_593_18.z = 0
				var_593_18.x = 0
				var_593_10.localEulerAngles = var_593_18
			end

			local var_593_19 = arg_590_1.actors_["10131ui_story"].transform
			local var_593_20 = 0

			if var_593_20 < arg_590_1.time_ and arg_590_1.time_ <= var_593_20 + arg_593_0 then
				arg_590_1.var_.moveOldPos10131ui_story = var_593_19.localPosition
			end

			local var_593_21 = 0.001

			if var_593_20 <= arg_590_1.time_ and arg_590_1.time_ < var_593_20 + var_593_21 then
				local var_593_22 = (arg_590_1.time_ - var_593_20) / var_593_21
				local var_593_23 = Vector3.New(-0.78, -0.96, -5.8)

				var_593_19.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos10131ui_story, var_593_23, var_593_22)

				local var_593_24 = manager.ui.mainCamera.transform.position - var_593_19.position

				var_593_19.forward = Vector3.New(var_593_24.x, var_593_24.y, var_593_24.z)

				local var_593_25 = var_593_19.localEulerAngles

				var_593_25.z = 0
				var_593_25.x = 0
				var_593_19.localEulerAngles = var_593_25
			end

			if arg_590_1.time_ >= var_593_20 + var_593_21 and arg_590_1.time_ < var_593_20 + var_593_21 + arg_593_0 then
				var_593_19.localPosition = Vector3.New(-0.78, -0.96, -5.8)

				local var_593_26 = manager.ui.mainCamera.transform.position - var_593_19.position

				var_593_19.forward = Vector3.New(var_593_26.x, var_593_26.y, var_593_26.z)

				local var_593_27 = var_593_19.localEulerAngles

				var_593_27.z = 0
				var_593_27.x = 0
				var_593_19.localEulerAngles = var_593_27
			end

			local var_593_28 = 0

			if var_593_28 < arg_590_1.time_ and arg_590_1.time_ <= var_593_28 + arg_593_0 then
				arg_590_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			local var_593_29 = 0
			local var_593_30 = 0.15

			if var_593_29 < arg_590_1.time_ and arg_590_1.time_ <= var_593_29 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_31 = arg_590_1:FormatText(StoryNameCfg[613].name)

				arg_590_1.leftNameTxt_.text = var_593_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_32 = arg_590_1:GetWordFromCfg(322281144)
				local var_593_33 = arg_590_1:FormatText(var_593_32.content)

				arg_590_1.text_.text = var_593_33

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_34 = 6
				local var_593_35 = utf8.len(var_593_33)
				local var_593_36 = var_593_34 <= 0 and var_593_30 or var_593_30 * (var_593_35 / var_593_34)

				if var_593_36 > 0 and var_593_30 < var_593_36 then
					arg_590_1.talkMaxDuration = var_593_36

					if var_593_36 + var_593_29 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_36 + var_593_29
					end
				end

				arg_590_1.text_.text = var_593_33
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281144", "story_v_out_322281.awb") ~= 0 then
					local var_593_37 = manager.audio:GetVoiceLength("story_v_out_322281", "322281144", "story_v_out_322281.awb") / 1000

					if var_593_37 + var_593_29 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_37 + var_593_29
					end

					if var_593_32.prefab_name ~= "" and arg_590_1.actors_[var_593_32.prefab_name] ~= nil then
						local var_593_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_32.prefab_name].transform, "story_v_out_322281", "322281144", "story_v_out_322281.awb")

						arg_590_1:RecordAudio("322281144", var_593_38)
						arg_590_1:RecordAudio("322281144", var_593_38)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_out_322281", "322281144", "story_v_out_322281.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_out_322281", "322281144", "story_v_out_322281.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_39 = math.max(var_593_30, arg_590_1.talkMaxDuration)

			if var_593_29 <= arg_590_1.time_ and arg_590_1.time_ < var_593_29 + var_593_39 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_29) / var_593_39

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_29 + var_593_39 and arg_590_1.time_ < var_593_29 + var_593_39 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_590_1:InitPlayNodeList()
	end,
	Play322281145 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 322281145
		arg_594_1.duration_ = 7.47

		local var_594_0 = {
			zh = 5.433,
			ja = 7.466
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play322281146(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.actors_["10131ui_story"]
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 and not isNil(var_597_0) and arg_594_1.var_.characterEffect10131ui_story == nil then
				arg_594_1.var_.characterEffect10131ui_story = var_597_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_2 = 0.200000002980232

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 and not isNil(var_597_0) then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2

				if arg_594_1.var_.characterEffect10131ui_story and not isNil(var_597_0) then
					arg_594_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 and not isNil(var_597_0) and arg_594_1.var_.characterEffect10131ui_story then
				arg_594_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_597_4 = arg_594_1.actors_["6056ui_story"]
			local var_597_5 = 0

			if var_597_5 < arg_594_1.time_ and arg_594_1.time_ <= var_597_5 + arg_597_0 and not isNil(var_597_4) and arg_594_1.var_.characterEffect6056ui_story == nil then
				arg_594_1.var_.characterEffect6056ui_story = var_597_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_6 = 0.200000002980232

			if var_597_5 <= arg_594_1.time_ and arg_594_1.time_ < var_597_5 + var_597_6 and not isNil(var_597_4) then
				local var_597_7 = (arg_594_1.time_ - var_597_5) / var_597_6

				if arg_594_1.var_.characterEffect6056ui_story and not isNil(var_597_4) then
					local var_597_8 = Mathf.Lerp(0, 0.5, var_597_7)

					arg_594_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_594_1.var_.characterEffect6056ui_story.fillRatio = var_597_8
				end
			end

			if arg_594_1.time_ >= var_597_5 + var_597_6 and arg_594_1.time_ < var_597_5 + var_597_6 + arg_597_0 and not isNil(var_597_4) and arg_594_1.var_.characterEffect6056ui_story then
				local var_597_9 = 0.5

				arg_594_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_594_1.var_.characterEffect6056ui_story.fillRatio = var_597_9
			end

			local var_597_10 = 0
			local var_597_11 = 0.65

			if var_597_10 < arg_594_1.time_ and arg_594_1.time_ <= var_597_10 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_12 = arg_594_1:FormatText(StoryNameCfg[1366].name)

				arg_594_1.leftNameTxt_.text = var_597_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_13 = arg_594_1:GetWordFromCfg(322281145)
				local var_597_14 = arg_594_1:FormatText(var_597_13.content)

				arg_594_1.text_.text = var_597_14

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_15 = 26
				local var_597_16 = utf8.len(var_597_14)
				local var_597_17 = var_597_15 <= 0 and var_597_11 or var_597_11 * (var_597_16 / var_597_15)

				if var_597_17 > 0 and var_597_11 < var_597_17 then
					arg_594_1.talkMaxDuration = var_597_17

					if var_597_17 + var_597_10 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_17 + var_597_10
					end
				end

				arg_594_1.text_.text = var_597_14
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281145", "story_v_out_322281.awb") ~= 0 then
					local var_597_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281145", "story_v_out_322281.awb") / 1000

					if var_597_18 + var_597_10 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_18 + var_597_10
					end

					if var_597_13.prefab_name ~= "" and arg_594_1.actors_[var_597_13.prefab_name] ~= nil then
						local var_597_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_13.prefab_name].transform, "story_v_out_322281", "322281145", "story_v_out_322281.awb")

						arg_594_1:RecordAudio("322281145", var_597_19)
						arg_594_1:RecordAudio("322281145", var_597_19)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_out_322281", "322281145", "story_v_out_322281.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_out_322281", "322281145", "story_v_out_322281.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_20 = math.max(var_597_11, arg_594_1.talkMaxDuration)

			if var_597_10 <= arg_594_1.time_ and arg_594_1.time_ < var_597_10 + var_597_20 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_10) / var_597_20

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_10 + var_597_20 and arg_594_1.time_ < var_597_10 + var_597_20 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play322281146 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 322281146
		arg_598_1.duration_ = 4.2

		local var_598_0 = {
			zh = 2.366,
			ja = 4.2
		}
		local var_598_1 = manager.audio:GetLocalizationFlag()

		if var_598_0[var_598_1] ~= nil then
			arg_598_1.duration_ = var_598_0[var_598_1]
		end

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play322281147(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = arg_598_1.actors_["6056ui_story"]
			local var_601_1 = 0

			if var_601_1 < arg_598_1.time_ and arg_598_1.time_ <= var_601_1 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect6056ui_story == nil then
				arg_598_1.var_.characterEffect6056ui_story = var_601_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_2 = 0.200000002980232

			if var_601_1 <= arg_598_1.time_ and arg_598_1.time_ < var_601_1 + var_601_2 and not isNil(var_601_0) then
				local var_601_3 = (arg_598_1.time_ - var_601_1) / var_601_2

				if arg_598_1.var_.characterEffect6056ui_story and not isNil(var_601_0) then
					arg_598_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= var_601_1 + var_601_2 and arg_598_1.time_ < var_601_1 + var_601_2 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect6056ui_story then
				arg_598_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_601_4 = arg_598_1.actors_["10131ui_story"]
			local var_601_5 = 0

			if var_601_5 < arg_598_1.time_ and arg_598_1.time_ <= var_601_5 + arg_601_0 and not isNil(var_601_4) and arg_598_1.var_.characterEffect10131ui_story == nil then
				arg_598_1.var_.characterEffect10131ui_story = var_601_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_6 = 0.200000002980232

			if var_601_5 <= arg_598_1.time_ and arg_598_1.time_ < var_601_5 + var_601_6 and not isNil(var_601_4) then
				local var_601_7 = (arg_598_1.time_ - var_601_5) / var_601_6

				if arg_598_1.var_.characterEffect10131ui_story and not isNil(var_601_4) then
					local var_601_8 = Mathf.Lerp(0, 0.5, var_601_7)

					arg_598_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_598_1.var_.characterEffect10131ui_story.fillRatio = var_601_8
				end
			end

			if arg_598_1.time_ >= var_601_5 + var_601_6 and arg_598_1.time_ < var_601_5 + var_601_6 + arg_601_0 and not isNil(var_601_4) and arg_598_1.var_.characterEffect10131ui_story then
				local var_601_9 = 0.5

				arg_598_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_598_1.var_.characterEffect10131ui_story.fillRatio = var_601_9
			end

			local var_601_10 = 0

			if var_601_10 < arg_598_1.time_ and arg_598_1.time_ <= var_601_10 + arg_601_0 then
				arg_598_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_1")
			end

			local var_601_11 = 0
			local var_601_12 = 0.25

			if var_601_11 < arg_598_1.time_ and arg_598_1.time_ <= var_601_11 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				local var_601_13 = arg_598_1:FormatText(StoryNameCfg[613].name)

				arg_598_1.leftNameTxt_.text = var_601_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_14 = arg_598_1:GetWordFromCfg(322281146)
				local var_601_15 = arg_598_1:FormatText(var_601_14.content)

				arg_598_1.text_.text = var_601_15

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_16 = 10
				local var_601_17 = utf8.len(var_601_15)
				local var_601_18 = var_601_16 <= 0 and var_601_12 or var_601_12 * (var_601_17 / var_601_16)

				if var_601_18 > 0 and var_601_12 < var_601_18 then
					arg_598_1.talkMaxDuration = var_601_18

					if var_601_18 + var_601_11 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_18 + var_601_11
					end
				end

				arg_598_1.text_.text = var_601_15
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281146", "story_v_out_322281.awb") ~= 0 then
					local var_601_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281146", "story_v_out_322281.awb") / 1000

					if var_601_19 + var_601_11 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_19 + var_601_11
					end

					if var_601_14.prefab_name ~= "" and arg_598_1.actors_[var_601_14.prefab_name] ~= nil then
						local var_601_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_14.prefab_name].transform, "story_v_out_322281", "322281146", "story_v_out_322281.awb")

						arg_598_1:RecordAudio("322281146", var_601_20)
						arg_598_1:RecordAudio("322281146", var_601_20)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_out_322281", "322281146", "story_v_out_322281.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_out_322281", "322281146", "story_v_out_322281.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_21 = math.max(var_601_12, arg_598_1.talkMaxDuration)

			if var_601_11 <= arg_598_1.time_ and arg_598_1.time_ < var_601_11 + var_601_21 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_11) / var_601_21

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_11 + var_601_21 and arg_598_1.time_ < var_601_11 + var_601_21 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play322281147 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 322281147
		arg_602_1.duration_ = 7.8

		local var_602_0 = {
			zh = 6.8,
			ja = 7.8
		}
		local var_602_1 = manager.audio:GetLocalizationFlag()

		if var_602_0[var_602_1] ~= nil then
			arg_602_1.duration_ = var_602_0[var_602_1]
		end

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play322281148(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = arg_602_1.actors_["10131ui_story"]
			local var_605_1 = 0

			if var_605_1 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 and not isNil(var_605_0) and arg_602_1.var_.characterEffect10131ui_story == nil then
				arg_602_1.var_.characterEffect10131ui_story = var_605_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_2 = 0.200000002980232

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_2 and not isNil(var_605_0) then
				local var_605_3 = (arg_602_1.time_ - var_605_1) / var_605_2

				if arg_602_1.var_.characterEffect10131ui_story and not isNil(var_605_0) then
					arg_602_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_602_1.time_ >= var_605_1 + var_605_2 and arg_602_1.time_ < var_605_1 + var_605_2 + arg_605_0 and not isNil(var_605_0) and arg_602_1.var_.characterEffect10131ui_story then
				arg_602_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_605_4 = arg_602_1.actors_["6056ui_story"]
			local var_605_5 = 0

			if var_605_5 < arg_602_1.time_ and arg_602_1.time_ <= var_605_5 + arg_605_0 and not isNil(var_605_4) and arg_602_1.var_.characterEffect6056ui_story == nil then
				arg_602_1.var_.characterEffect6056ui_story = var_605_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_6 = 0.200000002980232

			if var_605_5 <= arg_602_1.time_ and arg_602_1.time_ < var_605_5 + var_605_6 and not isNil(var_605_4) then
				local var_605_7 = (arg_602_1.time_ - var_605_5) / var_605_6

				if arg_602_1.var_.characterEffect6056ui_story and not isNil(var_605_4) then
					local var_605_8 = Mathf.Lerp(0, 0.5, var_605_7)

					arg_602_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_602_1.var_.characterEffect6056ui_story.fillRatio = var_605_8
				end
			end

			if arg_602_1.time_ >= var_605_5 + var_605_6 and arg_602_1.time_ < var_605_5 + var_605_6 + arg_605_0 and not isNil(var_605_4) and arg_602_1.var_.characterEffect6056ui_story then
				local var_605_9 = 0.5

				arg_602_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_602_1.var_.characterEffect6056ui_story.fillRatio = var_605_9
			end

			local var_605_10 = 0

			if var_605_10 < arg_602_1.time_ and arg_602_1.time_ <= var_605_10 + arg_605_0 then
				arg_602_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_605_11 = 0
			local var_605_12 = 0.775

			if var_605_11 < arg_602_1.time_ and arg_602_1.time_ <= var_605_11 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				local var_605_13 = arg_602_1:FormatText(StoryNameCfg[1366].name)

				arg_602_1.leftNameTxt_.text = var_605_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_14 = arg_602_1:GetWordFromCfg(322281147)
				local var_605_15 = arg_602_1:FormatText(var_605_14.content)

				arg_602_1.text_.text = var_605_15

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_16 = 31
				local var_605_17 = utf8.len(var_605_15)
				local var_605_18 = var_605_16 <= 0 and var_605_12 or var_605_12 * (var_605_17 / var_605_16)

				if var_605_18 > 0 and var_605_12 < var_605_18 then
					arg_602_1.talkMaxDuration = var_605_18

					if var_605_18 + var_605_11 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_18 + var_605_11
					end
				end

				arg_602_1.text_.text = var_605_15
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281147", "story_v_out_322281.awb") ~= 0 then
					local var_605_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281147", "story_v_out_322281.awb") / 1000

					if var_605_19 + var_605_11 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_19 + var_605_11
					end

					if var_605_14.prefab_name ~= "" and arg_602_1.actors_[var_605_14.prefab_name] ~= nil then
						local var_605_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_14.prefab_name].transform, "story_v_out_322281", "322281147", "story_v_out_322281.awb")

						arg_602_1:RecordAudio("322281147", var_605_20)
						arg_602_1:RecordAudio("322281147", var_605_20)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_out_322281", "322281147", "story_v_out_322281.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_out_322281", "322281147", "story_v_out_322281.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_21 = math.max(var_605_12, arg_602_1.talkMaxDuration)

			if var_605_11 <= arg_602_1.time_ and arg_602_1.time_ < var_605_11 + var_605_21 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_11) / var_605_21

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_11 + var_605_21 and arg_602_1.time_ < var_605_11 + var_605_21 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play322281148 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 322281148
		arg_606_1.duration_ = 9.3

		local var_606_0 = {
			zh = 3.866,
			ja = 9.3
		}
		local var_606_1 = manager.audio:GetLocalizationFlag()

		if var_606_0[var_606_1] ~= nil then
			arg_606_1.duration_ = var_606_0[var_606_1]
		end

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play322281149(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = arg_606_1.actors_["6056ui_story"]
			local var_609_1 = 0

			if var_609_1 < arg_606_1.time_ and arg_606_1.time_ <= var_609_1 + arg_609_0 and not isNil(var_609_0) and arg_606_1.var_.characterEffect6056ui_story == nil then
				arg_606_1.var_.characterEffect6056ui_story = var_609_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_2 = 0.200000002980232

			if var_609_1 <= arg_606_1.time_ and arg_606_1.time_ < var_609_1 + var_609_2 and not isNil(var_609_0) then
				local var_609_3 = (arg_606_1.time_ - var_609_1) / var_609_2

				if arg_606_1.var_.characterEffect6056ui_story and not isNil(var_609_0) then
					arg_606_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_606_1.time_ >= var_609_1 + var_609_2 and arg_606_1.time_ < var_609_1 + var_609_2 + arg_609_0 and not isNil(var_609_0) and arg_606_1.var_.characterEffect6056ui_story then
				arg_606_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_609_4 = arg_606_1.actors_["10131ui_story"]
			local var_609_5 = 0

			if var_609_5 < arg_606_1.time_ and arg_606_1.time_ <= var_609_5 + arg_609_0 and not isNil(var_609_4) and arg_606_1.var_.characterEffect10131ui_story == nil then
				arg_606_1.var_.characterEffect10131ui_story = var_609_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_6 = 0.200000002980232

			if var_609_5 <= arg_606_1.time_ and arg_606_1.time_ < var_609_5 + var_609_6 and not isNil(var_609_4) then
				local var_609_7 = (arg_606_1.time_ - var_609_5) / var_609_6

				if arg_606_1.var_.characterEffect10131ui_story and not isNil(var_609_4) then
					local var_609_8 = Mathf.Lerp(0, 0.5, var_609_7)

					arg_606_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_606_1.var_.characterEffect10131ui_story.fillRatio = var_609_8
				end
			end

			if arg_606_1.time_ >= var_609_5 + var_609_6 and arg_606_1.time_ < var_609_5 + var_609_6 + arg_609_0 and not isNil(var_609_4) and arg_606_1.var_.characterEffect10131ui_story then
				local var_609_9 = 0.5

				arg_606_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_606_1.var_.characterEffect10131ui_story.fillRatio = var_609_9
			end

			local var_609_10 = 0
			local var_609_11 = 0.45

			if var_609_10 < arg_606_1.time_ and arg_606_1.time_ <= var_609_10 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				local var_609_12 = arg_606_1:FormatText(StoryNameCfg[613].name)

				arg_606_1.leftNameTxt_.text = var_609_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_13 = arg_606_1:GetWordFromCfg(322281148)
				local var_609_14 = arg_606_1:FormatText(var_609_13.content)

				arg_606_1.text_.text = var_609_14

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_15 = 18
				local var_609_16 = utf8.len(var_609_14)
				local var_609_17 = var_609_15 <= 0 and var_609_11 or var_609_11 * (var_609_16 / var_609_15)

				if var_609_17 > 0 and var_609_11 < var_609_17 then
					arg_606_1.talkMaxDuration = var_609_17

					if var_609_17 + var_609_10 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_17 + var_609_10
					end
				end

				arg_606_1.text_.text = var_609_14
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281148", "story_v_out_322281.awb") ~= 0 then
					local var_609_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281148", "story_v_out_322281.awb") / 1000

					if var_609_18 + var_609_10 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_18 + var_609_10
					end

					if var_609_13.prefab_name ~= "" and arg_606_1.actors_[var_609_13.prefab_name] ~= nil then
						local var_609_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_13.prefab_name].transform, "story_v_out_322281", "322281148", "story_v_out_322281.awb")

						arg_606_1:RecordAudio("322281148", var_609_19)
						arg_606_1:RecordAudio("322281148", var_609_19)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_out_322281", "322281148", "story_v_out_322281.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_out_322281", "322281148", "story_v_out_322281.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_20 = math.max(var_609_11, arg_606_1.talkMaxDuration)

			if var_609_10 <= arg_606_1.time_ and arg_606_1.time_ < var_609_10 + var_609_20 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_10) / var_609_20

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_10 + var_609_20 and arg_606_1.time_ < var_609_10 + var_609_20 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play322281149 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 322281149
		arg_610_1.duration_ = 8.3

		local var_610_0 = {
			zh = 6.666,
			ja = 8.3
		}
		local var_610_1 = manager.audio:GetLocalizationFlag()

		if var_610_0[var_610_1] ~= nil then
			arg_610_1.duration_ = var_610_0[var_610_1]
		end

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play322281150(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = arg_610_1.actors_["10131ui_story"]
			local var_613_1 = 0

			if var_613_1 < arg_610_1.time_ and arg_610_1.time_ <= var_613_1 + arg_613_0 and not isNil(var_613_0) and arg_610_1.var_.characterEffect10131ui_story == nil then
				arg_610_1.var_.characterEffect10131ui_story = var_613_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_2 = 0.200000002980232

			if var_613_1 <= arg_610_1.time_ and arg_610_1.time_ < var_613_1 + var_613_2 and not isNil(var_613_0) then
				local var_613_3 = (arg_610_1.time_ - var_613_1) / var_613_2

				if arg_610_1.var_.characterEffect10131ui_story and not isNil(var_613_0) then
					arg_610_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_610_1.time_ >= var_613_1 + var_613_2 and arg_610_1.time_ < var_613_1 + var_613_2 + arg_613_0 and not isNil(var_613_0) and arg_610_1.var_.characterEffect10131ui_story then
				arg_610_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_613_4 = arg_610_1.actors_["6056ui_story"]
			local var_613_5 = 0

			if var_613_5 < arg_610_1.time_ and arg_610_1.time_ <= var_613_5 + arg_613_0 and not isNil(var_613_4) and arg_610_1.var_.characterEffect6056ui_story == nil then
				arg_610_1.var_.characterEffect6056ui_story = var_613_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_6 = 0.200000002980232

			if var_613_5 <= arg_610_1.time_ and arg_610_1.time_ < var_613_5 + var_613_6 and not isNil(var_613_4) then
				local var_613_7 = (arg_610_1.time_ - var_613_5) / var_613_6

				if arg_610_1.var_.characterEffect6056ui_story and not isNil(var_613_4) then
					local var_613_8 = Mathf.Lerp(0, 0.5, var_613_7)

					arg_610_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_610_1.var_.characterEffect6056ui_story.fillRatio = var_613_8
				end
			end

			if arg_610_1.time_ >= var_613_5 + var_613_6 and arg_610_1.time_ < var_613_5 + var_613_6 + arg_613_0 and not isNil(var_613_4) and arg_610_1.var_.characterEffect6056ui_story then
				local var_613_9 = 0.5

				arg_610_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_610_1.var_.characterEffect6056ui_story.fillRatio = var_613_9
			end

			local var_613_10 = 0
			local var_613_11 = 0.725

			if var_613_10 < arg_610_1.time_ and arg_610_1.time_ <= var_613_10 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				local var_613_12 = arg_610_1:FormatText(StoryNameCfg[1366].name)

				arg_610_1.leftNameTxt_.text = var_613_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_13 = arg_610_1:GetWordFromCfg(322281149)
				local var_613_14 = arg_610_1:FormatText(var_613_13.content)

				arg_610_1.text_.text = var_613_14

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_15 = 29
				local var_613_16 = utf8.len(var_613_14)
				local var_613_17 = var_613_15 <= 0 and var_613_11 or var_613_11 * (var_613_16 / var_613_15)

				if var_613_17 > 0 and var_613_11 < var_613_17 then
					arg_610_1.talkMaxDuration = var_613_17

					if var_613_17 + var_613_10 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_17 + var_613_10
					end
				end

				arg_610_1.text_.text = var_613_14
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281149", "story_v_out_322281.awb") ~= 0 then
					local var_613_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281149", "story_v_out_322281.awb") / 1000

					if var_613_18 + var_613_10 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_18 + var_613_10
					end

					if var_613_13.prefab_name ~= "" and arg_610_1.actors_[var_613_13.prefab_name] ~= nil then
						local var_613_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_610_1.actors_[var_613_13.prefab_name].transform, "story_v_out_322281", "322281149", "story_v_out_322281.awb")

						arg_610_1:RecordAudio("322281149", var_613_19)
						arg_610_1:RecordAudio("322281149", var_613_19)
					else
						arg_610_1:AudioAction("play", "voice", "story_v_out_322281", "322281149", "story_v_out_322281.awb")
					end

					arg_610_1:RecordHistoryTalkVoice("story_v_out_322281", "322281149", "story_v_out_322281.awb")
				end

				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_20 = math.max(var_613_11, arg_610_1.talkMaxDuration)

			if var_613_10 <= arg_610_1.time_ and arg_610_1.time_ < var_613_10 + var_613_20 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_10) / var_613_20

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_10 + var_613_20 and arg_610_1.time_ < var_613_10 + var_613_20 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play322281150 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 322281150
		arg_614_1.duration_ = 7.77

		local var_614_0 = {
			zh = 6.166,
			ja = 7.766
		}
		local var_614_1 = manager.audio:GetLocalizationFlag()

		if var_614_0[var_614_1] ~= nil then
			arg_614_1.duration_ = var_614_0[var_614_1]
		end

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play322281151(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0

			if var_617_0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_0 + arg_617_0 then
				arg_614_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_617_1 = 0
			local var_617_2 = 0.625

			if var_617_1 < arg_614_1.time_ and arg_614_1.time_ <= var_617_1 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				local var_617_3 = arg_614_1:FormatText(StoryNameCfg[1366].name)

				arg_614_1.leftNameTxt_.text = var_617_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_4 = arg_614_1:GetWordFromCfg(322281150)
				local var_617_5 = arg_614_1:FormatText(var_617_4.content)

				arg_614_1.text_.text = var_617_5

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_6 = 25
				local var_617_7 = utf8.len(var_617_5)
				local var_617_8 = var_617_6 <= 0 and var_617_2 or var_617_2 * (var_617_7 / var_617_6)

				if var_617_8 > 0 and var_617_2 < var_617_8 then
					arg_614_1.talkMaxDuration = var_617_8

					if var_617_8 + var_617_1 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_8 + var_617_1
					end
				end

				arg_614_1.text_.text = var_617_5
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281150", "story_v_out_322281.awb") ~= 0 then
					local var_617_9 = manager.audio:GetVoiceLength("story_v_out_322281", "322281150", "story_v_out_322281.awb") / 1000

					if var_617_9 + var_617_1 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_9 + var_617_1
					end

					if var_617_4.prefab_name ~= "" and arg_614_1.actors_[var_617_4.prefab_name] ~= nil then
						local var_617_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_4.prefab_name].transform, "story_v_out_322281", "322281150", "story_v_out_322281.awb")

						arg_614_1:RecordAudio("322281150", var_617_10)
						arg_614_1:RecordAudio("322281150", var_617_10)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_out_322281", "322281150", "story_v_out_322281.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_out_322281", "322281150", "story_v_out_322281.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_11 = math.max(var_617_2, arg_614_1.talkMaxDuration)

			if var_617_1 <= arg_614_1.time_ and arg_614_1.time_ < var_617_1 + var_617_11 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_1) / var_617_11

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_1 + var_617_11 and arg_614_1.time_ < var_617_1 + var_617_11 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play322281151 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 322281151
		arg_618_1.duration_ = 5.87

		local var_618_0 = {
			zh = 2.533,
			ja = 5.866
		}
		local var_618_1 = manager.audio:GetLocalizationFlag()

		if var_618_0[var_618_1] ~= nil then
			arg_618_1.duration_ = var_618_0[var_618_1]
		end

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play322281152(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = arg_618_1.actors_["6056ui_story"]
			local var_621_1 = 0

			if var_621_1 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 and not isNil(var_621_0) and arg_618_1.var_.characterEffect6056ui_story == nil then
				arg_618_1.var_.characterEffect6056ui_story = var_621_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_2 = 0.200000002980232

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_2 and not isNil(var_621_0) then
				local var_621_3 = (arg_618_1.time_ - var_621_1) / var_621_2

				if arg_618_1.var_.characterEffect6056ui_story and not isNil(var_621_0) then
					arg_618_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_618_1.time_ >= var_621_1 + var_621_2 and arg_618_1.time_ < var_621_1 + var_621_2 + arg_621_0 and not isNil(var_621_0) and arg_618_1.var_.characterEffect6056ui_story then
				arg_618_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_621_4 = arg_618_1.actors_["10131ui_story"]
			local var_621_5 = 0

			if var_621_5 < arg_618_1.time_ and arg_618_1.time_ <= var_621_5 + arg_621_0 and not isNil(var_621_4) and arg_618_1.var_.characterEffect10131ui_story == nil then
				arg_618_1.var_.characterEffect10131ui_story = var_621_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_6 = 0.200000002980232

			if var_621_5 <= arg_618_1.time_ and arg_618_1.time_ < var_621_5 + var_621_6 and not isNil(var_621_4) then
				local var_621_7 = (arg_618_1.time_ - var_621_5) / var_621_6

				if arg_618_1.var_.characterEffect10131ui_story and not isNil(var_621_4) then
					local var_621_8 = Mathf.Lerp(0, 0.5, var_621_7)

					arg_618_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_618_1.var_.characterEffect10131ui_story.fillRatio = var_621_8
				end
			end

			if arg_618_1.time_ >= var_621_5 + var_621_6 and arg_618_1.time_ < var_621_5 + var_621_6 + arg_621_0 and not isNil(var_621_4) and arg_618_1.var_.characterEffect10131ui_story then
				local var_621_9 = 0.5

				arg_618_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_618_1.var_.characterEffect10131ui_story.fillRatio = var_621_9
			end

			local var_621_10 = 0
			local var_621_11 = 0.375

			if var_621_10 < arg_618_1.time_ and arg_618_1.time_ <= var_621_10 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				local var_621_12 = arg_618_1:FormatText(StoryNameCfg[613].name)

				arg_618_1.leftNameTxt_.text = var_621_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_13 = arg_618_1:GetWordFromCfg(322281151)
				local var_621_14 = arg_618_1:FormatText(var_621_13.content)

				arg_618_1.text_.text = var_621_14

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_15 = 15
				local var_621_16 = utf8.len(var_621_14)
				local var_621_17 = var_621_15 <= 0 and var_621_11 or var_621_11 * (var_621_16 / var_621_15)

				if var_621_17 > 0 and var_621_11 < var_621_17 then
					arg_618_1.talkMaxDuration = var_621_17

					if var_621_17 + var_621_10 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_17 + var_621_10
					end
				end

				arg_618_1.text_.text = var_621_14
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281151", "story_v_out_322281.awb") ~= 0 then
					local var_621_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281151", "story_v_out_322281.awb") / 1000

					if var_621_18 + var_621_10 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_18 + var_621_10
					end

					if var_621_13.prefab_name ~= "" and arg_618_1.actors_[var_621_13.prefab_name] ~= nil then
						local var_621_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_13.prefab_name].transform, "story_v_out_322281", "322281151", "story_v_out_322281.awb")

						arg_618_1:RecordAudio("322281151", var_621_19)
						arg_618_1:RecordAudio("322281151", var_621_19)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_out_322281", "322281151", "story_v_out_322281.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_out_322281", "322281151", "story_v_out_322281.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_20 = math.max(var_621_11, arg_618_1.talkMaxDuration)

			if var_621_10 <= arg_618_1.time_ and arg_618_1.time_ < var_621_10 + var_621_20 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_10) / var_621_20

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_10 + var_621_20 and arg_618_1.time_ < var_621_10 + var_621_20 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {}

		arg_618_1:InitPlayNodeList()
	end,
	Play322281152 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 322281152
		arg_622_1.duration_ = 8.1

		local var_622_0 = {
			zh = 4.5,
			ja = 8.1
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play322281153(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = arg_622_1.actors_["10131ui_story"]
			local var_625_1 = 0

			if var_625_1 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.characterEffect10131ui_story == nil then
				arg_622_1.var_.characterEffect10131ui_story = var_625_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_625_2 = 0.200000002980232

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_2 and not isNil(var_625_0) then
				local var_625_3 = (arg_622_1.time_ - var_625_1) / var_625_2

				if arg_622_1.var_.characterEffect10131ui_story and not isNil(var_625_0) then
					arg_622_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_622_1.time_ >= var_625_1 + var_625_2 and arg_622_1.time_ < var_625_1 + var_625_2 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.characterEffect10131ui_story then
				arg_622_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_625_4 = arg_622_1.actors_["6056ui_story"]
			local var_625_5 = 0

			if var_625_5 < arg_622_1.time_ and arg_622_1.time_ <= var_625_5 + arg_625_0 and not isNil(var_625_4) and arg_622_1.var_.characterEffect6056ui_story == nil then
				arg_622_1.var_.characterEffect6056ui_story = var_625_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_625_6 = 0.200000002980232

			if var_625_5 <= arg_622_1.time_ and arg_622_1.time_ < var_625_5 + var_625_6 and not isNil(var_625_4) then
				local var_625_7 = (arg_622_1.time_ - var_625_5) / var_625_6

				if arg_622_1.var_.characterEffect6056ui_story and not isNil(var_625_4) then
					local var_625_8 = Mathf.Lerp(0, 0.5, var_625_7)

					arg_622_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_622_1.var_.characterEffect6056ui_story.fillRatio = var_625_8
				end
			end

			if arg_622_1.time_ >= var_625_5 + var_625_6 and arg_622_1.time_ < var_625_5 + var_625_6 + arg_625_0 and not isNil(var_625_4) and arg_622_1.var_.characterEffect6056ui_story then
				local var_625_9 = 0.5

				arg_622_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_622_1.var_.characterEffect6056ui_story.fillRatio = var_625_9
			end

			local var_625_10 = 0
			local var_625_11 = 0.55

			if var_625_10 < arg_622_1.time_ and arg_622_1.time_ <= var_625_10 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				local var_625_12 = arg_622_1:FormatText(StoryNameCfg[1366].name)

				arg_622_1.leftNameTxt_.text = var_625_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_13 = arg_622_1:GetWordFromCfg(322281152)
				local var_625_14 = arg_622_1:FormatText(var_625_13.content)

				arg_622_1.text_.text = var_625_14

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_15 = 22
				local var_625_16 = utf8.len(var_625_14)
				local var_625_17 = var_625_15 <= 0 and var_625_11 or var_625_11 * (var_625_16 / var_625_15)

				if var_625_17 > 0 and var_625_11 < var_625_17 then
					arg_622_1.talkMaxDuration = var_625_17

					if var_625_17 + var_625_10 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_17 + var_625_10
					end
				end

				arg_622_1.text_.text = var_625_14
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281152", "story_v_out_322281.awb") ~= 0 then
					local var_625_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281152", "story_v_out_322281.awb") / 1000

					if var_625_18 + var_625_10 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_18 + var_625_10
					end

					if var_625_13.prefab_name ~= "" and arg_622_1.actors_[var_625_13.prefab_name] ~= nil then
						local var_625_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_13.prefab_name].transform, "story_v_out_322281", "322281152", "story_v_out_322281.awb")

						arg_622_1:RecordAudio("322281152", var_625_19)
						arg_622_1:RecordAudio("322281152", var_625_19)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_out_322281", "322281152", "story_v_out_322281.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_out_322281", "322281152", "story_v_out_322281.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_20 = math.max(var_625_11, arg_622_1.talkMaxDuration)

			if var_625_10 <= arg_622_1.time_ and arg_622_1.time_ < var_625_10 + var_625_20 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_10) / var_625_20

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_10 + var_625_20 and arg_622_1.time_ < var_625_10 + var_625_20 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play322281153 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 322281153
		arg_626_1.duration_ = 4.43

		local var_626_0 = {
			zh = 3.266,
			ja = 4.433
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play322281154(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0
			local var_629_1 = 0.35

			if var_629_0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				local var_629_2 = arg_626_1:FormatText(StoryNameCfg[1366].name)

				arg_626_1.leftNameTxt_.text = var_629_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_3 = arg_626_1:GetWordFromCfg(322281153)
				local var_629_4 = arg_626_1:FormatText(var_629_3.content)

				arg_626_1.text_.text = var_629_4

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_5 = 14
				local var_629_6 = utf8.len(var_629_4)
				local var_629_7 = var_629_5 <= 0 and var_629_1 or var_629_1 * (var_629_6 / var_629_5)

				if var_629_7 > 0 and var_629_1 < var_629_7 then
					arg_626_1.talkMaxDuration = var_629_7

					if var_629_7 + var_629_0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_7 + var_629_0
					end
				end

				arg_626_1.text_.text = var_629_4
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281153", "story_v_out_322281.awb") ~= 0 then
					local var_629_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281153", "story_v_out_322281.awb") / 1000

					if var_629_8 + var_629_0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_8 + var_629_0
					end

					if var_629_3.prefab_name ~= "" and arg_626_1.actors_[var_629_3.prefab_name] ~= nil then
						local var_629_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_3.prefab_name].transform, "story_v_out_322281", "322281153", "story_v_out_322281.awb")

						arg_626_1:RecordAudio("322281153", var_629_9)
						arg_626_1:RecordAudio("322281153", var_629_9)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_out_322281", "322281153", "story_v_out_322281.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_out_322281", "322281153", "story_v_out_322281.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_10 = math.max(var_629_1, arg_626_1.talkMaxDuration)

			if var_629_0 <= arg_626_1.time_ and arg_626_1.time_ < var_629_0 + var_629_10 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_0) / var_629_10

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_0 + var_629_10 and arg_626_1.time_ < var_629_0 + var_629_10 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play322281154 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 322281154
		arg_630_1.duration_ = 3.7

		local var_630_0 = {
			zh = 3.7,
			ja = 2.766
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play322281155(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = arg_630_1.actors_["6056ui_story"]
			local var_633_1 = 0

			if var_633_1 < arg_630_1.time_ and arg_630_1.time_ <= var_633_1 + arg_633_0 and not isNil(var_633_0) and arg_630_1.var_.characterEffect6056ui_story == nil then
				arg_630_1.var_.characterEffect6056ui_story = var_633_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_2 = 0.200000002980232

			if var_633_1 <= arg_630_1.time_ and arg_630_1.time_ < var_633_1 + var_633_2 and not isNil(var_633_0) then
				local var_633_3 = (arg_630_1.time_ - var_633_1) / var_633_2

				if arg_630_1.var_.characterEffect6056ui_story and not isNil(var_633_0) then
					arg_630_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_630_1.time_ >= var_633_1 + var_633_2 and arg_630_1.time_ < var_633_1 + var_633_2 + arg_633_0 and not isNil(var_633_0) and arg_630_1.var_.characterEffect6056ui_story then
				arg_630_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_633_4 = arg_630_1.actors_["10131ui_story"]
			local var_633_5 = 0

			if var_633_5 < arg_630_1.time_ and arg_630_1.time_ <= var_633_5 + arg_633_0 and not isNil(var_633_4) and arg_630_1.var_.characterEffect10131ui_story == nil then
				arg_630_1.var_.characterEffect10131ui_story = var_633_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_6 = 0.200000002980232

			if var_633_5 <= arg_630_1.time_ and arg_630_1.time_ < var_633_5 + var_633_6 and not isNil(var_633_4) then
				local var_633_7 = (arg_630_1.time_ - var_633_5) / var_633_6

				if arg_630_1.var_.characterEffect10131ui_story and not isNil(var_633_4) then
					local var_633_8 = Mathf.Lerp(0, 0.5, var_633_7)

					arg_630_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_630_1.var_.characterEffect10131ui_story.fillRatio = var_633_8
				end
			end

			if arg_630_1.time_ >= var_633_5 + var_633_6 and arg_630_1.time_ < var_633_5 + var_633_6 + arg_633_0 and not isNil(var_633_4) and arg_630_1.var_.characterEffect10131ui_story then
				local var_633_9 = 0.5

				arg_630_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_630_1.var_.characterEffect10131ui_story.fillRatio = var_633_9
			end

			local var_633_10 = 0

			if var_633_10 < arg_630_1.time_ and arg_630_1.time_ <= var_633_10 + arg_633_0 then
				arg_630_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_2")
			end

			local var_633_11 = 0
			local var_633_12 = 0.25

			if var_633_11 < arg_630_1.time_ and arg_630_1.time_ <= var_633_11 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				local var_633_13 = arg_630_1:FormatText(StoryNameCfg[613].name)

				arg_630_1.leftNameTxt_.text = var_633_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_14 = arg_630_1:GetWordFromCfg(322281154)
				local var_633_15 = arg_630_1:FormatText(var_633_14.content)

				arg_630_1.text_.text = var_633_15

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_16 = 10
				local var_633_17 = utf8.len(var_633_15)
				local var_633_18 = var_633_16 <= 0 and var_633_12 or var_633_12 * (var_633_17 / var_633_16)

				if var_633_18 > 0 and var_633_12 < var_633_18 then
					arg_630_1.talkMaxDuration = var_633_18

					if var_633_18 + var_633_11 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_18 + var_633_11
					end
				end

				arg_630_1.text_.text = var_633_15
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281154", "story_v_out_322281.awb") ~= 0 then
					local var_633_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281154", "story_v_out_322281.awb") / 1000

					if var_633_19 + var_633_11 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_19 + var_633_11
					end

					if var_633_14.prefab_name ~= "" and arg_630_1.actors_[var_633_14.prefab_name] ~= nil then
						local var_633_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_14.prefab_name].transform, "story_v_out_322281", "322281154", "story_v_out_322281.awb")

						arg_630_1:RecordAudio("322281154", var_633_20)
						arg_630_1:RecordAudio("322281154", var_633_20)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_out_322281", "322281154", "story_v_out_322281.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_out_322281", "322281154", "story_v_out_322281.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_21 = math.max(var_633_12, arg_630_1.talkMaxDuration)

			if var_633_11 <= arg_630_1.time_ and arg_630_1.time_ < var_633_11 + var_633_21 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_11) / var_633_21

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_11 + var_633_21 and arg_630_1.time_ < var_633_11 + var_633_21 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play322281155 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 322281155
		arg_634_1.duration_ = 2

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play322281156(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = arg_634_1.actors_["10131ui_story"]
			local var_637_1 = 0

			if var_637_1 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.characterEffect10131ui_story == nil then
				arg_634_1.var_.characterEffect10131ui_story = var_637_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_2 = 0.200000002980232

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_2 and not isNil(var_637_0) then
				local var_637_3 = (arg_634_1.time_ - var_637_1) / var_637_2

				if arg_634_1.var_.characterEffect10131ui_story and not isNil(var_637_0) then
					arg_634_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_634_1.time_ >= var_637_1 + var_637_2 and arg_634_1.time_ < var_637_1 + var_637_2 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.characterEffect10131ui_story then
				arg_634_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_637_4 = arg_634_1.actors_["6056ui_story"]
			local var_637_5 = 0

			if var_637_5 < arg_634_1.time_ and arg_634_1.time_ <= var_637_5 + arg_637_0 and not isNil(var_637_4) and arg_634_1.var_.characterEffect6056ui_story == nil then
				arg_634_1.var_.characterEffect6056ui_story = var_637_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_6 = 0.200000002980232

			if var_637_5 <= arg_634_1.time_ and arg_634_1.time_ < var_637_5 + var_637_6 and not isNil(var_637_4) then
				local var_637_7 = (arg_634_1.time_ - var_637_5) / var_637_6

				if arg_634_1.var_.characterEffect6056ui_story and not isNil(var_637_4) then
					local var_637_8 = Mathf.Lerp(0, 0.5, var_637_7)

					arg_634_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_634_1.var_.characterEffect6056ui_story.fillRatio = var_637_8
				end
			end

			if arg_634_1.time_ >= var_637_5 + var_637_6 and arg_634_1.time_ < var_637_5 + var_637_6 + arg_637_0 and not isNil(var_637_4) and arg_634_1.var_.characterEffect6056ui_story then
				local var_637_9 = 0.5

				arg_634_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_634_1.var_.characterEffect6056ui_story.fillRatio = var_637_9
			end

			local var_637_10 = 0

			if var_637_10 < arg_634_1.time_ and arg_634_1.time_ <= var_637_10 + arg_637_0 then
				arg_634_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_637_11 = 0
			local var_637_12 = 0.1

			if var_637_11 < arg_634_1.time_ and arg_634_1.time_ <= var_637_11 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				local var_637_13 = arg_634_1:FormatText(StoryNameCfg[1366].name)

				arg_634_1.leftNameTxt_.text = var_637_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_14 = arg_634_1:GetWordFromCfg(322281155)
				local var_637_15 = arg_634_1:FormatText(var_637_14.content)

				arg_634_1.text_.text = var_637_15

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_16 = 4
				local var_637_17 = utf8.len(var_637_15)
				local var_637_18 = var_637_16 <= 0 and var_637_12 or var_637_12 * (var_637_17 / var_637_16)

				if var_637_18 > 0 and var_637_12 < var_637_18 then
					arg_634_1.talkMaxDuration = var_637_18

					if var_637_18 + var_637_11 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_18 + var_637_11
					end
				end

				arg_634_1.text_.text = var_637_15
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281155", "story_v_out_322281.awb") ~= 0 then
					local var_637_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281155", "story_v_out_322281.awb") / 1000

					if var_637_19 + var_637_11 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_19 + var_637_11
					end

					if var_637_14.prefab_name ~= "" and arg_634_1.actors_[var_637_14.prefab_name] ~= nil then
						local var_637_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_14.prefab_name].transform, "story_v_out_322281", "322281155", "story_v_out_322281.awb")

						arg_634_1:RecordAudio("322281155", var_637_20)
						arg_634_1:RecordAudio("322281155", var_637_20)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_out_322281", "322281155", "story_v_out_322281.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_out_322281", "322281155", "story_v_out_322281.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_21 = math.max(var_637_12, arg_634_1.talkMaxDuration)

			if var_637_11 <= arg_634_1.time_ and arg_634_1.time_ < var_637_11 + var_637_21 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_11) / var_637_21

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_11 + var_637_21 and arg_634_1.time_ < var_637_11 + var_637_21 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play322281156 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 322281156
		arg_638_1.duration_ = 5

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play322281157(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			local var_641_0 = arg_638_1.actors_["10131ui_story"].transform
			local var_641_1 = 0

			if var_641_1 < arg_638_1.time_ and arg_638_1.time_ <= var_641_1 + arg_641_0 then
				arg_638_1.var_.moveOldPos10131ui_story = var_641_0.localPosition
			end

			local var_641_2 = 0.001

			if var_641_1 <= arg_638_1.time_ and arg_638_1.time_ < var_641_1 + var_641_2 then
				local var_641_3 = (arg_638_1.time_ - var_641_1) / var_641_2
				local var_641_4 = Vector3.New(0, 100, 0)

				var_641_0.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos10131ui_story, var_641_4, var_641_3)

				local var_641_5 = manager.ui.mainCamera.transform.position - var_641_0.position

				var_641_0.forward = Vector3.New(var_641_5.x, var_641_5.y, var_641_5.z)

				local var_641_6 = var_641_0.localEulerAngles

				var_641_6.z = 0
				var_641_6.x = 0
				var_641_0.localEulerAngles = var_641_6
			end

			if arg_638_1.time_ >= var_641_1 + var_641_2 and arg_638_1.time_ < var_641_1 + var_641_2 + arg_641_0 then
				var_641_0.localPosition = Vector3.New(0, 100, 0)

				local var_641_7 = manager.ui.mainCamera.transform.position - var_641_0.position

				var_641_0.forward = Vector3.New(var_641_7.x, var_641_7.y, var_641_7.z)

				local var_641_8 = var_641_0.localEulerAngles

				var_641_8.z = 0
				var_641_8.x = 0
				var_641_0.localEulerAngles = var_641_8
			end

			local var_641_9 = arg_638_1.actors_["6056ui_story"].transform
			local var_641_10 = 0

			if var_641_10 < arg_638_1.time_ and arg_638_1.time_ <= var_641_10 + arg_641_0 then
				arg_638_1.var_.moveOldPos6056ui_story = var_641_9.localPosition
			end

			local var_641_11 = 0.001

			if var_641_10 <= arg_638_1.time_ and arg_638_1.time_ < var_641_10 + var_641_11 then
				local var_641_12 = (arg_638_1.time_ - var_641_10) / var_641_11
				local var_641_13 = Vector3.New(0, 100, 0)

				var_641_9.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos6056ui_story, var_641_13, var_641_12)

				local var_641_14 = manager.ui.mainCamera.transform.position - var_641_9.position

				var_641_9.forward = Vector3.New(var_641_14.x, var_641_14.y, var_641_14.z)

				local var_641_15 = var_641_9.localEulerAngles

				var_641_15.z = 0
				var_641_15.x = 0
				var_641_9.localEulerAngles = var_641_15
			end

			if arg_638_1.time_ >= var_641_10 + var_641_11 and arg_638_1.time_ < var_641_10 + var_641_11 + arg_641_0 then
				var_641_9.localPosition = Vector3.New(0, 100, 0)

				local var_641_16 = manager.ui.mainCamera.transform.position - var_641_9.position

				var_641_9.forward = Vector3.New(var_641_16.x, var_641_16.y, var_641_16.z)

				local var_641_17 = var_641_9.localEulerAngles

				var_641_17.z = 0
				var_641_17.x = 0
				var_641_9.localEulerAngles = var_641_17
			end

			local var_641_18 = 0.1
			local var_641_19 = 1

			if var_641_18 < arg_638_1.time_ and arg_638_1.time_ <= var_641_18 + arg_641_0 then
				local var_641_20 = "play"
				local var_641_21 = "effect"

				arg_638_1:AudioAction(var_641_20, var_641_21, "se_story_140", "se_story_140_laser", "")
			end

			local var_641_22 = manager.ui.mainCamera.transform
			local var_641_23 = 0.166666666666667

			if var_641_23 < arg_638_1.time_ and arg_638_1.time_ <= var_641_23 + arg_641_0 then
				arg_638_1.var_.shakeOldPos = var_641_22.localPosition
			end

			local var_641_24 = 0.5

			if var_641_23 <= arg_638_1.time_ and arg_638_1.time_ < var_641_23 + var_641_24 then
				local var_641_25 = (arg_638_1.time_ - var_641_23) / 0.066
				local var_641_26, var_641_27 = math.modf(var_641_25)

				var_641_22.localPosition = Vector3.New(var_641_27 * 0.13, var_641_27 * 0.13, var_641_27 * 0.13) + arg_638_1.var_.shakeOldPos
			end

			if arg_638_1.time_ >= var_641_23 + var_641_24 and arg_638_1.time_ < var_641_23 + var_641_24 + arg_641_0 then
				var_641_22.localPosition = arg_638_1.var_.shakeOldPos
			end

			local var_641_28 = 0
			local var_641_29 = 1.7

			if var_641_28 < arg_638_1.time_ and arg_638_1.time_ <= var_641_28 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, false)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_30 = arg_638_1:GetWordFromCfg(322281156)
				local var_641_31 = arg_638_1:FormatText(var_641_30.content)

				arg_638_1.text_.text = var_641_31

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_32 = 68
				local var_641_33 = utf8.len(var_641_31)
				local var_641_34 = var_641_32 <= 0 and var_641_29 or var_641_29 * (var_641_33 / var_641_32)

				if var_641_34 > 0 and var_641_29 < var_641_34 then
					arg_638_1.talkMaxDuration = var_641_34

					if var_641_34 + var_641_28 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_34 + var_641_28
					end
				end

				arg_638_1.text_.text = var_641_31
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)
				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_35 = math.max(var_641_29, arg_638_1.talkMaxDuration)

			if var_641_28 <= arg_638_1.time_ and arg_638_1.time_ < var_641_28 + var_641_35 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_28) / var_641_35

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_28 + var_641_35 and arg_638_1.time_ < var_641_28 + var_641_35 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_638_1:InitPlayNodeList()
	end,
	Play322281157 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 322281157
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play322281158(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = 0
			local var_645_1 = 0.975

			if var_645_0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_0 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, false)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_2 = arg_642_1:GetWordFromCfg(322281157)
				local var_645_3 = arg_642_1:FormatText(var_645_2.content)

				arg_642_1.text_.text = var_645_3

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_4 = 39
				local var_645_5 = utf8.len(var_645_3)
				local var_645_6 = var_645_4 <= 0 and var_645_1 or var_645_1 * (var_645_5 / var_645_4)

				if var_645_6 > 0 and var_645_1 < var_645_6 then
					arg_642_1.talkMaxDuration = var_645_6

					if var_645_6 + var_645_0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_6 + var_645_0
					end
				end

				arg_642_1.text_.text = var_645_3
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_7 = math.max(var_645_1, arg_642_1.talkMaxDuration)

			if var_645_0 <= arg_642_1.time_ and arg_642_1.time_ < var_645_0 + var_645_7 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_0) / var_645_7

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_0 + var_645_7 and arg_642_1.time_ < var_645_0 + var_645_7 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play322281158 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 322281158
		arg_646_1.duration_ = 4.77

		local var_646_0 = {
			zh = 4.766,
			ja = 4.3
		}
		local var_646_1 = manager.audio:GetLocalizationFlag()

		if var_646_0[var_646_1] ~= nil then
			arg_646_1.duration_ = var_646_0[var_646_1]
		end

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play322281159(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = arg_646_1.actors_["10131ui_story"].transform
			local var_649_1 = 0

			if var_649_1 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 then
				arg_646_1.var_.moveOldPos10131ui_story = var_649_0.localPosition
			end

			local var_649_2 = 0.001

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_2 then
				local var_649_3 = (arg_646_1.time_ - var_649_1) / var_649_2
				local var_649_4 = Vector3.New(0.05, -0.96, -5.8)

				var_649_0.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos10131ui_story, var_649_4, var_649_3)

				local var_649_5 = manager.ui.mainCamera.transform.position - var_649_0.position

				var_649_0.forward = Vector3.New(var_649_5.x, var_649_5.y, var_649_5.z)

				local var_649_6 = var_649_0.localEulerAngles

				var_649_6.z = 0
				var_649_6.x = 0
				var_649_0.localEulerAngles = var_649_6
			end

			if arg_646_1.time_ >= var_649_1 + var_649_2 and arg_646_1.time_ < var_649_1 + var_649_2 + arg_649_0 then
				var_649_0.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_649_7 = manager.ui.mainCamera.transform.position - var_649_0.position

				var_649_0.forward = Vector3.New(var_649_7.x, var_649_7.y, var_649_7.z)

				local var_649_8 = var_649_0.localEulerAngles

				var_649_8.z = 0
				var_649_8.x = 0
				var_649_0.localEulerAngles = var_649_8
			end

			local var_649_9 = arg_646_1.actors_["10131ui_story"]
			local var_649_10 = 0

			if var_649_10 < arg_646_1.time_ and arg_646_1.time_ <= var_649_10 + arg_649_0 and not isNil(var_649_9) and arg_646_1.var_.characterEffect10131ui_story == nil then
				arg_646_1.var_.characterEffect10131ui_story = var_649_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_11 = 0.200000002980232

			if var_649_10 <= arg_646_1.time_ and arg_646_1.time_ < var_649_10 + var_649_11 and not isNil(var_649_9) then
				local var_649_12 = (arg_646_1.time_ - var_649_10) / var_649_11

				if arg_646_1.var_.characterEffect10131ui_story and not isNil(var_649_9) then
					arg_646_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_646_1.time_ >= var_649_10 + var_649_11 and arg_646_1.time_ < var_649_10 + var_649_11 + arg_649_0 and not isNil(var_649_9) and arg_646_1.var_.characterEffect10131ui_story then
				arg_646_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_649_13 = 0

			if var_649_13 < arg_646_1.time_ and arg_646_1.time_ <= var_649_13 + arg_649_0 then
				arg_646_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_649_14 = 0

			if var_649_14 < arg_646_1.time_ and arg_646_1.time_ <= var_649_14 + arg_649_0 then
				arg_646_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_649_15 = 0
			local var_649_16 = 0.3

			if var_649_15 < arg_646_1.time_ and arg_646_1.time_ <= var_649_15 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				local var_649_17 = arg_646_1:FormatText(StoryNameCfg[1366].name)

				arg_646_1.leftNameTxt_.text = var_649_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_18 = arg_646_1:GetWordFromCfg(322281158)
				local var_649_19 = arg_646_1:FormatText(var_649_18.content)

				arg_646_1.text_.text = var_649_19

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_20 = 12
				local var_649_21 = utf8.len(var_649_19)
				local var_649_22 = var_649_20 <= 0 and var_649_16 or var_649_16 * (var_649_21 / var_649_20)

				if var_649_22 > 0 and var_649_16 < var_649_22 then
					arg_646_1.talkMaxDuration = var_649_22

					if var_649_22 + var_649_15 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_22 + var_649_15
					end
				end

				arg_646_1.text_.text = var_649_19
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281158", "story_v_out_322281.awb") ~= 0 then
					local var_649_23 = manager.audio:GetVoiceLength("story_v_out_322281", "322281158", "story_v_out_322281.awb") / 1000

					if var_649_23 + var_649_15 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_23 + var_649_15
					end

					if var_649_18.prefab_name ~= "" and arg_646_1.actors_[var_649_18.prefab_name] ~= nil then
						local var_649_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_646_1.actors_[var_649_18.prefab_name].transform, "story_v_out_322281", "322281158", "story_v_out_322281.awb")

						arg_646_1:RecordAudio("322281158", var_649_24)
						arg_646_1:RecordAudio("322281158", var_649_24)
					else
						arg_646_1:AudioAction("play", "voice", "story_v_out_322281", "322281158", "story_v_out_322281.awb")
					end

					arg_646_1:RecordHistoryTalkVoice("story_v_out_322281", "322281158", "story_v_out_322281.awb")
				end

				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_25 = math.max(var_649_16, arg_646_1.talkMaxDuration)

			if var_649_15 <= arg_646_1.time_ and arg_646_1.time_ < var_649_15 + var_649_25 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_15) / var_649_25

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_15 + var_649_25 and arg_646_1.time_ < var_649_15 + var_649_25 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play322281159 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 322281159
		arg_650_1.duration_ = 6.37

		local var_650_0 = {
			zh = 6.366,
			ja = 5.6
		}
		local var_650_1 = manager.audio:GetLocalizationFlag()

		if var_650_0[var_650_1] ~= nil then
			arg_650_1.duration_ = var_650_0[var_650_1]
		end

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play322281160(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			local var_653_0 = arg_650_1.actors_["10131ui_story"].transform
			local var_653_1 = 0

			if var_653_1 < arg_650_1.time_ and arg_650_1.time_ <= var_653_1 + arg_653_0 then
				arg_650_1.var_.moveOldPos10131ui_story = var_653_0.localPosition
			end

			local var_653_2 = 0.001

			if var_653_1 <= arg_650_1.time_ and arg_650_1.time_ < var_653_1 + var_653_2 then
				local var_653_3 = (arg_650_1.time_ - var_653_1) / var_653_2
				local var_653_4 = Vector3.New(-0.78, -0.96, -5.8)

				var_653_0.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPos10131ui_story, var_653_4, var_653_3)

				local var_653_5 = manager.ui.mainCamera.transform.position - var_653_0.position

				var_653_0.forward = Vector3.New(var_653_5.x, var_653_5.y, var_653_5.z)

				local var_653_6 = var_653_0.localEulerAngles

				var_653_6.z = 0
				var_653_6.x = 0
				var_653_0.localEulerAngles = var_653_6
			end

			if arg_650_1.time_ >= var_653_1 + var_653_2 and arg_650_1.time_ < var_653_1 + var_653_2 + arg_653_0 then
				var_653_0.localPosition = Vector3.New(-0.78, -0.96, -5.8)

				local var_653_7 = manager.ui.mainCamera.transform.position - var_653_0.position

				var_653_0.forward = Vector3.New(var_653_7.x, var_653_7.y, var_653_7.z)

				local var_653_8 = var_653_0.localEulerAngles

				var_653_8.z = 0
				var_653_8.x = 0
				var_653_0.localEulerAngles = var_653_8
			end

			local var_653_9 = arg_650_1.actors_["6056ui_story"].transform
			local var_653_10 = 0

			if var_653_10 < arg_650_1.time_ and arg_650_1.time_ <= var_653_10 + arg_653_0 then
				arg_650_1.var_.moveOldPos6056ui_story = var_653_9.localPosition
			end

			local var_653_11 = 0.001

			if var_653_10 <= arg_650_1.time_ and arg_650_1.time_ < var_653_10 + var_653_11 then
				local var_653_12 = (arg_650_1.time_ - var_653_10) / var_653_11
				local var_653_13 = Vector3.New(0.95, -1.16, -6.15)

				var_653_9.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPos6056ui_story, var_653_13, var_653_12)

				local var_653_14 = manager.ui.mainCamera.transform.position - var_653_9.position

				var_653_9.forward = Vector3.New(var_653_14.x, var_653_14.y, var_653_14.z)

				local var_653_15 = var_653_9.localEulerAngles

				var_653_15.z = 0
				var_653_15.x = 0
				var_653_9.localEulerAngles = var_653_15
			end

			if arg_650_1.time_ >= var_653_10 + var_653_11 and arg_650_1.time_ < var_653_10 + var_653_11 + arg_653_0 then
				var_653_9.localPosition = Vector3.New(0.95, -1.16, -6.15)

				local var_653_16 = manager.ui.mainCamera.transform.position - var_653_9.position

				var_653_9.forward = Vector3.New(var_653_16.x, var_653_16.y, var_653_16.z)

				local var_653_17 = var_653_9.localEulerAngles

				var_653_17.z = 0
				var_653_17.x = 0
				var_653_9.localEulerAngles = var_653_17
			end

			local var_653_18 = arg_650_1.actors_["6056ui_story"]
			local var_653_19 = 0

			if var_653_19 < arg_650_1.time_ and arg_650_1.time_ <= var_653_19 + arg_653_0 and not isNil(var_653_18) and arg_650_1.var_.characterEffect6056ui_story == nil then
				arg_650_1.var_.characterEffect6056ui_story = var_653_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_20 = 0.200000002980232

			if var_653_19 <= arg_650_1.time_ and arg_650_1.time_ < var_653_19 + var_653_20 and not isNil(var_653_18) then
				local var_653_21 = (arg_650_1.time_ - var_653_19) / var_653_20

				if arg_650_1.var_.characterEffect6056ui_story and not isNil(var_653_18) then
					arg_650_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_650_1.time_ >= var_653_19 + var_653_20 and arg_650_1.time_ < var_653_19 + var_653_20 + arg_653_0 and not isNil(var_653_18) and arg_650_1.var_.characterEffect6056ui_story then
				arg_650_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_653_22 = arg_650_1.actors_["10131ui_story"]
			local var_653_23 = 0

			if var_653_23 < arg_650_1.time_ and arg_650_1.time_ <= var_653_23 + arg_653_0 and not isNil(var_653_22) and arg_650_1.var_.characterEffect10131ui_story == nil then
				arg_650_1.var_.characterEffect10131ui_story = var_653_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_24 = 0.200000002980232

			if var_653_23 <= arg_650_1.time_ and arg_650_1.time_ < var_653_23 + var_653_24 and not isNil(var_653_22) then
				local var_653_25 = (arg_650_1.time_ - var_653_23) / var_653_24

				if arg_650_1.var_.characterEffect10131ui_story and not isNil(var_653_22) then
					local var_653_26 = Mathf.Lerp(0, 0.5, var_653_25)

					arg_650_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_650_1.var_.characterEffect10131ui_story.fillRatio = var_653_26
				end
			end

			if arg_650_1.time_ >= var_653_23 + var_653_24 and arg_650_1.time_ < var_653_23 + var_653_24 + arg_653_0 and not isNil(var_653_22) and arg_650_1.var_.characterEffect10131ui_story then
				local var_653_27 = 0.5

				arg_650_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_650_1.var_.characterEffect10131ui_story.fillRatio = var_653_27
			end

			local var_653_28 = 0

			if var_653_28 < arg_650_1.time_ and arg_650_1.time_ <= var_653_28 + arg_653_0 then
				arg_650_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action3_1")
			end

			local var_653_29 = 0
			local var_653_30 = 0.5

			if var_653_29 < arg_650_1.time_ and arg_650_1.time_ <= var_653_29 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				local var_653_31 = arg_650_1:FormatText(StoryNameCfg[613].name)

				arg_650_1.leftNameTxt_.text = var_653_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_32 = arg_650_1:GetWordFromCfg(322281159)
				local var_653_33 = arg_650_1:FormatText(var_653_32.content)

				arg_650_1.text_.text = var_653_33

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_34 = 20
				local var_653_35 = utf8.len(var_653_33)
				local var_653_36 = var_653_34 <= 0 and var_653_30 or var_653_30 * (var_653_35 / var_653_34)

				if var_653_36 > 0 and var_653_30 < var_653_36 then
					arg_650_1.talkMaxDuration = var_653_36

					if var_653_36 + var_653_29 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_36 + var_653_29
					end
				end

				arg_650_1.text_.text = var_653_33
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281159", "story_v_out_322281.awb") ~= 0 then
					local var_653_37 = manager.audio:GetVoiceLength("story_v_out_322281", "322281159", "story_v_out_322281.awb") / 1000

					if var_653_37 + var_653_29 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_37 + var_653_29
					end

					if var_653_32.prefab_name ~= "" and arg_650_1.actors_[var_653_32.prefab_name] ~= nil then
						local var_653_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_32.prefab_name].transform, "story_v_out_322281", "322281159", "story_v_out_322281.awb")

						arg_650_1:RecordAudio("322281159", var_653_38)
						arg_650_1:RecordAudio("322281159", var_653_38)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_out_322281", "322281159", "story_v_out_322281.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_out_322281", "322281159", "story_v_out_322281.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_39 = math.max(var_653_30, arg_650_1.talkMaxDuration)

			if var_653_29 <= arg_650_1.time_ and arg_650_1.time_ < var_653_29 + var_653_39 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_29) / var_653_39

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_29 + var_653_39 and arg_650_1.time_ < var_653_29 + var_653_39 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_650_1:InitPlayNodeList()
	end,
	Play322281160 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 322281160
		arg_654_1.duration_ = 6.2

		local var_654_0 = {
			zh = 4.766,
			ja = 6.2
		}
		local var_654_1 = manager.audio:GetLocalizationFlag()

		if var_654_0[var_654_1] ~= nil then
			arg_654_1.duration_ = var_654_0[var_654_1]
		end

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play322281161(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = arg_654_1.actors_["10131ui_story"]
			local var_657_1 = 0

			if var_657_1 < arg_654_1.time_ and arg_654_1.time_ <= var_657_1 + arg_657_0 and not isNil(var_657_0) and arg_654_1.var_.characterEffect10131ui_story == nil then
				arg_654_1.var_.characterEffect10131ui_story = var_657_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_2 = 0.200000002980232

			if var_657_1 <= arg_654_1.time_ and arg_654_1.time_ < var_657_1 + var_657_2 and not isNil(var_657_0) then
				local var_657_3 = (arg_654_1.time_ - var_657_1) / var_657_2

				if arg_654_1.var_.characterEffect10131ui_story and not isNil(var_657_0) then
					arg_654_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_654_1.time_ >= var_657_1 + var_657_2 and arg_654_1.time_ < var_657_1 + var_657_2 + arg_657_0 and not isNil(var_657_0) and arg_654_1.var_.characterEffect10131ui_story then
				arg_654_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_657_4 = arg_654_1.actors_["6056ui_story"]
			local var_657_5 = 0

			if var_657_5 < arg_654_1.time_ and arg_654_1.time_ <= var_657_5 + arg_657_0 and not isNil(var_657_4) and arg_654_1.var_.characterEffect6056ui_story == nil then
				arg_654_1.var_.characterEffect6056ui_story = var_657_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_6 = 0.200000002980232

			if var_657_5 <= arg_654_1.time_ and arg_654_1.time_ < var_657_5 + var_657_6 and not isNil(var_657_4) then
				local var_657_7 = (arg_654_1.time_ - var_657_5) / var_657_6

				if arg_654_1.var_.characterEffect6056ui_story and not isNil(var_657_4) then
					local var_657_8 = Mathf.Lerp(0, 0.5, var_657_7)

					arg_654_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_654_1.var_.characterEffect6056ui_story.fillRatio = var_657_8
				end
			end

			if arg_654_1.time_ >= var_657_5 + var_657_6 and arg_654_1.time_ < var_657_5 + var_657_6 + arg_657_0 and not isNil(var_657_4) and arg_654_1.var_.characterEffect6056ui_story then
				local var_657_9 = 0.5

				arg_654_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_654_1.var_.characterEffect6056ui_story.fillRatio = var_657_9
			end

			local var_657_10 = 0

			if var_657_10 < arg_654_1.time_ and arg_654_1.time_ <= var_657_10 + arg_657_0 then
				arg_654_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			local var_657_11 = 0

			if var_657_11 < arg_654_1.time_ and arg_654_1.time_ <= var_657_11 + arg_657_0 then
				arg_654_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_657_12 = 0
			local var_657_13 = 0.525

			if var_657_12 < arg_654_1.time_ and arg_654_1.time_ <= var_657_12 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				local var_657_14 = arg_654_1:FormatText(StoryNameCfg[1366].name)

				arg_654_1.leftNameTxt_.text = var_657_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, false)
				arg_654_1.callingController_:SetSelectedState("normal")

				local var_657_15 = arg_654_1:GetWordFromCfg(322281160)
				local var_657_16 = arg_654_1:FormatText(var_657_15.content)

				arg_654_1.text_.text = var_657_16

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_17 = 21
				local var_657_18 = utf8.len(var_657_16)
				local var_657_19 = var_657_17 <= 0 and var_657_13 or var_657_13 * (var_657_18 / var_657_17)

				if var_657_19 > 0 and var_657_13 < var_657_19 then
					arg_654_1.talkMaxDuration = var_657_19

					if var_657_19 + var_657_12 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_19 + var_657_12
					end
				end

				arg_654_1.text_.text = var_657_16
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281160", "story_v_out_322281.awb") ~= 0 then
					local var_657_20 = manager.audio:GetVoiceLength("story_v_out_322281", "322281160", "story_v_out_322281.awb") / 1000

					if var_657_20 + var_657_12 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_20 + var_657_12
					end

					if var_657_15.prefab_name ~= "" and arg_654_1.actors_[var_657_15.prefab_name] ~= nil then
						local var_657_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_654_1.actors_[var_657_15.prefab_name].transform, "story_v_out_322281", "322281160", "story_v_out_322281.awb")

						arg_654_1:RecordAudio("322281160", var_657_21)
						arg_654_1:RecordAudio("322281160", var_657_21)
					else
						arg_654_1:AudioAction("play", "voice", "story_v_out_322281", "322281160", "story_v_out_322281.awb")
					end

					arg_654_1:RecordHistoryTalkVoice("story_v_out_322281", "322281160", "story_v_out_322281.awb")
				end

				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_22 = math.max(var_657_13, arg_654_1.talkMaxDuration)

			if var_657_12 <= arg_654_1.time_ and arg_654_1.time_ < var_657_12 + var_657_22 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_12) / var_657_22

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_12 + var_657_22 and arg_654_1.time_ < var_657_12 + var_657_22 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play322281161 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 322281161
		arg_658_1.duration_ = 2

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play322281162(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			local var_661_0 = arg_658_1.actors_["6056ui_story"]
			local var_661_1 = 0

			if var_661_1 < arg_658_1.time_ and arg_658_1.time_ <= var_661_1 + arg_661_0 and not isNil(var_661_0) and arg_658_1.var_.characterEffect6056ui_story == nil then
				arg_658_1.var_.characterEffect6056ui_story = var_661_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_2 = 0.200000002980232

			if var_661_1 <= arg_658_1.time_ and arg_658_1.time_ < var_661_1 + var_661_2 and not isNil(var_661_0) then
				local var_661_3 = (arg_658_1.time_ - var_661_1) / var_661_2

				if arg_658_1.var_.characterEffect6056ui_story and not isNil(var_661_0) then
					arg_658_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_658_1.time_ >= var_661_1 + var_661_2 and arg_658_1.time_ < var_661_1 + var_661_2 + arg_661_0 and not isNil(var_661_0) and arg_658_1.var_.characterEffect6056ui_story then
				arg_658_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_661_4 = arg_658_1.actors_["10131ui_story"]
			local var_661_5 = 0

			if var_661_5 < arg_658_1.time_ and arg_658_1.time_ <= var_661_5 + arg_661_0 and not isNil(var_661_4) and arg_658_1.var_.characterEffect10131ui_story == nil then
				arg_658_1.var_.characterEffect10131ui_story = var_661_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_6 = 0.200000002980232

			if var_661_5 <= arg_658_1.time_ and arg_658_1.time_ < var_661_5 + var_661_6 and not isNil(var_661_4) then
				local var_661_7 = (arg_658_1.time_ - var_661_5) / var_661_6

				if arg_658_1.var_.characterEffect10131ui_story and not isNil(var_661_4) then
					local var_661_8 = Mathf.Lerp(0, 0.5, var_661_7)

					arg_658_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_658_1.var_.characterEffect10131ui_story.fillRatio = var_661_8
				end
			end

			if arg_658_1.time_ >= var_661_5 + var_661_6 and arg_658_1.time_ < var_661_5 + var_661_6 + arg_661_0 and not isNil(var_661_4) and arg_658_1.var_.characterEffect10131ui_story then
				local var_661_9 = 0.5

				arg_658_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_658_1.var_.characterEffect10131ui_story.fillRatio = var_661_9
			end

			local var_661_10 = 0

			if var_661_10 < arg_658_1.time_ and arg_658_1.time_ <= var_661_10 + arg_661_0 then
				arg_658_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action3_2")
			end

			local var_661_11 = 0
			local var_661_12 = 0.15

			if var_661_11 < arg_658_1.time_ and arg_658_1.time_ <= var_661_11 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				local var_661_13 = arg_658_1:FormatText(StoryNameCfg[613].name)

				arg_658_1.leftNameTxt_.text = var_661_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_14 = arg_658_1:GetWordFromCfg(322281161)
				local var_661_15 = arg_658_1:FormatText(var_661_14.content)

				arg_658_1.text_.text = var_661_15

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_16 = 6
				local var_661_17 = utf8.len(var_661_15)
				local var_661_18 = var_661_16 <= 0 and var_661_12 or var_661_12 * (var_661_17 / var_661_16)

				if var_661_18 > 0 and var_661_12 < var_661_18 then
					arg_658_1.talkMaxDuration = var_661_18

					if var_661_18 + var_661_11 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_18 + var_661_11
					end
				end

				arg_658_1.text_.text = var_661_15
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281161", "story_v_out_322281.awb") ~= 0 then
					local var_661_19 = manager.audio:GetVoiceLength("story_v_out_322281", "322281161", "story_v_out_322281.awb") / 1000

					if var_661_19 + var_661_11 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_19 + var_661_11
					end

					if var_661_14.prefab_name ~= "" and arg_658_1.actors_[var_661_14.prefab_name] ~= nil then
						local var_661_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_14.prefab_name].transform, "story_v_out_322281", "322281161", "story_v_out_322281.awb")

						arg_658_1:RecordAudio("322281161", var_661_20)
						arg_658_1:RecordAudio("322281161", var_661_20)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_out_322281", "322281161", "story_v_out_322281.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_out_322281", "322281161", "story_v_out_322281.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_21 = math.max(var_661_12, arg_658_1.talkMaxDuration)

			if var_661_11 <= arg_658_1.time_ and arg_658_1.time_ < var_661_11 + var_661_21 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_11) / var_661_21

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_11 + var_661_21 and arg_658_1.time_ < var_661_11 + var_661_21 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play322281162 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 322281162
		arg_662_1.duration_ = 1.27

		local var_662_0 = {
			zh = 1,
			ja = 1.266
		}
		local var_662_1 = manager.audio:GetLocalizationFlag()

		if var_662_0[var_662_1] ~= nil then
			arg_662_1.duration_ = var_662_0[var_662_1]
		end

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play322281163(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			local var_665_0 = arg_662_1.actors_["10131ui_story"]
			local var_665_1 = 0

			if var_665_1 < arg_662_1.time_ and arg_662_1.time_ <= var_665_1 + arg_665_0 and not isNil(var_665_0) and arg_662_1.var_.characterEffect10131ui_story == nil then
				arg_662_1.var_.characterEffect10131ui_story = var_665_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_2 = 0.200000002980232

			if var_665_1 <= arg_662_1.time_ and arg_662_1.time_ < var_665_1 + var_665_2 and not isNil(var_665_0) then
				local var_665_3 = (arg_662_1.time_ - var_665_1) / var_665_2

				if arg_662_1.var_.characterEffect10131ui_story and not isNil(var_665_0) then
					arg_662_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_662_1.time_ >= var_665_1 + var_665_2 and arg_662_1.time_ < var_665_1 + var_665_2 + arg_665_0 and not isNil(var_665_0) and arg_662_1.var_.characterEffect10131ui_story then
				arg_662_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_665_4 = arg_662_1.actors_["6056ui_story"]
			local var_665_5 = 0

			if var_665_5 < arg_662_1.time_ and arg_662_1.time_ <= var_665_5 + arg_665_0 and not isNil(var_665_4) and arg_662_1.var_.characterEffect6056ui_story == nil then
				arg_662_1.var_.characterEffect6056ui_story = var_665_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_6 = 0.200000002980232

			if var_665_5 <= arg_662_1.time_ and arg_662_1.time_ < var_665_5 + var_665_6 and not isNil(var_665_4) then
				local var_665_7 = (arg_662_1.time_ - var_665_5) / var_665_6

				if arg_662_1.var_.characterEffect6056ui_story and not isNil(var_665_4) then
					local var_665_8 = Mathf.Lerp(0, 0.5, var_665_7)

					arg_662_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_662_1.var_.characterEffect6056ui_story.fillRatio = var_665_8
				end
			end

			if arg_662_1.time_ >= var_665_5 + var_665_6 and arg_662_1.time_ < var_665_5 + var_665_6 + arg_665_0 and not isNil(var_665_4) and arg_662_1.var_.characterEffect6056ui_story then
				local var_665_9 = 0.5

				arg_662_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_662_1.var_.characterEffect6056ui_story.fillRatio = var_665_9
			end

			local var_665_10 = 0
			local var_665_11 = 0.075

			if var_665_10 < arg_662_1.time_ and arg_662_1.time_ <= var_665_10 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				local var_665_12 = arg_662_1:FormatText(StoryNameCfg[1366].name)

				arg_662_1.leftNameTxt_.text = var_665_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_13 = arg_662_1:GetWordFromCfg(322281162)
				local var_665_14 = arg_662_1:FormatText(var_665_13.content)

				arg_662_1.text_.text = var_665_14

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_15 = 3
				local var_665_16 = utf8.len(var_665_14)
				local var_665_17 = var_665_15 <= 0 and var_665_11 or var_665_11 * (var_665_16 / var_665_15)

				if var_665_17 > 0 and var_665_11 < var_665_17 then
					arg_662_1.talkMaxDuration = var_665_17

					if var_665_17 + var_665_10 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_17 + var_665_10
					end
				end

				arg_662_1.text_.text = var_665_14
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281162", "story_v_out_322281.awb") ~= 0 then
					local var_665_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281162", "story_v_out_322281.awb") / 1000

					if var_665_18 + var_665_10 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_18 + var_665_10
					end

					if var_665_13.prefab_name ~= "" and arg_662_1.actors_[var_665_13.prefab_name] ~= nil then
						local var_665_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_13.prefab_name].transform, "story_v_out_322281", "322281162", "story_v_out_322281.awb")

						arg_662_1:RecordAudio("322281162", var_665_19)
						arg_662_1:RecordAudio("322281162", var_665_19)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_out_322281", "322281162", "story_v_out_322281.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_out_322281", "322281162", "story_v_out_322281.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_20 = math.max(var_665_11, arg_662_1.talkMaxDuration)

			if var_665_10 <= arg_662_1.time_ and arg_662_1.time_ < var_665_10 + var_665_20 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_10) / var_665_20

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_10 + var_665_20 and arg_662_1.time_ < var_665_10 + var_665_20 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play322281163 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 322281163
		arg_666_1.duration_ = 9

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play322281164(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = "I17l"

			if arg_666_1.bgs_[var_669_0] == nil then
				local var_669_1 = Object.Instantiate(arg_666_1.paintGo_)

				var_669_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_669_0)
				var_669_1.name = var_669_0
				var_669_1.transform.parent = arg_666_1.stage_.transform
				var_669_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_666_1.bgs_[var_669_0] = var_669_1
			end

			local var_669_2 = 2

			if var_669_2 < arg_666_1.time_ and arg_666_1.time_ <= var_669_2 + arg_669_0 then
				local var_669_3 = manager.ui.mainCamera.transform.localPosition
				local var_669_4 = Vector3.New(0, 0, 10) + Vector3.New(var_669_3.x, var_669_3.y, 0)
				local var_669_5 = arg_666_1.bgs_.I17l

				var_669_5.transform.localPosition = var_669_4
				var_669_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_669_6 = var_669_5:GetComponent("SpriteRenderer")

				if var_669_6 and var_669_6.sprite then
					local var_669_7 = (var_669_5.transform.localPosition - var_669_3).z
					local var_669_8 = manager.ui.mainCameraCom_
					local var_669_9 = 2 * var_669_7 * Mathf.Tan(var_669_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_669_10 = var_669_9 * var_669_8.aspect
					local var_669_11 = var_669_6.sprite.bounds.size.x
					local var_669_12 = var_669_6.sprite.bounds.size.y
					local var_669_13 = var_669_10 / var_669_11
					local var_669_14 = var_669_9 / var_669_12
					local var_669_15 = var_669_14 < var_669_13 and var_669_13 or var_669_14

					var_669_5.transform.localScale = Vector3.New(var_669_15, var_669_15, 0)
				end

				for iter_669_0, iter_669_1 in pairs(arg_666_1.bgs_) do
					if iter_669_0 ~= "I17l" then
						iter_669_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_669_16 = 4

			if var_669_16 < arg_666_1.time_ and arg_666_1.time_ <= var_669_16 + arg_669_0 then
				arg_666_1.allBtn_.enabled = false
			end

			local var_669_17 = 0.766666666666667

			if arg_666_1.time_ >= var_669_16 + var_669_17 and arg_666_1.time_ < var_669_16 + var_669_17 + arg_669_0 then
				arg_666_1.allBtn_.enabled = true
			end

			local var_669_18 = 0

			if var_669_18 < arg_666_1.time_ and arg_666_1.time_ <= var_669_18 + arg_669_0 then
				arg_666_1.mask_.enabled = true
				arg_666_1.mask_.raycastTarget = true

				arg_666_1:SetGaussion(false)
			end

			local var_669_19 = 2

			if var_669_18 <= arg_666_1.time_ and arg_666_1.time_ < var_669_18 + var_669_19 then
				local var_669_20 = (arg_666_1.time_ - var_669_18) / var_669_19
				local var_669_21 = Color.New(0, 0, 0)

				var_669_21.a = Mathf.Lerp(0, 1, var_669_20)
				arg_666_1.mask_.color = var_669_21
			end

			if arg_666_1.time_ >= var_669_18 + var_669_19 and arg_666_1.time_ < var_669_18 + var_669_19 + arg_669_0 then
				local var_669_22 = Color.New(0, 0, 0)

				var_669_22.a = 1
				arg_666_1.mask_.color = var_669_22
			end

			local var_669_23 = 2

			if var_669_23 < arg_666_1.time_ and arg_666_1.time_ <= var_669_23 + arg_669_0 then
				arg_666_1.mask_.enabled = true
				arg_666_1.mask_.raycastTarget = true

				arg_666_1:SetGaussion(false)
			end

			local var_669_24 = 2

			if var_669_23 <= arg_666_1.time_ and arg_666_1.time_ < var_669_23 + var_669_24 then
				local var_669_25 = (arg_666_1.time_ - var_669_23) / var_669_24
				local var_669_26 = Color.New(0, 0, 0)

				var_669_26.a = Mathf.Lerp(1, 0, var_669_25)
				arg_666_1.mask_.color = var_669_26
			end

			if arg_666_1.time_ >= var_669_23 + var_669_24 and arg_666_1.time_ < var_669_23 + var_669_24 + arg_669_0 then
				local var_669_27 = Color.New(0, 0, 0)
				local var_669_28 = 0

				arg_666_1.mask_.enabled = false
				var_669_27.a = var_669_28
				arg_666_1.mask_.color = var_669_27
			end

			local var_669_29 = arg_666_1.actors_["10131ui_story"].transform
			local var_669_30 = 2

			if var_669_30 < arg_666_1.time_ and arg_666_1.time_ <= var_669_30 + arg_669_0 then
				arg_666_1.var_.moveOldPos10131ui_story = var_669_29.localPosition
			end

			local var_669_31 = 0.001

			if var_669_30 <= arg_666_1.time_ and arg_666_1.time_ < var_669_30 + var_669_31 then
				local var_669_32 = (arg_666_1.time_ - var_669_30) / var_669_31
				local var_669_33 = Vector3.New(0, 100, 0)

				var_669_29.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPos10131ui_story, var_669_33, var_669_32)

				local var_669_34 = manager.ui.mainCamera.transform.position - var_669_29.position

				var_669_29.forward = Vector3.New(var_669_34.x, var_669_34.y, var_669_34.z)

				local var_669_35 = var_669_29.localEulerAngles

				var_669_35.z = 0
				var_669_35.x = 0
				var_669_29.localEulerAngles = var_669_35
			end

			if arg_666_1.time_ >= var_669_30 + var_669_31 and arg_666_1.time_ < var_669_30 + var_669_31 + arg_669_0 then
				var_669_29.localPosition = Vector3.New(0, 100, 0)

				local var_669_36 = manager.ui.mainCamera.transform.position - var_669_29.position

				var_669_29.forward = Vector3.New(var_669_36.x, var_669_36.y, var_669_36.z)

				local var_669_37 = var_669_29.localEulerAngles

				var_669_37.z = 0
				var_669_37.x = 0
				var_669_29.localEulerAngles = var_669_37
			end

			local var_669_38 = arg_666_1.actors_["6056ui_story"].transform
			local var_669_39 = 2

			if var_669_39 < arg_666_1.time_ and arg_666_1.time_ <= var_669_39 + arg_669_0 then
				arg_666_1.var_.moveOldPos6056ui_story = var_669_38.localPosition
			end

			local var_669_40 = 0.001

			if var_669_39 <= arg_666_1.time_ and arg_666_1.time_ < var_669_39 + var_669_40 then
				local var_669_41 = (arg_666_1.time_ - var_669_39) / var_669_40
				local var_669_42 = Vector3.New(0, 100, 0)

				var_669_38.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPos6056ui_story, var_669_42, var_669_41)

				local var_669_43 = manager.ui.mainCamera.transform.position - var_669_38.position

				var_669_38.forward = Vector3.New(var_669_43.x, var_669_43.y, var_669_43.z)

				local var_669_44 = var_669_38.localEulerAngles

				var_669_44.z = 0
				var_669_44.x = 0
				var_669_38.localEulerAngles = var_669_44
			end

			if arg_666_1.time_ >= var_669_39 + var_669_40 and arg_666_1.time_ < var_669_39 + var_669_40 + arg_669_0 then
				var_669_38.localPosition = Vector3.New(0, 100, 0)

				local var_669_45 = manager.ui.mainCamera.transform.position - var_669_38.position

				var_669_38.forward = Vector3.New(var_669_45.x, var_669_45.y, var_669_45.z)

				local var_669_46 = var_669_38.localEulerAngles

				var_669_46.z = 0
				var_669_46.x = 0
				var_669_38.localEulerAngles = var_669_46
			end

			local var_669_47 = 0.166666666666667
			local var_669_48 = 1

			if var_669_47 < arg_666_1.time_ and arg_666_1.time_ <= var_669_47 + arg_669_0 then
				local var_669_49 = "stop"
				local var_669_50 = "effect"

				arg_666_1:AudioAction(var_669_49, var_669_50, "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			local var_669_51 = 1.6
			local var_669_52 = 1

			if var_669_51 < arg_666_1.time_ and arg_666_1.time_ <= var_669_51 + arg_669_0 then
				local var_669_53 = "play"
				local var_669_54 = "effect"

				arg_666_1:AudioAction(var_669_53, var_669_54, "se_story_1210", "se_story_1210_morning_loop", "")
			end

			local var_669_55 = arg_666_1.bgs_.I17l.transform
			local var_669_56 = 2

			if var_669_56 < arg_666_1.time_ and arg_666_1.time_ <= var_669_56 + arg_669_0 then
				arg_666_1.var_.moveOldPosI17l = var_669_55.localPosition
			end

			local var_669_57 = 1.96599999815226

			if var_669_56 <= arg_666_1.time_ and arg_666_1.time_ < var_669_56 + var_669_57 then
				local var_669_58 = (arg_666_1.time_ - var_669_56) / var_669_57
				local var_669_59 = Vector3.New(0, 1, 9)

				var_669_55.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPosI17l, var_669_59, var_669_58)
			end

			if arg_666_1.time_ >= var_669_56 + var_669_57 and arg_666_1.time_ < var_669_56 + var_669_57 + arg_669_0 then
				var_669_55.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_666_1.frameCnt_ <= 1 then
				arg_666_1.dialog_:SetActive(false)
			end

			local var_669_60 = 4
			local var_669_61 = 1.025

			if var_669_60 < arg_666_1.time_ and arg_666_1.time_ <= var_669_60 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0

				arg_666_1.dialog_:SetActive(true)

				arg_666_1.dialogCg_.alpha = 0

				local var_669_62 = LeanTween.value(arg_666_1.dialog_, 0, 1, 0.3)

				var_669_62:setOnUpdate(LuaHelper.FloatAction(function(arg_670_0)
					arg_666_1.dialogCg_.alpha = arg_670_0
				end))
				var_669_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_666_1.dialog_)
					var_669_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_666_1.duration_ = arg_666_1.duration_ + 0.3

				SetActive(arg_666_1.leftNameGo_, false)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_63 = arg_666_1:GetWordFromCfg(322281163)
				local var_669_64 = arg_666_1:FormatText(var_669_63.content)

				arg_666_1.text_.text = var_669_64

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_65 = 41
				local var_669_66 = utf8.len(var_669_64)
				local var_669_67 = var_669_65 <= 0 and var_669_61 or var_669_61 * (var_669_66 / var_669_65)

				if var_669_67 > 0 and var_669_61 < var_669_67 then
					arg_666_1.talkMaxDuration = var_669_67
					var_669_60 = var_669_60 + 0.3

					if var_669_67 + var_669_60 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_67 + var_669_60
					end
				end

				arg_666_1.text_.text = var_669_64
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)
				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_68 = var_669_60 + 0.3
			local var_669_69 = math.max(var_669_61, arg_666_1.talkMaxDuration)

			if var_669_68 <= arg_666_1.time_ and arg_666_1.time_ < var_669_68 + var_669_69 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_68) / var_669_69

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_68 + var_669_69 and arg_666_1.time_ < var_669_68 + var_669_69 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "I17l",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.96599999815226,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_666_1:InitPlayNodeList()
	end,
	Play322281164 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 322281164
		arg_672_1.duration_ = 7.77

		local var_672_0 = {
			zh = 5.4,
			ja = 7.766
		}
		local var_672_1 = manager.audio:GetLocalizationFlag()

		if var_672_0[var_672_1] ~= nil then
			arg_672_1.duration_ = var_672_0[var_672_1]
		end

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play322281165(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 0
			local var_675_1 = 0.45

			if var_675_0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				local var_675_2 = arg_672_1:FormatText(StoryNameCfg[613].name)

				arg_672_1.leftNameTxt_.text = var_675_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_3 = arg_672_1:GetWordFromCfg(322281164)
				local var_675_4 = arg_672_1:FormatText(var_675_3.content)

				arg_672_1.text_.text = var_675_4

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_5 = 18
				local var_675_6 = utf8.len(var_675_4)
				local var_675_7 = var_675_5 <= 0 and var_675_1 or var_675_1 * (var_675_6 / var_675_5)

				if var_675_7 > 0 and var_675_1 < var_675_7 then
					arg_672_1.talkMaxDuration = var_675_7

					if var_675_7 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_7 + var_675_0
					end
				end

				arg_672_1.text_.text = var_675_4
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281164", "story_v_out_322281.awb") ~= 0 then
					local var_675_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281164", "story_v_out_322281.awb") / 1000

					if var_675_8 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_8 + var_675_0
					end

					if var_675_3.prefab_name ~= "" and arg_672_1.actors_[var_675_3.prefab_name] ~= nil then
						local var_675_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_3.prefab_name].transform, "story_v_out_322281", "322281164", "story_v_out_322281.awb")

						arg_672_1:RecordAudio("322281164", var_675_9)
						arg_672_1:RecordAudio("322281164", var_675_9)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_out_322281", "322281164", "story_v_out_322281.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_out_322281", "322281164", "story_v_out_322281.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_10 = math.max(var_675_1, arg_672_1.talkMaxDuration)

			if var_675_0 <= arg_672_1.time_ and arg_672_1.time_ < var_675_0 + var_675_10 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_0) / var_675_10

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_0 + var_675_10 and arg_672_1.time_ < var_675_0 + var_675_10 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play322281165 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 322281165
		arg_676_1.duration_ = 3

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play322281166(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0

			if var_679_0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_0 + arg_679_0 then
				arg_676_1.mask_.enabled = true
				arg_676_1.mask_.raycastTarget = true

				arg_676_1:SetGaussion(false)
			end

			local var_679_1 = 1

			if var_679_0 <= arg_676_1.time_ and arg_676_1.time_ < var_679_0 + var_679_1 then
				local var_679_2 = (arg_676_1.time_ - var_679_0) / var_679_1
				local var_679_3 = Color.New(0, 0, 0)

				var_679_3.a = Mathf.Lerp(0, 1, var_679_2)
				arg_676_1.mask_.color = var_679_3
			end

			if arg_676_1.time_ >= var_679_0 + var_679_1 and arg_676_1.time_ < var_679_0 + var_679_1 + arg_679_0 then
				local var_679_4 = Color.New(0, 0, 0)

				var_679_4.a = 1
				arg_676_1.mask_.color = var_679_4
			end

			local var_679_5 = 1

			if var_679_5 < arg_676_1.time_ and arg_676_1.time_ <= var_679_5 + arg_679_0 then
				arg_676_1.mask_.enabled = true
				arg_676_1.mask_.raycastTarget = true

				arg_676_1:SetGaussion(false)
			end

			local var_679_6 = 1

			if var_679_5 <= arg_676_1.time_ and arg_676_1.time_ < var_679_5 + var_679_6 then
				local var_679_7 = (arg_676_1.time_ - var_679_5) / var_679_6
				local var_679_8 = Color.New(0, 0, 0)

				var_679_8.a = Mathf.Lerp(1, 0, var_679_7)
				arg_676_1.mask_.color = var_679_8
			end

			if arg_676_1.time_ >= var_679_5 + var_679_6 and arg_676_1.time_ < var_679_5 + var_679_6 + arg_679_0 then
				local var_679_9 = Color.New(0, 0, 0)
				local var_679_10 = 0

				arg_676_1.mask_.enabled = false
				var_679_9.a = var_679_10
				arg_676_1.mask_.color = var_679_9
			end
		end

		arg_676_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 102,
				charCount = 0,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.966666666666666,
				groupID = "11165",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322281165,
				charCount = 10,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.666666666666667,
				groupID = "1",
				startTime = 1.96666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_676_1:InitPlayNodeList()
	end,
	Play322281166 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 322281166
		arg_680_1.duration_ = 2

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play322281167(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			return
		end

		arg_680_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322281166,
				charCount = 30,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 2,
				groupID = "2",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1",
				duration = 1,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_680_1:InitPlayNodeList()
	end,
	Play322281167 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 322281167
		arg_684_1.duration_ = 2

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play322281168(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			return
		end

		arg_684_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322281167,
				charCount = 19,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 1.26666666666667,
				groupID = "3",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "2",
				duration = 0.133333333333333,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_684_1:InitPlayNodeList()
	end,
	Play322281168 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 322281168
		arg_688_1.duration_ = 2

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play322281169(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			return
		end

		arg_688_1.nodeConfigList_ = {
			{
				groupID = "3",
				duration = 2,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322281168,
				charCount = 18,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 1.2,
				groupID = "4",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_688_1:InitPlayNodeList()
	end,
	Play322281169 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 322281169
		arg_692_1.duration_ = 1.67

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
			arg_692_1.auto_ = false
		end

		function arg_692_1.playNext_(arg_694_0)
			arg_692_1.onStoryFinished_()
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			return
		end

		arg_692_1.nodeConfigList_ = {
			{
				groupID = "4",
				duration = 1.66666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322281169,
				charCount = 14,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.933333333333333,
				groupID = "5",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.ENABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_692_1:InitPlayNodeList()
	end,
	Play322281063 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 322281063
		arg_696_1.duration_ = 4.23

		local var_696_0 = {
			zh = 3.7,
			ja = 4.233
		}
		local var_696_1 = manager.audio:GetLocalizationFlag()

		if var_696_0[var_696_1] ~= nil then
			arg_696_1.duration_ = var_696_0[var_696_1]
		end

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play322281064(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = "1020ui_story"

			if arg_696_1.actors_[var_699_0] == nil then
				local var_699_1 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_699_1) then
					local var_699_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_696_1.stage_.transform)

					var_699_2.name = var_699_0
					var_699_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_696_1.actors_[var_699_0] = var_699_2

					local var_699_3 = var_699_2:GetComponentInChildren(typeof(CharacterEffect))

					var_699_3.enabled = true

					local var_699_4 = GameObjectTools.GetOrAddComponent(var_699_2, typeof(DynamicBoneHelper))

					if var_699_4 then
						var_699_4:EnableDynamicBone(false)
					end

					arg_696_1:ShowWeapon(var_699_3.transform, false)

					arg_696_1.var_[var_699_0 .. "Animator"] = var_699_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_696_1.var_[var_699_0 .. "Animator"].applyRootMotion = true
					arg_696_1.var_[var_699_0 .. "LipSync"] = var_699_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_699_5 = 0

			if var_699_5 < arg_696_1.time_ and arg_696_1.time_ <= var_699_5 + arg_699_0 then
				arg_696_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_699_6 = arg_696_1.actors_["1020ui_story"]
			local var_699_7 = 0

			if var_699_7 < arg_696_1.time_ and arg_696_1.time_ <= var_699_7 + arg_699_0 and not isNil(var_699_6) and arg_696_1.var_.characterEffect1020ui_story == nil then
				arg_696_1.var_.characterEffect1020ui_story = var_699_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_699_8 = 0.200000002980232

			if var_699_7 <= arg_696_1.time_ and arg_696_1.time_ < var_699_7 + var_699_8 and not isNil(var_699_6) then
				local var_699_9 = (arg_696_1.time_ - var_699_7) / var_699_8

				if arg_696_1.var_.characterEffect1020ui_story and not isNil(var_699_6) then
					arg_696_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_696_1.time_ >= var_699_7 + var_699_8 and arg_696_1.time_ < var_699_7 + var_699_8 + arg_699_0 and not isNil(var_699_6) and arg_696_1.var_.characterEffect1020ui_story then
				arg_696_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_699_10 = 0
			local var_699_11 = 0.375

			if var_699_10 < arg_696_1.time_ and arg_696_1.time_ <= var_699_10 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, true)

				local var_699_12 = arg_696_1:FormatText(StoryNameCfg[613].name)

				arg_696_1.leftNameTxt_.text = var_699_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_696_1.leftNameTxt_.transform)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1.leftNameTxt_.text)
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_13 = arg_696_1:GetWordFromCfg(322281063)
				local var_699_14 = arg_696_1:FormatText(var_699_13.content)

				arg_696_1.text_.text = var_699_14

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_15 = 15
				local var_699_16 = utf8.len(var_699_14)
				local var_699_17 = var_699_15 <= 0 and var_699_11 or var_699_11 * (var_699_16 / var_699_15)

				if var_699_17 > 0 and var_699_11 < var_699_17 then
					arg_696_1.talkMaxDuration = var_699_17

					if var_699_17 + var_699_10 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_17 + var_699_10
					end
				end

				arg_696_1.text_.text = var_699_14
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281063", "story_v_out_322281.awb") ~= 0 then
					local var_699_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281063", "story_v_out_322281.awb") / 1000

					if var_699_18 + var_699_10 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_18 + var_699_10
					end

					if var_699_13.prefab_name ~= "" and arg_696_1.actors_[var_699_13.prefab_name] ~= nil then
						local var_699_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_696_1.actors_[var_699_13.prefab_name].transform, "story_v_out_322281", "322281063", "story_v_out_322281.awb")

						arg_696_1:RecordAudio("322281063", var_699_19)
						arg_696_1:RecordAudio("322281063", var_699_19)
					else
						arg_696_1:AudioAction("play", "voice", "story_v_out_322281", "322281063", "story_v_out_322281.awb")
					end

					arg_696_1:RecordHistoryTalkVoice("story_v_out_322281", "322281063", "story_v_out_322281.awb")
				end

				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_20 = math.max(var_699_11, arg_696_1.talkMaxDuration)

			if var_699_10 <= arg_696_1.time_ and arg_696_1.time_ < var_699_10 + var_699_20 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_10) / var_699_20

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_10 + var_699_20 and arg_696_1.time_ < var_699_10 + var_699_20 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST18a",
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/L10i",
		"TextureConfig/Background/I17l"
	},
	voices = {
		"story_v_out_322281.awb"
	}
}
