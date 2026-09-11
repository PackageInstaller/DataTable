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
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = 1

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_8 + 1 and arg_1_1.time_ < var_4_8 + 1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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
			if 1.999999999999 < arg_18_1.time_ and arg_18_1.time_ <= 1.999999999999 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			if arg_18_1.time_ >= 1.999999999999 + 0.133333333334333 and arg_18_1.time_ < 1.999999999999 + 0.133333333334333 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_0 = "ST18a"

			if arg_18_1.bgs_.ST18a == nil then
				local var_21_1 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_0)
				var_21_1.name = var_21_0
				var_21_1.transform.parent = arg_18_1.stage_.transform
				var_21_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_0] = var_21_1
			end

			if 1.03333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 1.03333333333333 + arg_21_0 then
				local var_21_2 = arg_18_1.bgs_.ST18a

				arg_18_1.bgs_.ST18a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_21_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_3 = var_21_2:GetComponent("SpriteRenderer")

				if var_21_3 and var_21_3.sprite then
					local var_21_4 = 2 * (var_21_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_21_2.transform.localScale = Vector3.New(var_21_4 / var_21_3.sprite.bounds.size.y < var_21_4 * manager.ui.mainCameraCom_.aspect / var_21_3.sprite.bounds.size.x and var_21_4 * manager.ui.mainCameraCom_.aspect / var_21_3.sprite.bounds.size.x or var_21_4 / var_21_3.sprite.bounds.size.y, var_21_4 / var_21_3.sprite.bounds.size.y < var_21_4 * manager.ui.mainCameraCom_.aspect / var_21_3.sprite.bounds.size.x and var_21_4 * manager.ui.mainCameraCom_.aspect / var_21_3.sprite.bounds.size.x or var_21_4 / var_21_3.sprite.bounds.size.y, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "ST18a" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_5 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_6 = 1

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_6 then
				local var_21_7 = Color.New(0, 0, 0)

				var_21_7.a = Mathf.Lerp(0, 1, (arg_18_1.time_ - var_21_5) / var_21_6)
				arg_18_1.mask_.color = var_21_7
			end

			if arg_18_1.time_ >= var_21_5 + var_21_6 and arg_18_1.time_ < var_21_5 + var_21_6 + arg_21_0 then
				local var_21_8 = Color.New(0, 0, 0)

				var_21_8.a = 1
				arg_18_1.mask_.color = var_21_8
			end

			local var_21_9 = 1

			if 1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_10 = 1

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_10 then
				local var_21_11 = Color.New(0, 0, 0)

				var_21_11.a = Mathf.Lerp(1, 0, (arg_18_1.time_ - var_21_9) / var_21_10)
				arg_18_1.mask_.color = var_21_11
			end

			if arg_18_1.time_ >= var_21_9 + var_21_10 and arg_18_1.time_ < var_21_9 + var_21_10 + arg_21_0 then
				local var_21_12 = Color.New(0, 0, 0)

				arg_18_1.mask_.enabled = false
				var_21_12.a = 0
				arg_18_1.mask_.color = var_21_12
			end

			local var_21_13 = "10101ui_story"

			if arg_18_1.actors_["10101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10101ui_story"))) then
				local var_21_14 = Object.Instantiate(Asset.Load("Char/" .. "10101ui_story"), arg_18_1.stage_.transform)

				var_21_14.name = var_21_13
				var_21_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.actors_[var_21_13] = var_21_14

				local var_21_15 = var_21_14:GetComponentInChildren(typeof(CharacterEffect))

				var_21_15.enabled = true

				local var_21_16 = GameObjectTools.GetOrAddComponent(var_21_14, typeof(DynamicBoneHelper))

				if var_21_16 then
					var_21_16:EnableDynamicBone(false)
				end

				arg_18_1:ShowWeapon(var_21_15.transform, false)

				arg_18_1.var_[var_21_13 .. "Animator"] = var_21_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_18_1.var_[var_21_13 .. "Animator"].applyRootMotion = true
				arg_18_1.var_[var_21_13 .. "LipSync"] = var_21_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_21_17 = arg_18_1.actors_["10101ui_story"].transform

			if 1.03333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 1.03333333333333 + arg_21_0 then
				arg_18_1.var_.moveOldPos10101ui_story = var_21_17.localPosition
			end

			local var_21_18 = 0.001

			if 1.03333333333333 <= arg_18_1.time_ and arg_18_1.time_ < 1.03333333333333 + var_21_18 then
				var_21_17.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_18_1.time_ - 1.03333333333333) / var_21_18)
				var_21_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_17.position).x, (manager.ui.mainCamera.transform.position - var_21_17.position).y, (manager.ui.mainCamera.transform.position - var_21_17.position).z)
				var_21_17.localEulerAngles.z = 0
				var_21_17.localEulerAngles.x = 0
				var_21_17.localEulerAngles = var_21_17.localEulerAngles
			end

			if arg_18_1.time_ >= 1.03333333333333 + var_21_18 and arg_18_1.time_ < 1.03333333333333 + var_21_18 + arg_21_0 then
				var_21_17.localPosition = Vector3.New(0, -1.16, -6.01)
				var_21_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_17.position).x, (manager.ui.mainCamera.transform.position - var_21_17.position).y, (manager.ui.mainCamera.transform.position - var_21_17.position).z)
				var_21_17.localEulerAngles.z = 0
				var_21_17.localEulerAngles.x = 0
				var_21_17.localEulerAngles = var_21_17.localEulerAngles
			end

			local var_21_19 = arg_18_1.actors_["10101ui_story"]

			if 1.03333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 1.03333333333333 + arg_21_0 and not isNil(var_21_19) and arg_18_1.var_.characterEffect10101ui_story == nil then
				arg_18_1.var_.characterEffect10101ui_story = var_21_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_20 = 0.2

			if 1.03333333333333 <= arg_18_1.time_ and arg_18_1.time_ < 1.03333333333333 + var_21_20 and not isNil(var_21_19) then
				if arg_18_1.var_.characterEffect10101ui_story and not isNil(var_21_19) then
					arg_18_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 1.03333333333333 + var_21_20 and arg_18_1.time_ < 1.03333333333333 + var_21_20 + arg_21_0 and not isNil(var_21_19) and arg_18_1.var_.characterEffect10101ui_story then
				arg_18_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 1.03333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 1.03333333333333 + arg_21_0 then
				arg_18_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 1.03333333333433 < arg_18_1.time_ and arg_18_1.time_ <= 1.03333333333433 + arg_21_0 then
				arg_18_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_21_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_24 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_24

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_24
						arg_18_1.bgmTxt2_.text = var_21_24
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

			if 0.500666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 0.500666666666667 + arg_21_0 then
				arg_18_1:AudioAction("play", "music", "bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra.awb")

				local var_21_27 = manager.audio:GetAudioName("bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra")

				if "" ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_27 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_27

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_27
						arg_18_1.bgmTxt2_.text = var_21_27
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

			if 0.2 < arg_18_1.time_ and arg_18_1.time_ <= 0.2 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_ui_loop", "")
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_29 = 1.999999999999
			local var_21_30 = 0.175

			if 1.999999999999 < arg_18_1.time_ and arg_18_1.time_ <= var_21_29 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_31 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_31:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_18_1.dialogCg_.alpha = arg_24_0
				end))
				var_21_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_32 = arg_18_1:GetWordFromCfg(322281005)
				local var_21_33 = arg_18_1:FormatText(var_21_32.content)

				arg_18_1.text_.text = var_21_33

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_35 = 7 <= 0 and var_21_30 or var_21_30 * (utf8.len(var_21_33) / 7)

				if (7 <= 0 and var_21_30 or var_21_30 * (utf8.len(var_21_33) / 7)) > 0 and var_21_30 < var_21_35 then
					arg_18_1.talkMaxDuration = var_21_35
					var_21_29 = var_21_29 + 0.3

					if var_21_35 + var_21_29 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_35 + var_21_29
					end
				end

				arg_18_1.text_.text = var_21_33
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281005", "story_v_out_322281.awb") ~= 0 then
					local var_21_36 = manager.audio:GetVoiceLength("story_v_out_322281", "322281005", "story_v_out_322281.awb") / 1000

					if var_21_36 + var_21_29 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_36 + var_21_29
					end

					if var_21_32.prefab_name ~= "" and arg_18_1.actors_[var_21_32.prefab_name] ~= nil then
						local var_21_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_32.prefab_name].transform, "story_v_out_322281", "322281005", "story_v_out_322281.awb")

						arg_18_1:RecordAudio("322281005", var_21_37)
						arg_18_1:RecordAudio("322281005", var_21_37)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322281", "322281005", "story_v_out_322281.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322281", "322281005", "story_v_out_322281.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_38 = var_21_29 + 0.3
			local var_21_39 = math.max(var_21_30, arg_18_1.talkMaxDuration)

			if var_21_29 + 0.3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_38 + var_21_39 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_38) / var_21_39

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_38 + var_21_39 and arg_18_1.time_ < var_21_38 + var_21_39 + arg_21_0 then
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
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos10101ui_story = arg_26_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_29_0 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 then
				arg_26_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_26_1.time_ - 0) / var_29_0)
				arg_26_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["10101ui_story"].transform.position).z)
				arg_26_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["10101ui_story"].transform.localEulerAngles = arg_26_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 then
				arg_26_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["10101ui_story"].transform.position).z)
				arg_26_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["10101ui_story"].transform.localEulerAngles = arg_26_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_29_1 = 0
			local var_29_2 = 1.45

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(322281006).content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 58 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 58)

				if (58 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 58)) > 0 and var_29_2 < var_29_5 then
					arg_26_1.talkMaxDuration = var_29_5

					if var_29_5 + var_29_1 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + var_29_1
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_6 = math.max(var_29_2, arg_26_1.talkMaxDuration)

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_6 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_1) / var_29_6

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_1 + var_29_6 and arg_26_1.time_ < var_29_1 + var_29_6 + arg_29_0 then
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
			local var_33_0 = 0.275

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[7].name)

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

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(322281007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 11 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 11)

				if (11 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 11)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
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
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10101ui_story = arg_34_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_34_1.time_ - 0) / var_37_0)
				arg_34_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10101ui_story"].transform.position).z)
				arg_34_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["10101ui_story"].transform.localEulerAngles = arg_34_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.01)
				arg_34_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10101ui_story"].transform.position).z)
				arg_34_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["10101ui_story"].transform.localEulerAngles = arg_34_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_37_1 = arg_34_1.actors_["10101ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect10101ui_story == nil then
				arg_34_1.var_.characterEffect10101ui_story = var_37_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_2 and not isNil(var_37_1) then
				if arg_34_1.var_.characterEffect10101ui_story and not isNil(var_37_1) then
					arg_34_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_2 and arg_34_1.time_ < 0 + var_37_2 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect10101ui_story then
				arg_34_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_37_4 = 0
			local var_37_5 = 0.275

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_6 = arg_34_1:GetWordFromCfg(322281008)
				local var_37_7 = arg_34_1:FormatText(var_37_6.content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 11 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 11)

				if (11 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 11)) > 0 and var_37_5 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281008", "story_v_out_322281.awb") ~= 0 then
					local var_37_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281008", "story_v_out_322281.awb") / 1000

					if var_37_10 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_4
					end

					if var_37_6.prefab_name ~= "" and arg_34_1.actors_[var_37_6.prefab_name] ~= nil then
						local var_37_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_6.prefab_name].transform, "story_v_out_322281", "322281008", "story_v_out_322281.awb")

						arg_34_1:RecordAudio("322281008", var_37_11)
						arg_34_1:RecordAudio("322281008", var_37_11)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322281", "322281008", "story_v_out_322281.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322281", "322281008", "story_v_out_322281.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_12 and arg_34_1.time_ < var_37_4 + var_37_12 + arg_37_0 then
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
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10101ui_story"]) and arg_38_1.var_.characterEffect10101ui_story == nil then
				arg_38_1.var_.characterEffect10101ui_story = arg_38_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10101ui_story"]) then
				if arg_38_1.var_.characterEffect10101ui_story and not isNil(arg_38_1.actors_["10101ui_story"]) then
					arg_38_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_38_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10101ui_story"]) and arg_38_1.var_.characterEffect10101ui_story then
				arg_38_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_38_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.7

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

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

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(322281009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 28 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 28)

				if (28 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 28)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
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
			local var_45_0 = 1.225

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

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

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(322281010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 49 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 49)

				if (49 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 49)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
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
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10101ui_story"]) and arg_46_1.var_.characterEffect10101ui_story == nil then
				arg_46_1.var_.characterEffect10101ui_story = arg_46_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10101ui_story"]) then
				if arg_46_1.var_.characterEffect10101ui_story and not isNil(arg_46_1.actors_["10101ui_story"]) then
					arg_46_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10101ui_story"]) and arg_46_1.var_.characterEffect10101ui_story then
				arg_46_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_49_2 = 0
			local var_49_3 = 0.3

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(322281011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 12 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 12)

				if (12 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 12)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281011", "story_v_out_322281.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281011", "story_v_out_322281.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_322281", "322281011", "story_v_out_322281.awb")

						arg_46_1:RecordAudio("322281011", var_49_9)
						arg_46_1:RecordAudio("322281011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_322281", "322281011", "story_v_out_322281.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_322281", "322281011", "story_v_out_322281.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_10 and arg_46_1.time_ < var_49_2 + var_49_10 + arg_49_0 then
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
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10101ui_story"]) and arg_50_1.var_.characterEffect10101ui_story == nil then
				arg_50_1.var_.characterEffect10101ui_story = arg_50_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10101ui_story"]) then
				if arg_50_1.var_.characterEffect10101ui_story and not isNil(arg_50_1.actors_["10101ui_story"]) then
					arg_50_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_50_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10101ui_story"]) and arg_50_1.var_.characterEffect10101ui_story then
				arg_50_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_50_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_53_1 = 0
			local var_53_2 = 0.575

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

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

				local var_53_3 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(322281012).content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 23 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 23)

				if (23 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 23)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_1
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_6 = math.max(var_53_2, arg_50_1.talkMaxDuration)

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_6 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_1) / var_53_6

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_1 + var_53_6 and arg_50_1.time_ < var_53_1 + var_53_6 + arg_53_0 then
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
			local var_57_0 = 0.425

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[7].name)

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

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(322281013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 17 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 17)

				if (17 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 17)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
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
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10101ui_story"]) and arg_58_1.var_.characterEffect10101ui_story == nil then
				arg_58_1.var_.characterEffect10101ui_story = arg_58_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10101ui_story"]) then
				if arg_58_1.var_.characterEffect10101ui_story and not isNil(arg_58_1.actors_["10101ui_story"]) then
					arg_58_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10101ui_story"]) and arg_58_1.var_.characterEffect10101ui_story then
				arg_58_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_61_2 = 0
			local var_61_3 = 0.225

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(322281014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 9 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 9)

				if (9 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 9)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281014", "story_v_out_322281.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281014", "story_v_out_322281.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_322281", "322281014", "story_v_out_322281.awb")

						arg_58_1:RecordAudio("322281014", var_61_9)
						arg_58_1:RecordAudio("322281014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_322281", "322281014", "story_v_out_322281.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_322281", "322281014", "story_v_out_322281.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
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
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10101ui_story"]) and arg_62_1.var_.characterEffect10101ui_story == nil then
				arg_62_1.var_.characterEffect10101ui_story = arg_62_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10101ui_story"]) then
				if arg_62_1.var_.characterEffect10101ui_story and not isNil(arg_62_1.actors_["10101ui_story"]) then
					arg_62_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10101ui_story"]) and arg_62_1.var_.characterEffect10101ui_story then
				arg_62_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 1.475

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

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

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(322281015).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 59 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 59)

				if (59 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 59)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
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
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10101ui_story"]) and arg_66_1.var_.characterEffect10101ui_story == nil then
				arg_66_1.var_.characterEffect10101ui_story = arg_66_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10101ui_story"]) then
				if arg_66_1.var_.characterEffect10101ui_story and not isNil(arg_66_1.actors_["10101ui_story"]) then
					arg_66_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10101ui_story"]) and arg_66_1.var_.characterEffect10101ui_story then
				arg_66_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_2 = 0
			local var_69_3 = 0.725

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(322281016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 29 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 29)

				if (29 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 29)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281016", "story_v_out_322281.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281016", "story_v_out_322281.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_322281", "322281016", "story_v_out_322281.awb")

						arg_66_1:RecordAudio("322281016", var_69_9)
						arg_66_1:RecordAudio("322281016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322281", "322281016", "story_v_out_322281.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322281", "322281016", "story_v_out_322281.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_10 and arg_66_1.time_ < var_69_2 + var_69_10 + arg_69_0 then
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
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10101ui_story"]) and arg_70_1.var_.characterEffect10101ui_story == nil then
				arg_70_1.var_.characterEffect10101ui_story = arg_70_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10101ui_story"]) then
				if arg_70_1.var_.characterEffect10101ui_story and not isNil(arg_70_1.actors_["10101ui_story"]) then
					arg_70_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10101ui_story"]) and arg_70_1.var_.characterEffect10101ui_story then
				arg_70_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 0.375

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

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

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(322281017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 15 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 15)

				if (15 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 15)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
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
			local var_77_0 = 1.025

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

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

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(322281018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 41 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 41)

				if (41 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 41)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
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
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10101ui_story"]) and arg_78_1.var_.characterEffect10101ui_story == nil then
				arg_78_1.var_.characterEffect10101ui_story = arg_78_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10101ui_story"]) then
				if arg_78_1.var_.characterEffect10101ui_story and not isNil(arg_78_1.actors_["10101ui_story"]) then
					arg_78_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10101ui_story"]) and arg_78_1.var_.characterEffect10101ui_story then
				arg_78_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_81_2 = 0
			local var_81_3 = 0.5

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(322281019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 20 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 20)

				if (20 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 20)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281019", "story_v_out_322281.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281019", "story_v_out_322281.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_322281", "322281019", "story_v_out_322281.awb")

						arg_78_1:RecordAudio("322281019", var_81_9)
						arg_78_1:RecordAudio("322281019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322281", "322281019", "story_v_out_322281.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322281", "322281019", "story_v_out_322281.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
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
			local var_85_0 = 1.1

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(322281020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 44 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 44)

				if (44 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 44)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281020", "story_v_out_322281.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281020", "story_v_out_322281.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_322281", "322281020", "story_v_out_322281.awb")

						arg_82_1:RecordAudio("322281020", var_85_6)
						arg_82_1:RecordAudio("322281020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322281", "322281020", "story_v_out_322281.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322281", "322281020", "story_v_out_322281.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
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
			local var_89_0 = 1.375

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(322281021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 55 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 55)

				if (55 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 55)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281021", "story_v_out_322281.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281021", "story_v_out_322281.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_322281", "322281021", "story_v_out_322281.awb")

						arg_86_1:RecordAudio("322281021", var_89_6)
						arg_86_1:RecordAudio("322281021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322281", "322281021", "story_v_out_322281.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322281", "322281021", "story_v_out_322281.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
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
			local var_93_0 = 0.7

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(322281022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 28 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 28)

				if (28 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 28)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281022", "story_v_out_322281.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281022", "story_v_out_322281.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_322281", "322281022", "story_v_out_322281.awb")

						arg_90_1:RecordAudio("322281022", var_93_6)
						arg_90_1:RecordAudio("322281022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322281", "322281022", "story_v_out_322281.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322281", "322281022", "story_v_out_322281.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
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
			local var_97_0 = 0.925

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(322281023)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 37 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 37)

				if (37 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 37)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281023", "story_v_out_322281.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281023", "story_v_out_322281.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_322281", "322281023", "story_v_out_322281.awb")

						arg_94_1:RecordAudio("322281023", var_97_6)
						arg_94_1:RecordAudio("322281023", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322281", "322281023", "story_v_out_322281.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322281", "322281023", "story_v_out_322281.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
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
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_2")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_101_0 = 0
			local var_101_1 = 0.425

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(322281024)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 17 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 17)

				if (17 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 17)) > 0 and var_101_1 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281024", "story_v_out_322281.awb") ~= 0 then
					local var_101_6 = manager.audio:GetVoiceLength("story_v_out_322281", "322281024", "story_v_out_322281.awb") / 1000

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end

					if var_101_2.prefab_name ~= "" and arg_98_1.actors_[var_101_2.prefab_name] ~= nil then
						local var_101_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_2.prefab_name].transform, "story_v_out_322281", "322281024", "story_v_out_322281.awb")

						arg_98_1:RecordAudio("322281024", var_101_7)
						arg_98_1:RecordAudio("322281024", var_101_7)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322281", "322281024", "story_v_out_322281.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322281", "322281024", "story_v_out_322281.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
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
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10101ui_story"]) and arg_102_1.var_.characterEffect10101ui_story == nil then
				arg_102_1.var_.characterEffect10101ui_story = arg_102_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10101ui_story"]) then
				if arg_102_1.var_.characterEffect10101ui_story and not isNil(arg_102_1.actors_["10101ui_story"]) then
					arg_102_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10101ui_story"]) and arg_102_1.var_.characterEffect10101ui_story then
				arg_102_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 0.225

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

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

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(322281025).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 9 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 9)

				if (9 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 9)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
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
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10101ui_story"]) and arg_106_1.var_.characterEffect10101ui_story == nil then
				arg_106_1.var_.characterEffect10101ui_story = arg_106_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10101ui_story"]) then
				if arg_106_1.var_.characterEffect10101ui_story and not isNil(arg_106_1.actors_["10101ui_story"]) then
					arg_106_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10101ui_story"]) and arg_106_1.var_.characterEffect10101ui_story then
				arg_106_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_109_2 = 0
			local var_109_3 = 0.425

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(322281026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 17 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 17)

				if (17 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 17)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281026", "story_v_out_322281.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281026", "story_v_out_322281.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_322281", "322281026", "story_v_out_322281.awb")

						arg_106_1:RecordAudio("322281026", var_109_9)
						arg_106_1:RecordAudio("322281026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322281", "322281026", "story_v_out_322281.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322281", "322281026", "story_v_out_322281.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_10 and arg_106_1.time_ < var_109_2 + var_109_10 + arg_109_0 then
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
			if arg_110_1.bgs_.ST2401 == nil then
				local var_113_0 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2401")
				var_113_0.name = "ST2401"
				var_113_0.transform.parent = arg_110_1.stage_.transform
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_.ST2401 = var_113_0
			end

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_1 = arg_110_1.bgs_.ST2401

				arg_110_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_2 = var_113_1:GetComponent("SpriteRenderer")

				if var_113_2 and var_113_2.sprite then
					local var_113_3 = 2 * (var_113_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_1.transform.localScale = Vector3.New(var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "ST2401" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_4 = 3.999999999999

			if 3.999999999999 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_4 + 0.15 and arg_110_1.time_ < var_113_4 + 0.15 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_5 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_6 = 2

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_5) / var_113_6)
				arg_110_1.mask_.color = var_113_7
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				local var_113_8 = Color.New(0, 0, 0)

				var_113_8.a = 1
				arg_110_1.mask_.color = var_113_8
			end

			local var_113_9 = 1.999999999999

			if 1.999999999999 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_10 = 2

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 then
				local var_113_11 = Color.New(0, 0, 0)

				var_113_11.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_9) / var_113_10)
				arg_110_1.mask_.color = var_113_11
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 then
				local var_113_12 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_12.a = 0
				arg_110_1.mask_.color = var_113_12
			end

			local var_113_13 = arg_110_1.actors_["10101ui_story"].transform

			if 1.999999999999 < arg_110_1.time_ and arg_110_1.time_ <= 1.999999999999 + arg_113_0 then
				arg_110_1.var_.moveOldPos10101ui_story = var_113_13.localPosition
			end

			local var_113_14 = 0.001

			if 1.999999999999 <= arg_110_1.time_ and arg_110_1.time_ < 1.999999999999 + var_113_14 then
				var_113_13.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 1.999999999999) / var_113_14)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles
			end

			if arg_110_1.time_ >= 1.999999999999 + var_113_14 and arg_110_1.time_ < 1.999999999999 + var_113_14 + arg_113_0 then
				var_113_13.localPosition = Vector3.New(0, 100, 0)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles
			end

			local var_113_15 = "1089ui_story"

			if arg_110_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_113_16 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_110_1.stage_.transform)

				var_113_16.name = var_113_15
				var_113_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_[var_113_15] = var_113_16

				local var_113_17 = var_113_16:GetComponentInChildren(typeof(CharacterEffect))

				var_113_17.enabled = true

				local var_113_18 = GameObjectTools.GetOrAddComponent(var_113_16, typeof(DynamicBoneHelper))

				if var_113_18 then
					var_113_18:EnableDynamicBone(false)
				end

				arg_110_1:ShowWeapon(var_113_17.transform, false)

				arg_110_1.var_[var_113_15 .. "Animator"] = var_113_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_110_1.var_[var_113_15 .. "Animator"].applyRootMotion = true
				arg_110_1.var_[var_113_15 .. "LipSync"] = var_113_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_113_19 = arg_110_1.actors_["1089ui_story"].transform

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 then
				arg_110_1.var_.moveOldPos1089ui_story = var_113_19.localPosition

				arg_110_1:ShowWeapon(arg_110_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_113_20 = 0.001

			if 4 <= arg_110_1.time_ and arg_110_1.time_ < 4 + var_113_20 then
				var_113_19.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_110_1.time_ - 4) / var_113_20)
				var_113_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_19.position).x, (manager.ui.mainCamera.transform.position - var_113_19.position).y, (manager.ui.mainCamera.transform.position - var_113_19.position).z)
				var_113_19.localEulerAngles.z = 0
				var_113_19.localEulerAngles.x = 0
				var_113_19.localEulerAngles = var_113_19.localEulerAngles
			end

			if arg_110_1.time_ >= 4 + var_113_20 and arg_110_1.time_ < 4 + var_113_20 + arg_113_0 then
				var_113_19.localPosition = Vector3.New(0, -1.1, -6.17)
				var_113_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_19.position).x, (manager.ui.mainCamera.transform.position - var_113_19.position).y, (manager.ui.mainCamera.transform.position - var_113_19.position).z)
				var_113_19.localEulerAngles.z = 0
				var_113_19.localEulerAngles.x = 0
				var_113_19.localEulerAngles = var_113_19.localEulerAngles
			end

			local var_113_21 = arg_110_1.actors_["1089ui_story"]

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 and not isNil(var_113_21) and arg_110_1.var_.characterEffect1089ui_story == nil then
				arg_110_1.var_.characterEffect1089ui_story = var_113_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_22 = 0.200000002980232

			if 4 <= arg_110_1.time_ and arg_110_1.time_ < 4 + var_113_22 and not isNil(var_113_21) then
				if arg_110_1.var_.characterEffect1089ui_story and not isNil(var_113_21) then
					arg_110_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 4 + var_113_22 and arg_110_1.time_ < 4 + var_113_22 + arg_113_0 and not isNil(var_113_21) and arg_110_1.var_.characterEffect1089ui_story then
				arg_110_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 then
				arg_110_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 then
				arg_110_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_110_1.time_ and arg_110_1.time_ <= 0.2 + arg_113_0 then
				arg_110_1:AudioAction("stop", "effect", "se_story_side_1037", "se_story_1037_ui_loop", "")
			end

			if 1.63333333333333 < arg_110_1.time_ and arg_110_1.time_ <= 1.63333333333333 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_26 = 3.999999999999
			local var_113_27 = 0.15

			if 3.999999999999 < arg_110_1.time_ and arg_110_1.time_ <= var_113_26 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_28 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_28:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_29 = arg_110_1:GetWordFromCfg(322281027)
				local var_113_30 = arg_110_1:FormatText(var_113_29.content)

				arg_110_1.text_.text = var_113_30

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_32 = 6 <= 0 and var_113_27 or var_113_27 * (utf8.len(var_113_30) / 6)

				if (6 <= 0 and var_113_27 or var_113_27 * (utf8.len(var_113_30) / 6)) > 0 and var_113_27 < var_113_32 then
					arg_110_1.talkMaxDuration = var_113_32
					var_113_26 = var_113_26 + 0.3

					if var_113_32 + var_113_26 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_32 + var_113_26
					end
				end

				arg_110_1.text_.text = var_113_30
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281027", "story_v_out_322281.awb") ~= 0 then
					local var_113_33 = manager.audio:GetVoiceLength("story_v_out_322281", "322281027", "story_v_out_322281.awb") / 1000

					if var_113_33 + var_113_26 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_33 + var_113_26
					end

					if var_113_29.prefab_name ~= "" and arg_110_1.actors_[var_113_29.prefab_name] ~= nil then
						local var_113_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_29.prefab_name].transform, "story_v_out_322281", "322281027", "story_v_out_322281.awb")

						arg_110_1:RecordAudio("322281027", var_113_34)
						arg_110_1:RecordAudio("322281027", var_113_34)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322281", "322281027", "story_v_out_322281.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322281", "322281027", "story_v_out_322281.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_35 = var_113_26 + 0.3
			local var_113_36 = math.max(var_113_27, arg_110_1.talkMaxDuration)

			if var_113_26 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_35 + var_113_36 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_35) / var_113_36

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_35 + var_113_36 and arg_110_1.time_ < var_113_35 + var_113_36 + arg_113_0 then
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
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1089ui_story"]) and arg_116_1.var_.characterEffect1089ui_story == nil then
				arg_116_1.var_.characterEffect1089ui_story = arg_116_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1089ui_story"]) then
				if arg_116_1.var_.characterEffect1089ui_story and not isNil(arg_116_1.actors_["1089ui_story"]) then
					arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1089ui_story"]) and arg_116_1.var_.characterEffect1089ui_story then
				arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.175

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

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

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(322281028).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 7 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 7)

				if (7 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 7)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
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
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) and arg_120_1.var_.characterEffect1089ui_story == nil then
				arg_120_1.var_.characterEffect1089ui_story = arg_120_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) then
				if arg_120_1.var_.characterEffect1089ui_story and not isNil(arg_120_1.actors_["1089ui_story"]) then
					arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) and arg_120_1.var_.characterEffect1089ui_story then
				arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_123_2 = 0
			local var_123_3 = 0.175

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:GetWordFromCfg(322281029)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 7 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 7)

				if (7 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 7)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281029", "story_v_out_322281.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281029", "story_v_out_322281.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_322281", "322281029", "story_v_out_322281.awb")

						arg_120_1:RecordAudio("322281029", var_123_9)
						arg_120_1:RecordAudio("322281029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322281", "322281029", "story_v_out_322281.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322281", "322281029", "story_v_out_322281.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
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
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1089ui_story = arg_124_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1089ui_story"].transform.position).z)
				arg_124_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1089ui_story"].transform.localEulerAngles = arg_124_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1089ui_story"].transform.position).z)
				arg_124_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1089ui_story"].transform.localEulerAngles = arg_124_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_127_1 = 0
			local var_127_2 = 1.75

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(322281030).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 70 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 70)

				if (70 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 70)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
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
			local var_131_0 = 1.05

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[7].name)

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

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(322281031).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 42 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 42)

				if (42 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 42)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
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
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1089ui_story = arg_132_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1089ui_story"].transform.position).z)
				arg_132_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1089ui_story"].transform.localEulerAngles = arg_132_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_132_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1089ui_story"].transform.position).z)
				arg_132_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1089ui_story"].transform.localEulerAngles = arg_132_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["1089ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1089ui_story == nil then
				arg_132_1.var_.characterEffect1089ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1089ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1089ui_story then
				arg_132_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_135_4 = 0
			local var_135_5 = 0.4

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(322281032)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 16 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 16)

				if (16 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 16)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281032", "story_v_out_322281.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281032", "story_v_out_322281.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_322281", "322281032", "story_v_out_322281.awb")

						arg_132_1:RecordAudio("322281032", var_135_11)
						arg_132_1:RecordAudio("322281032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322281", "322281032", "story_v_out_322281.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322281", "322281032", "story_v_out_322281.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
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
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1089ui_story"]) and arg_136_1.var_.characterEffect1089ui_story == nil then
				arg_136_1.var_.characterEffect1089ui_story = arg_136_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1089ui_story"]) then
				if arg_136_1.var_.characterEffect1089ui_story and not isNil(arg_136_1.actors_["1089ui_story"]) then
					arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1089ui_story"]) and arg_136_1.var_.characterEffect1089ui_story then
				arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.325

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

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

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(322281033).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 13 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 13)

				if (13 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 13)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
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
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1089ui_story"]) and arg_140_1.var_.characterEffect1089ui_story == nil then
				arg_140_1.var_.characterEffect1089ui_story = arg_140_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1089ui_story"]) then
				if arg_140_1.var_.characterEffect1089ui_story and not isNil(arg_140_1.actors_["1089ui_story"]) then
					arg_140_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1089ui_story"]) and arg_140_1.var_.characterEffect1089ui_story then
				arg_140_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_143_2 = 0
			local var_143_3 = 0.725

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(322281034)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 29 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 29)

				if (29 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 29)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281034", "story_v_out_322281.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281034", "story_v_out_322281.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_322281", "322281034", "story_v_out_322281.awb")

						arg_140_1:RecordAudio("322281034", var_143_9)
						arg_140_1:RecordAudio("322281034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322281", "322281034", "story_v_out_322281.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322281", "322281034", "story_v_out_322281.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
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
			local var_147_0 = 1.275

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(322281035)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 51 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 51)

				if (51 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 51)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281035", "story_v_out_322281.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281035", "story_v_out_322281.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_322281", "322281035", "story_v_out_322281.awb")

						arg_144_1:RecordAudio("322281035", var_147_6)
						arg_144_1:RecordAudio("322281035", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322281", "322281035", "story_v_out_322281.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322281", "322281035", "story_v_out_322281.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
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
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_151_0 = 0
			local var_151_1 = 1.3

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(322281036)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 52 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 52)

				if (52 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 52)) > 0 and var_151_1 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281036", "story_v_out_322281.awb") ~= 0 then
					local var_151_6 = manager.audio:GetVoiceLength("story_v_out_322281", "322281036", "story_v_out_322281.awb") / 1000

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end

					if var_151_2.prefab_name ~= "" and arg_148_1.actors_[var_151_2.prefab_name] ~= nil then
						local var_151_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_2.prefab_name].transform, "story_v_out_322281", "322281036", "story_v_out_322281.awb")

						arg_148_1:RecordAudio("322281036", var_151_7)
						arg_148_1:RecordAudio("322281036", var_151_7)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_322281", "322281036", "story_v_out_322281.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_322281", "322281036", "story_v_out_322281.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
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
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_155_0 = 0

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			if arg_152_1.time_ >= var_155_0 + 2 and arg_152_1.time_ < var_155_0 + 2 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			local var_155_1 = 0
			local var_155_2 = 0.625

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:GetWordFromCfg(322281037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_6 = 25 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_4) / 25)

				if (25 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_4) / 25)) > 0 and var_155_2 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281037", "story_v_out_322281.awb") ~= 0 then
					local var_155_7 = manager.audio:GetVoiceLength("story_v_out_322281", "322281037", "story_v_out_322281.awb") / 1000

					if var_155_7 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_1
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_322281", "322281037", "story_v_out_322281.awb")

						arg_152_1:RecordAudio("322281037", var_155_8)
						arg_152_1:RecordAudio("322281037", var_155_8)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322281", "322281037", "story_v_out_322281.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322281", "322281037", "story_v_out_322281.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_9 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_9 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_9

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_9 and arg_152_1.time_ < var_155_1 + var_155_9 + arg_155_0 then
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
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1089ui_story"]) and arg_156_1.var_.characterEffect1089ui_story == nil then
				arg_156_1.var_.characterEffect1089ui_story = arg_156_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1089ui_story"]) then
				if arg_156_1.var_.characterEffect1089ui_story and not isNil(arg_156_1.actors_["1089ui_story"]) then
					arg_156_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1089ui_story"]) and arg_156_1.var_.characterEffect1089ui_story then
				arg_156_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.25

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

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

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(322281038).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 10 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 10)

				if (10 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 10)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
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
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1089ui_story"]) and arg_160_1.var_.characterEffect1089ui_story == nil then
				arg_160_1.var_.characterEffect1089ui_story = arg_160_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1089ui_story"]) then
				if arg_160_1.var_.characterEffect1089ui_story and not isNil(arg_160_1.actors_["1089ui_story"]) then
					arg_160_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1089ui_story"]) and arg_160_1.var_.characterEffect1089ui_story then
				arg_160_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_163_2 = 0
			local var_163_3 = 0.4

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(322281039)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 16 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 16)

				if (16 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 16)) > 0 and var_163_3 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281039", "story_v_out_322281.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281039", "story_v_out_322281.awb") / 1000

					if var_163_8 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_2
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_out_322281", "322281039", "story_v_out_322281.awb")

						arg_160_1:RecordAudio("322281039", var_163_9)
						arg_160_1:RecordAudio("322281039", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322281", "322281039", "story_v_out_322281.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322281", "322281039", "story_v_out_322281.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_10 and arg_160_1.time_ < var_163_2 + var_163_10 + arg_163_0 then
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
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1089ui_story"]) and arg_164_1.var_.characterEffect1089ui_story == nil then
				arg_164_1.var_.characterEffect1089ui_story = arg_164_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1089ui_story"]) then
				if arg_164_1.var_.characterEffect1089ui_story and not isNil(arg_164_1.actors_["1089ui_story"]) then
					arg_164_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1089ui_story"]) and arg_164_1.var_.characterEffect1089ui_story then
				arg_164_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 0.2

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

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

				local var_167_3 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(322281040).content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 8 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 8)

				if (8 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 8)) > 0 and var_167_2 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_6 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_6 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_6

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_6 and arg_164_1.time_ < var_167_1 + var_167_6 + arg_167_0 then
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
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1089ui_story"]) and arg_168_1.var_.characterEffect1089ui_story == nil then
				arg_168_1.var_.characterEffect1089ui_story = arg_168_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1089ui_story"]) then
				if arg_168_1.var_.characterEffect1089ui_story and not isNil(arg_168_1.actors_["1089ui_story"]) then
					arg_168_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1089ui_story"]) and arg_168_1.var_.characterEffect1089ui_story then
				arg_168_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_1")
			end

			if 2.13333333333333 < arg_168_1.time_ and arg_168_1.time_ <= 2.13333333333333 + arg_171_0 then
				arg_168_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_2")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_171_2 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.allBtn_.enabled = false
			end

			if arg_168_1.time_ >= var_171_2 + 3.93333333333333 and arg_168_1.time_ < var_171_2 + 3.93333333333333 + arg_171_0 then
				arg_168_1.allBtn_.enabled = true
			end

			local var_171_3 = 0
			local var_171_4 = 0.825

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_3 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_5 = arg_168_1:GetWordFromCfg(322281041)
				local var_171_6 = arg_168_1:FormatText(var_171_5.content)

				arg_168_1.text_.text = var_171_6

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_8 = 33 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_6) / 33)

				if (33 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_6) / 33)) > 0 and var_171_4 < var_171_8 then
					arg_168_1.talkMaxDuration = var_171_8

					if var_171_8 + var_171_3 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_3
					end
				end

				arg_168_1.text_.text = var_171_6
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281041", "story_v_out_322281.awb") ~= 0 then
					local var_171_9 = manager.audio:GetVoiceLength("story_v_out_322281", "322281041", "story_v_out_322281.awb") / 1000

					if var_171_9 + var_171_3 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_3
					end

					if var_171_5.prefab_name ~= "" and arg_168_1.actors_[var_171_5.prefab_name] ~= nil then
						local var_171_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_5.prefab_name].transform, "story_v_out_322281", "322281041", "story_v_out_322281.awb")

						arg_168_1:RecordAudio("322281041", var_171_10)
						arg_168_1:RecordAudio("322281041", var_171_10)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_322281", "322281041", "story_v_out_322281.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_322281", "322281041", "story_v_out_322281.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_11 = math.max(var_171_4, arg_168_1.talkMaxDuration)

			if var_171_3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_3 + var_171_11 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_3) / var_171_11

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_3 + var_171_11 and arg_168_1.time_ < var_171_3 + var_171_11 + arg_171_0 then
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
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1089ui_story"]) and arg_172_1.var_.characterEffect1089ui_story == nil then
				arg_172_1.var_.characterEffect1089ui_story = arg_172_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1089ui_story"]) then
				if arg_172_1.var_.characterEffect1089ui_story and not isNil(arg_172_1.actors_["1089ui_story"]) then
					arg_172_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1089ui_story"]) and arg_172_1.var_.characterEffect1089ui_story then
				arg_172_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.65

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

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

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(322281042).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 26 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 26)

				if (26 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 26)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
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
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1089ui_story"]) and arg_176_1.var_.characterEffect1089ui_story == nil then
				arg_176_1.var_.characterEffect1089ui_story = arg_176_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1089ui_story"]) then
				if arg_176_1.var_.characterEffect1089ui_story and not isNil(arg_176_1.actors_["1089ui_story"]) then
					arg_176_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1089ui_story"]) and arg_176_1.var_.characterEffect1089ui_story then
				arg_176_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_179_2 = 0
			local var_179_3 = 1.225

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(322281043)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 49 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 49)

				if (49 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 49)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281043", "story_v_out_322281.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281043", "story_v_out_322281.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_322281", "322281043", "story_v_out_322281.awb")

						arg_176_1:RecordAudio("322281043", var_179_9)
						arg_176_1:RecordAudio("322281043", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_322281", "322281043", "story_v_out_322281.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_322281", "322281043", "story_v_out_322281.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
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
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1089ui_story"]) and arg_180_1.var_.characterEffect1089ui_story == nil then
				arg_180_1.var_.characterEffect1089ui_story = arg_180_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1089ui_story"]) then
				if arg_180_1.var_.characterEffect1089ui_story and not isNil(arg_180_1.actors_["1089ui_story"]) then
					arg_180_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1089ui_story"]) and arg_180_1.var_.characterEffect1089ui_story then
				arg_180_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.4

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[7].name)

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

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(322281044).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 16 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 16)

				if (16 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 16)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
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
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1089ui_story"]) and arg_184_1.var_.characterEffect1089ui_story == nil then
				arg_184_1.var_.characterEffect1089ui_story = arg_184_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1089ui_story"]) then
				if arg_184_1.var_.characterEffect1089ui_story and not isNil(arg_184_1.actors_["1089ui_story"]) then
					arg_184_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1089ui_story"]) and arg_184_1.var_.characterEffect1089ui_story then
				arg_184_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_1")
			end

			local var_187_2 = 0
			local var_187_3 = 0.45

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(322281045)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 18 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 18)

				if (18 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 18)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281045", "story_v_out_322281.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281045", "story_v_out_322281.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_322281", "322281045", "story_v_out_322281.awb")

						arg_184_1:RecordAudio("322281045", var_187_9)
						arg_184_1:RecordAudio("322281045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_322281", "322281045", "story_v_out_322281.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_322281", "322281045", "story_v_out_322281.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
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
			if 4 < arg_188_1.time_ and arg_188_1.time_ <= 4 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			if arg_188_1.time_ >= 4 + 0.3 and arg_188_1.time_ < 4 + 0.3 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end

			local var_191_0 = "L01f"

			if arg_188_1.bgs_.L01f == nil then
				local var_191_1 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_191_0)
				var_191_1.name = var_191_0
				var_191_1.transform.parent = arg_188_1.stage_.transform
				var_191_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_[var_191_0] = var_191_1
			end

			if 1.999999999999 < arg_188_1.time_ and arg_188_1.time_ <= 1.999999999999 + arg_191_0 then
				local var_191_2 = arg_188_1.bgs_.L01f

				arg_188_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_191_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_3 = var_191_2:GetComponent("SpriteRenderer")

				if var_191_3 and var_191_3.sprite then
					local var_191_4 = 2 * (var_191_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_191_2.transform.localScale = Vector3.New(var_191_4 / var_191_3.sprite.bounds.size.y < var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x and var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x or var_191_4 / var_191_3.sprite.bounds.size.y, var_191_4 / var_191_3.sprite.bounds.size.y < var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x and var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x or var_191_4 / var_191_3.sprite.bounds.size.y, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "L01f" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_5 = 0

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_6 = 2

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 then
				local var_191_7 = Color.New(0, 0, 0)

				var_191_7.a = Mathf.Lerp(0, 1, (arg_188_1.time_ - var_191_5) / var_191_6)
				arg_188_1.mask_.color = var_191_7
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 then
				local var_191_8 = Color.New(0, 0, 0)

				var_191_8.a = 1
				arg_188_1.mask_.color = var_191_8
			end

			local var_191_9 = 2

			if 2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_10 = 2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 then
				local var_191_11 = Color.New(0, 0, 0)

				var_191_11.a = Mathf.Lerp(1, 0, (arg_188_1.time_ - var_191_9) / var_191_10)
				arg_188_1.mask_.color = var_191_11
			end

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 then
				local var_191_12 = Color.New(0, 0, 0)

				arg_188_1.mask_.enabled = false
				var_191_12.a = 0
				arg_188_1.mask_.color = var_191_12
			end

			local var_191_13 = arg_188_1.actors_["1089ui_story"].transform

			if 2 < arg_188_1.time_ and arg_188_1.time_ <= 2 + arg_191_0 then
				arg_188_1.var_.moveOldPos1089ui_story = var_191_13.localPosition
			end

			local var_191_14 = 0.001

			if 2 <= arg_188_1.time_ and arg_188_1.time_ < 2 + var_191_14 then
				var_191_13.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_188_1.time_ - 2) / var_191_14)
				var_191_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_13.position).x, (manager.ui.mainCamera.transform.position - var_191_13.position).y, (manager.ui.mainCamera.transform.position - var_191_13.position).z)
				var_191_13.localEulerAngles.z = 0
				var_191_13.localEulerAngles.x = 0
				var_191_13.localEulerAngles = var_191_13.localEulerAngles
			end

			if arg_188_1.time_ >= 2 + var_191_14 and arg_188_1.time_ < 2 + var_191_14 + arg_191_0 then
				var_191_13.localPosition = Vector3.New(0, 100, 0)
				var_191_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_13.position).x, (manager.ui.mainCamera.transform.position - var_191_13.position).y, (manager.ui.mainCamera.transform.position - var_191_13.position).z)
				var_191_13.localEulerAngles.z = 0
				var_191_13.localEulerAngles.x = 0
				var_191_13.localEulerAngles = var_191_13.localEulerAngles
			end

			if 0.1 < arg_188_1.time_ and arg_188_1.time_ <= 0.1 + arg_191_0 then
				arg_188_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if 1.66666666666667 < arg_188_1.time_ and arg_188_1.time_ <= 1.66666666666667 + arg_191_0 then
				arg_188_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_17 = 4
			local var_191_18 = 1.025

			if 4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_19 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_19:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_20 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(322281046).content)

				arg_188_1.text_.text = var_191_20

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_22 = 41 <= 0 and var_191_18 or var_191_18 * (utf8.len(var_191_20) / 41)

				if (41 <= 0 and var_191_18 or var_191_18 * (utf8.len(var_191_20) / 41)) > 0 and var_191_18 < var_191_22 then
					arg_188_1.talkMaxDuration = var_191_22
					var_191_17 = var_191_17 + 0.3

					if var_191_22 + var_191_17 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_17
					end
				end

				arg_188_1.text_.text = var_191_20
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_23 = var_191_17 + 0.3
			local var_191_24 = math.max(var_191_18, arg_188_1.talkMaxDuration)

			if var_191_17 + 0.3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_24 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_23) / var_191_24

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_23 + var_191_24 and arg_188_1.time_ < var_191_23 + var_191_24 + arg_191_0 then
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
			local var_197_9000

			if 0.1 < arg_194_1.time_ and arg_194_1.time_ <= 0.1 + arg_197_0 then
				arg_194_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car01", "")
			end

			if 0.366666666666667 < arg_194_1.time_ and arg_194_1.time_ <= 0.366666666666667 + arg_197_0 then
				local var_197_1 = arg_194_1.var_.effect1047

				if not arg_194_1.var_.effect1047 then
					var_197_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_197_1.name = "1047"
					arg_194_1.var_.effect1047 = var_197_1
				else
					var_197_1.transform:SetParent(var_197_9000)
				end

				var_197_1.transform.localPosition = Vector3.New(0, 0, -2.86)
				var_197_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_197_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_197_4 = var_197_1.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_197_0, iter_197_1 in ipairs((var_197_4:ToTable())) do
					iter_197_1.transform.localScale = Vector3.New(iter_197_1.transform.localScale.x / var_197_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_197_4 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_197_1.transform.localScale.y / var_197_3, iter_197_1.transform.localScale.z)
				end
			end

			local var_197_6 = arg_194_1.bgs_.L01f.transform

			if 0.366666666666667 < arg_194_1.time_ and arg_194_1.time_ <= 0.366666666666667 + arg_197_0 then
				arg_194_1.var_.moveOldPosL01f = var_197_6.localPosition
			end

			local var_197_7 = 0.833333333333333

			if 0.366666666666667 <= arg_194_1.time_ and arg_194_1.time_ < 0.366666666666667 + var_197_7 then
				var_197_6.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPosL01f, Vector3.New(0, 1, 8), (arg_194_1.time_ - 0.366666666666667) / var_197_7)
			end

			if arg_194_1.time_ >= 0.366666666666667 + var_197_7 and arg_194_1.time_ < 0.366666666666667 + var_197_7 + arg_197_0 then
				var_197_6.localPosition = Vector3.New(0, 1, 8)
			end

			local var_197_8 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			if arg_194_1.time_ >= var_197_8 + 2.13333333333333 and arg_194_1.time_ < var_197_8 + 2.13333333333333 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_9 = 1
			local var_197_10 = 1.4

			if 1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_11 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_11:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_194_1.dialogCg_.alpha = arg_198_0
				end))
				var_197_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_12 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(322281047).content)

				arg_194_1.text_.text = var_197_12

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_14 = 56 <= 0 and var_197_10 or var_197_10 * (utf8.len(var_197_12) / 56)

				if (56 <= 0 and var_197_10 or var_197_10 * (utf8.len(var_197_12) / 56)) > 0 and var_197_10 < var_197_14 then
					arg_194_1.talkMaxDuration = var_197_14
					var_197_9 = var_197_9 + 0.3

					if var_197_14 + var_197_9 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_9
					end
				end

				arg_194_1.text_.text = var_197_12
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_15 = var_197_9 + 0.3
			local var_197_16 = math.max(var_197_10, arg_194_1.talkMaxDuration)

			if var_197_9 + 0.3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_15 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_15) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_15 + var_197_16 and arg_194_1.time_ < var_197_15 + var_197_16 + arg_197_0 then
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
			if arg_200_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_203_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_200_1.stage_.transform)

				var_203_0.name = "1211ui_story"
				var_203_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_200_1.actors_["1211ui_story"] = var_203_0

				local var_203_1 = var_203_0:GetComponentInChildren(typeof(CharacterEffect))

				var_203_1.enabled = true

				local var_203_2 = GameObjectTools.GetOrAddComponent(var_203_0, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(false)
				end

				arg_200_1:ShowWeapon(var_203_1.transform, false)

				arg_200_1.var_["1211ui_story" .. "Animator"] = var_203_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_200_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_200_1.var_["1211ui_story" .. "LipSync"] = var_203_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_203_3 = arg_200_1.actors_["1211ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1211ui_story = var_203_3.localPosition

				arg_200_1:ShowWeapon(arg_200_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_203_4 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				var_203_3.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_200_1.time_ - 0) / var_203_4)
				var_203_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_3.position).x, (manager.ui.mainCamera.transform.position - var_203_3.position).y, (manager.ui.mainCamera.transform.position - var_203_3.position).z)
				var_203_3.localEulerAngles.z = 0
				var_203_3.localEulerAngles.x = 0
				var_203_3.localEulerAngles = var_203_3.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				var_203_3.localPosition = Vector3.New(0, -0.67, -6.07)
				var_203_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_3.position).x, (manager.ui.mainCamera.transform.position - var_203_3.position).y, (manager.ui.mainCamera.transform.position - var_203_3.position).z)
				var_203_3.localEulerAngles.z = 0
				var_203_3.localEulerAngles.x = 0
				var_203_3.localEulerAngles = var_203_3.localEulerAngles
			end

			local var_203_5 = arg_200_1.actors_["1211ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_5) and arg_200_1.var_.characterEffect1211ui_story == nil then
				arg_200_1.var_.characterEffect1211ui_story = var_203_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_6 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_6 and not isNil(var_203_5) then
				if arg_200_1.var_.characterEffect1211ui_story and not isNil(var_203_5) then
					arg_200_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_6 and arg_200_1.time_ < 0 + var_203_6 + arg_203_0 and not isNil(var_203_5) and arg_200_1.var_.characterEffect1211ui_story then
				arg_200_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action6_1")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				if arg_200_1.var_.effect1047 then
					Object.Destroy(arg_200_1.var_.effect1047)

					arg_200_1.var_.effect1047 = nil
				end
			end

			local var_203_9 = 0
			local var_203_10 = 0.175

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_11 = arg_200_1:GetWordFromCfg(322281048)
				local var_203_12 = arg_200_1:FormatText(var_203_11.content)

				arg_200_1.text_.text = var_203_12

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_14 = 7 <= 0 and var_203_10 or var_203_10 * (utf8.len(var_203_12) / 7)

				if (7 <= 0 and var_203_10 or var_203_10 * (utf8.len(var_203_12) / 7)) > 0 and var_203_10 < var_203_14 then
					arg_200_1.talkMaxDuration = var_203_14

					if var_203_14 + var_203_9 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_9
					end
				end

				arg_200_1.text_.text = var_203_12
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281048", "story_v_out_322281.awb") ~= 0 then
					local var_203_15 = manager.audio:GetVoiceLength("story_v_out_322281", "322281048", "story_v_out_322281.awb") / 1000

					if var_203_15 + var_203_9 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_15 + var_203_9
					end

					if var_203_11.prefab_name ~= "" and arg_200_1.actors_[var_203_11.prefab_name] ~= nil then
						local var_203_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_11.prefab_name].transform, "story_v_out_322281", "322281048", "story_v_out_322281.awb")

						arg_200_1:RecordAudio("322281048", var_203_16)
						arg_200_1:RecordAudio("322281048", var_203_16)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_322281", "322281048", "story_v_out_322281.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_322281", "322281048", "story_v_out_322281.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_17 = math.max(var_203_10, arg_200_1.talkMaxDuration)

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_17 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_9) / var_203_17

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_9 + var_203_17 and arg_200_1.time_ < var_203_9 + var_203_17 + arg_203_0 then
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
			if arg_204_1.actors_["1044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1044ui_story"))) then
				local var_207_0 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_204_1.stage_.transform)

				var_207_0.name = "1044ui_story"
				var_207_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.actors_["1044ui_story"] = var_207_0

				local var_207_1 = var_207_0:GetComponentInChildren(typeof(CharacterEffect))

				var_207_1.enabled = true

				local var_207_2 = GameObjectTools.GetOrAddComponent(var_207_0, typeof(DynamicBoneHelper))

				if var_207_2 then
					var_207_2:EnableDynamicBone(false)
				end

				arg_204_1:ShowWeapon(var_207_1.transform, false)

				arg_204_1.var_["1044ui_story" .. "Animator"] = var_207_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_204_1.var_["1044ui_story" .. "Animator"].applyRootMotion = true
				arg_204_1.var_["1044ui_story" .. "LipSync"] = var_207_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_207_3 = arg_204_1.actors_["1044ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1044ui_story = var_207_3.localPosition

				arg_204_1:ShowWeapon(arg_204_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_207_4 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				var_207_3.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_204_1.time_ - 0) / var_207_4)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				var_207_3.localPosition = Vector3.New(0.7, -1, -5.93)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles
			end

			local var_207_5 = arg_204_1.actors_["1044ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_5) and arg_204_1.var_.characterEffect1044ui_story == nil then
				arg_204_1.var_.characterEffect1044ui_story = var_207_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_6 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_6 and not isNil(var_207_5) then
				if arg_204_1.var_.characterEffect1044ui_story and not isNil(var_207_5) then
					arg_204_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_6 and arg_204_1.time_ < 0 + var_207_6 + arg_207_0 and not isNil(var_207_5) and arg_204_1.var_.characterEffect1044ui_story then
				arg_204_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_1")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_8 = arg_204_1.actors_["1211ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.characterEffect1211ui_story == nil then
				arg_204_1.var_.characterEffect1211ui_story = var_207_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_9 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_9 and not isNil(var_207_8) then
				if arg_204_1.var_.characterEffect1211ui_story and not isNil(var_207_8) then
					arg_204_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_9)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_9 and arg_204_1.time_ < 0 + var_207_9 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.characterEffect1211ui_story then
				arg_204_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_207_10 = arg_204_1.actors_["1211ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1211ui_story = var_207_10.localPosition

				arg_204_1:ShowWeapon(arg_204_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_207_11 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_11 then
				var_207_10.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_204_1.time_ - 0) / var_207_11)
				var_207_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_10.position).x, (manager.ui.mainCamera.transform.position - var_207_10.position).y, (manager.ui.mainCamera.transform.position - var_207_10.position).z)
				var_207_10.localEulerAngles.z = 0
				var_207_10.localEulerAngles.x = 0
				var_207_10.localEulerAngles = var_207_10.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_11 and arg_204_1.time_ < 0 + var_207_11 + arg_207_0 then
				var_207_10.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_207_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_10.position).x, (manager.ui.mainCamera.transform.position - var_207_10.position).y, (manager.ui.mainCamera.transform.position - var_207_10.position).z)
				var_207_10.localEulerAngles.z = 0
				var_207_10.localEulerAngles.x = 0
				var_207_10.localEulerAngles = var_207_10.localEulerAngles
			end

			local var_207_12 = 0
			local var_207_13 = 0.425

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_12 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_14 = arg_204_1:GetWordFromCfg(322281049)
				local var_207_15 = arg_204_1:FormatText(var_207_14.content)

				arg_204_1.text_.text = var_207_15

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_17 = 17 <= 0 and var_207_13 or var_207_13 * (utf8.len(var_207_15) / 17)

				if (17 <= 0 and var_207_13 or var_207_13 * (utf8.len(var_207_15) / 17)) > 0 and var_207_13 < var_207_17 then
					arg_204_1.talkMaxDuration = var_207_17

					if var_207_17 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_17 + var_207_12
					end
				end

				arg_204_1.text_.text = var_207_15
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281049", "story_v_out_322281.awb") ~= 0 then
					local var_207_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281049", "story_v_out_322281.awb") / 1000

					if var_207_18 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_18 + var_207_12
					end

					if var_207_14.prefab_name ~= "" and arg_204_1.actors_[var_207_14.prefab_name] ~= nil then
						local var_207_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_14.prefab_name].transform, "story_v_out_322281", "322281049", "story_v_out_322281.awb")

						arg_204_1:RecordAudio("322281049", var_207_19)
						arg_204_1:RecordAudio("322281049", var_207_19)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322281", "322281049", "story_v_out_322281.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322281", "322281049", "story_v_out_322281.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_20 = math.max(var_207_13, arg_204_1.talkMaxDuration)

			if var_207_12 <= arg_204_1.time_ and arg_204_1.time_ < var_207_12 + var_207_20 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_12) / var_207_20

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_12 + var_207_20 and arg_204_1.time_ < var_207_12 + var_207_20 + arg_207_0 then
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
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1044ui_story = arg_208_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_211_0 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 then
				arg_208_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_208_1.time_ - 0) / var_211_0)
				arg_208_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1044ui_story"].transform.position).z)
				arg_208_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1044ui_story"].transform.localEulerAngles = arg_208_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 then
				arg_208_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_208_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1044ui_story"].transform.position).z)
				arg_208_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1044ui_story"].transform.localEulerAngles = arg_208_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_211_1 = arg_208_1.actors_["1211ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1211ui_story = var_211_1.localPosition
			end

			local var_211_2 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_2 then
				var_211_1.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_208_1.time_ - 0) / var_211_2)
				var_211_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_1.position).x, (manager.ui.mainCamera.transform.position - var_211_1.position).y, (manager.ui.mainCamera.transform.position - var_211_1.position).z)
				var_211_1.localEulerAngles.z = 0
				var_211_1.localEulerAngles.x = 0
				var_211_1.localEulerAngles = var_211_1.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_2 and arg_208_1.time_ < 0 + var_211_2 + arg_211_0 then
				var_211_1.localPosition = Vector3.New(0, 100, 0)
				var_211_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_1.position).x, (manager.ui.mainCamera.transform.position - var_211_1.position).y, (manager.ui.mainCamera.transform.position - var_211_1.position).z)
				var_211_1.localEulerAngles.z = 0
				var_211_1.localEulerAngles.x = 0
				var_211_1.localEulerAngles = var_211_1.localEulerAngles
			end

			local var_211_3 = "10102ui_story"

			if arg_208_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_211_4 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_208_1.stage_.transform)

				var_211_4.name = var_211_3
				var_211_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_208_1.actors_[var_211_3] = var_211_4

				local var_211_5 = var_211_4:GetComponentInChildren(typeof(CharacterEffect))

				var_211_5.enabled = true

				local var_211_6 = GameObjectTools.GetOrAddComponent(var_211_4, typeof(DynamicBoneHelper))

				if var_211_6 then
					var_211_6:EnableDynamicBone(false)
				end

				arg_208_1:ShowWeapon(var_211_5.transform, false)

				arg_208_1.var_[var_211_3 .. "Animator"] = var_211_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_208_1.var_[var_211_3 .. "Animator"].applyRootMotion = true
				arg_208_1.var_[var_211_3 .. "LipSync"] = var_211_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_211_7 = arg_208_1.actors_["10102ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10102ui_story = var_211_7.localPosition
			end

			local var_211_8 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_8 then
				var_211_7.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_208_1.time_ - 0) / var_211_8)
				var_211_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_7.position).x, (manager.ui.mainCamera.transform.position - var_211_7.position).y, (manager.ui.mainCamera.transform.position - var_211_7.position).z)
				var_211_7.localEulerAngles.z = 0
				var_211_7.localEulerAngles.x = 0
				var_211_7.localEulerAngles = var_211_7.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_8 and arg_208_1.time_ < 0 + var_211_8 + arg_211_0 then
				var_211_7.localPosition = Vector3.New(0, -0.985, -6.275)
				var_211_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_7.position).x, (manager.ui.mainCamera.transform.position - var_211_7.position).y, (manager.ui.mainCamera.transform.position - var_211_7.position).z)
				var_211_7.localEulerAngles.z = 0
				var_211_7.localEulerAngles.x = 0
				var_211_7.localEulerAngles = var_211_7.localEulerAngles
			end

			local var_211_9 = arg_208_1.actors_["10102ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_9) and arg_208_1.var_.characterEffect10102ui_story == nil then
				arg_208_1.var_.characterEffect10102ui_story = var_211_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_10 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_10 and not isNil(var_211_9) then
				if arg_208_1.var_.characterEffect10102ui_story and not isNil(var_211_9) then
					arg_208_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_10 and arg_208_1.time_ < 0 + var_211_10 + arg_211_0 and not isNil(var_211_9) and arg_208_1.var_.characterEffect10102ui_story then
				arg_208_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_211_12 = 0
			local var_211_13 = 0.425

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_14 = arg_208_1:GetWordFromCfg(322281050)
				local var_211_15 = arg_208_1:FormatText(var_211_14.content)

				arg_208_1.text_.text = var_211_15

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_17 = 17 <= 0 and var_211_13 or var_211_13 * (utf8.len(var_211_15) / 17)

				if (17 <= 0 and var_211_13 or var_211_13 * (utf8.len(var_211_15) / 17)) > 0 and var_211_13 < var_211_17 then
					arg_208_1.talkMaxDuration = var_211_17

					if var_211_17 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_17 + var_211_12
					end
				end

				arg_208_1.text_.text = var_211_15
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281050", "story_v_out_322281.awb") ~= 0 then
					local var_211_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281050", "story_v_out_322281.awb") / 1000

					if var_211_18 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_18 + var_211_12
					end

					if var_211_14.prefab_name ~= "" and arg_208_1.actors_[var_211_14.prefab_name] ~= nil then
						local var_211_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_14.prefab_name].transform, "story_v_out_322281", "322281050", "story_v_out_322281.awb")

						arg_208_1:RecordAudio("322281050", var_211_19)
						arg_208_1:RecordAudio("322281050", var_211_19)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_322281", "322281050", "story_v_out_322281.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_322281", "322281050", "story_v_out_322281.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_20 = math.max(var_211_13, arg_208_1.talkMaxDuration)

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_20 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_12) / var_211_20

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_12 + var_211_20 and arg_208_1.time_ < var_211_12 + var_211_20 + arg_211_0 then
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
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10102ui_story = arg_212_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10102ui_story"].transform.position).z)
				arg_212_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["10102ui_story"].transform.localEulerAngles = arg_212_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10102ui_story"].transform.position).z)
				arg_212_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["10102ui_story"].transform.localEulerAngles = arg_212_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_215_1 = 0
			local var_215_2 = 1.4

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(322281051).content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 56 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 56)

				if (56 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 56)) > 0 and var_215_2 < var_215_5 then
					arg_212_1.talkMaxDuration = var_215_5

					if var_215_5 + var_215_1 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + var_215_1
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_6 = math.max(var_215_2, arg_212_1.talkMaxDuration)

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_6 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_1) / var_215_6

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_1 + var_215_6 and arg_212_1.time_ < var_215_1 + var_215_6 + arg_215_0 then
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
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1089ui_story = arg_216_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1089ui_story"].transform.position).z)
				arg_216_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1089ui_story"].transform.localEulerAngles = arg_216_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_216_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1089ui_story"].transform.position).z)
				arg_216_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1089ui_story"].transform.localEulerAngles = arg_216_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["1089ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1089ui_story == nil then
				arg_216_1.var_.characterEffect1089ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect1089ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1089ui_story then
				arg_216_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_219_4 = 0
			local var_219_5 = 0.25

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(322281052)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 10 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 10)

				if (10 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 10)) > 0 and var_219_5 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281052", "story_v_out_322281.awb") ~= 0 then
					local var_219_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281052", "story_v_out_322281.awb") / 1000

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end

					if var_219_6.prefab_name ~= "" and arg_216_1.actors_[var_219_6.prefab_name] ~= nil then
						local var_219_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_6.prefab_name].transform, "story_v_out_322281", "322281052", "story_v_out_322281.awb")

						arg_216_1:RecordAudio("322281052", var_219_11)
						arg_216_1:RecordAudio("322281052", var_219_11)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_322281", "322281052", "story_v_out_322281.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_322281", "322281052", "story_v_out_322281.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_12 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_12 and arg_216_1.time_ < var_219_4 + var_219_12 + arg_219_0 then
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
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1089ui_story = arg_220_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1089ui_story"].transform.position).z)
				arg_220_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1089ui_story"].transform.localEulerAngles = arg_220_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_220_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1089ui_story"].transform.position).z)
				arg_220_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1089ui_story"].transform.localEulerAngles = arg_220_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_223_1 = "1020ui_story"

			if arg_220_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_223_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_220_1.stage_.transform)

				var_223_2.name = var_223_1
				var_223_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.actors_[var_223_1] = var_223_2

				local var_223_3 = var_223_2:GetComponentInChildren(typeof(CharacterEffect))

				var_223_3.enabled = true

				local var_223_4 = GameObjectTools.GetOrAddComponent(var_223_2, typeof(DynamicBoneHelper))

				if var_223_4 then
					var_223_4:EnableDynamicBone(false)
				end

				arg_220_1:ShowWeapon(var_223_3.transform, false)

				arg_220_1.var_[var_223_1 .. "Animator"] = var_223_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_220_1.var_[var_223_1 .. "Animator"].applyRootMotion = true
				arg_220_1.var_[var_223_1 .. "LipSync"] = var_223_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_223_5 = arg_220_1.actors_["1020ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1020ui_story = var_223_5.localPosition
			end

			local var_223_6 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_6 then
				var_223_5.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_220_1.time_ - 0) / var_223_6)
				var_223_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_5.position).x, (manager.ui.mainCamera.transform.position - var_223_5.position).y, (manager.ui.mainCamera.transform.position - var_223_5.position).z)
				var_223_5.localEulerAngles.z = 0
				var_223_5.localEulerAngles.x = 0
				var_223_5.localEulerAngles = var_223_5.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_6 and arg_220_1.time_ < 0 + var_223_6 + arg_223_0 then
				var_223_5.localPosition = Vector3.New(0.7, -0.85, -6.25)
				var_223_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_5.position).x, (manager.ui.mainCamera.transform.position - var_223_5.position).y, (manager.ui.mainCamera.transform.position - var_223_5.position).z)
				var_223_5.localEulerAngles.z = 0
				var_223_5.localEulerAngles.x = 0
				var_223_5.localEulerAngles = var_223_5.localEulerAngles
			end

			local var_223_7 = arg_220_1.actors_["1020ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_7) and arg_220_1.var_.characterEffect1020ui_story == nil then
				arg_220_1.var_.characterEffect1020ui_story = var_223_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_8 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_8 and not isNil(var_223_7) then
				if arg_220_1.var_.characterEffect1020ui_story and not isNil(var_223_7) then
					arg_220_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_8 and arg_220_1.time_ < 0 + var_223_8 + arg_223_0 and not isNil(var_223_7) and arg_220_1.var_.characterEffect1020ui_story then
				arg_220_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_223_10 = arg_220_1.actors_["1089ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_10) and arg_220_1.var_.characterEffect1089ui_story == nil then
				arg_220_1.var_.characterEffect1089ui_story = var_223_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_11 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_11 and not isNil(var_223_10) then
				if arg_220_1.var_.characterEffect1089ui_story and not isNil(var_223_10) then
					arg_220_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_11)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_11 and arg_220_1.time_ < 0 + var_223_11 + arg_223_0 and not isNil(var_223_10) and arg_220_1.var_.characterEffect1089ui_story then
				arg_220_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_223_12 = 0
			local var_223_13 = 0.525

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_14 = arg_220_1:GetWordFromCfg(322281053)
				local var_223_15 = arg_220_1:FormatText(var_223_14.content)

				arg_220_1.text_.text = var_223_15

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_17 = 21 <= 0 and var_223_13 or var_223_13 * (utf8.len(var_223_15) / 21)

				if (21 <= 0 and var_223_13 or var_223_13 * (utf8.len(var_223_15) / 21)) > 0 and var_223_13 < var_223_17 then
					arg_220_1.talkMaxDuration = var_223_17

					if var_223_17 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_17 + var_223_12
					end
				end

				arg_220_1.text_.text = var_223_15
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281053", "story_v_out_322281.awb") ~= 0 then
					local var_223_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281053", "story_v_out_322281.awb") / 1000

					if var_223_18 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_18 + var_223_12
					end

					if var_223_14.prefab_name ~= "" and arg_220_1.actors_[var_223_14.prefab_name] ~= nil then
						local var_223_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_14.prefab_name].transform, "story_v_out_322281", "322281053", "story_v_out_322281.awb")

						arg_220_1:RecordAudio("322281053", var_223_19)
						arg_220_1:RecordAudio("322281053", var_223_19)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_322281", "322281053", "story_v_out_322281.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_322281", "322281053", "story_v_out_322281.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_20 = math.max(var_223_13, arg_220_1.talkMaxDuration)

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_20 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_12) / var_223_20

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_12 + var_223_20 and arg_220_1.time_ < var_223_12 + var_223_20 + arg_223_0 then
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
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1089ui_story"]) and arg_224_1.var_.characterEffect1089ui_story == nil then
				arg_224_1.var_.characterEffect1089ui_story = arg_224_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1089ui_story"]) then
				if arg_224_1.var_.characterEffect1089ui_story and not isNil(arg_224_1.actors_["1089ui_story"]) then
					arg_224_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1089ui_story"]) and arg_224_1.var_.characterEffect1089ui_story then
				arg_224_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_227_2 = arg_224_1.actors_["1020ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect1020ui_story == nil then
				arg_224_1.var_.characterEffect1020ui_story = var_227_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_3 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.characterEffect1020ui_story and not isNil(var_227_2) then
					arg_224_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_3)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect1020ui_story then
				arg_224_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_227_4 = 0
			local var_227_5 = 0.425

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(322281054)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 17 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 17)

				if (17 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 17)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281054", "story_v_out_322281.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281054", "story_v_out_322281.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_322281", "322281054", "story_v_out_322281.awb")

						arg_224_1:RecordAudio("322281054", var_227_11)
						arg_224_1:RecordAudio("322281054", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_322281", "322281054", "story_v_out_322281.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_322281", "322281054", "story_v_out_322281.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
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
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1020ui_story"]) and arg_228_1.var_.characterEffect1020ui_story == nil then
				arg_228_1.var_.characterEffect1020ui_story = arg_228_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1020ui_story"]) then
				if arg_228_1.var_.characterEffect1020ui_story and not isNil(arg_228_1.actors_["1020ui_story"]) then
					arg_228_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1020ui_story"]) and arg_228_1.var_.characterEffect1020ui_story then
				arg_228_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["1089ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1089ui_story == nil then
				arg_228_1.var_.characterEffect1089ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect1089ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1089ui_story then
				arg_228_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_231_4 = 0
			local var_231_5 = 0.5

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(322281055)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 20 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 20)

				if (20 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 20)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281055", "story_v_out_322281.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281055", "story_v_out_322281.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_322281", "322281055", "story_v_out_322281.awb")

						arg_228_1:RecordAudio("322281055", var_231_11)
						arg_228_1:RecordAudio("322281055", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_322281", "322281055", "story_v_out_322281.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_322281", "322281055", "story_v_out_322281.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
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
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1089ui_story = arg_232_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1089ui_story"].transform.position).z)
				arg_232_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1089ui_story"].transform.localEulerAngles = arg_232_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1089ui_story"].transform.position).z)
				arg_232_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1089ui_story"].transform.localEulerAngles = arg_232_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1020ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1020ui_story = var_235_1.localPosition
			end

			local var_235_2 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 then
				var_235_1.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_2)
				var_235_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_1.position).x, (manager.ui.mainCamera.transform.position - var_235_1.position).y, (manager.ui.mainCamera.transform.position - var_235_1.position).z)
				var_235_1.localEulerAngles.z = 0
				var_235_1.localEulerAngles.x = 0
				var_235_1.localEulerAngles = var_235_1.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 then
				var_235_1.localPosition = Vector3.New(0, 100, 0)
				var_235_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_1.position).x, (manager.ui.mainCamera.transform.position - var_235_1.position).y, (manager.ui.mainCamera.transform.position - var_235_1.position).z)
				var_235_1.localEulerAngles.z = 0
				var_235_1.localEulerAngles.x = 0
				var_235_1.localEulerAngles = var_235_1.localEulerAngles
			end

			local var_235_3 = 0
			local var_235_4 = 0.55

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_3 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_5 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(322281056).content)

				arg_232_1.text_.text = var_235_5

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_7 = 22 <= 0 and var_235_4 or var_235_4 * (utf8.len(var_235_5) / 22)

				if (22 <= 0 and var_235_4 or var_235_4 * (utf8.len(var_235_5) / 22)) > 0 and var_235_4 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_3 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_3
					end
				end

				arg_232_1.text_.text = var_235_5
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_4, arg_232_1.talkMaxDuration)

			if var_235_3 <= arg_232_1.time_ and arg_232_1.time_ < var_235_3 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_3) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_3 + var_235_8 and arg_232_1.time_ < var_235_3 + var_235_8 + arg_235_0 then
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
			local var_239_0 = 0.1

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

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

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(322281057).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 4 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 4)

				if (4 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 4)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
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
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1020ui_story = arg_240_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1020ui_story"].transform.position).z)
				arg_240_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1020ui_story"].transform.localEulerAngles = arg_240_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_240_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1020ui_story"].transform.position).z)
				arg_240_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1020ui_story"].transform.localEulerAngles = arg_240_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["1020ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1020ui_story == nil then
				arg_240_1.var_.characterEffect1020ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 and not isNil(var_243_1) then
				if arg_240_1.var_.characterEffect1020ui_story and not isNil(var_243_1) then
					arg_240_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1020ui_story then
				arg_240_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_4 = 0
			local var_243_5 = 0.925

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_6 = arg_240_1:GetWordFromCfg(322281058)
				local var_243_7 = arg_240_1:FormatText(var_243_6.content)

				arg_240_1.text_.text = var_243_7

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 37 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 37)

				if (37 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 37)) > 0 and var_243_5 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_4
					end
				end

				arg_240_1.text_.text = var_243_7
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281058", "story_v_out_322281.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281058", "story_v_out_322281.awb") / 1000

					if var_243_10 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_4
					end

					if var_243_6.prefab_name ~= "" and arg_240_1.actors_[var_243_6.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_6.prefab_name].transform, "story_v_out_322281", "322281058", "story_v_out_322281.awb")

						arg_240_1:RecordAudio("322281058", var_243_11)
						arg_240_1:RecordAudio("322281058", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_322281", "322281058", "story_v_out_322281.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_322281", "322281058", "story_v_out_322281.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_12 = math.max(var_243_5, arg_240_1.talkMaxDuration)

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_12 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_4) / var_243_12

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_4 + var_243_12 and arg_240_1.time_ < var_243_4 + var_243_12 + arg_243_0 then
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
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1020ui_story"]) and arg_244_1.var_.characterEffect1020ui_story == nil then
				arg_244_1.var_.characterEffect1020ui_story = arg_244_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1020ui_story"]) then
				if arg_244_1.var_.characterEffect1020ui_story and not isNil(arg_244_1.actors_["1020ui_story"]) then
					arg_244_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1020ui_story"]) and arg_244_1.var_.characterEffect1020ui_story then
				arg_244_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_247_1 = 0
			local var_247_2 = 0.725

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

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

				local var_247_3 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(322281059).content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 29 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 29)

				if (29 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 29)) > 0 and var_247_2 < var_247_5 then
					arg_244_1.talkMaxDuration = var_247_5

					if var_247_5 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_6 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_6 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_6

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_6 and arg_244_1.time_ < var_247_1 + var_247_6 + arg_247_0 then
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
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1020ui_story"]) and arg_248_1.var_.characterEffect1020ui_story == nil then
				arg_248_1.var_.characterEffect1020ui_story = arg_248_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1020ui_story"]) then
				if arg_248_1.var_.characterEffect1020ui_story and not isNil(arg_248_1.actors_["1020ui_story"]) then
					arg_248_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1020ui_story"]) and arg_248_1.var_.characterEffect1020ui_story then
				arg_248_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action428")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_251_2 = 0
			local var_251_3 = 0.625

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_4 = arg_248_1:GetWordFromCfg(322281060)
				local var_251_5 = arg_248_1:FormatText(var_251_4.content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 25 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 25)

				if (25 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 25)) > 0 and var_251_3 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_2
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281060", "story_v_out_322281.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281060", "story_v_out_322281.awb") / 1000

					if var_251_8 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_2
					end

					if var_251_4.prefab_name ~= "" and arg_248_1.actors_[var_251_4.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_4.prefab_name].transform, "story_v_out_322281", "322281060", "story_v_out_322281.awb")

						arg_248_1:RecordAudio("322281060", var_251_9)
						arg_248_1:RecordAudio("322281060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_322281", "322281060", "story_v_out_322281.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_322281", "322281060", "story_v_out_322281.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_3, arg_248_1.talkMaxDuration)

			if var_251_2 <= arg_248_1.time_ and arg_248_1.time_ < var_251_2 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_2) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_2 + var_251_10 and arg_248_1.time_ < var_251_2 + var_251_10 + arg_251_0 then
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
				SetActive(iter_253_1.go, iter_253_0 <= 2)
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
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1020ui_story"]) and arg_252_1.var_.characterEffect1020ui_story == nil then
				arg_252_1.var_.characterEffect1020ui_story = arg_252_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1020ui_story"]) then
				if arg_252_1.var_.characterEffect1020ui_story and not isNil(arg_252_1.actors_["1020ui_story"]) then
					arg_252_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1020ui_story"]) and arg_252_1.var_.characterEffect1020ui_story then
				arg_252_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1020ui_story.fillRatio = 0.5
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
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1020ui_story"]) and arg_256_1.var_.characterEffect1020ui_story == nil then
				arg_256_1.var_.characterEffect1020ui_story = arg_256_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1020ui_story"]) then
				if arg_256_1.var_.characterEffect1020ui_story and not isNil(arg_256_1.actors_["1020ui_story"]) then
					arg_256_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1020ui_story"]) and arg_256_1.var_.characterEffect1020ui_story then
				arg_256_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_259_2 = 0
			local var_259_3 = 0.45

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(322281062)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 18 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 18)

				if (18 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 18)) > 0 and var_259_3 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281062", "story_v_out_322281.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281062", "story_v_out_322281.awb") / 1000

					if var_259_8 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_2
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_out_322281", "322281062", "story_v_out_322281.awb")

						arg_256_1:RecordAudio("322281062", var_259_9)
						arg_256_1:RecordAudio("322281062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_322281", "322281062", "story_v_out_322281.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_322281", "322281062", "story_v_out_322281.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_10 and arg_256_1.time_ < var_259_2 + var_259_10 + arg_259_0 then
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
			local var_263_0 = 1.125

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(322281064)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 45 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 45)

				if (45 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 45)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281064", "story_v_out_322281.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281064", "story_v_out_322281.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_322281", "322281064", "story_v_out_322281.awb")

						arg_260_1:RecordAudio("322281064", var_263_6)
						arg_260_1:RecordAudio("322281064", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322281", "322281064", "story_v_out_322281.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322281", "322281064", "story_v_out_322281.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
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
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1020ui_story"]) and arg_264_1.var_.characterEffect1020ui_story == nil then
				arg_264_1.var_.characterEffect1020ui_story = arg_264_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1020ui_story"]) then
				if arg_264_1.var_.characterEffect1020ui_story and not isNil(arg_264_1.actors_["1020ui_story"]) then
					arg_264_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_0)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1020ui_story"]) and arg_264_1.var_.characterEffect1020ui_story then
				arg_264_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_267_1 = 0
			local var_267_2 = 0.55

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[7].name)

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

				local var_267_3 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(322281065).content)

				arg_264_1.text_.text = var_267_3

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 22 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 22)

				if (22 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 22)) > 0 and var_267_2 < var_267_5 then
					arg_264_1.talkMaxDuration = var_267_5

					if var_267_5 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + var_267_1
					end
				end

				arg_264_1.text_.text = var_267_3
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_6 = math.max(var_267_2, arg_264_1.talkMaxDuration)

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_6 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_1) / var_267_6

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_1 + var_267_6 and arg_264_1.time_ < var_267_1 + var_267_6 + arg_267_0 then
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
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1020ui_story = arg_268_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_271_0 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 then
				arg_268_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_268_1.time_ - 0) / var_271_0)
				arg_268_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1020ui_story"].transform.position).z)
				arg_268_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1020ui_story"].transform.localEulerAngles = arg_268_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 then
				arg_268_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_268_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1020ui_story"].transform.position).z)
				arg_268_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1020ui_story"].transform.localEulerAngles = arg_268_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_271_1 = 0
			local var_271_2 = 1.125

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_3 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(322281066).content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 45 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 45)

				if (45 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 45)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_6 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_6 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_6

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_6 and arg_268_1.time_ < var_271_1 + var_271_6 + arg_271_0 then
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
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1020ui_story = arg_272_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1020ui_story"].transform.position).z)
				arg_272_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1020ui_story"].transform.localEulerAngles = arg_272_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_272_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1020ui_story"].transform.position).z)
				arg_272_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1020ui_story"].transform.localEulerAngles = arg_272_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["1020ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1020ui_story == nil then
				arg_272_1.var_.characterEffect1020ui_story = var_275_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 and not isNil(var_275_1) then
				if arg_272_1.var_.characterEffect1020ui_story and not isNil(var_275_1) then
					arg_272_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1020ui_story then
				arg_272_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_275_4 = 0
			local var_275_5 = 0.1

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:GetWordFromCfg(322281067)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 4 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 4)

				if (4 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 4)) > 0 and var_275_5 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281067", "story_v_out_322281.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281067", "story_v_out_322281.awb") / 1000

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_out_322281", "322281067", "story_v_out_322281.awb")

						arg_272_1:RecordAudio("322281067", var_275_11)
						arg_272_1:RecordAudio("322281067", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_322281", "322281067", "story_v_out_322281.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_322281", "322281067", "story_v_out_322281.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_12 and arg_272_1.time_ < var_275_4 + var_275_12 + arg_275_0 then
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
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1020ui_story"]) and arg_276_1.var_.characterEffect1020ui_story == nil then
				arg_276_1.var_.characterEffect1020ui_story = arg_276_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1020ui_story"]) then
				if arg_276_1.var_.characterEffect1020ui_story and not isNil(arg_276_1.actors_["1020ui_story"]) then
					arg_276_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1020ui_story"]) and arg_276_1.var_.characterEffect1020ui_story then
				arg_276_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.325

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

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

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(322281068).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 13 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 13)

				if (13 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 13)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
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
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1020ui_story"]) and arg_280_1.var_.characterEffect1020ui_story == nil then
				arg_280_1.var_.characterEffect1020ui_story = arg_280_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1020ui_story"]) then
				if arg_280_1.var_.characterEffect1020ui_story and not isNil(arg_280_1.actors_["1020ui_story"]) then
					arg_280_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1020ui_story"]) and arg_280_1.var_.characterEffect1020ui_story then
				arg_280_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_283_2 = 0
			local var_283_3 = 1

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_4 = arg_280_1:GetWordFromCfg(322281069)
				local var_283_5 = arg_280_1:FormatText(var_283_4.content)

				arg_280_1.text_.text = var_283_5

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 40 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 40)

				if (40 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 40)) > 0 and var_283_3 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_5
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281069", "story_v_out_322281.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281069", "story_v_out_322281.awb") / 1000

					if var_283_8 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_2
					end

					if var_283_4.prefab_name ~= "" and arg_280_1.actors_[var_283_4.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_4.prefab_name].transform, "story_v_out_322281", "322281069", "story_v_out_322281.awb")

						arg_280_1:RecordAudio("322281069", var_283_9)
						arg_280_1:RecordAudio("322281069", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_322281", "322281069", "story_v_out_322281.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_322281", "322281069", "story_v_out_322281.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_10 and arg_280_1.time_ < var_283_2 + var_283_10 + arg_283_0 then
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
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1020ui_story"]) and arg_284_1.var_.characterEffect1020ui_story == nil then
				arg_284_1.var_.characterEffect1020ui_story = arg_284_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1020ui_story"]) then
				if arg_284_1.var_.characterEffect1020ui_story and not isNil(arg_284_1.actors_["1020ui_story"]) then
					arg_284_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1020ui_story"]) and arg_284_1.var_.characterEffect1020ui_story then
				arg_284_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.3

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[7].name)

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

				local var_287_3 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(322281070).content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 12 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 12)

				if (12 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 12)) > 0 and var_287_2 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_6 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_6 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_6

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_6 and arg_284_1.time_ < var_287_1 + var_287_6 + arg_287_0 then
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
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1020ui_story"]) and arg_288_1.var_.characterEffect1020ui_story == nil then
				arg_288_1.var_.characterEffect1020ui_story = arg_288_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1020ui_story"]) then
				if arg_288_1.var_.characterEffect1020ui_story and not isNil(arg_288_1.actors_["1020ui_story"]) then
					arg_288_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1020ui_story"]) and arg_288_1.var_.characterEffect1020ui_story then
				arg_288_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_291_2 = 0
			local var_291_3 = 0.95

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_4 = arg_288_1:GetWordFromCfg(322281071)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 38 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 38)

				if (38 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 38)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281071", "story_v_out_322281.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281071", "story_v_out_322281.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_out_322281", "322281071", "story_v_out_322281.awb")

						arg_288_1:RecordAudio("322281071", var_291_9)
						arg_288_1:RecordAudio("322281071", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_322281", "322281071", "story_v_out_322281.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_322281", "322281071", "story_v_out_322281.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
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
			local var_295_0 = 1.2

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:GetWordFromCfg(322281072)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 48 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 48)

				if (48 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 48)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281072", "story_v_out_322281.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281072", "story_v_out_322281.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_322281", "322281072", "story_v_out_322281.awb")

						arg_292_1:RecordAudio("322281072", var_295_6)
						arg_292_1:RecordAudio("322281072", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_322281", "322281072", "story_v_out_322281.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_322281", "322281072", "story_v_out_322281.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
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
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1020ui_story"]) and arg_296_1.var_.characterEffect1020ui_story == nil then
				arg_296_1.var_.characterEffect1020ui_story = arg_296_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1020ui_story"]) then
				if arg_296_1.var_.characterEffect1020ui_story and not isNil(arg_296_1.actors_["1020ui_story"]) then
					arg_296_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_0)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1020ui_story"]) and arg_296_1.var_.characterEffect1020ui_story then
				arg_296_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_299_1 = 0
			local var_299_2 = 0.7

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[7].name)

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

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(322281073).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 28 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 28)

				if (28 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 28)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
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
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1020ui_story = arg_300_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1020ui_story"].transform.position).z)
				arg_300_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1020ui_story"].transform.localEulerAngles = arg_300_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_300_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1020ui_story"].transform.position).z)
				arg_300_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1020ui_story"].transform.localEulerAngles = arg_300_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_303_1 = arg_300_1.actors_["1044ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1044ui_story = var_303_1.localPosition

				arg_300_1:ShowWeapon(arg_300_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_303_2 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 then
				var_303_1.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_300_1.time_ - 0) / var_303_2)
				var_303_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_1.position).x, (manager.ui.mainCamera.transform.position - var_303_1.position).y, (manager.ui.mainCamera.transform.position - var_303_1.position).z)
				var_303_1.localEulerAngles.z = 0
				var_303_1.localEulerAngles.x = 0
				var_303_1.localEulerAngles = var_303_1.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 then
				var_303_1.localPosition = Vector3.New(0, -1, -5.93)
				var_303_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_1.position).x, (manager.ui.mainCamera.transform.position - var_303_1.position).y, (manager.ui.mainCamera.transform.position - var_303_1.position).z)
				var_303_1.localEulerAngles.z = 0
				var_303_1.localEulerAngles.x = 0
				var_303_1.localEulerAngles = var_303_1.localEulerAngles
			end

			local var_303_3 = arg_300_1.actors_["1044ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1044ui_story == nil then
				arg_300_1.var_.characterEffect1044ui_story = var_303_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_4 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 and not isNil(var_303_3) then
				if arg_300_1.var_.characterEffect1044ui_story and not isNil(var_303_3) then
					arg_300_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1044ui_story then
				arg_300_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_303_6 = 0
			local var_303_7 = 0.375

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(322281074)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 15 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 15)

				if (15 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 15)) > 0 and var_303_7 < var_303_11 then
					arg_300_1.talkMaxDuration = var_303_11

					if var_303_11 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281074", "story_v_out_322281.awb") ~= 0 then
					local var_303_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281074", "story_v_out_322281.awb") / 1000

					if var_303_12 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_6
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_out_322281", "322281074", "story_v_out_322281.awb")

						arg_300_1:RecordAudio("322281074", var_303_13)
						arg_300_1:RecordAudio("322281074", var_303_13)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_322281", "322281074", "story_v_out_322281.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_322281", "322281074", "story_v_out_322281.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
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
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1044ui_story"]) and arg_304_1.var_.characterEffect1044ui_story == nil then
				arg_304_1.var_.characterEffect1044ui_story = arg_304_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1044ui_story"]) then
				if arg_304_1.var_.characterEffect1044ui_story and not isNil(arg_304_1.actors_["1044ui_story"]) then
					arg_304_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1044ui_story"]) and arg_304_1.var_.characterEffect1044ui_story then
				arg_304_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.225

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[7].name)

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

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(322281075).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 9 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 9)

				if (9 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 9)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
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
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1044ui_story"]) and arg_308_1.var_.characterEffect1044ui_story == nil then
				arg_308_1.var_.characterEffect1044ui_story = arg_308_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1044ui_story"]) then
				if arg_308_1.var_.characterEffect1044ui_story and not isNil(arg_308_1.actors_["1044ui_story"]) then
					arg_308_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1044ui_story"]) and arg_308_1.var_.characterEffect1044ui_story then
				arg_308_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_2")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_311_2 = 0
			local var_311_3 = 0.15

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_2 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_4 = arg_308_1:GetWordFromCfg(322281076)
				local var_311_5 = arg_308_1:FormatText(var_311_4.content)

				arg_308_1.text_.text = var_311_5

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_7 = 6 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_5) / 6)

				if (6 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_5) / 6)) > 0 and var_311_3 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_2 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_2
					end
				end

				arg_308_1.text_.text = var_311_5
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281076", "story_v_out_322281.awb") ~= 0 then
					local var_311_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281076", "story_v_out_322281.awb") / 1000

					if var_311_8 + var_311_2 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_8 + var_311_2
					end

					if var_311_4.prefab_name ~= "" and arg_308_1.actors_[var_311_4.prefab_name] ~= nil then
						local var_311_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_4.prefab_name].transform, "story_v_out_322281", "322281076", "story_v_out_322281.awb")

						arg_308_1:RecordAudio("322281076", var_311_9)
						arg_308_1:RecordAudio("322281076", var_311_9)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_322281", "322281076", "story_v_out_322281.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_322281", "322281076", "story_v_out_322281.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_10 = math.max(var_311_3, arg_308_1.talkMaxDuration)

			if var_311_2 <= arg_308_1.time_ and arg_308_1.time_ < var_311_2 + var_311_10 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_2) / var_311_10

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_2 + var_311_10 and arg_308_1.time_ < var_311_2 + var_311_10 + arg_311_0 then
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
			if 0.15 < arg_312_1.time_ and arg_312_1.time_ <= 0.15 + arg_315_0 then
				arg_312_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_315_1 = arg_312_1.actors_["1044ui_story"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1044ui_story = var_315_1.localPosition

				arg_312_1:ShowWeapon(arg_312_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_315_2 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 then
				var_315_1.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_2)
				var_315_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_1.position).x, (manager.ui.mainCamera.transform.position - var_315_1.position).y, (manager.ui.mainCamera.transform.position - var_315_1.position).z)
				var_315_1.localEulerAngles.z = 0
				var_315_1.localEulerAngles.x = 0
				var_315_1.localEulerAngles = var_315_1.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 then
				var_315_1.localPosition = Vector3.New(0, 100, 0)
				var_315_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_1.position).x, (manager.ui.mainCamera.transform.position - var_315_1.position).y, (manager.ui.mainCamera.transform.position - var_315_1.position).z)
				var_315_1.localEulerAngles.z = 0
				var_315_1.localEulerAngles.x = 0
				var_315_1.localEulerAngles = var_315_1.localEulerAngles
			end

			local var_315_3 = 0
			local var_315_4 = 1.15

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_5 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(322281077).content)

				arg_312_1.text_.text = var_315_5

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_7 = 46 <= 0 and var_315_4 or var_315_4 * (utf8.len(var_315_5) / 46)

				if (46 <= 0 and var_315_4 or var_315_4 * (utf8.len(var_315_5) / 46)) > 0 and var_315_4 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_3 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_3
					end
				end

				arg_312_1.text_.text = var_315_5
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_8 = math.max(var_315_4, arg_312_1.talkMaxDuration)

			if var_315_3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_3 + var_315_8 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_3) / var_315_8

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_3 + var_315_8 and arg_312_1.time_ < var_315_3 + var_315_8 + arg_315_0 then
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
			local var_319_0 = 1.35

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_1 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(322281078).content)

				arg_316_1.text_.text = var_319_1

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_3 = 54 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 54)

				if (54 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 54)) > 0 and var_319_0 < var_319_3 then
					arg_316_1.talkMaxDuration = var_319_3

					if var_319_3 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_3 + 0
					end
				end

				arg_316_1.text_.text = var_319_1
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_4 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_4

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
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
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1044ui_story = arg_320_1.actors_["1044ui_story"].transform.localPosition

				arg_320_1:ShowWeapon(arg_320_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_323_0 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				arg_320_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1044ui_story"].transform.position).z)
				arg_320_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1044ui_story"].transform.localEulerAngles = arg_320_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				arg_320_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_320_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1044ui_story"].transform.position).z)
				arg_320_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1044ui_story"].transform.localEulerAngles = arg_320_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_323_1 = arg_320_1.actors_["1044ui_story"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1044ui_story == nil then
				arg_320_1.var_.characterEffect1044ui_story = var_323_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_2 and not isNil(var_323_1) then
				if arg_320_1.var_.characterEffect1044ui_story and not isNil(var_323_1) then
					arg_320_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_2 and arg_320_1.time_ < 0 + var_323_2 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1044ui_story then
				arg_320_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_323_4 = 0
			local var_323_5 = 0.325

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:GetWordFromCfg(322281079)
				local var_323_7 = arg_320_1:FormatText(var_323_6.content)

				arg_320_1.text_.text = var_323_7

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_9 = 13 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 13)

				if (13 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 13)) > 0 and var_323_5 < var_323_9 then
					arg_320_1.talkMaxDuration = var_323_9

					if var_323_9 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_9 + var_323_4
					end
				end

				arg_320_1.text_.text = var_323_7
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281079", "story_v_out_322281.awb") ~= 0 then
					local var_323_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281079", "story_v_out_322281.awb") / 1000

					if var_323_10 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_10 + var_323_4
					end

					if var_323_6.prefab_name ~= "" and arg_320_1.actors_[var_323_6.prefab_name] ~= nil then
						local var_323_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_6.prefab_name].transform, "story_v_out_322281", "322281079", "story_v_out_322281.awb")

						arg_320_1:RecordAudio("322281079", var_323_11)
						arg_320_1:RecordAudio("322281079", var_323_11)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_322281", "322281079", "story_v_out_322281.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_322281", "322281079", "story_v_out_322281.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_12 = math.max(var_323_5, arg_320_1.talkMaxDuration)

			if var_323_4 <= arg_320_1.time_ and arg_320_1.time_ < var_323_4 + var_323_12 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_4) / var_323_12

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_4 + var_323_12 and arg_320_1.time_ < var_323_4 + var_323_12 + arg_323_0 then
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
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1089ui_story = arg_324_1.actors_["1089ui_story"].transform.localPosition

				arg_324_1:ShowWeapon(arg_324_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_327_0 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 then
				arg_324_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_324_1.time_ - 0) / var_327_0)
				arg_324_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1089ui_story"].transform.position).z)
				arg_324_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["1089ui_story"].transform.localEulerAngles = arg_324_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 then
				arg_324_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_324_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1089ui_story"].transform.position).z)
				arg_324_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["1089ui_story"].transform.localEulerAngles = arg_324_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_327_1 = arg_324_1.actors_["1089ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect1089ui_story == nil then
				arg_324_1.var_.characterEffect1089ui_story = var_327_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_2 and not isNil(var_327_1) then
				if arg_324_1.var_.characterEffect1089ui_story and not isNil(var_327_1) then
					arg_324_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_2 and arg_324_1.time_ < 0 + var_327_2 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect1089ui_story then
				arg_324_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_327_4 = arg_324_1.actors_["1044ui_story"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1044ui_story = var_327_4.localPosition

				arg_324_1:ShowWeapon(arg_324_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_327_5 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_5 then
				var_327_4.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_324_1.time_ - 0) / var_327_5)
				var_327_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_4.position).x, (manager.ui.mainCamera.transform.position - var_327_4.position).y, (manager.ui.mainCamera.transform.position - var_327_4.position).z)
				var_327_4.localEulerAngles.z = 0
				var_327_4.localEulerAngles.x = 0
				var_327_4.localEulerAngles = var_327_4.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_5 and arg_324_1.time_ < 0 + var_327_5 + arg_327_0 then
				var_327_4.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_327_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_4.position).x, (manager.ui.mainCamera.transform.position - var_327_4.position).y, (manager.ui.mainCamera.transform.position - var_327_4.position).z)
				var_327_4.localEulerAngles.z = 0
				var_327_4.localEulerAngles.x = 0
				var_327_4.localEulerAngles = var_327_4.localEulerAngles
			end

			local var_327_6 = arg_324_1.actors_["1044ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_6) and arg_324_1.var_.characterEffect1044ui_story == nil then
				arg_324_1.var_.characterEffect1044ui_story = var_327_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_7 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 and not isNil(var_327_6) then
				if arg_324_1.var_.characterEffect1044ui_story and not isNil(var_327_6) then
					arg_324_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_7)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 and not isNil(var_327_6) and arg_324_1.var_.characterEffect1044ui_story then
				arg_324_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_327_8 = 0
			local var_327_9 = 0.6

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_8 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_10 = arg_324_1:GetWordFromCfg(322281080)
				local var_327_11 = arg_324_1:FormatText(var_327_10.content)

				arg_324_1.text_.text = var_327_11

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_13 = 24 <= 0 and var_327_9 or var_327_9 * (utf8.len(var_327_11) / 24)

				if (24 <= 0 and var_327_9 or var_327_9 * (utf8.len(var_327_11) / 24)) > 0 and var_327_9 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_8 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_8
					end
				end

				arg_324_1.text_.text = var_327_11
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281080", "story_v_out_322281.awb") ~= 0 then
					local var_327_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281080", "story_v_out_322281.awb") / 1000

					if var_327_14 + var_327_8 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_14 + var_327_8
					end

					if var_327_10.prefab_name ~= "" and arg_324_1.actors_[var_327_10.prefab_name] ~= nil then
						local var_327_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_10.prefab_name].transform, "story_v_out_322281", "322281080", "story_v_out_322281.awb")

						arg_324_1:RecordAudio("322281080", var_327_15)
						arg_324_1:RecordAudio("322281080", var_327_15)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_322281", "322281080", "story_v_out_322281.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_322281", "322281080", "story_v_out_322281.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_16 = math.max(var_327_9, arg_324_1.talkMaxDuration)

			if var_327_8 <= arg_324_1.time_ and arg_324_1.time_ < var_327_8 + var_327_16 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_8) / var_327_16

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_8 + var_327_16 and arg_324_1.time_ < var_327_8 + var_327_16 + arg_327_0 then
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
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos1089ui_story = arg_328_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_331_0 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 then
				arg_328_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_328_1.time_ - 0) / var_331_0)
				arg_328_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1089ui_story"].transform.position).z)
				arg_328_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["1089ui_story"].transform.localEulerAngles = arg_328_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 then
				arg_328_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_328_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1089ui_story"].transform.position).z)
				arg_328_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["1089ui_story"].transform.localEulerAngles = arg_328_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if 0.133333333333333 < arg_328_1.time_ and arg_328_1.time_ <= 0.133333333333333 + arg_331_0 then
				arg_328_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car01", "")
			end

			local var_331_2 = arg_328_1.actors_["1044ui_story"].transform

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos1044ui_story = var_331_2.localPosition

				arg_328_1:ShowWeapon(arg_328_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_331_3 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_3 then
				var_331_2.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_328_1.time_ - 0) / var_331_3)
				var_331_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_2.position).x, (manager.ui.mainCamera.transform.position - var_331_2.position).y, (manager.ui.mainCamera.transform.position - var_331_2.position).z)
				var_331_2.localEulerAngles.z = 0
				var_331_2.localEulerAngles.x = 0
				var_331_2.localEulerAngles = var_331_2.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_3 and arg_328_1.time_ < 0 + var_331_3 + arg_331_0 then
				var_331_2.localPosition = Vector3.New(0, 100, 0)
				var_331_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_2.position).x, (manager.ui.mainCamera.transform.position - var_331_2.position).y, (manager.ui.mainCamera.transform.position - var_331_2.position).z)
				var_331_2.localEulerAngles.z = 0
				var_331_2.localEulerAngles.x = 0
				var_331_2.localEulerAngles = var_331_2.localEulerAngles
			end

			local var_331_4 = 0
			local var_331_5 = 1.375

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_6 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(322281081).content)

				arg_328_1.text_.text = var_331_6

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_8 = 55 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_6) / 55)

				if (55 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_6) / 55)) > 0 and var_331_5 < var_331_8 then
					arg_328_1.talkMaxDuration = var_331_8

					if var_331_8 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_6
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_9 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_9 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_9

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_9 and arg_328_1.time_ < var_331_4 + var_331_9 + arg_331_0 then
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
			local var_335_9000

			if 0.833333333333333 < arg_332_1.time_ and arg_332_1.time_ <= 0.833333333333333 + arg_335_0 then
				arg_332_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_brake", "")
			end

			if 0.833333333333333 < arg_332_1.time_ and arg_332_1.time_ <= 0.833333333333333 + arg_335_0 then
				local var_335_1 = arg_332_1.var_.effect1082

				if not arg_332_1.var_.effect1082 then
					var_335_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_335_1.name = "1082"
					arg_332_1.var_.effect1082 = var_335_1
				else
					var_335_1.transform:SetParent(var_335_9000)
				end

				var_335_1.transform.localPosition = Vector3.New(0, 0, -2.49)
				var_335_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_335_3 = arg_332_1.bgs_.L01f.transform

			if 0.833333333333334 < arg_332_1.time_ and arg_332_1.time_ <= 0.833333333333334 + arg_335_0 then
				arg_332_1.var_.moveOldPosL01f = var_335_3.localPosition
			end

			local var_335_4 = 1

			if 0.833333333333334 <= arg_332_1.time_ and arg_332_1.time_ < 0.833333333333334 + var_335_4 then
				var_335_3.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPosL01f, Vector3.New(0, 1, 7), (arg_332_1.time_ - 0.833333333333334) / var_335_4)
			end

			if arg_332_1.time_ >= 0.833333333333334 + var_335_4 and arg_332_1.time_ < 0.833333333333334 + var_335_4 + arg_335_0 then
				var_335_3.localPosition = Vector3.New(0, 1, 7)
			end

			local var_335_5 = 0

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				arg_332_1.allBtn_.enabled = false
			end

			if arg_332_1.time_ >= var_335_5 + 1.83333333333333 and arg_332_1.time_ < var_335_5 + 1.83333333333333 + arg_335_0 then
				arg_332_1.allBtn_.enabled = true
			end

			local var_335_6 = 0
			local var_335_7 = 1.35

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_8 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(322281082).content)

				arg_332_1.text_.text = var_335_8

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_10 = 54 <= 0 and var_335_7 or var_335_7 * (utf8.len(var_335_8) / 54)

				if (54 <= 0 and var_335_7 or var_335_7 * (utf8.len(var_335_8) / 54)) > 0 and var_335_7 < var_335_10 then
					arg_332_1.talkMaxDuration = var_335_10

					if var_335_10 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_6
					end
				end

				arg_332_1.text_.text = var_335_8
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_11 = math.max(var_335_7, arg_332_1.talkMaxDuration)

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_11 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_6) / var_335_11

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_6 + var_335_11 and arg_332_1.time_ < var_335_6 + var_335_11 + arg_335_0 then
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
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				if arg_336_1.var_.effect1082 then
					Object.Destroy(arg_336_1.var_.effect1082)

					arg_336_1.var_.effect1082 = nil
				end
			end

			local var_339_1 = 0
			local var_339_2 = 0.325

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[7].name)

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

				local var_339_3 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(322281083).content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 13 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 13)

				if (13 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 13)) > 0 and var_339_2 < var_339_5 then
					arg_336_1.talkMaxDuration = var_339_5

					if var_339_5 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + var_339_1
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_6 = math.max(var_339_2, arg_336_1.talkMaxDuration)

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_6 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_1) / var_339_6

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_1 + var_339_6 and arg_336_1.time_ < var_339_1 + var_339_6 + arg_339_0 then
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
			if arg_340_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_343_0 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_340_1.stage_.transform)

				var_343_0.name = "1085ui_story"
				var_343_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.actors_["1085ui_story"] = var_343_0

				local var_343_1 = var_343_0:GetComponentInChildren(typeof(CharacterEffect))

				var_343_1.enabled = true

				local var_343_2 = GameObjectTools.GetOrAddComponent(var_343_0, typeof(DynamicBoneHelper))

				if var_343_2 then
					var_343_2:EnableDynamicBone(false)
				end

				arg_340_1:ShowWeapon(var_343_1.transform, false)

				arg_340_1.var_["1085ui_story" .. "Animator"] = var_343_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_340_1.var_["1085ui_story" .. "Animator"].applyRootMotion = true
				arg_340_1.var_["1085ui_story" .. "LipSync"] = var_343_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_343_3 = arg_340_1.actors_["1085ui_story"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1085ui_story = var_343_3.localPosition
			end

			local var_343_4 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				var_343_3.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_340_1.time_ - 0) / var_343_4)
				var_343_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_3.position).x, (manager.ui.mainCamera.transform.position - var_343_3.position).y, (manager.ui.mainCamera.transform.position - var_343_3.position).z)
				var_343_3.localEulerAngles.z = 0
				var_343_3.localEulerAngles.x = 0
				var_343_3.localEulerAngles = var_343_3.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				var_343_3.localPosition = Vector3.New(0, -1.01, -5.83)
				var_343_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_3.position).x, (manager.ui.mainCamera.transform.position - var_343_3.position).y, (manager.ui.mainCamera.transform.position - var_343_3.position).z)
				var_343_3.localEulerAngles.z = 0
				var_343_3.localEulerAngles.x = 0
				var_343_3.localEulerAngles = var_343_3.localEulerAngles
			end

			local var_343_5 = arg_340_1.actors_["1085ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.characterEffect1085ui_story == nil then
				arg_340_1.var_.characterEffect1085ui_story = var_343_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_6 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_6 and not isNil(var_343_5) then
				if arg_340_1.var_.characterEffect1085ui_story and not isNil(var_343_5) then
					arg_340_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_6 and arg_340_1.time_ < 0 + var_343_6 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.characterEffect1085ui_story then
				arg_340_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_343_8 = 0
			local var_343_9 = 0.475

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_8 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_10 = arg_340_1:GetWordFromCfg(322281084)
				local var_343_11 = arg_340_1:FormatText(var_343_10.content)

				arg_340_1.text_.text = var_343_11

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_13 = 19 <= 0 and var_343_9 or var_343_9 * (utf8.len(var_343_11) / 19)

				if (19 <= 0 and var_343_9 or var_343_9 * (utf8.len(var_343_11) / 19)) > 0 and var_343_9 < var_343_13 then
					arg_340_1.talkMaxDuration = var_343_13

					if var_343_13 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_13 + var_343_8
					end
				end

				arg_340_1.text_.text = var_343_11
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281084", "story_v_out_322281.awb") ~= 0 then
					local var_343_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281084", "story_v_out_322281.awb") / 1000

					if var_343_14 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_14 + var_343_8
					end

					if var_343_10.prefab_name ~= "" and arg_340_1.actors_[var_343_10.prefab_name] ~= nil then
						local var_343_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_10.prefab_name].transform, "story_v_out_322281", "322281084", "story_v_out_322281.awb")

						arg_340_1:RecordAudio("322281084", var_343_15)
						arg_340_1:RecordAudio("322281084", var_343_15)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_322281", "322281084", "story_v_out_322281.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_322281", "322281084", "story_v_out_322281.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_16 = math.max(var_343_9, arg_340_1.talkMaxDuration)

			if var_343_8 <= arg_340_1.time_ and arg_340_1.time_ < var_343_8 + var_343_16 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_8) / var_343_16

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_8 + var_343_16 and arg_340_1.time_ < var_343_8 + var_343_16 + arg_343_0 then
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
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos1044ui_story = arg_344_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_347_0 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 then
				arg_344_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_344_1.time_ - 0) / var_347_0)
				arg_344_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1044ui_story"].transform.position).z)
				arg_344_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["1044ui_story"].transform.localEulerAngles = arg_344_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 then
				arg_344_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_344_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1044ui_story"].transform.position).z)
				arg_344_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["1044ui_story"].transform.localEulerAngles = arg_344_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_347_1 = arg_344_1.actors_["1044ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect1044ui_story == nil then
				arg_344_1.var_.characterEffect1044ui_story = var_347_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_2 and not isNil(var_347_1) then
				if arg_344_1.var_.characterEffect1044ui_story and not isNil(var_347_1) then
					arg_344_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_2 and arg_344_1.time_ < 0 + var_347_2 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect1044ui_story then
				arg_344_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_347_4 = arg_344_1.actors_["1085ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1085ui_story == nil then
				arg_344_1.var_.characterEffect1085ui_story = var_347_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_5 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_5 and not isNil(var_347_4) then
				if arg_344_1.var_.characterEffect1085ui_story and not isNil(var_347_4) then
					arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_5)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_5 and arg_344_1.time_ < 0 + var_347_5 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1085ui_story then
				arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_347_6 = arg_344_1.actors_["1085ui_story"].transform

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos1085ui_story = var_347_6.localPosition
			end

			local var_347_7 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				var_347_6.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_344_1.time_ - 0) / var_347_7)
				var_347_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_347_6.position).x, (manager.ui.mainCamera.transform.position - var_347_6.position).y, (manager.ui.mainCamera.transform.position - var_347_6.position).z)
				var_347_6.localEulerAngles.z = 0
				var_347_6.localEulerAngles.x = 0
				var_347_6.localEulerAngles = var_347_6.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				var_347_6.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				var_347_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_347_6.position).x, (manager.ui.mainCamera.transform.position - var_347_6.position).y, (manager.ui.mainCamera.transform.position - var_347_6.position).z)
				var_347_6.localEulerAngles.z = 0
				var_347_6.localEulerAngles.x = 0
				var_347_6.localEulerAngles = var_347_6.localEulerAngles
			end

			local var_347_8 = 0
			local var_347_9 = 0.475

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_8 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_10 = arg_344_1:GetWordFromCfg(322281085)
				local var_347_11 = arg_344_1:FormatText(var_347_10.content)

				arg_344_1.text_.text = var_347_11

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_13 = 19 <= 0 and var_347_9 or var_347_9 * (utf8.len(var_347_11) / 19)

				if (19 <= 0 and var_347_9 or var_347_9 * (utf8.len(var_347_11) / 19)) > 0 and var_347_9 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_8
					end
				end

				arg_344_1.text_.text = var_347_11
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281085", "story_v_out_322281.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281085", "story_v_out_322281.awb") / 1000

					if var_347_14 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_8
					end

					if var_347_10.prefab_name ~= "" and arg_344_1.actors_[var_347_10.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_10.prefab_name].transform, "story_v_out_322281", "322281085", "story_v_out_322281.awb")

						arg_344_1:RecordAudio("322281085", var_347_15)
						arg_344_1:RecordAudio("322281085", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_322281", "322281085", "story_v_out_322281.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_322281", "322281085", "story_v_out_322281.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_9, arg_344_1.talkMaxDuration)

			if var_347_8 <= arg_344_1.time_ and arg_344_1.time_ < var_347_8 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_8) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_8 + var_347_16 and arg_344_1.time_ < var_347_8 + var_347_16 + arg_347_0 then
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
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1044ui_story = arg_348_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_351_0 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 then
				arg_348_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_348_1.time_ - 0) / var_351_0)
				arg_348_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1044ui_story"].transform.position).z)
				arg_348_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1044ui_story"].transform.localEulerAngles = arg_348_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 then
				arg_348_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1044ui_story"].transform.position).z)
				arg_348_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1044ui_story"].transform.localEulerAngles = arg_348_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_351_1 = arg_348_1.actors_["1085ui_story"].transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1085ui_story = var_351_1.localPosition
			end

			local var_351_2 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_2 then
				var_351_1.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_348_1.time_ - 0) / var_351_2)
				var_351_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_1.position).x, (manager.ui.mainCamera.transform.position - var_351_1.position).y, (manager.ui.mainCamera.transform.position - var_351_1.position).z)
				var_351_1.localEulerAngles.z = 0
				var_351_1.localEulerAngles.x = 0
				var_351_1.localEulerAngles = var_351_1.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_2 and arg_348_1.time_ < 0 + var_351_2 + arg_351_0 then
				var_351_1.localPosition = Vector3.New(0, 100, 0)
				var_351_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_1.position).x, (manager.ui.mainCamera.transform.position - var_351_1.position).y, (manager.ui.mainCamera.transform.position - var_351_1.position).z)
				var_351_1.localEulerAngles.z = 0
				var_351_1.localEulerAngles.x = 0
				var_351_1.localEulerAngles = var_351_1.localEulerAngles
			end

			local var_351_3 = 0
			local var_351_4 = 1.375

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_3 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_5 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(322281086).content)

				arg_348_1.text_.text = var_351_5

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_7 = 55 <= 0 and var_351_4 or var_351_4 * (utf8.len(var_351_5) / 55)

				if (55 <= 0 and var_351_4 or var_351_4 * (utf8.len(var_351_5) / 55)) > 0 and var_351_4 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_3 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_3
					end
				end

				arg_348_1.text_.text = var_351_5
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_4, arg_348_1.talkMaxDuration)

			if var_351_3 <= arg_348_1.time_ and arg_348_1.time_ < var_351_3 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_3) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_3 + var_351_8 and arg_348_1.time_ < var_351_3 + var_351_8 + arg_351_0 then
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
			local var_355_0 = 0.375

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

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

				local var_355_1 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(322281087).content)

				arg_352_1.text_.text = var_355_1

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_3 = 15 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 15)

				if (15 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 15)) > 0 and var_355_0 < var_355_3 then
					arg_352_1.talkMaxDuration = var_355_3

					if var_355_3 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_3 + 0
					end
				end

				arg_352_1.text_.text = var_355_1
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_4 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_4

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
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
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1085ui_story = arg_356_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_356_1.time_ - 0) / var_359_0)
				arg_356_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1085ui_story"].transform.position).z)
				arg_356_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1085ui_story"].transform.localEulerAngles = arg_356_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_356_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1085ui_story"].transform.position).z)
				arg_356_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1085ui_story"].transform.localEulerAngles = arg_356_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_359_1 = arg_356_1.actors_["1085ui_story"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_1) and arg_356_1.var_.characterEffect1085ui_story == nil then
				arg_356_1.var_.characterEffect1085ui_story = var_359_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_2 and not isNil(var_359_1) then
				if arg_356_1.var_.characterEffect1085ui_story and not isNil(var_359_1) then
					arg_356_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_2 and arg_356_1.time_ < 0 + var_359_2 + arg_359_0 and not isNil(var_359_1) and arg_356_1.var_.characterEffect1085ui_story then
				arg_356_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_359_4 = 0
			local var_359_5 = 0.275

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_6 = arg_356_1:GetWordFromCfg(322281088)
				local var_359_7 = arg_356_1:FormatText(var_359_6.content)

				arg_356_1.text_.text = var_359_7

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_9 = 11 <= 0 and var_359_5 or var_359_5 * (utf8.len(var_359_7) / 11)

				if (11 <= 0 and var_359_5 or var_359_5 * (utf8.len(var_359_7) / 11)) > 0 and var_359_5 < var_359_9 then
					arg_356_1.talkMaxDuration = var_359_9

					if var_359_9 + var_359_4 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_9 + var_359_4
					end
				end

				arg_356_1.text_.text = var_359_7
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281088", "story_v_out_322281.awb") ~= 0 then
					local var_359_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281088", "story_v_out_322281.awb") / 1000

					if var_359_10 + var_359_4 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_10 + var_359_4
					end

					if var_359_6.prefab_name ~= "" and arg_356_1.actors_[var_359_6.prefab_name] ~= nil then
						local var_359_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_6.prefab_name].transform, "story_v_out_322281", "322281088", "story_v_out_322281.awb")

						arg_356_1:RecordAudio("322281088", var_359_11)
						arg_356_1:RecordAudio("322281088", var_359_11)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_322281", "322281088", "story_v_out_322281.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_322281", "322281088", "story_v_out_322281.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_12 = math.max(var_359_5, arg_356_1.talkMaxDuration)

			if var_359_4 <= arg_356_1.time_ and arg_356_1.time_ < var_359_4 + var_359_12 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_4) / var_359_12

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_4 + var_359_12 and arg_356_1.time_ < var_359_4 + var_359_12 + arg_359_0 then
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
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1085ui_story"]) and arg_360_1.var_.characterEffect1085ui_story == nil then
				arg_360_1.var_.characterEffect1085ui_story = arg_360_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1085ui_story"]) then
				if arg_360_1.var_.characterEffect1085ui_story and not isNil(arg_360_1.actors_["1085ui_story"]) then
					arg_360_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_360_1.time_ - 0) / var_363_0)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1085ui_story"]) and arg_360_1.var_.characterEffect1085ui_story then
				arg_360_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_363_1 = 0
			local var_363_2 = 0.55

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[7].name)

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

				local var_363_3 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(322281089).content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 22 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 22)

				if (22 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 22)) > 0 and var_363_2 < var_363_5 then
					arg_360_1.talkMaxDuration = var_363_5

					if var_363_5 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_6 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_6 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_6

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_6 and arg_360_1.time_ < var_363_1 + var_363_6 + arg_363_0 then
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
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["1085ui_story"]) and arg_364_1.var_.characterEffect1085ui_story == nil then
				arg_364_1.var_.characterEffect1085ui_story = arg_364_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_0 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["1085ui_story"]) then
				if arg_364_1.var_.characterEffect1085ui_story and not isNil(arg_364_1.actors_["1085ui_story"]) then
					arg_364_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["1085ui_story"]) and arg_364_1.var_.characterEffect1085ui_story then
				arg_364_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_2")
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_367_2 = 0
			local var_367_3 = 0.225

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_2 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:GetWordFromCfg(322281090)
				local var_367_5 = arg_364_1:FormatText(var_367_4.content)

				arg_364_1.text_.text = var_367_5

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_7 = 9 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 9)

				if (9 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 9)) > 0 and var_367_3 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_2
					end
				end

				arg_364_1.text_.text = var_367_5
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281090", "story_v_out_322281.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_322281", "322281090", "story_v_out_322281.awb") / 1000

					if var_367_8 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_2
					end

					if var_367_4.prefab_name ~= "" and arg_364_1.actors_[var_367_4.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_4.prefab_name].transform, "story_v_out_322281", "322281090", "story_v_out_322281.awb")

						arg_364_1:RecordAudio("322281090", var_367_9)
						arg_364_1:RecordAudio("322281090", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_322281", "322281090", "story_v_out_322281.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_322281", "322281090", "story_v_out_322281.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_3, arg_364_1.talkMaxDuration)

			if var_367_2 <= arg_364_1.time_ and arg_364_1.time_ < var_367_2 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_2) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_2 + var_367_10 and arg_364_1.time_ < var_367_2 + var_367_10 + arg_367_0 then
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
			if 4 < arg_368_1.time_ and arg_368_1.time_ <= 4 + arg_371_0 then
				arg_368_1.allBtn_.enabled = false
			end

			if arg_368_1.time_ >= 4 + 0.3 and arg_368_1.time_ < 4 + 0.3 + arg_371_0 then
				arg_368_1.allBtn_.enabled = true
			end

			local var_371_0 = "ST0505"

			if arg_368_1.bgs_.ST0505 == nil then
				local var_371_1 = Object.Instantiate(arg_368_1.paintGo_)

				var_371_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_371_0)
				var_371_1.name = var_371_0
				var_371_1.transform.parent = arg_368_1.stage_.transform
				var_371_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.bgs_[var_371_0] = var_371_1
			end

			if 2 < arg_368_1.time_ and arg_368_1.time_ <= 2 + arg_371_0 then
				local var_371_2 = arg_368_1.bgs_.ST0505

				arg_368_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_371_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_3 = var_371_2:GetComponent("SpriteRenderer")

				if var_371_3 and var_371_3.sprite then
					local var_371_4 = 2 * (var_371_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_371_2.transform.localScale = Vector3.New(var_371_4 / var_371_3.sprite.bounds.size.y < var_371_4 * manager.ui.mainCameraCom_.aspect / var_371_3.sprite.bounds.size.x and var_371_4 * manager.ui.mainCameraCom_.aspect / var_371_3.sprite.bounds.size.x or var_371_4 / var_371_3.sprite.bounds.size.y, var_371_4 / var_371_3.sprite.bounds.size.y < var_371_4 * manager.ui.mainCameraCom_.aspect / var_371_3.sprite.bounds.size.x and var_371_4 * manager.ui.mainCameraCom_.aspect / var_371_3.sprite.bounds.size.x or var_371_4 / var_371_3.sprite.bounds.size.y, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "ST0505" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_5 = 0

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_5 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_6 = 2

			if var_371_5 <= arg_368_1.time_ and arg_368_1.time_ < var_371_5 + var_371_6 then
				local var_371_7 = Color.New(0, 0, 0)

				var_371_7.a = Mathf.Lerp(0, 1, (arg_368_1.time_ - var_371_5) / var_371_6)
				arg_368_1.mask_.color = var_371_7
			end

			if arg_368_1.time_ >= var_371_5 + var_371_6 and arg_368_1.time_ < var_371_5 + var_371_6 + arg_371_0 then
				local var_371_8 = Color.New(0, 0, 0)

				var_371_8.a = 1
				arg_368_1.mask_.color = var_371_8
			end

			local var_371_9 = 2

			if 2 < arg_368_1.time_ and arg_368_1.time_ <= var_371_9 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_10 = 2

			if var_371_9 <= arg_368_1.time_ and arg_368_1.time_ < var_371_9 + var_371_10 then
				local var_371_11 = Color.New(0, 0, 0)

				var_371_11.a = Mathf.Lerp(1, 0, (arg_368_1.time_ - var_371_9) / var_371_10)
				arg_368_1.mask_.color = var_371_11
			end

			if arg_368_1.time_ >= var_371_9 + var_371_10 and arg_368_1.time_ < var_371_9 + var_371_10 + arg_371_0 then
				local var_371_12 = Color.New(0, 0, 0)

				arg_368_1.mask_.enabled = false
				var_371_12.a = 0
				arg_368_1.mask_.color = var_371_12
			end

			local var_371_13 = "404001ui_story"

			if arg_368_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_371_14 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_368_1.stage_.transform)

				var_371_14.name = var_371_13
				var_371_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.actors_[var_371_13] = var_371_14

				local var_371_15 = var_371_14:GetComponentInChildren(typeof(CharacterEffect))

				var_371_15.enabled = true

				local var_371_16 = GameObjectTools.GetOrAddComponent(var_371_14, typeof(DynamicBoneHelper))

				if var_371_16 then
					var_371_16:EnableDynamicBone(false)
				end

				arg_368_1:ShowWeapon(var_371_15.transform, false)

				arg_368_1.var_[var_371_13 .. "Animator"] = var_371_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_368_1.var_[var_371_13 .. "Animator"].applyRootMotion = true
				arg_368_1.var_[var_371_13 .. "LipSync"] = var_371_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_371_17 = arg_368_1.actors_["404001ui_story"].transform

			if 4 < arg_368_1.time_ and arg_368_1.time_ <= 4 + arg_371_0 then
				arg_368_1.var_.moveOldPos404001ui_story = var_371_17.localPosition
			end

			local var_371_18 = 0.001

			if 4 <= arg_368_1.time_ and arg_368_1.time_ < 4 + var_371_18 then
				var_371_17.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_368_1.time_ - 4) / var_371_18)
				var_371_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_17.position).x, (manager.ui.mainCamera.transform.position - var_371_17.position).y, (manager.ui.mainCamera.transform.position - var_371_17.position).z)
				var_371_17.localEulerAngles.z = 0
				var_371_17.localEulerAngles.x = 0
				var_371_17.localEulerAngles = var_371_17.localEulerAngles
			end

			if arg_368_1.time_ >= 4 + var_371_18 and arg_368_1.time_ < 4 + var_371_18 + arg_371_0 then
				var_371_17.localPosition = Vector3.New(0, -1.55, -5.5)
				var_371_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_17.position).x, (manager.ui.mainCamera.transform.position - var_371_17.position).y, (manager.ui.mainCamera.transform.position - var_371_17.position).z)
				var_371_17.localEulerAngles.z = 0
				var_371_17.localEulerAngles.x = 0
				var_371_17.localEulerAngles = var_371_17.localEulerAngles
			end

			local var_371_19 = arg_368_1.actors_["404001ui_story"]

			if 4 < arg_368_1.time_ and arg_368_1.time_ <= 4 + arg_371_0 and not isNil(var_371_19) and arg_368_1.var_.characterEffect404001ui_story == nil then
				arg_368_1.var_.characterEffect404001ui_story = var_371_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_20 = 0.200000002980232

			if 4 <= arg_368_1.time_ and arg_368_1.time_ < 4 + var_371_20 and not isNil(var_371_19) then
				if arg_368_1.var_.characterEffect404001ui_story and not isNil(var_371_19) then
					arg_368_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 4 + var_371_20 and arg_368_1.time_ < 4 + var_371_20 + arg_371_0 and not isNil(var_371_19) and arg_368_1.var_.characterEffect404001ui_story then
				arg_368_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 4 < arg_368_1.time_ and arg_368_1.time_ <= 4 + arg_371_0 then
				arg_368_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 4 < arg_368_1.time_ and arg_368_1.time_ <= 4 + arg_371_0 then
				arg_368_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_371_22 = arg_368_1.actors_["1085ui_story"].transform

			if 2 < arg_368_1.time_ and arg_368_1.time_ <= 2 + arg_371_0 then
				arg_368_1.var_.moveOldPos1085ui_story = var_371_22.localPosition
			end

			local var_371_23 = 0.001

			if 2 <= arg_368_1.time_ and arg_368_1.time_ < 2 + var_371_23 then
				var_371_22.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_368_1.time_ - 2) / var_371_23)
				var_371_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_22.position).x, (manager.ui.mainCamera.transform.position - var_371_22.position).y, (manager.ui.mainCamera.transform.position - var_371_22.position).z)
				var_371_22.localEulerAngles.z = 0
				var_371_22.localEulerAngles.x = 0
				var_371_22.localEulerAngles = var_371_22.localEulerAngles
			end

			if arg_368_1.time_ >= 2 + var_371_23 and arg_368_1.time_ < 2 + var_371_23 + arg_371_0 then
				var_371_22.localPosition = Vector3.New(0, 100, 0)
				var_371_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_22.position).x, (manager.ui.mainCamera.transform.position - var_371_22.position).y, (manager.ui.mainCamera.transform.position - var_371_22.position).z)
				var_371_22.localEulerAngles.z = 0
				var_371_22.localEulerAngles.x = 0
				var_371_22.localEulerAngles = var_371_22.localEulerAngles
			end

			if 0.1 < arg_368_1.time_ and arg_368_1.time_ <= 0.1 + arg_371_0 then
				arg_368_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 1.66666666666667 < arg_368_1.time_ and arg_368_1.time_ <= 1.66666666666667 + arg_371_0 then
				arg_368_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_371_26 = 2

			arg_368_1.isInRecall_ = false

			if var_371_26 < arg_368_1.time_ and arg_368_1.time_ <= var_371_26 + arg_371_0 then
				arg_368_1.screenFilterGo_:SetActive(true)

				arg_368_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_371_2, iter_371_3 in pairs(arg_368_1.actors_) do
					for iter_371_4, iter_371_5 in ipairs((iter_371_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_371_5.color = iter_371_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_371_27 = 0.0166666666666667

			if var_371_26 <= arg_368_1.time_ and arg_368_1.time_ < var_371_26 + var_371_27 then
				arg_368_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_368_1.time_ - var_371_26) / var_371_27)
			end

			if arg_368_1.time_ >= var_371_26 + var_371_27 and arg_368_1.time_ < var_371_26 + var_371_27 + arg_371_0 then
				arg_368_1.screenFilterEffect_.weight = 1
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_28 = 4
			local var_371_29 = 1.15

			if 4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_28 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_30 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_30:setOnUpdate(LuaHelper.FloatAction(function(arg_372_0)
					arg_368_1.dialogCg_.alpha = arg_372_0
				end))
				var_371_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_31 = arg_368_1:GetWordFromCfg(322281091)
				local var_371_32 = arg_368_1:FormatText(var_371_31.content)

				arg_368_1.text_.text = var_371_32

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_34 = 46 <= 0 and var_371_29 or var_371_29 * (utf8.len(var_371_32) / 46)

				if (46 <= 0 and var_371_29 or var_371_29 * (utf8.len(var_371_32) / 46)) > 0 and var_371_29 < var_371_34 then
					arg_368_1.talkMaxDuration = var_371_34
					var_371_28 = var_371_28 + 0.3

					if var_371_34 + var_371_28 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_34 + var_371_28
					end
				end

				arg_368_1.text_.text = var_371_32
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281091", "story_v_out_322281.awb") ~= 0 then
					local var_371_35 = manager.audio:GetVoiceLength("story_v_out_322281", "322281091", "story_v_out_322281.awb") / 1000

					if var_371_35 + var_371_28 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_35 + var_371_28
					end

					if var_371_31.prefab_name ~= "" and arg_368_1.actors_[var_371_31.prefab_name] ~= nil then
						local var_371_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_31.prefab_name].transform, "story_v_out_322281", "322281091", "story_v_out_322281.awb")

						arg_368_1:RecordAudio("322281091", var_371_36)
						arg_368_1:RecordAudio("322281091", var_371_36)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_322281", "322281091", "story_v_out_322281.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_322281", "322281091", "story_v_out_322281.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_37 = var_371_28 + 0.3
			local var_371_38 = math.max(var_371_29, arg_368_1.talkMaxDuration)

			if var_371_28 + 0.3 <= arg_368_1.time_ and arg_368_1.time_ < var_371_37 + var_371_38 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_37) / var_371_38

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_37 + var_371_38 and arg_368_1.time_ < var_371_37 + var_371_38 + arg_371_0 then
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
			local var_377_0 = 0.95

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(322281092)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 38 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 38)

				if (38 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 38)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281092", "story_v_out_322281.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281092", "story_v_out_322281.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_322281", "322281092", "story_v_out_322281.awb")

						arg_374_1:RecordAudio("322281092", var_377_6)
						arg_374_1:RecordAudio("322281092", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_322281", "322281092", "story_v_out_322281.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_322281", "322281092", "story_v_out_322281.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
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
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_381_0 = 0
			local var_381_1 = 0.75

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_2 = arg_378_1:GetWordFromCfg(322281093)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 30 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 30)

				if (30 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 30)) > 0 and var_381_1 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281093", "story_v_out_322281.awb") ~= 0 then
					local var_381_6 = manager.audio:GetVoiceLength("story_v_out_322281", "322281093", "story_v_out_322281.awb") / 1000

					if var_381_6 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_0
					end

					if var_381_2.prefab_name ~= "" and arg_378_1.actors_[var_381_2.prefab_name] ~= nil then
						local var_381_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_2.prefab_name].transform, "story_v_out_322281", "322281093", "story_v_out_322281.awb")

						arg_378_1:RecordAudio("322281093", var_381_7)
						arg_378_1:RecordAudio("322281093", var_381_7)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_322281", "322281093", "story_v_out_322281.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_322281", "322281093", "story_v_out_322281.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_8 and arg_378_1.time_ < var_381_0 + var_381_8 + arg_381_0 then
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
			local var_385_0 = 1.225

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_1 = arg_382_1:GetWordFromCfg(322281094)
				local var_385_2 = arg_382_1:FormatText(var_385_1.content)

				arg_382_1.text_.text = var_385_2

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 49 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 49)

				if (49 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 49)) > 0 and var_385_0 < var_385_4 then
					arg_382_1.talkMaxDuration = var_385_4

					if var_385_4 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_4 + 0
					end
				end

				arg_382_1.text_.text = var_385_2
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281094", "story_v_out_322281.awb") ~= 0 then
					local var_385_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281094", "story_v_out_322281.awb") / 1000

					if var_385_5 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + 0
					end

					if var_385_1.prefab_name ~= "" and arg_382_1.actors_[var_385_1.prefab_name] ~= nil then
						local var_385_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_1.prefab_name].transform, "story_v_out_322281", "322281094", "story_v_out_322281.awb")

						arg_382_1:RecordAudio("322281094", var_385_6)
						arg_382_1:RecordAudio("322281094", var_385_6)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_322281", "322281094", "story_v_out_322281.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_322281", "322281094", "story_v_out_322281.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_7 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_7

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
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
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			local var_389_0 = 0
			local var_389_1 = 0.475

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_2 = arg_386_1:GetWordFromCfg(322281095)
				local var_389_3 = arg_386_1:FormatText(var_389_2.content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 19 <= 0 and var_389_1 or var_389_1 * (utf8.len(var_389_3) / 19)

				if (19 <= 0 and var_389_1 or var_389_1 * (utf8.len(var_389_3) / 19)) > 0 and var_389_1 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281095", "story_v_out_322281.awb") ~= 0 then
					local var_389_6 = manager.audio:GetVoiceLength("story_v_out_322281", "322281095", "story_v_out_322281.awb") / 1000

					if var_389_6 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_6 + var_389_0
					end

					if var_389_2.prefab_name ~= "" and arg_386_1.actors_[var_389_2.prefab_name] ~= nil then
						local var_389_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_2.prefab_name].transform, "story_v_out_322281", "322281095", "story_v_out_322281.awb")

						arg_386_1:RecordAudio("322281095", var_389_7)
						arg_386_1:RecordAudio("322281095", var_389_7)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_322281", "322281095", "story_v_out_322281.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_322281", "322281095", "story_v_out_322281.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_8 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_8 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_8

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_8 and arg_386_1.time_ < var_389_0 + var_389_8 + arg_389_0 then
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
			if 3.999999999999 < arg_390_1.time_ and arg_390_1.time_ <= 3.999999999999 + arg_393_0 then
				arg_390_1.allBtn_.enabled = false
			end

			if arg_390_1.time_ >= 3.999999999999 + 0.125 and arg_390_1.time_ < 3.999999999999 + 0.125 + arg_393_0 then
				arg_390_1.allBtn_.enabled = true
			end

			if 1.999999999999 < arg_390_1.time_ and arg_390_1.time_ <= 1.999999999999 + arg_393_0 then
				local var_393_0 = arg_390_1.bgs_.L01f

				arg_390_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_393_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_393_1 = var_393_0:GetComponent("SpriteRenderer")

				if var_393_1 and var_393_1.sprite then
					local var_393_2 = 2 * (var_393_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_393_0.transform.localScale = Vector3.New(var_393_2 / var_393_1.sprite.bounds.size.y < var_393_2 * manager.ui.mainCameraCom_.aspect / var_393_1.sprite.bounds.size.x and var_393_2 * manager.ui.mainCameraCom_.aspect / var_393_1.sprite.bounds.size.x or var_393_2 / var_393_1.sprite.bounds.size.y, var_393_2 / var_393_1.sprite.bounds.size.y < var_393_2 * manager.ui.mainCameraCom_.aspect / var_393_1.sprite.bounds.size.x and var_393_2 * manager.ui.mainCameraCom_.aspect / var_393_1.sprite.bounds.size.x or var_393_2 / var_393_1.sprite.bounds.size.y, 0)
				end

				for iter_393_0, iter_393_1 in pairs(arg_390_1.bgs_) do
					if iter_393_0 ~= "L01f" then
						iter_393_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_393_3 = 0

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_3 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_4 = 2

			if var_393_3 <= arg_390_1.time_ and arg_390_1.time_ < var_393_3 + var_393_4 then
				local var_393_5 = Color.New(0, 0, 0)

				var_393_5.a = Mathf.Lerp(0, 1, (arg_390_1.time_ - var_393_3) / var_393_4)
				arg_390_1.mask_.color = var_393_5
			end

			if arg_390_1.time_ >= var_393_3 + var_393_4 and arg_390_1.time_ < var_393_3 + var_393_4 + arg_393_0 then
				local var_393_6 = Color.New(0, 0, 0)

				var_393_6.a = 1
				arg_390_1.mask_.color = var_393_6
			end

			local var_393_7 = 2

			if 2 < arg_390_1.time_ and arg_390_1.time_ <= var_393_7 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_8 = 2

			if var_393_7 <= arg_390_1.time_ and arg_390_1.time_ < var_393_7 + var_393_8 then
				local var_393_9 = Color.New(0, 0, 0)

				var_393_9.a = Mathf.Lerp(1, 0, (arg_390_1.time_ - var_393_7) / var_393_8)
				arg_390_1.mask_.color = var_393_9
			end

			if arg_390_1.time_ >= var_393_7 + var_393_8 and arg_390_1.time_ < var_393_7 + var_393_8 + arg_393_0 then
				local var_393_10 = Color.New(0, 0, 0)

				arg_390_1.mask_.enabled = false
				var_393_10.a = 0
				arg_390_1.mask_.color = var_393_10
			end

			local var_393_11 = arg_390_1.actors_["404001ui_story"].transform

			if 1.96599999815126 < arg_390_1.time_ and arg_390_1.time_ <= 1.96599999815126 + arg_393_0 then
				arg_390_1.var_.moveOldPos404001ui_story = var_393_11.localPosition
			end

			local var_393_12 = 0.001

			if 1.96599999815126 <= arg_390_1.time_ and arg_390_1.time_ < 1.96599999815126 + var_393_12 then
				var_393_11.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_390_1.time_ - 1.96599999815126) / var_393_12)
				var_393_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_11.position).x, (manager.ui.mainCamera.transform.position - var_393_11.position).y, (manager.ui.mainCamera.transform.position - var_393_11.position).z)
				var_393_11.localEulerAngles.z = 0
				var_393_11.localEulerAngles.x = 0
				var_393_11.localEulerAngles = var_393_11.localEulerAngles
			end

			if arg_390_1.time_ >= 1.96599999815126 + var_393_12 and arg_390_1.time_ < 1.96599999815126 + var_393_12 + arg_393_0 then
				var_393_11.localPosition = Vector3.New(0, 100, 0)
				var_393_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_11.position).x, (manager.ui.mainCamera.transform.position - var_393_11.position).y, (manager.ui.mainCamera.transform.position - var_393_11.position).z)
				var_393_11.localEulerAngles.z = 0
				var_393_11.localEulerAngles.x = 0
				var_393_11.localEulerAngles = var_393_11.localEulerAngles
			end

			local var_393_13 = arg_390_1.actors_["10102ui_story"]

			if 3.999999999999 < arg_390_1.time_ and arg_390_1.time_ <= 3.999999999999 + arg_393_0 and not isNil(var_393_13) and arg_390_1.var_.characterEffect10102ui_story == nil then
				arg_390_1.var_.characterEffect10102ui_story = var_393_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_14 = 0.125

			if 3.999999999999 <= arg_390_1.time_ and arg_390_1.time_ < 3.999999999999 + var_393_14 and not isNil(var_393_13) then
				if arg_390_1.var_.characterEffect10102ui_story and not isNil(var_393_13) then
					arg_390_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 3.999999999999 + var_393_14 and arg_390_1.time_ < 3.999999999999 + var_393_14 + arg_393_0 and not isNil(var_393_13) and arg_390_1.var_.characterEffect10102ui_story then
				arg_390_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_393_16 = arg_390_1.actors_["10102ui_story"].transform

			if 4.01733333518008 < arg_390_1.time_ and arg_390_1.time_ <= 4.01733333518008 + arg_393_0 then
				arg_390_1.var_.moveOldPos10102ui_story = var_393_16.localPosition
			end

			local var_393_17 = 0.001

			if 4.01733333518008 <= arg_390_1.time_ and arg_390_1.time_ < 4.01733333518008 + var_393_17 then
				var_393_16.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_390_1.time_ - 4.01733333518008) / var_393_17)
				var_393_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_16.position).x, (manager.ui.mainCamera.transform.position - var_393_16.position).y, (manager.ui.mainCamera.transform.position - var_393_16.position).z)
				var_393_16.localEulerAngles.z = 0
				var_393_16.localEulerAngles.x = 0
				var_393_16.localEulerAngles = var_393_16.localEulerAngles
			end

			if arg_390_1.time_ >= 4.01733333518008 + var_393_17 and arg_390_1.time_ < 4.01733333518008 + var_393_17 + arg_393_0 then
				var_393_16.localPosition = Vector3.New(0, -0.985, -6.275)
				var_393_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_16.position).x, (manager.ui.mainCamera.transform.position - var_393_16.position).y, (manager.ui.mainCamera.transform.position - var_393_16.position).z)
				var_393_16.localEulerAngles.z = 0
				var_393_16.localEulerAngles.x = 0
				var_393_16.localEulerAngles = var_393_16.localEulerAngles
			end

			if 3.999999999999 < arg_390_1.time_ and arg_390_1.time_ <= 3.999999999999 + arg_393_0 then
				arg_390_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 3.999999999999 < arg_390_1.time_ and arg_390_1.time_ <= 3.999999999999 + arg_393_0 then
				arg_390_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0.233333333333333 < arg_390_1.time_ and arg_390_1.time_ <= 0.233333333333333 + arg_393_0 then
				arg_390_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.53333333333333 < arg_390_1.time_ and arg_390_1.time_ <= 1.53333333333333 + arg_393_0 then
				arg_390_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_393_20 = 2

			arg_390_1.isInRecall_ = false

			if var_393_20 < arg_390_1.time_ and arg_390_1.time_ <= var_393_20 + arg_393_0 then
				arg_390_1.screenFilterGo_:SetActive(false)

				for iter_393_2, iter_393_3 in pairs(arg_390_1.actors_) do
					for iter_393_4, iter_393_5 in ipairs((iter_393_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_393_5.color = iter_393_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_393_21 = 0.0166666666666667

			if var_393_20 <= arg_390_1.time_ and arg_390_1.time_ < var_393_20 + var_393_21 then
				arg_390_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_390_1.time_ - var_393_20) / var_393_21)
			end

			if arg_390_1.time_ >= var_393_20 + var_393_21 and arg_390_1.time_ < var_393_20 + var_393_21 + arg_393_0 then
				arg_390_1.screenFilterEffect_.weight = 0
			end

			if arg_390_1.frameCnt_ <= 1 then
				arg_390_1.dialog_:SetActive(false)
			end

			local var_393_22 = 3.999999999999
			local var_393_23 = 0.125

			if 3.999999999999 < arg_390_1.time_ and arg_390_1.time_ <= var_393_22 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0

				arg_390_1.dialog_:SetActive(true)

				arg_390_1.dialogCg_.alpha = 0

				local var_393_24 = LeanTween.value(arg_390_1.dialog_, 0, 1, 0.3)

				var_393_24:setOnUpdate(LuaHelper.FloatAction(function(arg_394_0)
					arg_390_1.dialogCg_.alpha = arg_394_0
				end))
				var_393_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_390_1.dialog_)
					var_393_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_390_1.duration_ = arg_390_1.duration_ + 0.3

				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_25 = arg_390_1:GetWordFromCfg(322281096)
				local var_393_26 = arg_390_1:FormatText(var_393_25.content)

				arg_390_1.text_.text = var_393_26

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_28 = 5 <= 0 and var_393_23 or var_393_23 * (utf8.len(var_393_26) / 5)

				if (5 <= 0 and var_393_23 or var_393_23 * (utf8.len(var_393_26) / 5)) > 0 and var_393_23 < var_393_28 then
					arg_390_1.talkMaxDuration = var_393_28
					var_393_22 = var_393_22 + 0.3

					if var_393_28 + var_393_22 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_28 + var_393_22
					end
				end

				arg_390_1.text_.text = var_393_26
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281096", "story_v_out_322281.awb") ~= 0 then
					local var_393_29 = manager.audio:GetVoiceLength("story_v_out_322281", "322281096", "story_v_out_322281.awb") / 1000

					if var_393_29 + var_393_22 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_29 + var_393_22
					end

					if var_393_25.prefab_name ~= "" and arg_390_1.actors_[var_393_25.prefab_name] ~= nil then
						local var_393_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_25.prefab_name].transform, "story_v_out_322281", "322281096", "story_v_out_322281.awb")

						arg_390_1:RecordAudio("322281096", var_393_30)
						arg_390_1:RecordAudio("322281096", var_393_30)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_322281", "322281096", "story_v_out_322281.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_322281", "322281096", "story_v_out_322281.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_31 = var_393_22 + 0.3
			local var_393_32 = math.max(var_393_23, arg_390_1.talkMaxDuration)

			if var_393_22 + 0.3 <= arg_390_1.time_ and arg_390_1.time_ < var_393_31 + var_393_32 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_31) / var_393_32

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_31 + var_393_32 and arg_390_1.time_ < var_393_31 + var_393_32 + arg_393_0 then
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
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos10102ui_story = arg_396_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_399_0 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 then
				arg_396_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_0)
				arg_396_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10102ui_story"].transform.position).z)
				arg_396_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["10102ui_story"].transform.localEulerAngles = arg_396_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 then
				arg_396_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_396_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10102ui_story"].transform.position).z)
				arg_396_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["10102ui_story"].transform.localEulerAngles = arg_396_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_399_1 = 0
			local var_399_2 = 0.5

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

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

				local var_399_3 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(322281097).content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 20 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 20)

				if (20 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 20)) > 0 and var_399_2 < var_399_5 then
					arg_396_1.talkMaxDuration = var_399_5

					if var_399_5 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_6 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_6 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_6

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_6 and arg_396_1.time_ < var_399_1 + var_399_6 + arg_399_0 then
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
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos10102ui_story = arg_400_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_403_0 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 then
				arg_400_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_400_1.time_ - 0) / var_403_0)
				arg_400_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["10102ui_story"].transform.position).z)
				arg_400_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["10102ui_story"].transform.localEulerAngles = arg_400_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 then
				arg_400_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["10102ui_story"].transform.position).z)
				arg_400_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["10102ui_story"].transform.localEulerAngles = arg_400_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_403_1 = arg_400_1.actors_["1044ui_story"].transform

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos1044ui_story = var_403_1.localPosition

				arg_400_1:ShowWeapon(arg_400_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_403_2 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_2 then
				var_403_1.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_400_1.time_ - 0) / var_403_2)
				var_403_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_1.position).x, (manager.ui.mainCamera.transform.position - var_403_1.position).y, (manager.ui.mainCamera.transform.position - var_403_1.position).z)
				var_403_1.localEulerAngles.z = 0
				var_403_1.localEulerAngles.x = 0
				var_403_1.localEulerAngles = var_403_1.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_2 and arg_400_1.time_ < 0 + var_403_2 + arg_403_0 then
				var_403_1.localPosition = Vector3.New(0, -1, -5.93)
				var_403_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_1.position).x, (manager.ui.mainCamera.transform.position - var_403_1.position).y, (manager.ui.mainCamera.transform.position - var_403_1.position).z)
				var_403_1.localEulerAngles.z = 0
				var_403_1.localEulerAngles.x = 0
				var_403_1.localEulerAngles = var_403_1.localEulerAngles
			end

			local var_403_3 = arg_400_1.actors_["1044ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_3) and arg_400_1.var_.characterEffect1044ui_story == nil then
				arg_400_1.var_.characterEffect1044ui_story = var_403_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_4 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 and not isNil(var_403_3) then
				if arg_400_1.var_.characterEffect1044ui_story and not isNil(var_403_3) then
					arg_400_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 and not isNil(var_403_3) and arg_400_1.var_.characterEffect1044ui_story then
				arg_400_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_403_6 = 0
			local var_403_7 = 0.575

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_6 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_8 = arg_400_1:GetWordFromCfg(322281098)
				local var_403_9 = arg_400_1:FormatText(var_403_8.content)

				arg_400_1.text_.text = var_403_9

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_11 = 22 <= 0 and var_403_7 or var_403_7 * (utf8.len(var_403_9) / 22)

				if (22 <= 0 and var_403_7 or var_403_7 * (utf8.len(var_403_9) / 22)) > 0 and var_403_7 < var_403_11 then
					arg_400_1.talkMaxDuration = var_403_11

					if var_403_11 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_6
					end
				end

				arg_400_1.text_.text = var_403_9
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281098", "story_v_out_322281.awb") ~= 0 then
					local var_403_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281098", "story_v_out_322281.awb") / 1000

					if var_403_12 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_12 + var_403_6
					end

					if var_403_8.prefab_name ~= "" and arg_400_1.actors_[var_403_8.prefab_name] ~= nil then
						local var_403_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_8.prefab_name].transform, "story_v_out_322281", "322281098", "story_v_out_322281.awb")

						arg_400_1:RecordAudio("322281098", var_403_13)
						arg_400_1:RecordAudio("322281098", var_403_13)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_322281", "322281098", "story_v_out_322281.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_322281", "322281098", "story_v_out_322281.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_14 = math.max(var_403_7, arg_400_1.talkMaxDuration)

			if var_403_6 <= arg_400_1.time_ and arg_400_1.time_ < var_403_6 + var_403_14 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_6) / var_403_14

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_6 + var_403_14 and arg_400_1.time_ < var_403_6 + var_403_14 + arg_403_0 then
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
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1044ui_story = arg_404_1.actors_["1044ui_story"].transform.localPosition

				arg_404_1:ShowWeapon(arg_404_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1044ui_story"].transform.position).z)
				arg_404_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1044ui_story"].transform.localEulerAngles = arg_404_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_404_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1044ui_story"].transform.position).z)
				arg_404_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1044ui_story"].transform.localEulerAngles = arg_404_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_407_1 = 0
			local var_407_2 = 1.15

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[7].name)

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

				local var_407_3 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(322281099).content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 46 <= 0 and var_407_2 or var_407_2 * (utf8.len(var_407_3) / 46)

				if (46 <= 0 and var_407_2 or var_407_2 * (utf8.len(var_407_3) / 46)) > 0 and var_407_2 < var_407_5 then
					arg_404_1.talkMaxDuration = var_407_5

					if var_407_5 + var_407_1 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + var_407_1
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_6 = math.max(var_407_2, arg_404_1.talkMaxDuration)

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_6 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_1) / var_407_6

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_1 + var_407_6 and arg_404_1.time_ < var_407_1 + var_407_6 + arg_407_0 then
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
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos1020ui_story = arg_408_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_411_0 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 then
				arg_408_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_408_1.time_ - 0) / var_411_0)
				arg_408_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1020ui_story"].transform.position).z)
				arg_408_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1020ui_story"].transform.localEulerAngles = arg_408_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 then
				arg_408_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_408_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1020ui_story"].transform.position).z)
				arg_408_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1020ui_story"].transform.localEulerAngles = arg_408_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_411_1 = arg_408_1.actors_["1020ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1020ui_story == nil then
				arg_408_1.var_.characterEffect1020ui_story = var_411_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_2 and not isNil(var_411_1) then
				if arg_408_1.var_.characterEffect1020ui_story and not isNil(var_411_1) then
					arg_408_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= 0 + var_411_2 and arg_408_1.time_ < 0 + var_411_2 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1020ui_story then
				arg_408_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_411_4 = 0
			local var_411_5 = 0.45

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_6 = arg_408_1:GetWordFromCfg(322281100)
				local var_411_7 = arg_408_1:FormatText(var_411_6.content)

				arg_408_1.text_.text = var_411_7

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_9 = 18 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 18)

				if (18 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 18)) > 0 and var_411_5 < var_411_9 then
					arg_408_1.talkMaxDuration = var_411_9

					if var_411_9 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_9 + var_411_4
					end
				end

				arg_408_1.text_.text = var_411_7
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281100", "story_v_out_322281.awb") ~= 0 then
					local var_411_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281100", "story_v_out_322281.awb") / 1000

					if var_411_10 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_4
					end

					if var_411_6.prefab_name ~= "" and arg_408_1.actors_[var_411_6.prefab_name] ~= nil then
						local var_411_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_6.prefab_name].transform, "story_v_out_322281", "322281100", "story_v_out_322281.awb")

						arg_408_1:RecordAudio("322281100", var_411_11)
						arg_408_1:RecordAudio("322281100", var_411_11)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_322281", "322281100", "story_v_out_322281.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_322281", "322281100", "story_v_out_322281.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_12 = math.max(var_411_5, arg_408_1.talkMaxDuration)

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_12 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_4) / var_411_12

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_4 + var_411_12 and arg_408_1.time_ < var_411_4 + var_411_12 + arg_411_0 then
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
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1020ui_story = arg_412_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).z)
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles = arg_412_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_412_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).z)
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles = arg_412_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if 0.963863093405962 < arg_412_1.time_ and arg_412_1.time_ <= 0.963863093405962 + arg_415_0 then
				arg_412_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_cardoor02", "")
			end

			local var_415_2 = 0
			local var_415_3 = 1.4

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_2 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_4 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(322281101).content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_6 = 56 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_4) / 56)

				if (56 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_4) / 56)) > 0 and var_415_3 < var_415_6 then
					arg_412_1.talkMaxDuration = var_415_6

					if var_415_6 + var_415_2 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_6 + var_415_2
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_3, arg_412_1.talkMaxDuration)

			if var_415_2 <= arg_412_1.time_ and arg_412_1.time_ < var_415_2 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_2) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_2 + var_415_7 and arg_412_1.time_ < var_415_2 + var_415_7 + arg_415_0 then
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
			local var_419_0 = 0.325

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[7].name)

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

				local var_419_1 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(322281102).content)

				arg_416_1.text_.text = var_419_1

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_3 = 13 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 13)

				if (13 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 13)) > 0 and var_419_0 < var_419_3 then
					arg_416_1.talkMaxDuration = var_419_3

					if var_419_3 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_3 + 0
					end
				end

				arg_416_1.text_.text = var_419_1
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_4 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_4

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
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
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1089ui_story = arg_420_1.actors_["1089ui_story"].transform.localPosition

				arg_420_1:ShowWeapon(arg_420_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_423_0 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				arg_420_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1089ui_story"].transform.position).z)
				arg_420_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1089ui_story"].transform.localEulerAngles = arg_420_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				arg_420_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_420_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1089ui_story"].transform.position).z)
				arg_420_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1089ui_story"].transform.localEulerAngles = arg_420_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_423_1 = arg_420_1.actors_["1089ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect1089ui_story == nil then
				arg_420_1.var_.characterEffect1089ui_story = var_423_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 and not isNil(var_423_1) then
				if arg_420_1.var_.characterEffect1089ui_story and not isNil(var_423_1) then
					arg_420_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect1089ui_story then
				arg_420_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_423_4 = 0
			local var_423_5 = 0.7

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_6 = arg_420_1:GetWordFromCfg(322281103)
				local var_423_7 = arg_420_1:FormatText(var_423_6.content)

				arg_420_1.text_.text = var_423_7

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_9 = 28 <= 0 and var_423_5 or var_423_5 * (utf8.len(var_423_7) / 28)

				if (28 <= 0 and var_423_5 or var_423_5 * (utf8.len(var_423_7) / 28)) > 0 and var_423_5 < var_423_9 then
					arg_420_1.talkMaxDuration = var_423_9

					if var_423_9 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_9 + var_423_4
					end
				end

				arg_420_1.text_.text = var_423_7
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281103", "story_v_out_322281.awb") ~= 0 then
					local var_423_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281103", "story_v_out_322281.awb") / 1000

					if var_423_10 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_10 + var_423_4
					end

					if var_423_6.prefab_name ~= "" and arg_420_1.actors_[var_423_6.prefab_name] ~= nil then
						local var_423_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_6.prefab_name].transform, "story_v_out_322281", "322281103", "story_v_out_322281.awb")

						arg_420_1:RecordAudio("322281103", var_423_11)
						arg_420_1:RecordAudio("322281103", var_423_11)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_322281", "322281103", "story_v_out_322281.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_322281", "322281103", "story_v_out_322281.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_12 = math.max(var_423_5, arg_420_1.talkMaxDuration)

			if var_423_4 <= arg_420_1.time_ and arg_420_1.time_ < var_423_4 + var_423_12 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_4) / var_423_12

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_4 + var_423_12 and arg_420_1.time_ < var_423_4 + var_423_12 + arg_423_0 then
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
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1089ui_story = arg_424_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1089ui_story"].transform.position).z)
				arg_424_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1089ui_story"].transform.localEulerAngles = arg_424_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_424_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1089ui_story"].transform.position).z)
				arg_424_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1089ui_story"].transform.localEulerAngles = arg_424_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["1044ui_story"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1044ui_story = var_427_1.localPosition

				arg_424_1:ShowWeapon(arg_424_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_427_2 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 then
				var_427_1.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_424_1.time_ - 0) / var_427_2)
				var_427_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_1.position).x, (manager.ui.mainCamera.transform.position - var_427_1.position).y, (manager.ui.mainCamera.transform.position - var_427_1.position).z)
				var_427_1.localEulerAngles.z = 0
				var_427_1.localEulerAngles.x = 0
				var_427_1.localEulerAngles = var_427_1.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 then
				var_427_1.localPosition = Vector3.New(0.7, -1, -5.93)
				var_427_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_1.position).x, (manager.ui.mainCamera.transform.position - var_427_1.position).y, (manager.ui.mainCamera.transform.position - var_427_1.position).z)
				var_427_1.localEulerAngles.z = 0
				var_427_1.localEulerAngles.x = 0
				var_427_1.localEulerAngles = var_427_1.localEulerAngles
			end

			local var_427_3 = arg_424_1.actors_["1044ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_3) and arg_424_1.var_.characterEffect1044ui_story == nil then
				arg_424_1.var_.characterEffect1044ui_story = var_427_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_4 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 and not isNil(var_427_3) then
				if arg_424_1.var_.characterEffect1044ui_story and not isNil(var_427_3) then
					arg_424_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 and not isNil(var_427_3) and arg_424_1.var_.characterEffect1044ui_story then
				arg_424_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_427_6 = arg_424_1.actors_["1089ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_6) and arg_424_1.var_.characterEffect1089ui_story == nil then
				arg_424_1.var_.characterEffect1089ui_story = var_427_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_7 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 and not isNil(var_427_6) then
				if arg_424_1.var_.characterEffect1089ui_story and not isNil(var_427_6) then
					arg_424_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_7)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 and not isNil(var_427_6) and arg_424_1.var_.characterEffect1089ui_story then
				arg_424_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_427_8 = 0
			local var_427_9 = 0.3

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_10 = arg_424_1:GetWordFromCfg(322281104)
				local var_427_11 = arg_424_1:FormatText(var_427_10.content)

				arg_424_1.text_.text = var_427_11

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_13 = 12 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 12)

				if (12 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 12)) > 0 and var_427_9 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_11
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281104", "story_v_out_322281.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281104", "story_v_out_322281.awb") / 1000

					if var_427_14 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_8
					end

					if var_427_10.prefab_name ~= "" and arg_424_1.actors_[var_427_10.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_10.prefab_name].transform, "story_v_out_322281", "322281104", "story_v_out_322281.awb")

						arg_424_1:RecordAudio("322281104", var_427_15)
						arg_424_1:RecordAudio("322281104", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_322281", "322281104", "story_v_out_322281.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_322281", "322281104", "story_v_out_322281.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_9, arg_424_1.talkMaxDuration)

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_8) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_8 + var_427_16 and arg_424_1.time_ < var_427_8 + var_427_16 + arg_427_0 then
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
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1089ui_story = arg_428_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_431_0 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 then
				arg_428_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_428_1.time_ - 0) / var_431_0)
				arg_428_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1089ui_story"].transform.position).z)
				arg_428_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1089ui_story"].transform.localEulerAngles = arg_428_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 then
				arg_428_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_428_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1089ui_story"].transform.position).z)
				arg_428_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1089ui_story"].transform.localEulerAngles = arg_428_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if 0.533333333333333 < arg_428_1.time_ and arg_428_1.time_ <= 0.533333333333333 + arg_431_0 then
				arg_428_1:AudioAction("play", "effect", "se_story_140", "se_story_140_safety belt", "")
			end

			local var_431_2 = arg_428_1.actors_["1044ui_story"].transform

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1044ui_story = var_431_2.localPosition

				arg_428_1:ShowWeapon(arg_428_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_431_3 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_3 then
				var_431_2.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_428_1.time_ - 0) / var_431_3)
				var_431_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_431_2.position).x, (manager.ui.mainCamera.transform.position - var_431_2.position).y, (manager.ui.mainCamera.transform.position - var_431_2.position).z)
				var_431_2.localEulerAngles.z = 0
				var_431_2.localEulerAngles.x = 0
				var_431_2.localEulerAngles = var_431_2.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_3 and arg_428_1.time_ < 0 + var_431_3 + arg_431_0 then
				var_431_2.localPosition = Vector3.New(0, 100, 0)
				var_431_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_431_2.position).x, (manager.ui.mainCamera.transform.position - var_431_2.position).y, (manager.ui.mainCamera.transform.position - var_431_2.position).z)
				var_431_2.localEulerAngles.z = 0
				var_431_2.localEulerAngles.x = 0
				var_431_2.localEulerAngles = var_431_2.localEulerAngles
			end

			local var_431_4 = 0
			local var_431_5 = 1.15

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_6 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(322281105).content)

				arg_428_1.text_.text = var_431_6

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_8 = 46 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_6) / 46)

				if (46 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_6) / 46)) > 0 and var_431_5 < var_431_8 then
					arg_428_1.talkMaxDuration = var_431_8

					if var_431_8 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_4
					end
				end

				arg_428_1.text_.text = var_431_6
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_9 = math.max(var_431_5, arg_428_1.talkMaxDuration)

			if var_431_4 <= arg_428_1.time_ and arg_428_1.time_ < var_431_4 + var_431_9 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_4) / var_431_9

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_4 + var_431_9 and arg_428_1.time_ < var_431_4 + var_431_9 + arg_431_0 then
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
			local var_435_0 = 0.9

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_1 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(322281106).content)

				arg_432_1.text_.text = var_435_1

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_3 = 36 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 36)

				if (36 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 36)) > 0 and var_435_0 < var_435_3 then
					arg_432_1.talkMaxDuration = var_435_3

					if var_435_3 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_3 + 0
					end
				end

				arg_432_1.text_.text = var_435_1
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_4 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_4

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
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
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos1020ui_story = arg_436_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_439_0 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 then
				arg_436_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_436_1.time_ - 0) / var_439_0)
				arg_436_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1020ui_story"].transform.position).z)
				arg_436_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1020ui_story"].transform.localEulerAngles = arg_436_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 then
				arg_436_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_436_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1020ui_story"].transform.position).z)
				arg_436_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1020ui_story"].transform.localEulerAngles = arg_436_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_439_1 = arg_436_1.actors_["1020ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1020ui_story == nil then
				arg_436_1.var_.characterEffect1020ui_story = var_439_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_2 and not isNil(var_439_1) then
				if arg_436_1.var_.characterEffect1020ui_story and not isNil(var_439_1) then
					arg_436_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_2 and arg_436_1.time_ < 0 + var_439_2 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1020ui_story then
				arg_436_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_439_4 = 0
			local var_439_5 = 0.3

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_6 = arg_436_1:GetWordFromCfg(322281107)
				local var_439_7 = arg_436_1:FormatText(var_439_6.content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 12 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 12)

				if (12 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 12)) > 0 and var_439_5 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281107", "story_v_out_322281.awb") ~= 0 then
					local var_439_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281107", "story_v_out_322281.awb") / 1000

					if var_439_10 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_4
					end

					if var_439_6.prefab_name ~= "" and arg_436_1.actors_[var_439_6.prefab_name] ~= nil then
						local var_439_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_6.prefab_name].transform, "story_v_out_322281", "322281107", "story_v_out_322281.awb")

						arg_436_1:RecordAudio("322281107", var_439_11)
						arg_436_1:RecordAudio("322281107", var_439_11)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_322281", "322281107", "story_v_out_322281.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_322281", "322281107", "story_v_out_322281.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_12 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_12 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_12

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_12 and arg_436_1.time_ < var_439_4 + var_439_12 + arg_439_0 then
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
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1020ui_story = arg_440_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1020ui_story, Vector3.New(-0.7, -0.85, -6.25), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).z)
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles = arg_440_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(-0.7, -0.85, -6.25)
				arg_440_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).z)
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles = arg_440_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_443_1 = arg_440_1.actors_["1020ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1020ui_story == nil then
				arg_440_1.var_.characterEffect1020ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect1020ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_2)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1020ui_story then
				arg_440_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_443_3 = arg_440_1.actors_["1044ui_story"].transform

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1044ui_story = var_443_3.localPosition

				arg_440_1:ShowWeapon(arg_440_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_443_4 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 then
				var_443_3.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_440_1.time_ - 0) / var_443_4)
				var_443_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_443_3.position).x, (manager.ui.mainCamera.transform.position - var_443_3.position).y, (manager.ui.mainCamera.transform.position - var_443_3.position).z)
				var_443_3.localEulerAngles.z = 0
				var_443_3.localEulerAngles.x = 0
				var_443_3.localEulerAngles = var_443_3.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 then
				var_443_3.localPosition = Vector3.New(0.7, -1, -5.93)
				var_443_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_443_3.position).x, (manager.ui.mainCamera.transform.position - var_443_3.position).y, (manager.ui.mainCamera.transform.position - var_443_3.position).z)
				var_443_3.localEulerAngles.z = 0
				var_443_3.localEulerAngles.x = 0
				var_443_3.localEulerAngles = var_443_3.localEulerAngles
			end

			local var_443_5 = arg_440_1.actors_["1044ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.characterEffect1044ui_story == nil then
				arg_440_1.var_.characterEffect1044ui_story = var_443_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_6 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_6 and not isNil(var_443_5) then
				if arg_440_1.var_.characterEffect1044ui_story and not isNil(var_443_5) then
					arg_440_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_6 and arg_440_1.time_ < 0 + var_443_6 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.characterEffect1044ui_story then
				arg_440_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_1")
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_443_8 = 0
			local var_443_9 = 0.325

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_8 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_10 = arg_440_1:GetWordFromCfg(322281108)
				local var_443_11 = arg_440_1:FormatText(var_443_10.content)

				arg_440_1.text_.text = var_443_11

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_13 = 13 <= 0 and var_443_9 or var_443_9 * (utf8.len(var_443_11) / 13)

				if (13 <= 0 and var_443_9 or var_443_9 * (utf8.len(var_443_11) / 13)) > 0 and var_443_9 < var_443_13 then
					arg_440_1.talkMaxDuration = var_443_13

					if var_443_13 + var_443_8 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_13 + var_443_8
					end
				end

				arg_440_1.text_.text = var_443_11
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281108", "story_v_out_322281.awb") ~= 0 then
					local var_443_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281108", "story_v_out_322281.awb") / 1000

					if var_443_14 + var_443_8 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_14 + var_443_8
					end

					if var_443_10.prefab_name ~= "" and arg_440_1.actors_[var_443_10.prefab_name] ~= nil then
						local var_443_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_10.prefab_name].transform, "story_v_out_322281", "322281108", "story_v_out_322281.awb")

						arg_440_1:RecordAudio("322281108", var_443_15)
						arg_440_1:RecordAudio("322281108", var_443_15)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_322281", "322281108", "story_v_out_322281.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_322281", "322281108", "story_v_out_322281.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_16 = math.max(var_443_9, arg_440_1.talkMaxDuration)

			if var_443_8 <= arg_440_1.time_ and arg_440_1.time_ < var_443_8 + var_443_16 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_8) / var_443_16

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_8 + var_443_16 and arg_440_1.time_ < var_443_8 + var_443_16 + arg_443_0 then
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
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["1020ui_story"]) and arg_444_1.var_.characterEffect1020ui_story == nil then
				arg_444_1.var_.characterEffect1020ui_story = arg_444_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["1020ui_story"]) then
				if arg_444_1.var_.characterEffect1020ui_story and not isNil(arg_444_1.actors_["1020ui_story"]) then
					arg_444_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["1020ui_story"]) and arg_444_1.var_.characterEffect1020ui_story then
				arg_444_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_447_2 = arg_444_1.actors_["1044ui_story"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.characterEffect1044ui_story == nil then
				arg_444_1.var_.characterEffect1044ui_story = var_447_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_3 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_3 and not isNil(var_447_2) then
				if arg_444_1.var_.characterEffect1044ui_story and not isNil(var_447_2) then
					arg_444_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_3)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_3 and arg_444_1.time_ < 0 + var_447_3 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.characterEffect1044ui_story then
				arg_444_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_447_4 = 0
			local var_447_5 = 0.075

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_4 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_6 = arg_444_1:GetWordFromCfg(322281109)
				local var_447_7 = arg_444_1:FormatText(var_447_6.content)

				arg_444_1.text_.text = var_447_7

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_9 = 3 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 3)

				if (3 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 3)) > 0 and var_447_5 < var_447_9 then
					arg_444_1.talkMaxDuration = var_447_9

					if var_447_9 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_9 + var_447_4
					end
				end

				arg_444_1.text_.text = var_447_7
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281109", "story_v_out_322281.awb") ~= 0 then
					local var_447_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281109", "story_v_out_322281.awb") / 1000

					if var_447_10 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_10 + var_447_4
					end

					if var_447_6.prefab_name ~= "" and arg_444_1.actors_[var_447_6.prefab_name] ~= nil then
						local var_447_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_6.prefab_name].transform, "story_v_out_322281", "322281109", "story_v_out_322281.awb")

						arg_444_1:RecordAudio("322281109", var_447_11)
						arg_444_1:RecordAudio("322281109", var_447_11)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_322281", "322281109", "story_v_out_322281.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_322281", "322281109", "story_v_out_322281.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_12 = math.max(var_447_5, arg_444_1.talkMaxDuration)

			if var_447_4 <= arg_444_1.time_ and arg_444_1.time_ < var_447_4 + var_447_12 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_4) / var_447_12

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_4 + var_447_12 and arg_444_1.time_ < var_447_4 + var_447_12 + arg_447_0 then
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
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["1020ui_story"]) and arg_448_1.var_.characterEffect1020ui_story == nil then
				arg_448_1.var_.characterEffect1020ui_story = arg_448_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["1020ui_story"]) then
				if arg_448_1.var_.characterEffect1020ui_story and not isNil(arg_448_1.actors_["1020ui_story"]) then
					arg_448_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_0)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["1020ui_story"]) and arg_448_1.var_.characterEffect1020ui_story then
				arg_448_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_451_1 = arg_448_1.actors_["1044ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1044ui_story == nil then
				arg_448_1.var_.characterEffect1044ui_story = var_451_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_2 and not isNil(var_451_1) then
				if arg_448_1.var_.characterEffect1044ui_story and not isNil(var_451_1) then
					arg_448_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_2 and arg_448_1.time_ < 0 + var_451_2 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1044ui_story then
				arg_448_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_2")
			end

			local var_451_4 = 0
			local var_451_5 = 0.15

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_6 = arg_448_1:GetWordFromCfg(322281110)
				local var_451_7 = arg_448_1:FormatText(var_451_6.content)

				arg_448_1.text_.text = var_451_7

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_9 = 6 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 6)

				if (6 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 6)) > 0 and var_451_5 < var_451_9 then
					arg_448_1.talkMaxDuration = var_451_9

					if var_451_9 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_9 + var_451_4
					end
				end

				arg_448_1.text_.text = var_451_7
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281110", "story_v_out_322281.awb") ~= 0 then
					local var_451_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281110", "story_v_out_322281.awb") / 1000

					if var_451_10 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_4
					end

					if var_451_6.prefab_name ~= "" and arg_448_1.actors_[var_451_6.prefab_name] ~= nil then
						local var_451_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_6.prefab_name].transform, "story_v_out_322281", "322281110", "story_v_out_322281.awb")

						arg_448_1:RecordAudio("322281110", var_451_11)
						arg_448_1:RecordAudio("322281110", var_451_11)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_322281", "322281110", "story_v_out_322281.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_322281", "322281110", "story_v_out_322281.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_12 = math.max(var_451_5, arg_448_1.talkMaxDuration)

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_12 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_4) / var_451_12

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_4 + var_451_12 and arg_448_1.time_ < var_451_4 + var_451_12 + arg_451_0 then
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
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1020ui_story = arg_452_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_455_0 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 then
				arg_452_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_452_1.time_ - 0) / var_455_0)
				arg_452_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).z)
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles = arg_452_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 then
				arg_452_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_452_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).z)
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles = arg_452_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_455_1 = arg_452_1.actors_["1044ui_story"].transform

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1044ui_story = var_455_1.localPosition

				arg_452_1:ShowWeapon(arg_452_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_455_2 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_2 then
				var_455_1.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_452_1.time_ - 0) / var_455_2)
				var_455_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_1.position).x, (manager.ui.mainCamera.transform.position - var_455_1.position).y, (manager.ui.mainCamera.transform.position - var_455_1.position).z)
				var_455_1.localEulerAngles.z = 0
				var_455_1.localEulerAngles.x = 0
				var_455_1.localEulerAngles = var_455_1.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_2 and arg_452_1.time_ < 0 + var_455_2 + arg_455_0 then
				var_455_1.localPosition = Vector3.New(0, 100, 0)
				var_455_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_1.position).x, (manager.ui.mainCamera.transform.position - var_455_1.position).y, (manager.ui.mainCamera.transform.position - var_455_1.position).z)
				var_455_1.localEulerAngles.z = 0
				var_455_1.localEulerAngles.x = 0
				var_455_1.localEulerAngles = var_455_1.localEulerAngles
			end

			local var_455_3 = 0
			local var_455_4 = 1.725

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_3 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_5 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(322281111).content)

				arg_452_1.text_.text = var_455_5

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_7 = 69 <= 0 and var_455_4 or var_455_4 * (utf8.len(var_455_5) / 69)

				if (69 <= 0 and var_455_4 or var_455_4 * (utf8.len(var_455_5) / 69)) > 0 and var_455_4 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_3 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_3
					end
				end

				arg_452_1.text_.text = var_455_5
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_4, arg_452_1.talkMaxDuration)

			if var_455_3 <= arg_452_1.time_ and arg_452_1.time_ < var_455_3 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_3) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_3 + var_455_8 and arg_452_1.time_ < var_455_3 + var_455_8 + arg_455_0 then
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
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1044ui_story = arg_456_1.actors_["1044ui_story"].transform.localPosition

				arg_456_1:ShowWeapon(arg_456_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_459_0 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 then
				arg_456_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_456_1.time_ - 0) / var_459_0)
				arg_456_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1044ui_story"].transform.position).z)
				arg_456_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1044ui_story"].transform.localEulerAngles = arg_456_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 then
				arg_456_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_456_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1044ui_story"].transform.position).z)
				arg_456_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1044ui_story"].transform.localEulerAngles = arg_456_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_459_1 = arg_456_1.actors_["1044ui_story"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_1) and arg_456_1.var_.characterEffect1044ui_story == nil then
				arg_456_1.var_.characterEffect1044ui_story = var_459_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_2 and not isNil(var_459_1) then
				if arg_456_1.var_.characterEffect1044ui_story and not isNil(var_459_1) then
					arg_456_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= 0 + var_459_2 and arg_456_1.time_ < 0 + var_459_2 + arg_459_0 and not isNil(var_459_1) and arg_456_1.var_.characterEffect1044ui_story then
				arg_456_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_459_4 = 0
			local var_459_5 = 0.125

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_4 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_6 = arg_456_1:GetWordFromCfg(322281112)
				local var_459_7 = arg_456_1:FormatText(var_459_6.content)

				arg_456_1.text_.text = var_459_7

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_9 = 5 <= 0 and var_459_5 or var_459_5 * (utf8.len(var_459_7) / 5)

				if (5 <= 0 and var_459_5 or var_459_5 * (utf8.len(var_459_7) / 5)) > 0 and var_459_5 < var_459_9 then
					arg_456_1.talkMaxDuration = var_459_9

					if var_459_9 + var_459_4 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_9 + var_459_4
					end
				end

				arg_456_1.text_.text = var_459_7
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281112", "story_v_out_322281.awb") ~= 0 then
					local var_459_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281112", "story_v_out_322281.awb") / 1000

					if var_459_10 + var_459_4 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_10 + var_459_4
					end

					if var_459_6.prefab_name ~= "" and arg_456_1.actors_[var_459_6.prefab_name] ~= nil then
						local var_459_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_6.prefab_name].transform, "story_v_out_322281", "322281112", "story_v_out_322281.awb")

						arg_456_1:RecordAudio("322281112", var_459_11)
						arg_456_1:RecordAudio("322281112", var_459_11)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_322281", "322281112", "story_v_out_322281.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_322281", "322281112", "story_v_out_322281.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_12 = math.max(var_459_5, arg_456_1.talkMaxDuration)

			if var_459_4 <= arg_456_1.time_ and arg_456_1.time_ < var_459_4 + var_459_12 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_4) / var_459_12

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_4 + var_459_12 and arg_456_1.time_ < var_459_4 + var_459_12 + arg_459_0 then
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
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1020ui_story = arg_460_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_463_0 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 then
				arg_460_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_460_1.time_ - 0) / var_463_0)
				arg_460_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1020ui_story"].transform.position).z)
				arg_460_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1020ui_story"].transform.localEulerAngles = arg_460_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 then
				arg_460_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0.7, -0.85, -6.25)
				arg_460_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1020ui_story"].transform.position).z)
				arg_460_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1020ui_story"].transform.localEulerAngles = arg_460_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_463_1 = arg_460_1.actors_["1020ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1020ui_story == nil then
				arg_460_1.var_.characterEffect1020ui_story = var_463_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_2 and not isNil(var_463_1) then
				if arg_460_1.var_.characterEffect1020ui_story and not isNil(var_463_1) then
					arg_460_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_2 and arg_460_1.time_ < 0 + var_463_2 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1020ui_story then
				arg_460_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_463_4 = arg_460_1.actors_["1044ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_4) and arg_460_1.var_.characterEffect1044ui_story == nil then
				arg_460_1.var_.characterEffect1044ui_story = var_463_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_5 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_5 and not isNil(var_463_4) then
				if arg_460_1.var_.characterEffect1044ui_story and not isNil(var_463_4) then
					arg_460_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_460_1.time_ - 0) / var_463_5)
				end
			end

			if arg_460_1.time_ >= 0 + var_463_5 and arg_460_1.time_ < 0 + var_463_5 + arg_463_0 and not isNil(var_463_4) and arg_460_1.var_.characterEffect1044ui_story then
				arg_460_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_463_6 = arg_460_1.actors_["1044ui_story"].transform

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1044ui_story = var_463_6.localPosition

				arg_460_1:ShowWeapon(arg_460_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_463_7 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_7 then
				var_463_6.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_460_1.time_ - 0) / var_463_7)
				var_463_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_463_6.position).x, (manager.ui.mainCamera.transform.position - var_463_6.position).y, (manager.ui.mainCamera.transform.position - var_463_6.position).z)
				var_463_6.localEulerAngles.z = 0
				var_463_6.localEulerAngles.x = 0
				var_463_6.localEulerAngles = var_463_6.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_7 and arg_460_1.time_ < 0 + var_463_7 + arg_463_0 then
				var_463_6.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_463_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_463_6.position).x, (manager.ui.mainCamera.transform.position - var_463_6.position).y, (manager.ui.mainCamera.transform.position - var_463_6.position).z)
				var_463_6.localEulerAngles.z = 0
				var_463_6.localEulerAngles.x = 0
				var_463_6.localEulerAngles = var_463_6.localEulerAngles
			end

			local var_463_8 = 0
			local var_463_9 = 0.275

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_8 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_10 = arg_460_1:GetWordFromCfg(322281113)
				local var_463_11 = arg_460_1:FormatText(var_463_10.content)

				arg_460_1.text_.text = var_463_11

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_13 = 11 <= 0 and var_463_9 or var_463_9 * (utf8.len(var_463_11) / 11)

				if (11 <= 0 and var_463_9 or var_463_9 * (utf8.len(var_463_11) / 11)) > 0 and var_463_9 < var_463_13 then
					arg_460_1.talkMaxDuration = var_463_13

					if var_463_13 + var_463_8 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_13 + var_463_8
					end
				end

				arg_460_1.text_.text = var_463_11
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281113", "story_v_out_322281.awb") ~= 0 then
					local var_463_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281113", "story_v_out_322281.awb") / 1000

					if var_463_14 + var_463_8 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_14 + var_463_8
					end

					if var_463_10.prefab_name ~= "" and arg_460_1.actors_[var_463_10.prefab_name] ~= nil then
						local var_463_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_10.prefab_name].transform, "story_v_out_322281", "322281113", "story_v_out_322281.awb")

						arg_460_1:RecordAudio("322281113", var_463_15)
						arg_460_1:RecordAudio("322281113", var_463_15)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_322281", "322281113", "story_v_out_322281.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_322281", "322281113", "story_v_out_322281.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_16 = math.max(var_463_9, arg_460_1.talkMaxDuration)

			if var_463_8 <= arg_460_1.time_ and arg_460_1.time_ < var_463_8 + var_463_16 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_8) / var_463_16

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_8 + var_463_16 and arg_460_1.time_ < var_463_8 + var_463_16 + arg_463_0 then
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
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1020ui_story = arg_464_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_467_0 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 then
				arg_464_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_464_1.time_ - 0) / var_467_0)
				arg_464_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1020ui_story"].transform.position).z)
				arg_464_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1020ui_story"].transform.localEulerAngles = arg_464_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 then
				arg_464_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0.7, -0.85, -6.25)
				arg_464_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1020ui_story"].transform.position).z)
				arg_464_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1020ui_story"].transform.localEulerAngles = arg_464_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_467_1 = arg_464_1.actors_["1044ui_story"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1044ui_story = var_467_1.localPosition

				arg_464_1:ShowWeapon(arg_464_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_467_2 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_2 then
				var_467_1.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_464_1.time_ - 0) / var_467_2)
				var_467_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_467_1.position).x, (manager.ui.mainCamera.transform.position - var_467_1.position).y, (manager.ui.mainCamera.transform.position - var_467_1.position).z)
				var_467_1.localEulerAngles.z = 0
				var_467_1.localEulerAngles.x = 0
				var_467_1.localEulerAngles = var_467_1.localEulerAngles
			end

			if arg_464_1.time_ >= 0 + var_467_2 and arg_464_1.time_ < 0 + var_467_2 + arg_467_0 then
				var_467_1.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_467_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_467_1.position).x, (manager.ui.mainCamera.transform.position - var_467_1.position).y, (manager.ui.mainCamera.transform.position - var_467_1.position).z)
				var_467_1.localEulerAngles.z = 0
				var_467_1.localEulerAngles.x = 0
				var_467_1.localEulerAngles = var_467_1.localEulerAngles
			end

			local var_467_3 = arg_464_1.actors_["1044ui_story"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_3) and arg_464_1.var_.characterEffect1044ui_story == nil then
				arg_464_1.var_.characterEffect1044ui_story = var_467_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_4 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 and not isNil(var_467_3) then
				if arg_464_1.var_.characterEffect1044ui_story and not isNil(var_467_3) then
					arg_464_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 and not isNil(var_467_3) and arg_464_1.var_.characterEffect1044ui_story then
				arg_464_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_467_6 = 0
			local var_467_7 = 0.625

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_8 = arg_464_1:GetWordFromCfg(322281114)
				local var_467_9 = arg_464_1:FormatText(var_467_8.content)

				arg_464_1.text_.text = var_467_9

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_11 = 25 <= 0 and var_467_7 or var_467_7 * (utf8.len(var_467_9) / 25)

				if (25 <= 0 and var_467_7 or var_467_7 * (utf8.len(var_467_9) / 25)) > 0 and var_467_7 < var_467_11 then
					arg_464_1.talkMaxDuration = var_467_11

					if var_467_11 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_11 + var_467_6
					end
				end

				arg_464_1.text_.text = var_467_9
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281114", "story_v_out_322281.awb") ~= 0 then
					local var_467_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281114", "story_v_out_322281.awb") / 1000

					if var_467_12 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_12 + var_467_6
					end

					if var_467_8.prefab_name ~= "" and arg_464_1.actors_[var_467_8.prefab_name] ~= nil then
						local var_467_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_8.prefab_name].transform, "story_v_out_322281", "322281114", "story_v_out_322281.awb")

						arg_464_1:RecordAudio("322281114", var_467_13)
						arg_464_1:RecordAudio("322281114", var_467_13)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_322281", "322281114", "story_v_out_322281.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_322281", "322281114", "story_v_out_322281.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_14 = math.max(var_467_7, arg_464_1.talkMaxDuration)

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_14 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_6) / var_467_14

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_6 + var_467_14 and arg_464_1.time_ < var_467_6 + var_467_14 + arg_467_0 then
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
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["1020ui_story"]) and arg_468_1.var_.characterEffect1020ui_story == nil then
				arg_468_1.var_.characterEffect1020ui_story = arg_468_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_0 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["1020ui_story"]) then
				if arg_468_1.var_.characterEffect1020ui_story and not isNil(arg_468_1.actors_["1020ui_story"]) then
					arg_468_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["1020ui_story"]) and arg_468_1.var_.characterEffect1020ui_story then
				arg_468_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_471_2 = arg_468_1.actors_["1044ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_2) and arg_468_1.var_.characterEffect1044ui_story == nil then
				arg_468_1.var_.characterEffect1044ui_story = var_471_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_3 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_3 and not isNil(var_471_2) then
				if arg_468_1.var_.characterEffect1044ui_story and not isNil(var_471_2) then
					arg_468_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_468_1.time_ - 0) / var_471_3)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_3 and arg_468_1.time_ < 0 + var_471_3 + arg_471_0 and not isNil(var_471_2) and arg_468_1.var_.characterEffect1044ui_story then
				arg_468_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_471_4 = 0
			local var_471_5 = 0.325

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_6 = arg_468_1:GetWordFromCfg(322281115)
				local var_471_7 = arg_468_1:FormatText(var_471_6.content)

				arg_468_1.text_.text = var_471_7

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_9 = 13 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 13)

				if (13 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 13)) > 0 and var_471_5 < var_471_9 then
					arg_468_1.talkMaxDuration = var_471_9

					if var_471_9 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_9 + var_471_4
					end
				end

				arg_468_1.text_.text = var_471_7
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281115", "story_v_out_322281.awb") ~= 0 then
					local var_471_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281115", "story_v_out_322281.awb") / 1000

					if var_471_10 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_10 + var_471_4
					end

					if var_471_6.prefab_name ~= "" and arg_468_1.actors_[var_471_6.prefab_name] ~= nil then
						local var_471_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_6.prefab_name].transform, "story_v_out_322281", "322281115", "story_v_out_322281.awb")

						arg_468_1:RecordAudio("322281115", var_471_11)
						arg_468_1:RecordAudio("322281115", var_471_11)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_322281", "322281115", "story_v_out_322281.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_322281", "322281115", "story_v_out_322281.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_12 = math.max(var_471_5, arg_468_1.talkMaxDuration)

			if var_471_4 <= arg_468_1.time_ and arg_468_1.time_ < var_471_4 + var_471_12 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_4) / var_471_12

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_4 + var_471_12 and arg_468_1.time_ < var_471_4 + var_471_12 + arg_471_0 then
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
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(arg_472_1.actors_["1020ui_story"]) and arg_472_1.var_.characterEffect1020ui_story == nil then
				arg_472_1.var_.characterEffect1020ui_story = arg_472_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_0 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 and not isNil(arg_472_1.actors_["1020ui_story"]) then
				if arg_472_1.var_.characterEffect1020ui_story and not isNil(arg_472_1.actors_["1020ui_story"]) then
					arg_472_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_472_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_472_1.time_ - 0) / var_475_0)
				end
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 and not isNil(arg_472_1.actors_["1020ui_story"]) and arg_472_1.var_.characterEffect1020ui_story then
				arg_472_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_472_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_475_1 = arg_472_1.actors_["1044ui_story"].transform

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos1044ui_story = var_475_1.localPosition

				arg_472_1:ShowWeapon(arg_472_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_475_2 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_2 then
				var_475_1.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_472_1.time_ - 0) / var_475_2)
				var_475_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_475_1.position).x, (manager.ui.mainCamera.transform.position - var_475_1.position).y, (manager.ui.mainCamera.transform.position - var_475_1.position).z)
				var_475_1.localEulerAngles.z = 0
				var_475_1.localEulerAngles.x = 0
				var_475_1.localEulerAngles = var_475_1.localEulerAngles
			end

			if arg_472_1.time_ >= 0 + var_475_2 and arg_472_1.time_ < 0 + var_475_2 + arg_475_0 then
				var_475_1.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_475_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_475_1.position).x, (manager.ui.mainCamera.transform.position - var_475_1.position).y, (manager.ui.mainCamera.transform.position - var_475_1.position).z)
				var_475_1.localEulerAngles.z = 0
				var_475_1.localEulerAngles.x = 0
				var_475_1.localEulerAngles = var_475_1.localEulerAngles
			end

			local var_475_3 = arg_472_1.actors_["1044ui_story"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_3) and arg_472_1.var_.characterEffect1044ui_story == nil then
				arg_472_1.var_.characterEffect1044ui_story = var_475_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_4 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_4 and not isNil(var_475_3) then
				if arg_472_1.var_.characterEffect1044ui_story and not isNil(var_475_3) then
					arg_472_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= 0 + var_475_4 and arg_472_1.time_ < 0 + var_475_4 + arg_475_0 and not isNil(var_475_3) and arg_472_1.var_.characterEffect1044ui_story then
				arg_472_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_1")
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_475_6 = 0
			local var_475_7 = 0.725

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_6 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_8 = arg_472_1:GetWordFromCfg(322281116)
				local var_475_9 = arg_472_1:FormatText(var_475_8.content)

				arg_472_1.text_.text = var_475_9

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_11 = 29 <= 0 and var_475_7 or var_475_7 * (utf8.len(var_475_9) / 29)

				if (29 <= 0 and var_475_7 or var_475_7 * (utf8.len(var_475_9) / 29)) > 0 and var_475_7 < var_475_11 then
					arg_472_1.talkMaxDuration = var_475_11

					if var_475_11 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_11 + var_475_6
					end
				end

				arg_472_1.text_.text = var_475_9
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281116", "story_v_out_322281.awb") ~= 0 then
					local var_475_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281116", "story_v_out_322281.awb") / 1000

					if var_475_12 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_12 + var_475_6
					end

					if var_475_8.prefab_name ~= "" and arg_472_1.actors_[var_475_8.prefab_name] ~= nil then
						local var_475_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_8.prefab_name].transform, "story_v_out_322281", "322281116", "story_v_out_322281.awb")

						arg_472_1:RecordAudio("322281116", var_475_13)
						arg_472_1:RecordAudio("322281116", var_475_13)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_322281", "322281116", "story_v_out_322281.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_322281", "322281116", "story_v_out_322281.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_14 = math.max(var_475_7, arg_472_1.talkMaxDuration)

			if var_475_6 <= arg_472_1.time_ and arg_472_1.time_ < var_475_6 + var_475_14 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_6) / var_475_14

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_6 + var_475_14 and arg_472_1.time_ < var_475_6 + var_475_14 + arg_475_0 then
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
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["1020ui_story"]) and arg_476_1.var_.characterEffect1020ui_story == nil then
				arg_476_1.var_.characterEffect1020ui_story = arg_476_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["1020ui_story"]) then
				if arg_476_1.var_.characterEffect1020ui_story and not isNil(arg_476_1.actors_["1020ui_story"]) then
					arg_476_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["1020ui_story"]) and arg_476_1.var_.characterEffect1020ui_story then
				arg_476_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_479_2 = arg_476_1.actors_["1044ui_story"]

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(var_479_2) and arg_476_1.var_.characterEffect1044ui_story == nil then
				arg_476_1.var_.characterEffect1044ui_story = var_479_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_3 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_3 and not isNil(var_479_2) then
				if arg_476_1.var_.characterEffect1044ui_story and not isNil(var_479_2) then
					arg_476_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_3)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_3 and arg_476_1.time_ < 0 + var_479_3 + arg_479_0 and not isNil(var_479_2) and arg_476_1.var_.characterEffect1044ui_story then
				arg_476_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_479_4 = 0
			local var_479_5 = 1

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_4 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_6 = arg_476_1:GetWordFromCfg(322281117)
				local var_479_7 = arg_476_1:FormatText(var_479_6.content)

				arg_476_1.text_.text = var_479_7

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_9 = 40 <= 0 and var_479_5 or var_479_5 * (utf8.len(var_479_7) / 40)

				if (40 <= 0 and var_479_5 or var_479_5 * (utf8.len(var_479_7) / 40)) > 0 and var_479_5 < var_479_9 then
					arg_476_1.talkMaxDuration = var_479_9

					if var_479_9 + var_479_4 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_9 + var_479_4
					end
				end

				arg_476_1.text_.text = var_479_7
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281117", "story_v_out_322281.awb") ~= 0 then
					local var_479_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281117", "story_v_out_322281.awb") / 1000

					if var_479_10 + var_479_4 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_10 + var_479_4
					end

					if var_479_6.prefab_name ~= "" and arg_476_1.actors_[var_479_6.prefab_name] ~= nil then
						local var_479_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_6.prefab_name].transform, "story_v_out_322281", "322281117", "story_v_out_322281.awb")

						arg_476_1:RecordAudio("322281117", var_479_11)
						arg_476_1:RecordAudio("322281117", var_479_11)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_322281", "322281117", "story_v_out_322281.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_322281", "322281117", "story_v_out_322281.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_12 = math.max(var_479_5, arg_476_1.talkMaxDuration)

			if var_479_4 <= arg_476_1.time_ and arg_476_1.time_ < var_479_4 + var_479_12 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_4) / var_479_12

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_4 + var_479_12 and arg_476_1.time_ < var_479_4 + var_479_12 + arg_479_0 then
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
			local var_483_0 = 1.075

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_1 = arg_480_1:GetWordFromCfg(322281118)
				local var_483_2 = arg_480_1:FormatText(var_483_1.content)

				arg_480_1.text_.text = var_483_2

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_4 = 43 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_2) / 43)

				if (43 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_2) / 43)) > 0 and var_483_0 < var_483_4 then
					arg_480_1.talkMaxDuration = var_483_4

					if var_483_4 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_4 + 0
					end
				end

				arg_480_1.text_.text = var_483_2
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281118", "story_v_out_322281.awb") ~= 0 then
					local var_483_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281118", "story_v_out_322281.awb") / 1000

					if var_483_5 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_5 + 0
					end

					if var_483_1.prefab_name ~= "" and arg_480_1.actors_[var_483_1.prefab_name] ~= nil then
						local var_483_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_1.prefab_name].transform, "story_v_out_322281", "322281118", "story_v_out_322281.awb")

						arg_480_1:RecordAudio("322281118", var_483_6)
						arg_480_1:RecordAudio("322281118", var_483_6)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_322281", "322281118", "story_v_out_322281.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_322281", "322281118", "story_v_out_322281.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_7 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_7 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_7

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_7 and arg_480_1.time_ < 0 + var_483_7 + arg_483_0 then
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
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_1")
			end

			local var_487_0 = 0
			local var_487_1 = 0.875

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_2 = arg_484_1:GetWordFromCfg(322281119)
				local var_487_3 = arg_484_1:FormatText(var_487_2.content)

				arg_484_1.text_.text = var_487_3

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 35 <= 0 and var_487_1 or var_487_1 * (utf8.len(var_487_3) / 35)

				if (35 <= 0 and var_487_1 or var_487_1 * (utf8.len(var_487_3) / 35)) > 0 and var_487_1 < var_487_5 then
					arg_484_1.talkMaxDuration = var_487_5

					if var_487_5 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_3
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281119", "story_v_out_322281.awb") ~= 0 then
					local var_487_6 = manager.audio:GetVoiceLength("story_v_out_322281", "322281119", "story_v_out_322281.awb") / 1000

					if var_487_6 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_6 + var_487_0
					end

					if var_487_2.prefab_name ~= "" and arg_484_1.actors_[var_487_2.prefab_name] ~= nil then
						local var_487_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_2.prefab_name].transform, "story_v_out_322281", "322281119", "story_v_out_322281.awb")

						arg_484_1:RecordAudio("322281119", var_487_7)
						arg_484_1:RecordAudio("322281119", var_487_7)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_322281", "322281119", "story_v_out_322281.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_322281", "322281119", "story_v_out_322281.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_8 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_8 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_8

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_8 and arg_484_1.time_ < var_487_0 + var_487_8 + arg_487_0 then
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
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["1020ui_story"]) and arg_488_1.var_.characterEffect1020ui_story == nil then
				arg_488_1.var_.characterEffect1020ui_story = arg_488_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_0 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["1020ui_story"]) then
				if arg_488_1.var_.characterEffect1020ui_story and not isNil(arg_488_1.actors_["1020ui_story"]) then
					arg_488_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_488_1.time_ - 0) / var_491_0)
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["1020ui_story"]) and arg_488_1.var_.characterEffect1020ui_story then
				arg_488_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_491_1 = arg_488_1.actors_["1044ui_story"]

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect1044ui_story == nil then
				arg_488_1.var_.characterEffect1044ui_story = var_491_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_2 and not isNil(var_491_1) then
				if arg_488_1.var_.characterEffect1044ui_story and not isNil(var_491_1) then
					arg_488_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= 0 + var_491_2 and arg_488_1.time_ < 0 + var_491_2 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect1044ui_story then
				arg_488_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_2")
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_491_4 = 0
			local var_491_5 = 0.6

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_4 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_6 = arg_488_1:GetWordFromCfg(322281120)
				local var_491_7 = arg_488_1:FormatText(var_491_6.content)

				arg_488_1.text_.text = var_491_7

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_9 = 24 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 24)

				if (24 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 24)) > 0 and var_491_5 < var_491_9 then
					arg_488_1.talkMaxDuration = var_491_9

					if var_491_9 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_9 + var_491_4
					end
				end

				arg_488_1.text_.text = var_491_7
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281120", "story_v_out_322281.awb") ~= 0 then
					local var_491_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281120", "story_v_out_322281.awb") / 1000

					if var_491_10 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_10 + var_491_4
					end

					if var_491_6.prefab_name ~= "" and arg_488_1.actors_[var_491_6.prefab_name] ~= nil then
						local var_491_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_6.prefab_name].transform, "story_v_out_322281", "322281120", "story_v_out_322281.awb")

						arg_488_1:RecordAudio("322281120", var_491_11)
						arg_488_1:RecordAudio("322281120", var_491_11)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_322281", "322281120", "story_v_out_322281.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_322281", "322281120", "story_v_out_322281.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_12 = math.max(var_491_5, arg_488_1.talkMaxDuration)

			if var_491_4 <= arg_488_1.time_ and arg_488_1.time_ < var_491_4 + var_491_12 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_4) / var_491_12

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_4 + var_491_12 and arg_488_1.time_ < var_491_4 + var_491_12 + arg_491_0 then
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
			local var_495_0 = 1.125

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_1 = arg_492_1:GetWordFromCfg(322281121)
				local var_495_2 = arg_492_1:FormatText(var_495_1.content)

				arg_492_1.text_.text = var_495_2

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_4 = 45 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_2) / 45)

				if (45 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_2) / 45)) > 0 and var_495_0 < var_495_4 then
					arg_492_1.talkMaxDuration = var_495_4

					if var_495_4 + 0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_4 + 0
					end
				end

				arg_492_1.text_.text = var_495_2
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281121", "story_v_out_322281.awb") ~= 0 then
					local var_495_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281121", "story_v_out_322281.awb") / 1000

					if var_495_5 + 0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_5 + 0
					end

					if var_495_1.prefab_name ~= "" and arg_492_1.actors_[var_495_1.prefab_name] ~= nil then
						local var_495_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_1.prefab_name].transform, "story_v_out_322281", "322281121", "story_v_out_322281.awb")

						arg_492_1:RecordAudio("322281121", var_495_6)
						arg_492_1:RecordAudio("322281121", var_495_6)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_322281", "322281121", "story_v_out_322281.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_322281", "322281121", "story_v_out_322281.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_7 = math.max(var_495_0, arg_492_1.talkMaxDuration)

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_7 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - 0) / var_495_7

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= 0 + var_495_7 and arg_492_1.time_ < 0 + var_495_7 + arg_495_0 then
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
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(arg_496_1.actors_["1020ui_story"]) and arg_496_1.var_.characterEffect1020ui_story == nil then
				arg_496_1.var_.characterEffect1020ui_story = arg_496_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_0 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 and not isNil(arg_496_1.actors_["1020ui_story"]) then
				if arg_496_1.var_.characterEffect1020ui_story and not isNil(arg_496_1.actors_["1020ui_story"]) then
					arg_496_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 and not isNil(arg_496_1.actors_["1020ui_story"]) and arg_496_1.var_.characterEffect1020ui_story then
				arg_496_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_499_2 = arg_496_1.actors_["1044ui_story"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_2) and arg_496_1.var_.characterEffect1044ui_story == nil then
				arg_496_1.var_.characterEffect1044ui_story = var_499_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_3 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_3 and not isNil(var_499_2) then
				if arg_496_1.var_.characterEffect1044ui_story and not isNil(var_499_2) then
					arg_496_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_496_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_496_1.time_ - 0) / var_499_3)
				end
			end

			if arg_496_1.time_ >= 0 + var_499_3 and arg_496_1.time_ < 0 + var_499_3 + arg_499_0 and not isNil(var_499_2) and arg_496_1.var_.characterEffect1044ui_story then
				arg_496_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_496_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_499_4 = 0
			local var_499_5 = 0.425

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_4 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_6 = arg_496_1:GetWordFromCfg(322281122)
				local var_499_7 = arg_496_1:FormatText(var_499_6.content)

				arg_496_1.text_.text = var_499_7

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_9 = 16 <= 0 and var_499_5 or var_499_5 * (utf8.len(var_499_7) / 16)

				if (16 <= 0 and var_499_5 or var_499_5 * (utf8.len(var_499_7) / 16)) > 0 and var_499_5 < var_499_9 then
					arg_496_1.talkMaxDuration = var_499_9

					if var_499_9 + var_499_4 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_9 + var_499_4
					end
				end

				arg_496_1.text_.text = var_499_7
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281122", "story_v_out_322281.awb") ~= 0 then
					local var_499_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281122", "story_v_out_322281.awb") / 1000

					if var_499_10 + var_499_4 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_10 + var_499_4
					end

					if var_499_6.prefab_name ~= "" and arg_496_1.actors_[var_499_6.prefab_name] ~= nil then
						local var_499_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_6.prefab_name].transform, "story_v_out_322281", "322281122", "story_v_out_322281.awb")

						arg_496_1:RecordAudio("322281122", var_499_11)
						arg_496_1:RecordAudio("322281122", var_499_11)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_322281", "322281122", "story_v_out_322281.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_322281", "322281122", "story_v_out_322281.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_12 = math.max(var_499_5, arg_496_1.talkMaxDuration)

			if var_499_4 <= arg_496_1.time_ and arg_496_1.time_ < var_499_4 + var_499_12 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_4) / var_499_12

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_4 + var_499_12 and arg_496_1.time_ < var_499_4 + var_499_12 + arg_499_0 then
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
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["1020ui_story"]) and arg_500_1.var_.characterEffect1020ui_story == nil then
				arg_500_1.var_.characterEffect1020ui_story = arg_500_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_0 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["1020ui_story"]) then
				if arg_500_1.var_.characterEffect1020ui_story and not isNil(arg_500_1.actors_["1020ui_story"]) then
					arg_500_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_500_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_500_1.time_ - 0) / var_503_0)
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["1020ui_story"]) and arg_500_1.var_.characterEffect1020ui_story then
				arg_500_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_500_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_503_1 = arg_500_1.actors_["1044ui_story"]

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(var_503_1) and arg_500_1.var_.characterEffect1044ui_story == nil then
				arg_500_1.var_.characterEffect1044ui_story = var_503_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_2 and not isNil(var_503_1) then
				if arg_500_1.var_.characterEffect1044ui_story and not isNil(var_503_1) then
					arg_500_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= 0 + var_503_2 and arg_500_1.time_ < 0 + var_503_2 + arg_503_0 and not isNil(var_503_1) and arg_500_1.var_.characterEffect1044ui_story then
				arg_500_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_503_4 = 0
			local var_503_5 = 0.05

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_4 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_6 = arg_500_1:GetWordFromCfg(322281123)
				local var_503_7 = arg_500_1:FormatText(var_503_6.content)

				arg_500_1.text_.text = var_503_7

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_9 = 2 <= 0 and var_503_5 or var_503_5 * (utf8.len(var_503_7) / 2)

				if (2 <= 0 and var_503_5 or var_503_5 * (utf8.len(var_503_7) / 2)) > 0 and var_503_5 < var_503_9 then
					arg_500_1.talkMaxDuration = var_503_9

					if var_503_9 + var_503_4 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_9 + var_503_4
					end
				end

				arg_500_1.text_.text = var_503_7
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281123", "story_v_out_322281.awb") ~= 0 then
					local var_503_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281123", "story_v_out_322281.awb") / 1000

					if var_503_10 + var_503_4 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_10 + var_503_4
					end

					if var_503_6.prefab_name ~= "" and arg_500_1.actors_[var_503_6.prefab_name] ~= nil then
						local var_503_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_6.prefab_name].transform, "story_v_out_322281", "322281123", "story_v_out_322281.awb")

						arg_500_1:RecordAudio("322281123", var_503_11)
						arg_500_1:RecordAudio("322281123", var_503_11)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_322281", "322281123", "story_v_out_322281.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_322281", "322281123", "story_v_out_322281.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_12 = math.max(var_503_5, arg_500_1.talkMaxDuration)

			if var_503_4 <= arg_500_1.time_ and arg_500_1.time_ < var_503_4 + var_503_12 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_4) / var_503_12

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_4 + var_503_12 and arg_500_1.time_ < var_503_4 + var_503_12 + arg_503_0 then
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
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(arg_504_1.actors_["1020ui_story"]) and arg_504_1.var_.characterEffect1020ui_story == nil then
				arg_504_1.var_.characterEffect1020ui_story = arg_504_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_0 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_0 and not isNil(arg_504_1.actors_["1020ui_story"]) then
				if arg_504_1.var_.characterEffect1020ui_story and not isNil(arg_504_1.actors_["1020ui_story"]) then
					arg_504_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= 0 + var_507_0 and arg_504_1.time_ < 0 + var_507_0 + arg_507_0 and not isNil(arg_504_1.actors_["1020ui_story"]) and arg_504_1.var_.characterEffect1020ui_story then
				arg_504_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_507_2 = arg_504_1.actors_["1044ui_story"]

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(var_507_2) and arg_504_1.var_.characterEffect1044ui_story == nil then
				arg_504_1.var_.characterEffect1044ui_story = var_507_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_3 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_3 and not isNil(var_507_2) then
				if arg_504_1.var_.characterEffect1044ui_story and not isNil(var_507_2) then
					arg_504_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_504_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_504_1.time_ - 0) / var_507_3)
				end
			end

			if arg_504_1.time_ >= 0 + var_507_3 and arg_504_1.time_ < 0 + var_507_3 + arg_507_0 and not isNil(var_507_2) and arg_504_1.var_.characterEffect1044ui_story then
				arg_504_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_504_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_507_4 = 0
			local var_507_5 = 0.425

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_4 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_6 = arg_504_1:GetWordFromCfg(322281124)
				local var_507_7 = arg_504_1:FormatText(var_507_6.content)

				arg_504_1.text_.text = var_507_7

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_9 = 17 <= 0 and var_507_5 or var_507_5 * (utf8.len(var_507_7) / 17)

				if (17 <= 0 and var_507_5 or var_507_5 * (utf8.len(var_507_7) / 17)) > 0 and var_507_5 < var_507_9 then
					arg_504_1.talkMaxDuration = var_507_9

					if var_507_9 + var_507_4 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_9 + var_507_4
					end
				end

				arg_504_1.text_.text = var_507_7
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281124", "story_v_out_322281.awb") ~= 0 then
					local var_507_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281124", "story_v_out_322281.awb") / 1000

					if var_507_10 + var_507_4 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_10 + var_507_4
					end

					if var_507_6.prefab_name ~= "" and arg_504_1.actors_[var_507_6.prefab_name] ~= nil then
						local var_507_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_6.prefab_name].transform, "story_v_out_322281", "322281124", "story_v_out_322281.awb")

						arg_504_1:RecordAudio("322281124", var_507_11)
						arg_504_1:RecordAudio("322281124", var_507_11)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_322281", "322281124", "story_v_out_322281.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_322281", "322281124", "story_v_out_322281.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_12 = math.max(var_507_5, arg_504_1.talkMaxDuration)

			if var_507_4 <= arg_504_1.time_ and arg_504_1.time_ < var_507_4 + var_507_12 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_4) / var_507_12

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_4 + var_507_12 and arg_504_1.time_ < var_507_4 + var_507_12 + arg_507_0 then
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
			local var_511_0 = 0.3

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_1 = arg_508_1:GetWordFromCfg(322281125)
				local var_511_2 = arg_508_1:FormatText(var_511_1.content)

				arg_508_1.text_.text = var_511_2

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_4 = 12 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_2) / 12)

				if (12 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_2) / 12)) > 0 and var_511_0 < var_511_4 then
					arg_508_1.talkMaxDuration = var_511_4

					if var_511_4 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_4 + 0
					end
				end

				arg_508_1.text_.text = var_511_2
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281125", "story_v_out_322281.awb") ~= 0 then
					local var_511_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281125", "story_v_out_322281.awb") / 1000

					if var_511_5 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_5 + 0
					end

					if var_511_1.prefab_name ~= "" and arg_508_1.actors_[var_511_1.prefab_name] ~= nil then
						local var_511_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_1.prefab_name].transform, "story_v_out_322281", "322281125", "story_v_out_322281.awb")

						arg_508_1:RecordAudio("322281125", var_511_6)
						arg_508_1:RecordAudio("322281125", var_511_6)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_322281", "322281125", "story_v_out_322281.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_322281", "322281125", "story_v_out_322281.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_7 = math.max(var_511_0, arg_508_1.talkMaxDuration)

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_7 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - 0) / var_511_7

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= 0 + var_511_7 and arg_508_1.time_ < 0 + var_511_7 + arg_511_0 then
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
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(arg_512_1.actors_["1020ui_story"]) and arg_512_1.var_.characterEffect1020ui_story == nil then
				arg_512_1.var_.characterEffect1020ui_story = arg_512_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_0 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 and not isNil(arg_512_1.actors_["1020ui_story"]) then
				if arg_512_1.var_.characterEffect1020ui_story and not isNil(arg_512_1.actors_["1020ui_story"]) then
					arg_512_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_512_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_512_1.time_ - 0) / var_515_0)
				end
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 and not isNil(arg_512_1.actors_["1020ui_story"]) and arg_512_1.var_.characterEffect1020ui_story then
				arg_512_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_512_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_515_1 = arg_512_1.actors_["1044ui_story"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_1) and arg_512_1.var_.characterEffect1044ui_story == nil then
				arg_512_1.var_.characterEffect1044ui_story = var_515_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_2 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_2 and not isNil(var_515_1) then
				if arg_512_1.var_.characterEffect1044ui_story and not isNil(var_515_1) then
					arg_512_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= 0 + var_515_2 and arg_512_1.time_ < 0 + var_515_2 + arg_515_0 and not isNil(var_515_1) and arg_512_1.var_.characterEffect1044ui_story then
				arg_512_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_515_4 = 0
			local var_515_5 = 0.175

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_4 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_6 = arg_512_1:GetWordFromCfg(322281126)
				local var_515_7 = arg_512_1:FormatText(var_515_6.content)

				arg_512_1.text_.text = var_515_7

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_9 = 7 <= 0 and var_515_5 or var_515_5 * (utf8.len(var_515_7) / 7)

				if (7 <= 0 and var_515_5 or var_515_5 * (utf8.len(var_515_7) / 7)) > 0 and var_515_5 < var_515_9 then
					arg_512_1.talkMaxDuration = var_515_9

					if var_515_9 + var_515_4 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_9 + var_515_4
					end
				end

				arg_512_1.text_.text = var_515_7
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281126", "story_v_out_322281.awb") ~= 0 then
					local var_515_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281126", "story_v_out_322281.awb") / 1000

					if var_515_10 + var_515_4 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_10 + var_515_4
					end

					if var_515_6.prefab_name ~= "" and arg_512_1.actors_[var_515_6.prefab_name] ~= nil then
						local var_515_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_6.prefab_name].transform, "story_v_out_322281", "322281126", "story_v_out_322281.awb")

						arg_512_1:RecordAudio("322281126", var_515_11)
						arg_512_1:RecordAudio("322281126", var_515_11)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_322281", "322281126", "story_v_out_322281.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_322281", "322281126", "story_v_out_322281.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_12 = math.max(var_515_5, arg_512_1.talkMaxDuration)

			if var_515_4 <= arg_512_1.time_ and arg_512_1.time_ < var_515_4 + var_515_12 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_4) / var_515_12

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_4 + var_515_12 and arg_512_1.time_ < var_515_4 + var_515_12 + arg_515_0 then
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
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(arg_516_1.actors_["1020ui_story"]) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = arg_516_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_0 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 and not isNil(arg_516_1.actors_["1020ui_story"]) then
				if arg_516_1.var_.characterEffect1020ui_story and not isNil(arg_516_1.actors_["1020ui_story"]) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 and not isNil(arg_516_1.actors_["1020ui_story"]) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_519_2 = arg_516_1.actors_["1044ui_story"]

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(var_519_2) and arg_516_1.var_.characterEffect1044ui_story == nil then
				arg_516_1.var_.characterEffect1044ui_story = var_519_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_3 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_3 and not isNil(var_519_2) then
				if arg_516_1.var_.characterEffect1044ui_story and not isNil(var_519_2) then
					arg_516_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_516_1.time_ - 0) / var_519_3)
				end
			end

			if arg_516_1.time_ >= 0 + var_519_3 and arg_516_1.time_ < 0 + var_519_3 + arg_519_0 and not isNil(var_519_2) and arg_516_1.var_.characterEffect1044ui_story then
				arg_516_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_519_4 = 0
			local var_519_5 = 0.275

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_4 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_6 = arg_516_1:GetWordFromCfg(322281127)
				local var_519_7 = arg_516_1:FormatText(var_519_6.content)

				arg_516_1.text_.text = var_519_7

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_9 = 11 <= 0 and var_519_5 or var_519_5 * (utf8.len(var_519_7) / 11)

				if (11 <= 0 and var_519_5 or var_519_5 * (utf8.len(var_519_7) / 11)) > 0 and var_519_5 < var_519_9 then
					arg_516_1.talkMaxDuration = var_519_9

					if var_519_9 + var_519_4 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_9 + var_519_4
					end
				end

				arg_516_1.text_.text = var_519_7
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281127", "story_v_out_322281.awb") ~= 0 then
					local var_519_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281127", "story_v_out_322281.awb") / 1000

					if var_519_10 + var_519_4 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_10 + var_519_4
					end

					if var_519_6.prefab_name ~= "" and arg_516_1.actors_[var_519_6.prefab_name] ~= nil then
						local var_519_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_6.prefab_name].transform, "story_v_out_322281", "322281127", "story_v_out_322281.awb")

						arg_516_1:RecordAudio("322281127", var_519_11)
						arg_516_1:RecordAudio("322281127", var_519_11)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_322281", "322281127", "story_v_out_322281.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_322281", "322281127", "story_v_out_322281.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_12 = math.max(var_519_5, arg_516_1.talkMaxDuration)

			if var_519_4 <= arg_516_1.time_ and arg_516_1.time_ < var_519_4 + var_519_12 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_4) / var_519_12

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_4 + var_519_12 and arg_516_1.time_ < var_519_4 + var_519_12 + arg_519_0 then
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
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos1020ui_story = arg_520_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_523_0 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 then
				arg_520_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_520_1.time_ - 0) / var_523_0)
				arg_520_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1020ui_story"].transform.position).z)
				arg_520_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1020ui_story"].transform.localEulerAngles = arg_520_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 then
				arg_520_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_520_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1020ui_story"].transform.position).z)
				arg_520_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1020ui_story"].transform.localEulerAngles = arg_520_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if 0.333333333333333 < arg_520_1.time_ and arg_520_1.time_ <= 0.333333333333333 + arg_523_0 then
				arg_520_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_523_2 = arg_520_1.actors_["1044ui_story"].transform

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos1044ui_story = var_523_2.localPosition

				arg_520_1:ShowWeapon(arg_520_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_523_3 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_3 then
				var_523_2.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_520_1.time_ - 0) / var_523_3)
				var_523_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_523_2.position).x, (manager.ui.mainCamera.transform.position - var_523_2.position).y, (manager.ui.mainCamera.transform.position - var_523_2.position).z)
				var_523_2.localEulerAngles.z = 0
				var_523_2.localEulerAngles.x = 0
				var_523_2.localEulerAngles = var_523_2.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_3 and arg_520_1.time_ < 0 + var_523_3 + arg_523_0 then
				var_523_2.localPosition = Vector3.New(0, 100, 0)
				var_523_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_523_2.position).x, (manager.ui.mainCamera.transform.position - var_523_2.position).y, (manager.ui.mainCamera.transform.position - var_523_2.position).z)
				var_523_2.localEulerAngles.z = 0
				var_523_2.localEulerAngles.x = 0
				var_523_2.localEulerAngles = var_523_2.localEulerAngles
			end

			local var_523_4 = 0
			local var_523_5 = 1.1

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_4 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, false)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_6 = arg_520_1:FormatText(arg_520_1:GetWordFromCfg(322281128).content)

				arg_520_1.text_.text = var_523_6

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_8 = 44 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_6) / 44)

				if (44 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_6) / 44)) > 0 and var_523_5 < var_523_8 then
					arg_520_1.talkMaxDuration = var_523_8

					if var_523_8 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_4
					end
				end

				arg_520_1.text_.text = var_523_6
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_9 = math.max(var_523_5, arg_520_1.talkMaxDuration)

			if var_523_4 <= arg_520_1.time_ and arg_520_1.time_ < var_523_4 + var_523_9 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_4) / var_523_9

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_4 + var_523_9 and arg_520_1.time_ < var_523_4 + var_523_9 + arg_523_0 then
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
			if arg_524_1.bgs_.L01f == nil then
				local var_527_0 = Object.Instantiate(arg_524_1.blurPaintGo_)

				var_527_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_527_0.name = "L01f"
				var_527_0.transform.parent = arg_524_1.stage_.transform
				var_527_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_524_1.bgs_.L01f = var_527_0
			end

			local var_527_1 = 0
			local var_527_2 = arg_524_1.bgs_.L01f

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				var_527_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_527_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_527_3 = var_527_2:GetComponent("SpriteRenderer")

				if var_527_3 and var_527_3.sprite then
					local var_527_4 = 2 * (var_527_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_527_2.transform.localScale = Vector3.New(var_527_4 / var_527_3.sprite.bounds.size.y < var_527_4 * manager.ui.mainCameraCom_.aspect / var_527_3.sprite.bounds.size.x and var_527_4 * manager.ui.mainCameraCom_.aspect / var_527_3.sprite.bounds.size.x or var_527_4 / var_527_3.sprite.bounds.size.y, var_527_4 / var_527_3.sprite.bounds.size.y < var_527_4 * manager.ui.mainCameraCom_.aspect / var_527_3.sprite.bounds.size.x and var_527_4 * manager.ui.mainCameraCom_.aspect / var_527_3.sprite.bounds.size.x or var_527_4 / var_527_3.sprite.bounds.size.y, 0)
				end
			end

			local var_527_5 = 1

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_5 then
				local var_527_6 = Color.New(1, 1, 1)

				var_527_6.a = Mathf.Lerp(0, 2, (arg_524_1.time_ - var_527_1) / var_527_5)

				var_527_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_527_6)
			end

			if arg_524_1.frameCnt_ <= 1 then
				arg_524_1.dialog_:SetActive(false)
			end

			local var_527_7 = 1
			local var_527_8 = 1.75

			if 1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_7 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0

				arg_524_1.dialog_:SetActive(true)

				arg_524_1.dialogCg_.alpha = 0

				local var_527_9 = LeanTween.value(arg_524_1.dialog_, 0, 1, 0.3)

				var_527_9:setOnUpdate(LuaHelper.FloatAction(function(arg_528_0)
					arg_524_1.dialogCg_.alpha = arg_528_0
				end))
				var_527_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_524_1.dialog_)
					var_527_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_524_1.duration_ = arg_524_1.duration_ + 0.3

				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_10 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(322281129).content)

				arg_524_1.text_.text = var_527_10

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_12 = 70 <= 0 and var_527_8 or var_527_8 * (utf8.len(var_527_10) / 70)

				if (70 <= 0 and var_527_8 or var_527_8 * (utf8.len(var_527_10) / 70)) > 0 and var_527_8 < var_527_12 then
					arg_524_1.talkMaxDuration = var_527_12
					var_527_7 = var_527_7 + 0.3

					if var_527_12 + var_527_7 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_12 + var_527_7
					end
				end

				arg_524_1.text_.text = var_527_10
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_13 = var_527_7 + 0.3
			local var_527_14 = math.max(var_527_8, arg_524_1.talkMaxDuration)

			if var_527_7 + 0.3 <= arg_524_1.time_ and arg_524_1.time_ < var_527_13 + var_527_14 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_13) / var_527_14

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_13 + var_527_14 and arg_524_1.time_ < var_527_13 + var_527_14 + arg_527_0 then
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
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				local var_533_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_533_0 then
					var_533_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_533_0.radialBlurScale = 1
					var_533_0.radialBlurGradient = 1
					var_533_0.radialBlurIntensity = 1

					if arg_530_1.actors_["233"] then
						var_533_0.radialBlurTarget = arg_530_1.actors_["233"].transform
					end
				end
			end

			local var_533_1 = 3.53333333333333

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_1 then
				local var_533_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_533_2 then
					var_533_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_533_2.radialBlurScale = Mathf.Lerp(1, 0.512, (arg_530_1.time_ - 0) / var_533_1)
					var_533_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_530_1.time_ - 0) / var_533_1)
					var_533_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_530_1.time_ - 0) / var_533_1)
				end
			end

			if arg_530_1.time_ >= 0 + var_533_1 and arg_530_1.time_ < 0 + var_533_1 + arg_533_0 then
				local var_533_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_533_3 then
					var_533_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_533_3.radialBlurScale = 0.512
					var_533_3.radialBlurGradient = 1
					var_533_3.radialBlurIntensity = 1
				end
			end

			local var_533_4 = 0
			local var_533_5 = 1.25

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_4 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_6 = arg_530_1:FormatText(arg_530_1:GetWordFromCfg(322281130).content)

				arg_530_1.text_.text = var_533_6

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_8 = 50 <= 0 and var_533_5 or var_533_5 * (utf8.len(var_533_6) / 50)

				if (50 <= 0 and var_533_5 or var_533_5 * (utf8.len(var_533_6) / 50)) > 0 and var_533_5 < var_533_8 then
					arg_530_1.talkMaxDuration = var_533_8

					if var_533_8 + var_533_4 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_8 + var_533_4
					end
				end

				arg_530_1.text_.text = var_533_6
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_9 = math.max(var_533_5, arg_530_1.talkMaxDuration)

			if var_533_4 <= arg_530_1.time_ and arg_530_1.time_ < var_533_4 + var_533_9 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_4) / var_533_9

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_4 + var_533_9 and arg_530_1.time_ < var_533_4 + var_533_9 + arg_533_0 then
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
			if 0.2 < arg_534_1.time_ and arg_534_1.time_ <= 0.2 + arg_537_0 then
				arg_534_1.var_.moveOldPos1020ui_story = arg_534_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_537_0 = 0.001

			if 0.2 <= arg_534_1.time_ and arg_534_1.time_ < 0.2 + var_537_0 then
				arg_534_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_534_1.time_ - 0.2) / var_537_0)
				arg_534_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1020ui_story"].transform.position).z)
				arg_534_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["1020ui_story"].transform.localEulerAngles = arg_534_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_534_1.time_ >= 0.2 + var_537_0 and arg_534_1.time_ < 0.2 + var_537_0 + arg_537_0 then
				arg_534_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_534_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1020ui_story"].transform.position).z)
				arg_534_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["1020ui_story"].transform.localEulerAngles = arg_534_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_537_1 = arg_534_1.actors_["1020ui_story"]

			if 0.2 < arg_534_1.time_ and arg_534_1.time_ <= 0.2 + arg_537_0 and not isNil(var_537_1) and arg_534_1.var_.characterEffect1020ui_story == nil then
				arg_534_1.var_.characterEffect1020ui_story = var_537_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if 0.2 <= arg_534_1.time_ and arg_534_1.time_ < 0.2 + var_537_2 and not isNil(var_537_1) then
				if arg_534_1.var_.characterEffect1020ui_story and not isNil(var_537_1) then
					arg_534_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= 0.2 + var_537_2 and arg_534_1.time_ < 0.2 + var_537_2 + arg_537_0 and not isNil(var_537_1) and arg_534_1.var_.characterEffect1020ui_story then
				arg_534_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0.2 < arg_534_1.time_ and arg_534_1.time_ <= 0.2 + arg_537_0 then
				arg_534_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0.2 < arg_534_1.time_ and arg_534_1.time_ <= 0.2 + arg_537_0 then
				arg_534_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_537_4

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				local var_537_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_537_5 then
					var_537_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_537_5.radialBlurScale = 0
					var_537_5.radialBlurGradient = 1
					var_537_5.radialBlurIntensity = 1

					if var_537_4 then
						var_537_5.radialBlurTarget = var_537_4.transform
					end
				end
			end

			local var_537_6 = 0.333333333333333

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_6 then
				local var_537_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_537_7 then
					var_537_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_537_7.radialBlurScale = Mathf.Lerp(0, 0, (arg_534_1.time_ - 0) / var_537_6)
					var_537_7.radialBlurGradient = Mathf.Lerp(1, 1, (arg_534_1.time_ - 0) / var_537_6)
					var_537_7.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_534_1.time_ - 0) / var_537_6)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_6 and arg_534_1.time_ < 0 + var_537_6 + arg_537_0 then
				local var_537_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_537_8 then
					var_537_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_537_8.radialBlurScale = 0
					var_537_8.radialBlurGradient = 1
					var_537_8.radialBlurIntensity = 1
				end
			end

			if arg_534_1.frameCnt_ <= 1 then
				arg_534_1.dialog_:SetActive(false)
			end

			local var_537_9 = 0.2
			local var_537_10 = 0.525

			if 0.2 < arg_534_1.time_ and arg_534_1.time_ <= var_537_9 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0

				arg_534_1.dialog_:SetActive(true)

				arg_534_1.dialogCg_.alpha = 0

				local var_537_11 = LeanTween.value(arg_534_1.dialog_, 0, 1, 0.3)

				var_537_11:setOnUpdate(LuaHelper.FloatAction(function(arg_538_0)
					arg_534_1.dialogCg_.alpha = arg_538_0
				end))
				var_537_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_534_1.dialog_)
					var_537_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_534_1.duration_ = arg_534_1.duration_ + 0.3

				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_12 = arg_534_1:GetWordFromCfg(322281131)
				local var_537_13 = arg_534_1:FormatText(var_537_12.content)

				arg_534_1.text_.text = var_537_13

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_15 = 21 <= 0 and var_537_10 or var_537_10 * (utf8.len(var_537_13) / 21)

				if (21 <= 0 and var_537_10 or var_537_10 * (utf8.len(var_537_13) / 21)) > 0 and var_537_10 < var_537_15 then
					arg_534_1.talkMaxDuration = var_537_15
					var_537_9 = var_537_9 + 0.3

					if var_537_15 + var_537_9 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_15 + var_537_9
					end
				end

				arg_534_1.text_.text = var_537_13
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281131", "story_v_out_322281.awb") ~= 0 then
					local var_537_16 = manager.audio:GetVoiceLength("story_v_out_322281", "322281131", "story_v_out_322281.awb") / 1000

					if var_537_16 + var_537_9 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_16 + var_537_9
					end

					if var_537_12.prefab_name ~= "" and arg_534_1.actors_[var_537_12.prefab_name] ~= nil then
						local var_537_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_12.prefab_name].transform, "story_v_out_322281", "322281131", "story_v_out_322281.awb")

						arg_534_1:RecordAudio("322281131", var_537_17)
						arg_534_1:RecordAudio("322281131", var_537_17)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_322281", "322281131", "story_v_out_322281.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_322281", "322281131", "story_v_out_322281.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_18 = var_537_9 + 0.3
			local var_537_19 = math.max(var_537_10, arg_534_1.talkMaxDuration)

			if var_537_9 + 0.3 <= arg_534_1.time_ and arg_534_1.time_ < var_537_18 + var_537_19 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_18) / var_537_19

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_18 + var_537_19 and arg_534_1.time_ < var_537_18 + var_537_19 + arg_537_0 then
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
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.var_.moveOldPos1020ui_story = arg_540_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_543_0 = 0.001

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 then
				arg_540_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_540_1.time_ - 0) / var_543_0)
				arg_540_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1020ui_story"].transform.position).z)
				arg_540_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["1020ui_story"].transform.localEulerAngles = arg_540_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 then
				arg_540_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_540_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1020ui_story"].transform.position).z)
				arg_540_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["1020ui_story"].transform.localEulerAngles = arg_540_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_543_1 = 0
			local var_543_2 = 0.625

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_3 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(322281132).content)

				arg_540_1.text_.text = var_543_3

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 25 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 25)

				if (25 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 25)) > 0 and var_543_2 < var_543_5 then
					arg_540_1.talkMaxDuration = var_543_5

					if var_543_5 + var_543_1 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + var_543_1
					end
				end

				arg_540_1.text_.text = var_543_3
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_6 = math.max(var_543_2, arg_540_1.talkMaxDuration)

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_6 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_1) / var_543_6

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_1 + var_543_6 and arg_540_1.time_ < var_543_1 + var_543_6 + arg_543_0 then
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
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(arg_544_1.actors_["1020ui_story"]) and arg_544_1.var_.characterEffect1020ui_story == nil then
				arg_544_1.var_.characterEffect1020ui_story = arg_544_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_0 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 and not isNil(arg_544_1.actors_["1020ui_story"]) then
				if arg_544_1.var_.characterEffect1020ui_story and not isNil(arg_544_1.actors_["1020ui_story"]) then
					arg_544_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 and not isNil(arg_544_1.actors_["1020ui_story"]) and arg_544_1.var_.characterEffect1020ui_story then
				arg_544_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_547_2 = arg_544_1.actors_["1020ui_story"].transform

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos1020ui_story = var_547_2.localPosition
			end

			local var_547_3 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_3 then
				var_547_2.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_544_1.time_ - 0) / var_547_3)
				var_547_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_547_2.position).x, (manager.ui.mainCamera.transform.position - var_547_2.position).y, (manager.ui.mainCamera.transform.position - var_547_2.position).z)
				var_547_2.localEulerAngles.z = 0
				var_547_2.localEulerAngles.x = 0
				var_547_2.localEulerAngles = var_547_2.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_3 and arg_544_1.time_ < 0 + var_547_3 + arg_547_0 then
				var_547_2.localPosition = Vector3.New(0, -0.85, -6.25)
				var_547_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_547_2.position).x, (manager.ui.mainCamera.transform.position - var_547_2.position).y, (manager.ui.mainCamera.transform.position - var_547_2.position).z)
				var_547_2.localEulerAngles.z = 0
				var_547_2.localEulerAngles.x = 0
				var_547_2.localEulerAngles = var_547_2.localEulerAngles
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_547_4 = 0
			local var_547_5 = 0.5

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_4 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_6 = arg_544_1:GetWordFromCfg(322281133)
				local var_547_7 = arg_544_1:FormatText(var_547_6.content)

				arg_544_1.text_.text = var_547_7

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_9 = 20 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 20)

				if (20 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 20)) > 0 and var_547_5 < var_547_9 then
					arg_544_1.talkMaxDuration = var_547_9

					if var_547_9 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_9 + var_547_4
					end
				end

				arg_544_1.text_.text = var_547_7
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281133", "story_v_out_322281.awb") ~= 0 then
					local var_547_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281133", "story_v_out_322281.awb") / 1000

					if var_547_10 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_10 + var_547_4
					end

					if var_547_6.prefab_name ~= "" and arg_544_1.actors_[var_547_6.prefab_name] ~= nil then
						local var_547_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_6.prefab_name].transform, "story_v_out_322281", "322281133", "story_v_out_322281.awb")

						arg_544_1:RecordAudio("322281133", var_547_11)
						arg_544_1:RecordAudio("322281133", var_547_11)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_322281", "322281133", "story_v_out_322281.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_322281", "322281133", "story_v_out_322281.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_12 = math.max(var_547_5, arg_544_1.talkMaxDuration)

			if var_547_4 <= arg_544_1.time_ and arg_544_1.time_ < var_547_4 + var_547_12 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_4) / var_547_12

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_4 + var_547_12 and arg_544_1.time_ < var_547_4 + var_547_12 + arg_547_0 then
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
			if 4 < arg_548_1.time_ and arg_548_1.time_ <= 4 + arg_551_0 then
				arg_548_1.allBtn_.enabled = false
			end

			if arg_548_1.time_ >= 4 + 1.23333333333333 and arg_548_1.time_ < 4 + 1.23333333333333 + arg_551_0 then
				arg_548_1.allBtn_.enabled = true
			end

			local var_551_0 = "L10i"

			if arg_548_1.bgs_.L10i == nil then
				local var_551_1 = Object.Instantiate(arg_548_1.paintGo_)

				var_551_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_551_0)
				var_551_1.name = var_551_0
				var_551_1.transform.parent = arg_548_1.stage_.transform
				var_551_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_548_1.bgs_[var_551_0] = var_551_1
			end

			if 2 < arg_548_1.time_ and arg_548_1.time_ <= 2 + arg_551_0 then
				local var_551_2 = arg_548_1.bgs_.L10i

				arg_548_1.bgs_.L10i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_551_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_551_3 = var_551_2:GetComponent("SpriteRenderer")

				if var_551_3 and var_551_3.sprite then
					local var_551_4 = 2 * (var_551_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_551_2.transform.localScale = Vector3.New(var_551_4 / var_551_3.sprite.bounds.size.y < var_551_4 * manager.ui.mainCameraCom_.aspect / var_551_3.sprite.bounds.size.x and var_551_4 * manager.ui.mainCameraCom_.aspect / var_551_3.sprite.bounds.size.x or var_551_4 / var_551_3.sprite.bounds.size.y, var_551_4 / var_551_3.sprite.bounds.size.y < var_551_4 * manager.ui.mainCameraCom_.aspect / var_551_3.sprite.bounds.size.x and var_551_4 * manager.ui.mainCameraCom_.aspect / var_551_3.sprite.bounds.size.x or var_551_4 / var_551_3.sprite.bounds.size.y, 0)
				end

				for iter_551_0, iter_551_1 in pairs(arg_548_1.bgs_) do
					if iter_551_0 ~= "L10i" then
						iter_551_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_551_5 = 0

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_5 + arg_551_0 then
				arg_548_1.mask_.enabled = true
				arg_548_1.mask_.raycastTarget = true

				arg_548_1:SetGaussion(false)
			end

			local var_551_6 = 2

			if var_551_5 <= arg_548_1.time_ and arg_548_1.time_ < var_551_5 + var_551_6 then
				local var_551_7 = Color.New(0, 0, 0)

				var_551_7.a = Mathf.Lerp(0, 1, (arg_548_1.time_ - var_551_5) / var_551_6)
				arg_548_1.mask_.color = var_551_7
			end

			if arg_548_1.time_ >= var_551_5 + var_551_6 and arg_548_1.time_ < var_551_5 + var_551_6 + arg_551_0 then
				local var_551_8 = Color.New(0, 0, 0)

				var_551_8.a = 1
				arg_548_1.mask_.color = var_551_8
			end

			local var_551_9 = 2

			if 2 < arg_548_1.time_ and arg_548_1.time_ <= var_551_9 + arg_551_0 then
				arg_548_1.mask_.enabled = true
				arg_548_1.mask_.raycastTarget = true

				arg_548_1:SetGaussion(false)
			end

			local var_551_10 = 2

			if var_551_9 <= arg_548_1.time_ and arg_548_1.time_ < var_551_9 + var_551_10 then
				local var_551_11 = Color.New(0, 0, 0)

				var_551_11.a = Mathf.Lerp(1, 0, (arg_548_1.time_ - var_551_9) / var_551_10)
				arg_548_1.mask_.color = var_551_11
			end

			if arg_548_1.time_ >= var_551_9 + var_551_10 and arg_548_1.time_ < var_551_9 + var_551_10 + arg_551_0 then
				local var_551_12 = Color.New(0, 0, 0)

				arg_548_1.mask_.enabled = false
				var_551_12.a = 0
				arg_548_1.mask_.color = var_551_12
			end

			local var_551_13 = arg_548_1.actors_["1020ui_story"].transform

			if 2 < arg_548_1.time_ and arg_548_1.time_ <= 2 + arg_551_0 then
				arg_548_1.var_.moveOldPos1020ui_story = var_551_13.localPosition
			end

			local var_551_14 = 0.001

			if 2 <= arg_548_1.time_ and arg_548_1.time_ < 2 + var_551_14 then
				var_551_13.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_548_1.time_ - 2) / var_551_14)
				var_551_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_551_13.position).x, (manager.ui.mainCamera.transform.position - var_551_13.position).y, (manager.ui.mainCamera.transform.position - var_551_13.position).z)
				var_551_13.localEulerAngles.z = 0
				var_551_13.localEulerAngles.x = 0
				var_551_13.localEulerAngles = var_551_13.localEulerAngles
			end

			if arg_548_1.time_ >= 2 + var_551_14 and arg_548_1.time_ < 2 + var_551_14 + arg_551_0 then
				var_551_13.localPosition = Vector3.New(0, 100, 0)
				var_551_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_551_13.position).x, (manager.ui.mainCamera.transform.position - var_551_13.position).y, (manager.ui.mainCamera.transform.position - var_551_13.position).z)
				var_551_13.localEulerAngles.z = 0
				var_551_13.localEulerAngles.x = 0
				var_551_13.localEulerAngles = var_551_13.localEulerAngles
			end

			if 0.2 < arg_548_1.time_ and arg_548_1.time_ <= 0.2 + arg_551_0 then
				arg_548_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 1.56666666666667 < arg_548_1.time_ and arg_548_1.time_ <= 1.56666666666667 + arg_551_0 then
				arg_548_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			local var_551_17 = "L01f"

			if arg_548_1.bgs_.L01f == nil then
				local var_551_18 = Object.Instantiate(arg_548_1.blurPaintGo_)

				var_551_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_551_17)
				var_551_18.name = var_551_17
				var_551_18.transform.parent = arg_548_1.stage_.transform
				var_551_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_548_1.bgs_[var_551_17] = var_551_18
			end

			local var_551_19 = 2
			local var_551_20 = arg_548_1.bgs_[var_551_17]

			if 2 < arg_548_1.time_ and arg_548_1.time_ <= var_551_19 + arg_551_0 then
				var_551_20.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_551_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_551_21 = var_551_20:GetComponent("SpriteRenderer")

				if var_551_21 and var_551_21.sprite then
					local var_551_22 = 2 * (var_551_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_551_20.transform.localScale = Vector3.New(var_551_22 / var_551_21.sprite.bounds.size.y < var_551_22 * manager.ui.mainCameraCom_.aspect / var_551_21.sprite.bounds.size.x and var_551_22 * manager.ui.mainCameraCom_.aspect / var_551_21.sprite.bounds.size.x or var_551_22 / var_551_21.sprite.bounds.size.y, var_551_22 / var_551_21.sprite.bounds.size.y < var_551_22 * manager.ui.mainCameraCom_.aspect / var_551_21.sprite.bounds.size.x and var_551_22 * manager.ui.mainCameraCom_.aspect / var_551_21.sprite.bounds.size.x or var_551_22 / var_551_21.sprite.bounds.size.y, 0)
				end
			end

			local var_551_23 = 0.0166666666666667

			if var_551_19 <= arg_548_1.time_ and arg_548_1.time_ < var_551_19 + var_551_23 then
				local var_551_24 = Color.New(1, 1, 1)

				var_551_24.a = Mathf.Lerp(0, 0, (arg_548_1.time_ - var_551_19) / var_551_23)

				var_551_20:GetComponent("SpriteRenderer").material:SetColor("_Color", var_551_24)
			end

			if arg_548_1.frameCnt_ <= 1 then
				arg_548_1.dialog_:SetActive(false)
			end

			local var_551_25 = 4
			local var_551_26 = 1.475

			if 4 < arg_548_1.time_ and arg_548_1.time_ <= var_551_25 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0

				arg_548_1.dialog_:SetActive(true)

				arg_548_1.dialogCg_.alpha = 0

				local var_551_27 = LeanTween.value(arg_548_1.dialog_, 0, 1, 0.3)

				var_551_27:setOnUpdate(LuaHelper.FloatAction(function(arg_552_0)
					arg_548_1.dialogCg_.alpha = arg_552_0
				end))
				var_551_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_548_1.dialog_)
					var_551_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_548_1.duration_ = arg_548_1.duration_ + 0.3

				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_28 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(322281134).content)

				arg_548_1.text_.text = var_551_28

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_30 = 59 <= 0 and var_551_26 or var_551_26 * (utf8.len(var_551_28) / 59)

				if (59 <= 0 and var_551_26 or var_551_26 * (utf8.len(var_551_28) / 59)) > 0 and var_551_26 < var_551_30 then
					arg_548_1.talkMaxDuration = var_551_30
					var_551_25 = var_551_25 + 0.3

					if var_551_30 + var_551_25 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_30 + var_551_25
					end
				end

				arg_548_1.text_.text = var_551_28
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_31 = var_551_25 + 0.3
			local var_551_32 = math.max(var_551_26, arg_548_1.talkMaxDuration)

			if var_551_25 + 0.3 <= arg_548_1.time_ and arg_548_1.time_ < var_551_31 + var_551_32 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_31) / var_551_32

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_31 + var_551_32 and arg_548_1.time_ < var_551_31 + var_551_32 + arg_551_0 then
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
			local var_557_0 = 1.225

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, false)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_1 = arg_554_1:FormatText(arg_554_1:GetWordFromCfg(322281135).content)

				arg_554_1.text_.text = var_557_1

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_3 = 49 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_1) / 49)

				if (49 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_1) / 49)) > 0 and var_557_0 < var_557_3 then
					arg_554_1.talkMaxDuration = var_557_3

					if var_557_3 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_3 + 0
					end
				end

				arg_554_1.text_.text = var_557_1
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_4 = math.max(var_557_0, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_4 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - 0) / var_557_4

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_4 and arg_554_1.time_ < 0 + var_557_4 + arg_557_0 then
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
			if arg_558_1.actors_["6056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6056ui_story"))) then
				local var_561_0 = Object.Instantiate(Asset.Load("Char/" .. "6056ui_story"), arg_558_1.stage_.transform)

				var_561_0.name = "6056ui_story"
				var_561_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_558_1.actors_["6056ui_story"] = var_561_0

				local var_561_1 = var_561_0:GetComponentInChildren(typeof(CharacterEffect))

				var_561_1.enabled = true

				local var_561_2 = GameObjectTools.GetOrAddComponent(var_561_0, typeof(DynamicBoneHelper))

				if var_561_2 then
					var_561_2:EnableDynamicBone(false)
				end

				arg_558_1:ShowWeapon(var_561_1.transform, false)

				arg_558_1.var_["6056ui_story" .. "Animator"] = var_561_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_558_1.var_["6056ui_story" .. "Animator"].applyRootMotion = true
				arg_558_1.var_["6056ui_story" .. "LipSync"] = var_561_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_561_3 = arg_558_1.actors_["6056ui_story"].transform

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.var_.moveOldPos6056ui_story = var_561_3.localPosition
			end

			local var_561_4 = 0.001

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 then
				var_561_3.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos6056ui_story, Vector3.New(0.15, -1.16, -6.15), (arg_558_1.time_ - 0) / var_561_4)
				var_561_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_3.position).x, (manager.ui.mainCamera.transform.position - var_561_3.position).y, (manager.ui.mainCamera.transform.position - var_561_3.position).z)
				var_561_3.localEulerAngles.z = 0
				var_561_3.localEulerAngles.x = 0
				var_561_3.localEulerAngles = var_561_3.localEulerAngles
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 then
				var_561_3.localPosition = Vector3.New(0.15, -1.16, -6.15)
				var_561_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_3.position).x, (manager.ui.mainCamera.transform.position - var_561_3.position).y, (manager.ui.mainCamera.transform.position - var_561_3.position).z)
				var_561_3.localEulerAngles.z = 0
				var_561_3.localEulerAngles.x = 0
				var_561_3.localEulerAngles = var_561_3.localEulerAngles
			end

			local var_561_5 = arg_558_1.actors_["6056ui_story"]

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(var_561_5) and arg_558_1.var_.characterEffect6056ui_story == nil then
				arg_558_1.var_.characterEffect6056ui_story = var_561_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_6 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_6 and not isNil(var_561_5) then
				if arg_558_1.var_.characterEffect6056ui_story and not isNil(var_561_5) then
					arg_558_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_558_1.time_ >= 0 + var_561_6 and arg_558_1.time_ < 0 + var_561_6 + arg_561_0 and not isNil(var_561_5) and arg_558_1.var_.characterEffect6056ui_story then
				arg_558_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_561_8 = 0
			local var_561_9 = 0.2

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_8 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_10 = arg_558_1:GetWordFromCfg(322281136)
				local var_561_11 = arg_558_1:FormatText(var_561_10.content)

				arg_558_1.text_.text = var_561_11

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_13 = 8 <= 0 and var_561_9 or var_561_9 * (utf8.len(var_561_11) / 8)

				if (8 <= 0 and var_561_9 or var_561_9 * (utf8.len(var_561_11) / 8)) > 0 and var_561_9 < var_561_13 then
					arg_558_1.talkMaxDuration = var_561_13

					if var_561_13 + var_561_8 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_13 + var_561_8
					end
				end

				arg_558_1.text_.text = var_561_11
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281136", "story_v_out_322281.awb") ~= 0 then
					local var_561_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281136", "story_v_out_322281.awb") / 1000

					if var_561_14 + var_561_8 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_14 + var_561_8
					end

					if var_561_10.prefab_name ~= "" and arg_558_1.actors_[var_561_10.prefab_name] ~= nil then
						local var_561_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_10.prefab_name].transform, "story_v_out_322281", "322281136", "story_v_out_322281.awb")

						arg_558_1:RecordAudio("322281136", var_561_15)
						arg_558_1:RecordAudio("322281136", var_561_15)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_322281", "322281136", "story_v_out_322281.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_322281", "322281136", "story_v_out_322281.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_16 = math.max(var_561_9, arg_558_1.talkMaxDuration)

			if var_561_8 <= arg_558_1.time_ and arg_558_1.time_ < var_561_8 + var_561_16 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_8) / var_561_16

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_8 + var_561_16 and arg_558_1.time_ < var_561_8 + var_561_16 + arg_561_0 then
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
			if arg_562_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_565_0 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_562_1.stage_.transform)

				var_565_0.name = "10131ui_story"
				var_565_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_562_1.actors_["10131ui_story"] = var_565_0

				local var_565_1 = var_565_0:GetComponentInChildren(typeof(CharacterEffect))

				var_565_1.enabled = true

				local var_565_2 = GameObjectTools.GetOrAddComponent(var_565_0, typeof(DynamicBoneHelper))

				if var_565_2 then
					var_565_2:EnableDynamicBone(false)
				end

				arg_562_1:ShowWeapon(var_565_1.transform, false)

				arg_562_1.var_["10131ui_story" .. "Animator"] = var_565_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_562_1.var_["10131ui_story" .. "Animator"].applyRootMotion = true
				arg_562_1.var_["10131ui_story" .. "LipSync"] = var_565_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_565_3 = arg_562_1.actors_["10131ui_story"].transform

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.var_.moveOldPos10131ui_story = var_565_3.localPosition
			end

			local var_565_4 = 0.001

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_4 then
				var_565_3.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_562_1.time_ - 0) / var_565_4)
				var_565_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_565_3.position).x, (manager.ui.mainCamera.transform.position - var_565_3.position).y, (manager.ui.mainCamera.transform.position - var_565_3.position).z)
				var_565_3.localEulerAngles.z = 0
				var_565_3.localEulerAngles.x = 0
				var_565_3.localEulerAngles = var_565_3.localEulerAngles
			end

			if arg_562_1.time_ >= 0 + var_565_4 and arg_562_1.time_ < 0 + var_565_4 + arg_565_0 then
				var_565_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_565_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_565_3.position).x, (manager.ui.mainCamera.transform.position - var_565_3.position).y, (manager.ui.mainCamera.transform.position - var_565_3.position).z)
				var_565_3.localEulerAngles.z = 0
				var_565_3.localEulerAngles.x = 0
				var_565_3.localEulerAngles = var_565_3.localEulerAngles
			end

			local var_565_5 = arg_562_1.actors_["6056ui_story"].transform

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.var_.moveOldPos6056ui_story = var_565_5.localPosition
			end

			local var_565_6 = 0.001

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_6 then
				var_565_5.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos6056ui_story, Vector3.New(-0.85, -1.16, -6.15), (arg_562_1.time_ - 0) / var_565_6)
				var_565_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_565_5.position).x, (manager.ui.mainCamera.transform.position - var_565_5.position).y, (manager.ui.mainCamera.transform.position - var_565_5.position).z)
				var_565_5.localEulerAngles.z = 0
				var_565_5.localEulerAngles.x = 0
				var_565_5.localEulerAngles = var_565_5.localEulerAngles
			end

			if arg_562_1.time_ >= 0 + var_565_6 and arg_562_1.time_ < 0 + var_565_6 + arg_565_0 then
				var_565_5.localPosition = Vector3.New(-0.85, -1.16, -6.15)
				var_565_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_565_5.position).x, (manager.ui.mainCamera.transform.position - var_565_5.position).y, (manager.ui.mainCamera.transform.position - var_565_5.position).z)
				var_565_5.localEulerAngles.z = 0
				var_565_5.localEulerAngles.x = 0
				var_565_5.localEulerAngles = var_565_5.localEulerAngles
			end

			local var_565_7 = arg_562_1.actors_["10131ui_story"]

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(var_565_7) and arg_562_1.var_.characterEffect10131ui_story == nil then
				arg_562_1.var_.characterEffect10131ui_story = var_565_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_8 = 0.200000002980232

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_8 and not isNil(var_565_7) then
				if arg_562_1.var_.characterEffect10131ui_story and not isNil(var_565_7) then
					arg_562_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= 0 + var_565_8 and arg_562_1.time_ < 0 + var_565_8 + arg_565_0 and not isNil(var_565_7) and arg_562_1.var_.characterEffect10131ui_story then
				arg_562_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_565_10 = arg_562_1.actors_["6056ui_story"]

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(var_565_10) and arg_562_1.var_.characterEffect6056ui_story == nil then
				arg_562_1.var_.characterEffect6056ui_story = var_565_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_11 = 0.200000002980232

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_11 and not isNil(var_565_10) then
				if arg_562_1.var_.characterEffect6056ui_story and not isNil(var_565_10) then
					arg_562_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_562_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_562_1.time_ - 0) / var_565_11)
				end
			end

			if arg_562_1.time_ >= 0 + var_565_11 and arg_562_1.time_ < 0 + var_565_11 + arg_565_0 and not isNil(var_565_10) and arg_562_1.var_.characterEffect6056ui_story then
				arg_562_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_562_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_565_12 = 0
			local var_565_13 = 0.175

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_12 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_14 = arg_562_1:GetWordFromCfg(322281137)
				local var_565_15 = arg_562_1:FormatText(var_565_14.content)

				arg_562_1.text_.text = var_565_15

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_17 = 7 <= 0 and var_565_13 or var_565_13 * (utf8.len(var_565_15) / 7)

				if (7 <= 0 and var_565_13 or var_565_13 * (utf8.len(var_565_15) / 7)) > 0 and var_565_13 < var_565_17 then
					arg_562_1.talkMaxDuration = var_565_17

					if var_565_17 + var_565_12 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_17 + var_565_12
					end
				end

				arg_562_1.text_.text = var_565_15
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281137", "story_v_out_322281.awb") ~= 0 then
					local var_565_18 = manager.audio:GetVoiceLength("story_v_out_322281", "322281137", "story_v_out_322281.awb") / 1000

					if var_565_18 + var_565_12 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_18 + var_565_12
					end

					if var_565_14.prefab_name ~= "" and arg_562_1.actors_[var_565_14.prefab_name] ~= nil then
						local var_565_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_14.prefab_name].transform, "story_v_out_322281", "322281137", "story_v_out_322281.awb")

						arg_562_1:RecordAudio("322281137", var_565_19)
						arg_562_1:RecordAudio("322281137", var_565_19)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_322281", "322281137", "story_v_out_322281.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_322281", "322281137", "story_v_out_322281.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_20 = math.max(var_565_13, arg_562_1.talkMaxDuration)

			if var_565_12 <= arg_562_1.time_ and arg_562_1.time_ < var_565_12 + var_565_20 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_12) / var_565_20

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_12 + var_565_20 and arg_562_1.time_ < var_565_12 + var_565_20 + arg_565_0 then
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
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(arg_566_1.actors_["6056ui_story"]) and arg_566_1.var_.characterEffect6056ui_story == nil then
				arg_566_1.var_.characterEffect6056ui_story = arg_566_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_0 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 and not isNil(arg_566_1.actors_["6056ui_story"]) then
				if arg_566_1.var_.characterEffect6056ui_story and not isNil(arg_566_1.actors_["6056ui_story"]) then
					arg_566_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 and not isNil(arg_566_1.actors_["6056ui_story"]) and arg_566_1.var_.characterEffect6056ui_story then
				arg_566_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_569_2 = arg_566_1.actors_["10131ui_story"]

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(var_569_2) and arg_566_1.var_.characterEffect10131ui_story == nil then
				arg_566_1.var_.characterEffect10131ui_story = var_569_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_3 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_3 and not isNil(var_569_2) then
				if arg_566_1.var_.characterEffect10131ui_story and not isNil(var_569_2) then
					arg_566_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_566_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_566_1.time_ - 0) / var_569_3)
				end
			end

			if arg_566_1.time_ >= 0 + var_569_3 and arg_566_1.time_ < 0 + var_569_3 + arg_569_0 and not isNil(var_569_2) and arg_566_1.var_.characterEffect10131ui_story then
				arg_566_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_566_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action5_1")
			end

			local var_569_4 = 0
			local var_569_5 = 0.725

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_4 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_6 = arg_566_1:GetWordFromCfg(322281138)
				local var_569_7 = arg_566_1:FormatText(var_569_6.content)

				arg_566_1.text_.text = var_569_7

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_9 = 29 <= 0 and var_569_5 or var_569_5 * (utf8.len(var_569_7) / 29)

				if (29 <= 0 and var_569_5 or var_569_5 * (utf8.len(var_569_7) / 29)) > 0 and var_569_5 < var_569_9 then
					arg_566_1.talkMaxDuration = var_569_9

					if var_569_9 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_9 + var_569_4
					end
				end

				arg_566_1.text_.text = var_569_7
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281138", "story_v_out_322281.awb") ~= 0 then
					local var_569_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281138", "story_v_out_322281.awb") / 1000

					if var_569_10 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_10 + var_569_4
					end

					if var_569_6.prefab_name ~= "" and arg_566_1.actors_[var_569_6.prefab_name] ~= nil then
						local var_569_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_6.prefab_name].transform, "story_v_out_322281", "322281138", "story_v_out_322281.awb")

						arg_566_1:RecordAudio("322281138", var_569_11)
						arg_566_1:RecordAudio("322281138", var_569_11)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_322281", "322281138", "story_v_out_322281.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_322281", "322281138", "story_v_out_322281.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_12 = math.max(var_569_5, arg_566_1.talkMaxDuration)

			if var_569_4 <= arg_566_1.time_ and arg_566_1.time_ < var_569_4 + var_569_12 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_4) / var_569_12

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_4 + var_569_12 and arg_566_1.time_ < var_569_4 + var_569_12 + arg_569_0 then
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
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_573_0 = 0
			local var_573_1 = 0.35

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_2 = arg_570_1:GetWordFromCfg(322281139)
				local var_573_3 = arg_570_1:FormatText(var_573_2.content)

				arg_570_1.text_.text = var_573_3

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_5 = 14 <= 0 and var_573_1 or var_573_1 * (utf8.len(var_573_3) / 14)

				if (14 <= 0 and var_573_1 or var_573_1 * (utf8.len(var_573_3) / 14)) > 0 and var_573_1 < var_573_5 then
					arg_570_1.talkMaxDuration = var_573_5

					if var_573_5 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_5 + var_573_0
					end
				end

				arg_570_1.text_.text = var_573_3
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281139", "story_v_out_322281.awb") ~= 0 then
					local var_573_6 = manager.audio:GetVoiceLength("story_v_out_322281", "322281139", "story_v_out_322281.awb") / 1000

					if var_573_6 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_6 + var_573_0
					end

					if var_573_2.prefab_name ~= "" and arg_570_1.actors_[var_573_2.prefab_name] ~= nil then
						local var_573_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_2.prefab_name].transform, "story_v_out_322281", "322281139", "story_v_out_322281.awb")

						arg_570_1:RecordAudio("322281139", var_573_7)
						arg_570_1:RecordAudio("322281139", var_573_7)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_322281", "322281139", "story_v_out_322281.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_322281", "322281139", "story_v_out_322281.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_8 = math.max(var_573_1, arg_570_1.talkMaxDuration)

			if var_573_0 <= arg_570_1.time_ and arg_570_1.time_ < var_573_0 + var_573_8 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_0) / var_573_8

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_0 + var_573_8 and arg_570_1.time_ < var_573_0 + var_573_8 + arg_573_0 then
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
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["10131ui_story"]) and arg_574_1.var_.characterEffect10131ui_story == nil then
				arg_574_1.var_.characterEffect10131ui_story = arg_574_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_0 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["10131ui_story"]) then
				if arg_574_1.var_.characterEffect10131ui_story and not isNil(arg_574_1.actors_["10131ui_story"]) then
					arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["10131ui_story"]) and arg_574_1.var_.characterEffect10131ui_story then
				arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_577_2 = arg_574_1.actors_["6056ui_story"]

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(var_577_2) and arg_574_1.var_.characterEffect6056ui_story == nil then
				arg_574_1.var_.characterEffect6056ui_story = var_577_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_3 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_3 and not isNil(var_577_2) then
				if arg_574_1.var_.characterEffect6056ui_story and not isNil(var_577_2) then
					arg_574_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_574_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_574_1.time_ - 0) / var_577_3)
				end
			end

			if arg_574_1.time_ >= 0 + var_577_3 and arg_574_1.time_ < 0 + var_577_3 + arg_577_0 and not isNil(var_577_2) and arg_574_1.var_.characterEffect6056ui_story then
				arg_574_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_574_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_577_4 = 0
			local var_577_5 = 0.325

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_4 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_6 = arg_574_1:GetWordFromCfg(322281140)
				local var_577_7 = arg_574_1:FormatText(var_577_6.content)

				arg_574_1.text_.text = var_577_7

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_9 = 13 <= 0 and var_577_5 or var_577_5 * (utf8.len(var_577_7) / 13)

				if (13 <= 0 and var_577_5 or var_577_5 * (utf8.len(var_577_7) / 13)) > 0 and var_577_5 < var_577_9 then
					arg_574_1.talkMaxDuration = var_577_9

					if var_577_9 + var_577_4 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_9 + var_577_4
					end
				end

				arg_574_1.text_.text = var_577_7
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281140", "story_v_out_322281.awb") ~= 0 then
					local var_577_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281140", "story_v_out_322281.awb") / 1000

					if var_577_10 + var_577_4 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_10 + var_577_4
					end

					if var_577_6.prefab_name ~= "" and arg_574_1.actors_[var_577_6.prefab_name] ~= nil then
						local var_577_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_6.prefab_name].transform, "story_v_out_322281", "322281140", "story_v_out_322281.awb")

						arg_574_1:RecordAudio("322281140", var_577_11)
						arg_574_1:RecordAudio("322281140", var_577_11)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_out_322281", "322281140", "story_v_out_322281.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_out_322281", "322281140", "story_v_out_322281.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_12 = math.max(var_577_5, arg_574_1.talkMaxDuration)

			if var_577_4 <= arg_574_1.time_ and arg_574_1.time_ < var_577_4 + var_577_12 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_4) / var_577_12

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_4 + var_577_12 and arg_574_1.time_ < var_577_4 + var_577_12 + arg_577_0 then
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
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(arg_578_1.actors_["6056ui_story"]) and arg_578_1.var_.characterEffect6056ui_story == nil then
				arg_578_1.var_.characterEffect6056ui_story = arg_578_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_0 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 and not isNil(arg_578_1.actors_["6056ui_story"]) then
				if arg_578_1.var_.characterEffect6056ui_story and not isNil(arg_578_1.actors_["6056ui_story"]) then
					arg_578_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 and not isNil(arg_578_1.actors_["6056ui_story"]) and arg_578_1.var_.characterEffect6056ui_story then
				arg_578_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_581_2 = arg_578_1.actors_["10131ui_story"]

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(var_581_2) and arg_578_1.var_.characterEffect10131ui_story == nil then
				arg_578_1.var_.characterEffect10131ui_story = var_581_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_3 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_3 and not isNil(var_581_2) then
				if arg_578_1.var_.characterEffect10131ui_story and not isNil(var_581_2) then
					arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_578_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_578_1.time_ - 0) / var_581_3)
				end
			end

			if arg_578_1.time_ >= 0 + var_581_3 and arg_578_1.time_ < 0 + var_581_3 + arg_581_0 and not isNil(var_581_2) and arg_578_1.var_.characterEffect10131ui_story then
				arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_578_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action5_2")
			end

			local var_581_4 = 0
			local var_581_5 = 0.225

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_4 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_6 = arg_578_1:GetWordFromCfg(322281141)
				local var_581_7 = arg_578_1:FormatText(var_581_6.content)

				arg_578_1.text_.text = var_581_7

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_9 = 9 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 9)

				if (9 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 9)) > 0 and var_581_5 < var_581_9 then
					arg_578_1.talkMaxDuration = var_581_9

					if var_581_9 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_9 + var_581_4
					end
				end

				arg_578_1.text_.text = var_581_7
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281141", "story_v_out_322281.awb") ~= 0 then
					local var_581_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281141", "story_v_out_322281.awb") / 1000

					if var_581_10 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_10 + var_581_4
					end

					if var_581_6.prefab_name ~= "" and arg_578_1.actors_[var_581_6.prefab_name] ~= nil then
						local var_581_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_6.prefab_name].transform, "story_v_out_322281", "322281141", "story_v_out_322281.awb")

						arg_578_1:RecordAudio("322281141", var_581_11)
						arg_578_1:RecordAudio("322281141", var_581_11)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_322281", "322281141", "story_v_out_322281.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_322281", "322281141", "story_v_out_322281.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_12 = math.max(var_581_5, arg_578_1.talkMaxDuration)

			if var_581_4 <= arg_578_1.time_ and arg_578_1.time_ < var_581_4 + var_581_12 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_4) / var_581_12

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_4 + var_581_12 and arg_578_1.time_ < var_581_4 + var_581_12 + arg_581_0 then
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
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.var_.moveOldPos6056ui_story = arg_582_1.actors_["6056ui_story"].transform.localPosition
			end

			local var_585_0 = 0.001

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 then
				arg_582_1.actors_["6056ui_story"].transform.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos6056ui_story, Vector3.New(0, 100, 0), (arg_582_1.time_ - 0) / var_585_0)
				arg_582_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["6056ui_story"].transform.position).z)
				arg_582_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["6056ui_story"].transform.localEulerAngles = arg_582_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 then
				arg_582_1.actors_["6056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_582_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["6056ui_story"].transform.position).z)
				arg_582_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["6056ui_story"].transform.localEulerAngles = arg_582_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			local var_585_1 = arg_582_1.actors_["10131ui_story"].transform

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.var_.moveOldPos10131ui_story = var_585_1.localPosition
			end

			local var_585_2 = 0.001

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_2 then
				var_585_1.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_582_1.time_ - 0) / var_585_2)
				var_585_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_585_1.position).x, (manager.ui.mainCamera.transform.position - var_585_1.position).y, (manager.ui.mainCamera.transform.position - var_585_1.position).z)
				var_585_1.localEulerAngles.z = 0
				var_585_1.localEulerAngles.x = 0
				var_585_1.localEulerAngles = var_585_1.localEulerAngles
			end

			if arg_582_1.time_ >= 0 + var_585_2 and arg_582_1.time_ < 0 + var_585_2 + arg_585_0 then
				var_585_1.localPosition = Vector3.New(0, 100, 0)
				var_585_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_585_1.position).x, (manager.ui.mainCamera.transform.position - var_585_1.position).y, (manager.ui.mainCamera.transform.position - var_585_1.position).z)
				var_585_1.localEulerAngles.z = 0
				var_585_1.localEulerAngles.x = 0
				var_585_1.localEulerAngles = var_585_1.localEulerAngles
			end

			local var_585_3 = 0
			local var_585_4 = 1.475

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_3 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_5 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(322281142).content)

				arg_582_1.text_.text = var_585_5

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_7 = 59 <= 0 and var_585_4 or var_585_4 * (utf8.len(var_585_5) / 59)

				if (59 <= 0 and var_585_4 or var_585_4 * (utf8.len(var_585_5) / 59)) > 0 and var_585_4 < var_585_7 then
					arg_582_1.talkMaxDuration = var_585_7

					if var_585_7 + var_585_3 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_7 + var_585_3
					end
				end

				arg_582_1.text_.text = var_585_5
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_8 = math.max(var_585_4, arg_582_1.talkMaxDuration)

			if var_585_3 <= arg_582_1.time_ and arg_582_1.time_ < var_585_3 + var_585_8 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_3) / var_585_8

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_3 + var_585_8 and arg_582_1.time_ < var_585_3 + var_585_8 + arg_585_0 then
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
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 and not isNil(arg_586_1.actors_["10131ui_story"]) and arg_586_1.var_.characterEffect10131ui_story == nil then
				arg_586_1.var_.characterEffect10131ui_story = arg_586_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_0 = 0.200000002980232

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 and not isNil(arg_586_1.actors_["10131ui_story"]) then
				if arg_586_1.var_.characterEffect10131ui_story and not isNil(arg_586_1.actors_["10131ui_story"]) then
					arg_586_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 and not isNil(arg_586_1.actors_["10131ui_story"]) and arg_586_1.var_.characterEffect10131ui_story then
				arg_586_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_589_2 = arg_586_1.actors_["10131ui_story"].transform

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.var_.moveOldPos10131ui_story = var_589_2.localPosition
			end

			local var_589_3 = 0.001

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_3 then
				var_589_2.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_586_1.time_ - 0) / var_589_3)
				var_589_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_589_2.position).x, (manager.ui.mainCamera.transform.position - var_589_2.position).y, (manager.ui.mainCamera.transform.position - var_589_2.position).z)
				var_589_2.localEulerAngles.z = 0
				var_589_2.localEulerAngles.x = 0
				var_589_2.localEulerAngles = var_589_2.localEulerAngles
			end

			if arg_586_1.time_ >= 0 + var_589_3 and arg_586_1.time_ < 0 + var_589_3 + arg_589_0 then
				var_589_2.localPosition = Vector3.New(0.05, -0.96, -5.8)
				var_589_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_589_2.position).x, (manager.ui.mainCamera.transform.position - var_589_2.position).y, (manager.ui.mainCamera.transform.position - var_589_2.position).z)
				var_589_2.localEulerAngles.z = 0
				var_589_2.localEulerAngles.x = 0
				var_589_2.localEulerAngles = var_589_2.localEulerAngles
			end

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_589_4 = 0
			local var_589_5 = 0.2

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_4 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_6 = arg_586_1:GetWordFromCfg(322281143)
				local var_589_7 = arg_586_1:FormatText(var_589_6.content)

				arg_586_1.text_.text = var_589_7

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_9 = 8 <= 0 and var_589_5 or var_589_5 * (utf8.len(var_589_7) / 8)

				if (8 <= 0 and var_589_5 or var_589_5 * (utf8.len(var_589_7) / 8)) > 0 and var_589_5 < var_589_9 then
					arg_586_1.talkMaxDuration = var_589_9

					if var_589_9 + var_589_4 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_9 + var_589_4
					end
				end

				arg_586_1.text_.text = var_589_7
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281143", "story_v_out_322281.awb") ~= 0 then
					local var_589_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281143", "story_v_out_322281.awb") / 1000

					if var_589_10 + var_589_4 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_10 + var_589_4
					end

					if var_589_6.prefab_name ~= "" and arg_586_1.actors_[var_589_6.prefab_name] ~= nil then
						local var_589_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_6.prefab_name].transform, "story_v_out_322281", "322281143", "story_v_out_322281.awb")

						arg_586_1:RecordAudio("322281143", var_589_11)
						arg_586_1:RecordAudio("322281143", var_589_11)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_322281", "322281143", "story_v_out_322281.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_322281", "322281143", "story_v_out_322281.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_12 = math.max(var_589_5, arg_586_1.talkMaxDuration)

			if var_589_4 <= arg_586_1.time_ and arg_586_1.time_ < var_589_4 + var_589_12 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_4) / var_589_12

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_4 + var_589_12 and arg_586_1.time_ < var_589_4 + var_589_12 + arg_589_0 then
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
			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 and not isNil(arg_590_1.actors_["6056ui_story"]) and arg_590_1.var_.characterEffect6056ui_story == nil then
				arg_590_1.var_.characterEffect6056ui_story = arg_590_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_0 = 0.200000002980232

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_0 and not isNil(arg_590_1.actors_["6056ui_story"]) then
				if arg_590_1.var_.characterEffect6056ui_story and not isNil(arg_590_1.actors_["6056ui_story"]) then
					arg_590_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_590_1.time_ >= 0 + var_593_0 and arg_590_1.time_ < 0 + var_593_0 + arg_593_0 and not isNil(arg_590_1.actors_["6056ui_story"]) and arg_590_1.var_.characterEffect6056ui_story then
				arg_590_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_593_2 = arg_590_1.actors_["10131ui_story"]

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 and not isNil(var_593_2) and arg_590_1.var_.characterEffect10131ui_story == nil then
				arg_590_1.var_.characterEffect10131ui_story = var_593_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_3 = 0.200000002980232

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_3 and not isNil(var_593_2) then
				if arg_590_1.var_.characterEffect10131ui_story and not isNil(var_593_2) then
					arg_590_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_590_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_590_1.time_ - 0) / var_593_3)
				end
			end

			if arg_590_1.time_ >= 0 + var_593_3 and arg_590_1.time_ < 0 + var_593_3 + arg_593_0 and not isNil(var_593_2) and arg_590_1.var_.characterEffect10131ui_story then
				arg_590_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_590_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_593_4 = arg_590_1.actors_["6056ui_story"].transform

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.var_.moveOldPos6056ui_story = var_593_4.localPosition
			end

			local var_593_5 = 0.001

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_5 then
				var_593_4.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos6056ui_story, Vector3.New(0.95, -1.16, -6.15), (arg_590_1.time_ - 0) / var_593_5)
				var_593_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_593_4.position).x, (manager.ui.mainCamera.transform.position - var_593_4.position).y, (manager.ui.mainCamera.transform.position - var_593_4.position).z)
				var_593_4.localEulerAngles.z = 0
				var_593_4.localEulerAngles.x = 0
				var_593_4.localEulerAngles = var_593_4.localEulerAngles
			end

			if arg_590_1.time_ >= 0 + var_593_5 and arg_590_1.time_ < 0 + var_593_5 + arg_593_0 then
				var_593_4.localPosition = Vector3.New(0.95, -1.16, -6.15)
				var_593_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_593_4.position).x, (manager.ui.mainCamera.transform.position - var_593_4.position).y, (manager.ui.mainCamera.transform.position - var_593_4.position).z)
				var_593_4.localEulerAngles.z = 0
				var_593_4.localEulerAngles.x = 0
				var_593_4.localEulerAngles = var_593_4.localEulerAngles
			end

			local var_593_6 = arg_590_1.actors_["10131ui_story"].transform

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.var_.moveOldPos10131ui_story = var_593_6.localPosition
			end

			local var_593_7 = 0.001

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_7 then
				var_593_6.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_590_1.time_ - 0) / var_593_7)
				var_593_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_593_6.position).x, (manager.ui.mainCamera.transform.position - var_593_6.position).y, (manager.ui.mainCamera.transform.position - var_593_6.position).z)
				var_593_6.localEulerAngles.z = 0
				var_593_6.localEulerAngles.x = 0
				var_593_6.localEulerAngles = var_593_6.localEulerAngles
			end

			if arg_590_1.time_ >= 0 + var_593_7 and arg_590_1.time_ < 0 + var_593_7 + arg_593_0 then
				var_593_6.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				var_593_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_593_6.position).x, (manager.ui.mainCamera.transform.position - var_593_6.position).y, (manager.ui.mainCamera.transform.position - var_593_6.position).z)
				var_593_6.localEulerAngles.z = 0
				var_593_6.localEulerAngles.x = 0
				var_593_6.localEulerAngles = var_593_6.localEulerAngles
			end

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			local var_593_8 = 0
			local var_593_9 = 0.15

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_8 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_10 = arg_590_1:GetWordFromCfg(322281144)
				local var_593_11 = arg_590_1:FormatText(var_593_10.content)

				arg_590_1.text_.text = var_593_11

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_13 = 6 <= 0 and var_593_9 or var_593_9 * (utf8.len(var_593_11) / 6)

				if (6 <= 0 and var_593_9 or var_593_9 * (utf8.len(var_593_11) / 6)) > 0 and var_593_9 < var_593_13 then
					arg_590_1.talkMaxDuration = var_593_13

					if var_593_13 + var_593_8 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_13 + var_593_8
					end
				end

				arg_590_1.text_.text = var_593_11
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281144", "story_v_out_322281.awb") ~= 0 then
					local var_593_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281144", "story_v_out_322281.awb") / 1000

					if var_593_14 + var_593_8 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_14 + var_593_8
					end

					if var_593_10.prefab_name ~= "" and arg_590_1.actors_[var_593_10.prefab_name] ~= nil then
						local var_593_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_10.prefab_name].transform, "story_v_out_322281", "322281144", "story_v_out_322281.awb")

						arg_590_1:RecordAudio("322281144", var_593_15)
						arg_590_1:RecordAudio("322281144", var_593_15)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_out_322281", "322281144", "story_v_out_322281.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_out_322281", "322281144", "story_v_out_322281.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_16 = math.max(var_593_9, arg_590_1.talkMaxDuration)

			if var_593_8 <= arg_590_1.time_ and arg_590_1.time_ < var_593_8 + var_593_16 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_8) / var_593_16

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_8 + var_593_16 and arg_590_1.time_ < var_593_8 + var_593_16 + arg_593_0 then
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
			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 and not isNil(arg_594_1.actors_["10131ui_story"]) and arg_594_1.var_.characterEffect10131ui_story == nil then
				arg_594_1.var_.characterEffect10131ui_story = arg_594_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_0 = 0.200000002980232

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_0 and not isNil(arg_594_1.actors_["10131ui_story"]) then
				if arg_594_1.var_.characterEffect10131ui_story and not isNil(arg_594_1.actors_["10131ui_story"]) then
					arg_594_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= 0 + var_597_0 and arg_594_1.time_ < 0 + var_597_0 + arg_597_0 and not isNil(arg_594_1.actors_["10131ui_story"]) and arg_594_1.var_.characterEffect10131ui_story then
				arg_594_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_597_2 = arg_594_1.actors_["6056ui_story"]

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 and not isNil(var_597_2) and arg_594_1.var_.characterEffect6056ui_story == nil then
				arg_594_1.var_.characterEffect6056ui_story = var_597_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_3 = 0.200000002980232

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_3 and not isNil(var_597_2) then
				if arg_594_1.var_.characterEffect6056ui_story and not isNil(var_597_2) then
					arg_594_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_594_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_594_1.time_ - 0) / var_597_3)
				end
			end

			if arg_594_1.time_ >= 0 + var_597_3 and arg_594_1.time_ < 0 + var_597_3 + arg_597_0 and not isNil(var_597_2) and arg_594_1.var_.characterEffect6056ui_story then
				arg_594_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_594_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_597_4 = 0
			local var_597_5 = 0.65

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_4 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_6 = arg_594_1:GetWordFromCfg(322281145)
				local var_597_7 = arg_594_1:FormatText(var_597_6.content)

				arg_594_1.text_.text = var_597_7

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_9 = 26 <= 0 and var_597_5 or var_597_5 * (utf8.len(var_597_7) / 26)

				if (26 <= 0 and var_597_5 or var_597_5 * (utf8.len(var_597_7) / 26)) > 0 and var_597_5 < var_597_9 then
					arg_594_1.talkMaxDuration = var_597_9

					if var_597_9 + var_597_4 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_9 + var_597_4
					end
				end

				arg_594_1.text_.text = var_597_7
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281145", "story_v_out_322281.awb") ~= 0 then
					local var_597_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281145", "story_v_out_322281.awb") / 1000

					if var_597_10 + var_597_4 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_10 + var_597_4
					end

					if var_597_6.prefab_name ~= "" and arg_594_1.actors_[var_597_6.prefab_name] ~= nil then
						local var_597_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_6.prefab_name].transform, "story_v_out_322281", "322281145", "story_v_out_322281.awb")

						arg_594_1:RecordAudio("322281145", var_597_11)
						arg_594_1:RecordAudio("322281145", var_597_11)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_out_322281", "322281145", "story_v_out_322281.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_out_322281", "322281145", "story_v_out_322281.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_12 = math.max(var_597_5, arg_594_1.talkMaxDuration)

			if var_597_4 <= arg_594_1.time_ and arg_594_1.time_ < var_597_4 + var_597_12 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_4) / var_597_12

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_4 + var_597_12 and arg_594_1.time_ < var_597_4 + var_597_12 + arg_597_0 then
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
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(arg_598_1.actors_["6056ui_story"]) and arg_598_1.var_.characterEffect6056ui_story == nil then
				arg_598_1.var_.characterEffect6056ui_story = arg_598_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_0 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 and not isNil(arg_598_1.actors_["6056ui_story"]) then
				if arg_598_1.var_.characterEffect6056ui_story and not isNil(arg_598_1.actors_["6056ui_story"]) then
					arg_598_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 and not isNil(arg_598_1.actors_["6056ui_story"]) and arg_598_1.var_.characterEffect6056ui_story then
				arg_598_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_601_2 = arg_598_1.actors_["10131ui_story"]

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(var_601_2) and arg_598_1.var_.characterEffect10131ui_story == nil then
				arg_598_1.var_.characterEffect10131ui_story = var_601_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_3 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_3 and not isNil(var_601_2) then
				if arg_598_1.var_.characterEffect10131ui_story and not isNil(var_601_2) then
					arg_598_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_598_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_598_1.time_ - 0) / var_601_3)
				end
			end

			if arg_598_1.time_ >= 0 + var_601_3 and arg_598_1.time_ < 0 + var_601_3 + arg_601_0 and not isNil(var_601_2) and arg_598_1.var_.characterEffect10131ui_story then
				arg_598_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_598_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_1")
			end

			local var_601_4 = 0
			local var_601_5 = 0.25

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_4 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_6 = arg_598_1:GetWordFromCfg(322281146)
				local var_601_7 = arg_598_1:FormatText(var_601_6.content)

				arg_598_1.text_.text = var_601_7

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_9 = 10 <= 0 and var_601_5 or var_601_5 * (utf8.len(var_601_7) / 10)

				if (10 <= 0 and var_601_5 or var_601_5 * (utf8.len(var_601_7) / 10)) > 0 and var_601_5 < var_601_9 then
					arg_598_1.talkMaxDuration = var_601_9

					if var_601_9 + var_601_4 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_9 + var_601_4
					end
				end

				arg_598_1.text_.text = var_601_7
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281146", "story_v_out_322281.awb") ~= 0 then
					local var_601_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281146", "story_v_out_322281.awb") / 1000

					if var_601_10 + var_601_4 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_10 + var_601_4
					end

					if var_601_6.prefab_name ~= "" and arg_598_1.actors_[var_601_6.prefab_name] ~= nil then
						local var_601_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_6.prefab_name].transform, "story_v_out_322281", "322281146", "story_v_out_322281.awb")

						arg_598_1:RecordAudio("322281146", var_601_11)
						arg_598_1:RecordAudio("322281146", var_601_11)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_out_322281", "322281146", "story_v_out_322281.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_out_322281", "322281146", "story_v_out_322281.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_12 = math.max(var_601_5, arg_598_1.talkMaxDuration)

			if var_601_4 <= arg_598_1.time_ and arg_598_1.time_ < var_601_4 + var_601_12 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_4) / var_601_12

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_4 + var_601_12 and arg_598_1.time_ < var_601_4 + var_601_12 + arg_601_0 then
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
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 and not isNil(arg_602_1.actors_["10131ui_story"]) and arg_602_1.var_.characterEffect10131ui_story == nil then
				arg_602_1.var_.characterEffect10131ui_story = arg_602_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_0 = 0.200000002980232

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_0 and not isNil(arg_602_1.actors_["10131ui_story"]) then
				if arg_602_1.var_.characterEffect10131ui_story and not isNil(arg_602_1.actors_["10131ui_story"]) then
					arg_602_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_602_1.time_ >= 0 + var_605_0 and arg_602_1.time_ < 0 + var_605_0 + arg_605_0 and not isNil(arg_602_1.actors_["10131ui_story"]) and arg_602_1.var_.characterEffect10131ui_story then
				arg_602_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_605_2 = arg_602_1.actors_["6056ui_story"]

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 and not isNil(var_605_2) and arg_602_1.var_.characterEffect6056ui_story == nil then
				arg_602_1.var_.characterEffect6056ui_story = var_605_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_3 = 0.200000002980232

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_3 and not isNil(var_605_2) then
				if arg_602_1.var_.characterEffect6056ui_story and not isNil(var_605_2) then
					arg_602_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_602_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_602_1.time_ - 0) / var_605_3)
				end
			end

			if arg_602_1.time_ >= 0 + var_605_3 and arg_602_1.time_ < 0 + var_605_3 + arg_605_0 and not isNil(var_605_2) and arg_602_1.var_.characterEffect6056ui_story then
				arg_602_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_602_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_605_4 = 0
			local var_605_5 = 0.775

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_4 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_6 = arg_602_1:GetWordFromCfg(322281147)
				local var_605_7 = arg_602_1:FormatText(var_605_6.content)

				arg_602_1.text_.text = var_605_7

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_9 = 31 <= 0 and var_605_5 or var_605_5 * (utf8.len(var_605_7) / 31)

				if (31 <= 0 and var_605_5 or var_605_5 * (utf8.len(var_605_7) / 31)) > 0 and var_605_5 < var_605_9 then
					arg_602_1.talkMaxDuration = var_605_9

					if var_605_9 + var_605_4 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_9 + var_605_4
					end
				end

				arg_602_1.text_.text = var_605_7
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281147", "story_v_out_322281.awb") ~= 0 then
					local var_605_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281147", "story_v_out_322281.awb") / 1000

					if var_605_10 + var_605_4 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_10 + var_605_4
					end

					if var_605_6.prefab_name ~= "" and arg_602_1.actors_[var_605_6.prefab_name] ~= nil then
						local var_605_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_6.prefab_name].transform, "story_v_out_322281", "322281147", "story_v_out_322281.awb")

						arg_602_1:RecordAudio("322281147", var_605_11)
						arg_602_1:RecordAudio("322281147", var_605_11)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_out_322281", "322281147", "story_v_out_322281.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_out_322281", "322281147", "story_v_out_322281.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_12 = math.max(var_605_5, arg_602_1.talkMaxDuration)

			if var_605_4 <= arg_602_1.time_ and arg_602_1.time_ < var_605_4 + var_605_12 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_4) / var_605_12

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_4 + var_605_12 and arg_602_1.time_ < var_605_4 + var_605_12 + arg_605_0 then
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
			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 and not isNil(arg_606_1.actors_["6056ui_story"]) and arg_606_1.var_.characterEffect6056ui_story == nil then
				arg_606_1.var_.characterEffect6056ui_story = arg_606_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_0 = 0.200000002980232

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_0 and not isNil(arg_606_1.actors_["6056ui_story"]) then
				if arg_606_1.var_.characterEffect6056ui_story and not isNil(arg_606_1.actors_["6056ui_story"]) then
					arg_606_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_606_1.time_ >= 0 + var_609_0 and arg_606_1.time_ < 0 + var_609_0 + arg_609_0 and not isNil(arg_606_1.actors_["6056ui_story"]) and arg_606_1.var_.characterEffect6056ui_story then
				arg_606_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_609_2 = arg_606_1.actors_["10131ui_story"]

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 and not isNil(var_609_2) and arg_606_1.var_.characterEffect10131ui_story == nil then
				arg_606_1.var_.characterEffect10131ui_story = var_609_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_3 = 0.200000002980232

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_3 and not isNil(var_609_2) then
				if arg_606_1.var_.characterEffect10131ui_story and not isNil(var_609_2) then
					arg_606_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_606_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_606_1.time_ - 0) / var_609_3)
				end
			end

			if arg_606_1.time_ >= 0 + var_609_3 and arg_606_1.time_ < 0 + var_609_3 + arg_609_0 and not isNil(var_609_2) and arg_606_1.var_.characterEffect10131ui_story then
				arg_606_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_606_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_609_4 = 0
			local var_609_5 = 0.45

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_4 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				arg_606_1.leftNameTxt_.text = arg_606_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_6 = arg_606_1:GetWordFromCfg(322281148)
				local var_609_7 = arg_606_1:FormatText(var_609_6.content)

				arg_606_1.text_.text = var_609_7

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_9 = 18 <= 0 and var_609_5 or var_609_5 * (utf8.len(var_609_7) / 18)

				if (18 <= 0 and var_609_5 or var_609_5 * (utf8.len(var_609_7) / 18)) > 0 and var_609_5 < var_609_9 then
					arg_606_1.talkMaxDuration = var_609_9

					if var_609_9 + var_609_4 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_9 + var_609_4
					end
				end

				arg_606_1.text_.text = var_609_7
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281148", "story_v_out_322281.awb") ~= 0 then
					local var_609_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281148", "story_v_out_322281.awb") / 1000

					if var_609_10 + var_609_4 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_10 + var_609_4
					end

					if var_609_6.prefab_name ~= "" and arg_606_1.actors_[var_609_6.prefab_name] ~= nil then
						local var_609_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_6.prefab_name].transform, "story_v_out_322281", "322281148", "story_v_out_322281.awb")

						arg_606_1:RecordAudio("322281148", var_609_11)
						arg_606_1:RecordAudio("322281148", var_609_11)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_out_322281", "322281148", "story_v_out_322281.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_out_322281", "322281148", "story_v_out_322281.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_12 = math.max(var_609_5, arg_606_1.talkMaxDuration)

			if var_609_4 <= arg_606_1.time_ and arg_606_1.time_ < var_609_4 + var_609_12 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_4) / var_609_12

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_4 + var_609_12 and arg_606_1.time_ < var_609_4 + var_609_12 + arg_609_0 then
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
			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 and not isNil(arg_610_1.actors_["10131ui_story"]) and arg_610_1.var_.characterEffect10131ui_story == nil then
				arg_610_1.var_.characterEffect10131ui_story = arg_610_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_0 = 0.200000002980232

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_0 and not isNil(arg_610_1.actors_["10131ui_story"]) then
				if arg_610_1.var_.characterEffect10131ui_story and not isNil(arg_610_1.actors_["10131ui_story"]) then
					arg_610_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_610_1.time_ >= 0 + var_613_0 and arg_610_1.time_ < 0 + var_613_0 + arg_613_0 and not isNil(arg_610_1.actors_["10131ui_story"]) and arg_610_1.var_.characterEffect10131ui_story then
				arg_610_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_613_2 = arg_610_1.actors_["6056ui_story"]

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 and not isNil(var_613_2) and arg_610_1.var_.characterEffect6056ui_story == nil then
				arg_610_1.var_.characterEffect6056ui_story = var_613_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_3 = 0.200000002980232

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_3 and not isNil(var_613_2) then
				if arg_610_1.var_.characterEffect6056ui_story and not isNil(var_613_2) then
					arg_610_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_610_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_610_1.time_ - 0) / var_613_3)
				end
			end

			if arg_610_1.time_ >= 0 + var_613_3 and arg_610_1.time_ < 0 + var_613_3 + arg_613_0 and not isNil(var_613_2) and arg_610_1.var_.characterEffect6056ui_story then
				arg_610_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_610_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_613_4 = 0
			local var_613_5 = 0.725

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= var_613_4 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				arg_610_1.leftNameTxt_.text = arg_610_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_6 = arg_610_1:GetWordFromCfg(322281149)
				local var_613_7 = arg_610_1:FormatText(var_613_6.content)

				arg_610_1.text_.text = var_613_7

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_9 = 29 <= 0 and var_613_5 or var_613_5 * (utf8.len(var_613_7) / 29)

				if (29 <= 0 and var_613_5 or var_613_5 * (utf8.len(var_613_7) / 29)) > 0 and var_613_5 < var_613_9 then
					arg_610_1.talkMaxDuration = var_613_9

					if var_613_9 + var_613_4 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_9 + var_613_4
					end
				end

				arg_610_1.text_.text = var_613_7
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281149", "story_v_out_322281.awb") ~= 0 then
					local var_613_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281149", "story_v_out_322281.awb") / 1000

					if var_613_10 + var_613_4 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_10 + var_613_4
					end

					if var_613_6.prefab_name ~= "" and arg_610_1.actors_[var_613_6.prefab_name] ~= nil then
						local var_613_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_610_1.actors_[var_613_6.prefab_name].transform, "story_v_out_322281", "322281149", "story_v_out_322281.awb")

						arg_610_1:RecordAudio("322281149", var_613_11)
						arg_610_1:RecordAudio("322281149", var_613_11)
					else
						arg_610_1:AudioAction("play", "voice", "story_v_out_322281", "322281149", "story_v_out_322281.awb")
					end

					arg_610_1:RecordHistoryTalkVoice("story_v_out_322281", "322281149", "story_v_out_322281.awb")
				end

				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_12 = math.max(var_613_5, arg_610_1.talkMaxDuration)

			if var_613_4 <= arg_610_1.time_ and arg_610_1.time_ < var_613_4 + var_613_12 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_4) / var_613_12

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_4 + var_613_12 and arg_610_1.time_ < var_613_4 + var_613_12 + arg_613_0 then
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
			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_617_0 = 0
			local var_617_1 = 0.625

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_0 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_2 = arg_614_1:GetWordFromCfg(322281150)
				local var_617_3 = arg_614_1:FormatText(var_617_2.content)

				arg_614_1.text_.text = var_617_3

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_5 = 25 <= 0 and var_617_1 or var_617_1 * (utf8.len(var_617_3) / 25)

				if (25 <= 0 and var_617_1 or var_617_1 * (utf8.len(var_617_3) / 25)) > 0 and var_617_1 < var_617_5 then
					arg_614_1.talkMaxDuration = var_617_5

					if var_617_5 + var_617_0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_5 + var_617_0
					end
				end

				arg_614_1.text_.text = var_617_3
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281150", "story_v_out_322281.awb") ~= 0 then
					local var_617_6 = manager.audio:GetVoiceLength("story_v_out_322281", "322281150", "story_v_out_322281.awb") / 1000

					if var_617_6 + var_617_0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_6 + var_617_0
					end

					if var_617_2.prefab_name ~= "" and arg_614_1.actors_[var_617_2.prefab_name] ~= nil then
						local var_617_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_2.prefab_name].transform, "story_v_out_322281", "322281150", "story_v_out_322281.awb")

						arg_614_1:RecordAudio("322281150", var_617_7)
						arg_614_1:RecordAudio("322281150", var_617_7)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_out_322281", "322281150", "story_v_out_322281.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_out_322281", "322281150", "story_v_out_322281.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_8 = math.max(var_617_1, arg_614_1.talkMaxDuration)

			if var_617_0 <= arg_614_1.time_ and arg_614_1.time_ < var_617_0 + var_617_8 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_0) / var_617_8

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_0 + var_617_8 and arg_614_1.time_ < var_617_0 + var_617_8 + arg_617_0 then
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
			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 and not isNil(arg_618_1.actors_["6056ui_story"]) and arg_618_1.var_.characterEffect6056ui_story == nil then
				arg_618_1.var_.characterEffect6056ui_story = arg_618_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_0 = 0.200000002980232

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_0 and not isNil(arg_618_1.actors_["6056ui_story"]) then
				if arg_618_1.var_.characterEffect6056ui_story and not isNil(arg_618_1.actors_["6056ui_story"]) then
					arg_618_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_618_1.time_ >= 0 + var_621_0 and arg_618_1.time_ < 0 + var_621_0 + arg_621_0 and not isNil(arg_618_1.actors_["6056ui_story"]) and arg_618_1.var_.characterEffect6056ui_story then
				arg_618_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_621_2 = arg_618_1.actors_["10131ui_story"]

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 and not isNil(var_621_2) and arg_618_1.var_.characterEffect10131ui_story == nil then
				arg_618_1.var_.characterEffect10131ui_story = var_621_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_3 = 0.200000002980232

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_3 and not isNil(var_621_2) then
				if arg_618_1.var_.characterEffect10131ui_story and not isNil(var_621_2) then
					arg_618_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_618_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_618_1.time_ - 0) / var_621_3)
				end
			end

			if arg_618_1.time_ >= 0 + var_621_3 and arg_618_1.time_ < 0 + var_621_3 + arg_621_0 and not isNil(var_621_2) and arg_618_1.var_.characterEffect10131ui_story then
				arg_618_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_618_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_621_4 = 0
			local var_621_5 = 0.375

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= var_621_4 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_6 = arg_618_1:GetWordFromCfg(322281151)
				local var_621_7 = arg_618_1:FormatText(var_621_6.content)

				arg_618_1.text_.text = var_621_7

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_9 = 15 <= 0 and var_621_5 or var_621_5 * (utf8.len(var_621_7) / 15)

				if (15 <= 0 and var_621_5 or var_621_5 * (utf8.len(var_621_7) / 15)) > 0 and var_621_5 < var_621_9 then
					arg_618_1.talkMaxDuration = var_621_9

					if var_621_9 + var_621_4 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_9 + var_621_4
					end
				end

				arg_618_1.text_.text = var_621_7
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281151", "story_v_out_322281.awb") ~= 0 then
					local var_621_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281151", "story_v_out_322281.awb") / 1000

					if var_621_10 + var_621_4 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_10 + var_621_4
					end

					if var_621_6.prefab_name ~= "" and arg_618_1.actors_[var_621_6.prefab_name] ~= nil then
						local var_621_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_6.prefab_name].transform, "story_v_out_322281", "322281151", "story_v_out_322281.awb")

						arg_618_1:RecordAudio("322281151", var_621_11)
						arg_618_1:RecordAudio("322281151", var_621_11)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_out_322281", "322281151", "story_v_out_322281.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_out_322281", "322281151", "story_v_out_322281.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_12 = math.max(var_621_5, arg_618_1.talkMaxDuration)

			if var_621_4 <= arg_618_1.time_ and arg_618_1.time_ < var_621_4 + var_621_12 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_4) / var_621_12

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_4 + var_621_12 and arg_618_1.time_ < var_621_4 + var_621_12 + arg_621_0 then
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
			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 and not isNil(arg_622_1.actors_["10131ui_story"]) and arg_622_1.var_.characterEffect10131ui_story == nil then
				arg_622_1.var_.characterEffect10131ui_story = arg_622_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_625_0 = 0.200000002980232

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_0 and not isNil(arg_622_1.actors_["10131ui_story"]) then
				if arg_622_1.var_.characterEffect10131ui_story and not isNil(arg_622_1.actors_["10131ui_story"]) then
					arg_622_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_622_1.time_ >= 0 + var_625_0 and arg_622_1.time_ < 0 + var_625_0 + arg_625_0 and not isNil(arg_622_1.actors_["10131ui_story"]) and arg_622_1.var_.characterEffect10131ui_story then
				arg_622_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_625_2 = arg_622_1.actors_["6056ui_story"]

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 and not isNil(var_625_2) and arg_622_1.var_.characterEffect6056ui_story == nil then
				arg_622_1.var_.characterEffect6056ui_story = var_625_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_625_3 = 0.200000002980232

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_3 and not isNil(var_625_2) then
				if arg_622_1.var_.characterEffect6056ui_story and not isNil(var_625_2) then
					arg_622_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_622_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_622_1.time_ - 0) / var_625_3)
				end
			end

			if arg_622_1.time_ >= 0 + var_625_3 and arg_622_1.time_ < 0 + var_625_3 + arg_625_0 and not isNil(var_625_2) and arg_622_1.var_.characterEffect6056ui_story then
				arg_622_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_622_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_625_4 = 0
			local var_625_5 = 0.55

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= var_625_4 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_6 = arg_622_1:GetWordFromCfg(322281152)
				local var_625_7 = arg_622_1:FormatText(var_625_6.content)

				arg_622_1.text_.text = var_625_7

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_9 = 22 <= 0 and var_625_5 or var_625_5 * (utf8.len(var_625_7) / 22)

				if (22 <= 0 and var_625_5 or var_625_5 * (utf8.len(var_625_7) / 22)) > 0 and var_625_5 < var_625_9 then
					arg_622_1.talkMaxDuration = var_625_9

					if var_625_9 + var_625_4 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_9 + var_625_4
					end
				end

				arg_622_1.text_.text = var_625_7
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281152", "story_v_out_322281.awb") ~= 0 then
					local var_625_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281152", "story_v_out_322281.awb") / 1000

					if var_625_10 + var_625_4 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_10 + var_625_4
					end

					if var_625_6.prefab_name ~= "" and arg_622_1.actors_[var_625_6.prefab_name] ~= nil then
						local var_625_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_6.prefab_name].transform, "story_v_out_322281", "322281152", "story_v_out_322281.awb")

						arg_622_1:RecordAudio("322281152", var_625_11)
						arg_622_1:RecordAudio("322281152", var_625_11)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_out_322281", "322281152", "story_v_out_322281.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_out_322281", "322281152", "story_v_out_322281.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_12 = math.max(var_625_5, arg_622_1.talkMaxDuration)

			if var_625_4 <= arg_622_1.time_ and arg_622_1.time_ < var_625_4 + var_625_12 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_4) / var_625_12

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_4 + var_625_12 and arg_622_1.time_ < var_625_4 + var_625_12 + arg_625_0 then
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
			local var_629_0 = 0.35

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_1 = arg_626_1:GetWordFromCfg(322281153)
				local var_629_2 = arg_626_1:FormatText(var_629_1.content)

				arg_626_1.text_.text = var_629_2

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_4 = 14 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 14)

				if (14 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 14)) > 0 and var_629_0 < var_629_4 then
					arg_626_1.talkMaxDuration = var_629_4

					if var_629_4 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_4 + 0
					end
				end

				arg_626_1.text_.text = var_629_2
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281153", "story_v_out_322281.awb") ~= 0 then
					local var_629_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281153", "story_v_out_322281.awb") / 1000

					if var_629_5 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_5 + 0
					end

					if var_629_1.prefab_name ~= "" and arg_626_1.actors_[var_629_1.prefab_name] ~= nil then
						local var_629_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_1.prefab_name].transform, "story_v_out_322281", "322281153", "story_v_out_322281.awb")

						arg_626_1:RecordAudio("322281153", var_629_6)
						arg_626_1:RecordAudio("322281153", var_629_6)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_out_322281", "322281153", "story_v_out_322281.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_out_322281", "322281153", "story_v_out_322281.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_7 = math.max(var_629_0, arg_626_1.talkMaxDuration)

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_7 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - 0) / var_629_7

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= 0 + var_629_7 and arg_626_1.time_ < 0 + var_629_7 + arg_629_0 then
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
			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 and not isNil(arg_630_1.actors_["6056ui_story"]) and arg_630_1.var_.characterEffect6056ui_story == nil then
				arg_630_1.var_.characterEffect6056ui_story = arg_630_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_0 = 0.200000002980232

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_0 and not isNil(arg_630_1.actors_["6056ui_story"]) then
				if arg_630_1.var_.characterEffect6056ui_story and not isNil(arg_630_1.actors_["6056ui_story"]) then
					arg_630_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_630_1.time_ >= 0 + var_633_0 and arg_630_1.time_ < 0 + var_633_0 + arg_633_0 and not isNil(arg_630_1.actors_["6056ui_story"]) and arg_630_1.var_.characterEffect6056ui_story then
				arg_630_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_633_2 = arg_630_1.actors_["10131ui_story"]

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 and not isNil(var_633_2) and arg_630_1.var_.characterEffect10131ui_story == nil then
				arg_630_1.var_.characterEffect10131ui_story = var_633_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_3 = 0.200000002980232

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_3 and not isNil(var_633_2) then
				if arg_630_1.var_.characterEffect10131ui_story and not isNil(var_633_2) then
					arg_630_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_630_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_630_1.time_ - 0) / var_633_3)
				end
			end

			if arg_630_1.time_ >= 0 + var_633_3 and arg_630_1.time_ < 0 + var_633_3 + arg_633_0 and not isNil(var_633_2) and arg_630_1.var_.characterEffect10131ui_story then
				arg_630_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_630_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_2")
			end

			local var_633_4 = 0
			local var_633_5 = 0.25

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= var_633_4 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_6 = arg_630_1:GetWordFromCfg(322281154)
				local var_633_7 = arg_630_1:FormatText(var_633_6.content)

				arg_630_1.text_.text = var_633_7

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_9 = 10 <= 0 and var_633_5 or var_633_5 * (utf8.len(var_633_7) / 10)

				if (10 <= 0 and var_633_5 or var_633_5 * (utf8.len(var_633_7) / 10)) > 0 and var_633_5 < var_633_9 then
					arg_630_1.talkMaxDuration = var_633_9

					if var_633_9 + var_633_4 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_9 + var_633_4
					end
				end

				arg_630_1.text_.text = var_633_7
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281154", "story_v_out_322281.awb") ~= 0 then
					local var_633_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281154", "story_v_out_322281.awb") / 1000

					if var_633_10 + var_633_4 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_10 + var_633_4
					end

					if var_633_6.prefab_name ~= "" and arg_630_1.actors_[var_633_6.prefab_name] ~= nil then
						local var_633_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_6.prefab_name].transform, "story_v_out_322281", "322281154", "story_v_out_322281.awb")

						arg_630_1:RecordAudio("322281154", var_633_11)
						arg_630_1:RecordAudio("322281154", var_633_11)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_out_322281", "322281154", "story_v_out_322281.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_out_322281", "322281154", "story_v_out_322281.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_12 = math.max(var_633_5, arg_630_1.talkMaxDuration)

			if var_633_4 <= arg_630_1.time_ and arg_630_1.time_ < var_633_4 + var_633_12 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_4) / var_633_12

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_4 + var_633_12 and arg_630_1.time_ < var_633_4 + var_633_12 + arg_633_0 then
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
			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(arg_634_1.actors_["10131ui_story"]) and arg_634_1.var_.characterEffect10131ui_story == nil then
				arg_634_1.var_.characterEffect10131ui_story = arg_634_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_0 = 0.200000002980232

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_0 and not isNil(arg_634_1.actors_["10131ui_story"]) then
				if arg_634_1.var_.characterEffect10131ui_story and not isNil(arg_634_1.actors_["10131ui_story"]) then
					arg_634_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_634_1.time_ >= 0 + var_637_0 and arg_634_1.time_ < 0 + var_637_0 + arg_637_0 and not isNil(arg_634_1.actors_["10131ui_story"]) and arg_634_1.var_.characterEffect10131ui_story then
				arg_634_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_637_2 = arg_634_1.actors_["6056ui_story"]

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(var_637_2) and arg_634_1.var_.characterEffect6056ui_story == nil then
				arg_634_1.var_.characterEffect6056ui_story = var_637_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_3 = 0.200000002980232

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_3 and not isNil(var_637_2) then
				if arg_634_1.var_.characterEffect6056ui_story and not isNil(var_637_2) then
					arg_634_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_634_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_634_1.time_ - 0) / var_637_3)
				end
			end

			if arg_634_1.time_ >= 0 + var_637_3 and arg_634_1.time_ < 0 + var_637_3 + arg_637_0 and not isNil(var_637_2) and arg_634_1.var_.characterEffect6056ui_story then
				arg_634_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_634_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_637_4 = 0
			local var_637_5 = 0.1

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_4 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_6 = arg_634_1:GetWordFromCfg(322281155)
				local var_637_7 = arg_634_1:FormatText(var_637_6.content)

				arg_634_1.text_.text = var_637_7

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_9 = 4 <= 0 and var_637_5 or var_637_5 * (utf8.len(var_637_7) / 4)

				if (4 <= 0 and var_637_5 or var_637_5 * (utf8.len(var_637_7) / 4)) > 0 and var_637_5 < var_637_9 then
					arg_634_1.talkMaxDuration = var_637_9

					if var_637_9 + var_637_4 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_9 + var_637_4
					end
				end

				arg_634_1.text_.text = var_637_7
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281155", "story_v_out_322281.awb") ~= 0 then
					local var_637_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281155", "story_v_out_322281.awb") / 1000

					if var_637_10 + var_637_4 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_10 + var_637_4
					end

					if var_637_6.prefab_name ~= "" and arg_634_1.actors_[var_637_6.prefab_name] ~= nil then
						local var_637_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_6.prefab_name].transform, "story_v_out_322281", "322281155", "story_v_out_322281.awb")

						arg_634_1:RecordAudio("322281155", var_637_11)
						arg_634_1:RecordAudio("322281155", var_637_11)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_out_322281", "322281155", "story_v_out_322281.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_out_322281", "322281155", "story_v_out_322281.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_12 = math.max(var_637_5, arg_634_1.talkMaxDuration)

			if var_637_4 <= arg_634_1.time_ and arg_634_1.time_ < var_637_4 + var_637_12 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_4) / var_637_12

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_4 + var_637_12 and arg_634_1.time_ < var_637_4 + var_637_12 + arg_637_0 then
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
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1.var_.moveOldPos10131ui_story = arg_638_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_641_0 = 0.001

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_0 then
				arg_638_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_638_1.time_ - 0) / var_641_0)
				arg_638_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_638_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10131ui_story"].transform.position).z)
				arg_638_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_638_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_638_1.actors_["10131ui_story"].transform.localEulerAngles = arg_638_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_638_1.time_ >= 0 + var_641_0 and arg_638_1.time_ < 0 + var_641_0 + arg_641_0 then
				arg_638_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_638_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_638_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10131ui_story"].transform.position).z)
				arg_638_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_638_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_638_1.actors_["10131ui_story"].transform.localEulerAngles = arg_638_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_641_1 = arg_638_1.actors_["6056ui_story"].transform

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1.var_.moveOldPos6056ui_story = var_641_1.localPosition
			end

			local var_641_2 = 0.001

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_2 then
				var_641_1.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos6056ui_story, Vector3.New(0, 100, 0), (arg_638_1.time_ - 0) / var_641_2)
				var_641_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_641_1.position).x, (manager.ui.mainCamera.transform.position - var_641_1.position).y, (manager.ui.mainCamera.transform.position - var_641_1.position).z)
				var_641_1.localEulerAngles.z = 0
				var_641_1.localEulerAngles.x = 0
				var_641_1.localEulerAngles = var_641_1.localEulerAngles
			end

			if arg_638_1.time_ >= 0 + var_641_2 and arg_638_1.time_ < 0 + var_641_2 + arg_641_0 then
				var_641_1.localPosition = Vector3.New(0, 100, 0)
				var_641_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_641_1.position).x, (manager.ui.mainCamera.transform.position - var_641_1.position).y, (manager.ui.mainCamera.transform.position - var_641_1.position).z)
				var_641_1.localEulerAngles.z = 0
				var_641_1.localEulerAngles.x = 0
				var_641_1.localEulerAngles = var_641_1.localEulerAngles
			end

			if 0.1 < arg_638_1.time_ and arg_638_1.time_ <= 0.1 + arg_641_0 then
				arg_638_1:AudioAction("play", "effect", "se_story_140", "se_story_140_laser", "")
			end

			local var_641_4 = manager.ui.mainCamera.transform

			if 0.166666666666667 < arg_638_1.time_ and arg_638_1.time_ <= 0.166666666666667 + arg_641_0 then
				arg_638_1.var_.shakeOldPos = var_641_4.localPosition
			end

			local var_641_5 = 0.5

			if 0.166666666666667 <= arg_638_1.time_ and arg_638_1.time_ < 0.166666666666667 + var_641_5 then
				local var_641_6, var_641_7 = math.modf((arg_638_1.time_ - 0.166666666666667) / 0.066)

				var_641_4.localPosition = Vector3.New(var_641_7 * 0.13, var_641_7 * 0.13, var_641_7 * 0.13) + arg_638_1.var_.shakeOldPos
			end

			if arg_638_1.time_ >= 0.166666666666667 + var_641_5 and arg_638_1.time_ < 0.166666666666667 + var_641_5 + arg_641_0 then
				var_641_4.localPosition = arg_638_1.var_.shakeOldPos
			end

			local var_641_8 = 0
			local var_641_9 = 1.7

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_8 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, false)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_10 = arg_638_1:FormatText(arg_638_1:GetWordFromCfg(322281156).content)

				arg_638_1.text_.text = var_641_10

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_12 = 68 <= 0 and var_641_9 or var_641_9 * (utf8.len(var_641_10) / 68)

				if (68 <= 0 and var_641_9 or var_641_9 * (utf8.len(var_641_10) / 68)) > 0 and var_641_9 < var_641_12 then
					arg_638_1.talkMaxDuration = var_641_12

					if var_641_12 + var_641_8 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_12 + var_641_8
					end
				end

				arg_638_1.text_.text = var_641_10
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)
				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_13 = math.max(var_641_9, arg_638_1.talkMaxDuration)

			if var_641_8 <= arg_638_1.time_ and arg_638_1.time_ < var_641_8 + var_641_13 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_8) / var_641_13

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_8 + var_641_13 and arg_638_1.time_ < var_641_8 + var_641_13 + arg_641_0 then
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
			local var_645_0 = 0.975

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, false)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_1 = arg_642_1:FormatText(arg_642_1:GetWordFromCfg(322281157).content)

				arg_642_1.text_.text = var_645_1

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_3 = 39 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_1) / 39)

				if (39 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_1) / 39)) > 0 and var_645_0 < var_645_3 then
					arg_642_1.talkMaxDuration = var_645_3

					if var_645_3 + 0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_3 + 0
					end
				end

				arg_642_1.text_.text = var_645_1
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_4 = math.max(var_645_0, arg_642_1.talkMaxDuration)

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_4 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - 0) / var_645_4

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= 0 + var_645_4 and arg_642_1.time_ < 0 + var_645_4 + arg_645_0 then
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
			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.var_.moveOldPos10131ui_story = arg_646_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_649_0 = 0.001

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_0 then
				arg_646_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_646_1.time_ - 0) / var_649_0)
				arg_646_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_646_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["10131ui_story"].transform.position).z)
				arg_646_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_646_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_646_1.actors_["10131ui_story"].transform.localEulerAngles = arg_646_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_646_1.time_ >= 0 + var_649_0 and arg_646_1.time_ < 0 + var_649_0 + arg_649_0 then
				arg_646_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.05, -0.96, -5.8)
				arg_646_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_646_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["10131ui_story"].transform.position).z)
				arg_646_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_646_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_646_1.actors_["10131ui_story"].transform.localEulerAngles = arg_646_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_649_1 = arg_646_1.actors_["10131ui_story"]

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 and not isNil(var_649_1) and arg_646_1.var_.characterEffect10131ui_story == nil then
				arg_646_1.var_.characterEffect10131ui_story = var_649_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_2 = 0.200000002980232

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_2 and not isNil(var_649_1) then
				if arg_646_1.var_.characterEffect10131ui_story and not isNil(var_649_1) then
					arg_646_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_646_1.time_ >= 0 + var_649_2 and arg_646_1.time_ < 0 + var_649_2 + arg_649_0 and not isNil(var_649_1) and arg_646_1.var_.characterEffect10131ui_story then
				arg_646_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_649_4 = 0
			local var_649_5 = 0.3

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_4 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				arg_646_1.leftNameTxt_.text = arg_646_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_6 = arg_646_1:GetWordFromCfg(322281158)
				local var_649_7 = arg_646_1:FormatText(var_649_6.content)

				arg_646_1.text_.text = var_649_7

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_9 = 12 <= 0 and var_649_5 or var_649_5 * (utf8.len(var_649_7) / 12)

				if (12 <= 0 and var_649_5 or var_649_5 * (utf8.len(var_649_7) / 12)) > 0 and var_649_5 < var_649_9 then
					arg_646_1.talkMaxDuration = var_649_9

					if var_649_9 + var_649_4 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_9 + var_649_4
					end
				end

				arg_646_1.text_.text = var_649_7
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281158", "story_v_out_322281.awb") ~= 0 then
					local var_649_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281158", "story_v_out_322281.awb") / 1000

					if var_649_10 + var_649_4 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_10 + var_649_4
					end

					if var_649_6.prefab_name ~= "" and arg_646_1.actors_[var_649_6.prefab_name] ~= nil then
						local var_649_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_646_1.actors_[var_649_6.prefab_name].transform, "story_v_out_322281", "322281158", "story_v_out_322281.awb")

						arg_646_1:RecordAudio("322281158", var_649_11)
						arg_646_1:RecordAudio("322281158", var_649_11)
					else
						arg_646_1:AudioAction("play", "voice", "story_v_out_322281", "322281158", "story_v_out_322281.awb")
					end

					arg_646_1:RecordHistoryTalkVoice("story_v_out_322281", "322281158", "story_v_out_322281.awb")
				end

				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_12 = math.max(var_649_5, arg_646_1.talkMaxDuration)

			if var_649_4 <= arg_646_1.time_ and arg_646_1.time_ < var_649_4 + var_649_12 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_4) / var_649_12

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_4 + var_649_12 and arg_646_1.time_ < var_649_4 + var_649_12 + arg_649_0 then
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
			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1.var_.moveOldPos10131ui_story = arg_650_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_653_0 = 0.001

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_0 then
				arg_650_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_650_1.time_ - 0) / var_653_0)
				arg_650_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_650_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["10131ui_story"].transform.position).z)
				arg_650_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_650_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_650_1.actors_["10131ui_story"].transform.localEulerAngles = arg_650_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_650_1.time_ >= 0 + var_653_0 and arg_650_1.time_ < 0 + var_653_0 + arg_653_0 then
				arg_650_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_650_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_650_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["10131ui_story"].transform.position).z)
				arg_650_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_650_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_650_1.actors_["10131ui_story"].transform.localEulerAngles = arg_650_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_653_1 = arg_650_1.actors_["6056ui_story"].transform

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1.var_.moveOldPos6056ui_story = var_653_1.localPosition
			end

			local var_653_2 = 0.001

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_2 then
				var_653_1.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPos6056ui_story, Vector3.New(0.95, -1.16, -6.15), (arg_650_1.time_ - 0) / var_653_2)
				var_653_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_653_1.position).x, (manager.ui.mainCamera.transform.position - var_653_1.position).y, (manager.ui.mainCamera.transform.position - var_653_1.position).z)
				var_653_1.localEulerAngles.z = 0
				var_653_1.localEulerAngles.x = 0
				var_653_1.localEulerAngles = var_653_1.localEulerAngles
			end

			if arg_650_1.time_ >= 0 + var_653_2 and arg_650_1.time_ < 0 + var_653_2 + arg_653_0 then
				var_653_1.localPosition = Vector3.New(0.95, -1.16, -6.15)
				var_653_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_653_1.position).x, (manager.ui.mainCamera.transform.position - var_653_1.position).y, (manager.ui.mainCamera.transform.position - var_653_1.position).z)
				var_653_1.localEulerAngles.z = 0
				var_653_1.localEulerAngles.x = 0
				var_653_1.localEulerAngles = var_653_1.localEulerAngles
			end

			local var_653_3 = arg_650_1.actors_["6056ui_story"]

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 and not isNil(var_653_3) and arg_650_1.var_.characterEffect6056ui_story == nil then
				arg_650_1.var_.characterEffect6056ui_story = var_653_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_4 = 0.200000002980232

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_4 and not isNil(var_653_3) then
				if arg_650_1.var_.characterEffect6056ui_story and not isNil(var_653_3) then
					arg_650_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_650_1.time_ >= 0 + var_653_4 and arg_650_1.time_ < 0 + var_653_4 + arg_653_0 and not isNil(var_653_3) and arg_650_1.var_.characterEffect6056ui_story then
				arg_650_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_653_6 = arg_650_1.actors_["10131ui_story"]

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 and not isNil(var_653_6) and arg_650_1.var_.characterEffect10131ui_story == nil then
				arg_650_1.var_.characterEffect10131ui_story = var_653_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_7 = 0.200000002980232

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_7 and not isNil(var_653_6) then
				if arg_650_1.var_.characterEffect10131ui_story and not isNil(var_653_6) then
					arg_650_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_650_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_650_1.time_ - 0) / var_653_7)
				end
			end

			if arg_650_1.time_ >= 0 + var_653_7 and arg_650_1.time_ < 0 + var_653_7 + arg_653_0 and not isNil(var_653_6) and arg_650_1.var_.characterEffect10131ui_story then
				arg_650_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_650_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action3_1")
			end

			local var_653_8 = 0
			local var_653_9 = 0.5

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_8 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				arg_650_1.leftNameTxt_.text = arg_650_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_10 = arg_650_1:GetWordFromCfg(322281159)
				local var_653_11 = arg_650_1:FormatText(var_653_10.content)

				arg_650_1.text_.text = var_653_11

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_13 = 20 <= 0 and var_653_9 or var_653_9 * (utf8.len(var_653_11) / 20)

				if (20 <= 0 and var_653_9 or var_653_9 * (utf8.len(var_653_11) / 20)) > 0 and var_653_9 < var_653_13 then
					arg_650_1.talkMaxDuration = var_653_13

					if var_653_13 + var_653_8 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_13 + var_653_8
					end
				end

				arg_650_1.text_.text = var_653_11
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281159", "story_v_out_322281.awb") ~= 0 then
					local var_653_14 = manager.audio:GetVoiceLength("story_v_out_322281", "322281159", "story_v_out_322281.awb") / 1000

					if var_653_14 + var_653_8 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_14 + var_653_8
					end

					if var_653_10.prefab_name ~= "" and arg_650_1.actors_[var_653_10.prefab_name] ~= nil then
						local var_653_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_10.prefab_name].transform, "story_v_out_322281", "322281159", "story_v_out_322281.awb")

						arg_650_1:RecordAudio("322281159", var_653_15)
						arg_650_1:RecordAudio("322281159", var_653_15)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_out_322281", "322281159", "story_v_out_322281.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_out_322281", "322281159", "story_v_out_322281.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_16 = math.max(var_653_9, arg_650_1.talkMaxDuration)

			if var_653_8 <= arg_650_1.time_ and arg_650_1.time_ < var_653_8 + var_653_16 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_8) / var_653_16

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_8 + var_653_16 and arg_650_1.time_ < var_653_8 + var_653_16 + arg_653_0 then
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
			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 and not isNil(arg_654_1.actors_["10131ui_story"]) and arg_654_1.var_.characterEffect10131ui_story == nil then
				arg_654_1.var_.characterEffect10131ui_story = arg_654_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_0 = 0.200000002980232

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_0 and not isNil(arg_654_1.actors_["10131ui_story"]) then
				if arg_654_1.var_.characterEffect10131ui_story and not isNil(arg_654_1.actors_["10131ui_story"]) then
					arg_654_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_654_1.time_ >= 0 + var_657_0 and arg_654_1.time_ < 0 + var_657_0 + arg_657_0 and not isNil(arg_654_1.actors_["10131ui_story"]) and arg_654_1.var_.characterEffect10131ui_story then
				arg_654_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_657_2 = arg_654_1.actors_["6056ui_story"]

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 and not isNil(var_657_2) and arg_654_1.var_.characterEffect6056ui_story == nil then
				arg_654_1.var_.characterEffect6056ui_story = var_657_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_3 = 0.200000002980232

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_3 and not isNil(var_657_2) then
				if arg_654_1.var_.characterEffect6056ui_story and not isNil(var_657_2) then
					arg_654_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_654_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_654_1.time_ - 0) / var_657_3)
				end
			end

			if arg_654_1.time_ >= 0 + var_657_3 and arg_654_1.time_ < 0 + var_657_3 + arg_657_0 and not isNil(var_657_2) and arg_654_1.var_.characterEffect6056ui_story then
				arg_654_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_654_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_657_4 = 0
			local var_657_5 = 0.525

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_4 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, false)
				arg_654_1.callingController_:SetSelectedState("normal")

				local var_657_6 = arg_654_1:GetWordFromCfg(322281160)
				local var_657_7 = arg_654_1:FormatText(var_657_6.content)

				arg_654_1.text_.text = var_657_7

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_9 = 21 <= 0 and var_657_5 or var_657_5 * (utf8.len(var_657_7) / 21)

				if (21 <= 0 and var_657_5 or var_657_5 * (utf8.len(var_657_7) / 21)) > 0 and var_657_5 < var_657_9 then
					arg_654_1.talkMaxDuration = var_657_9

					if var_657_9 + var_657_4 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_9 + var_657_4
					end
				end

				arg_654_1.text_.text = var_657_7
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281160", "story_v_out_322281.awb") ~= 0 then
					local var_657_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281160", "story_v_out_322281.awb") / 1000

					if var_657_10 + var_657_4 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_10 + var_657_4
					end

					if var_657_6.prefab_name ~= "" and arg_654_1.actors_[var_657_6.prefab_name] ~= nil then
						local var_657_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_654_1.actors_[var_657_6.prefab_name].transform, "story_v_out_322281", "322281160", "story_v_out_322281.awb")

						arg_654_1:RecordAudio("322281160", var_657_11)
						arg_654_1:RecordAudio("322281160", var_657_11)
					else
						arg_654_1:AudioAction("play", "voice", "story_v_out_322281", "322281160", "story_v_out_322281.awb")
					end

					arg_654_1:RecordHistoryTalkVoice("story_v_out_322281", "322281160", "story_v_out_322281.awb")
				end

				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_12 = math.max(var_657_5, arg_654_1.talkMaxDuration)

			if var_657_4 <= arg_654_1.time_ and arg_654_1.time_ < var_657_4 + var_657_12 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_4) / var_657_12

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_4 + var_657_12 and arg_654_1.time_ < var_657_4 + var_657_12 + arg_657_0 then
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
			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 and not isNil(arg_658_1.actors_["6056ui_story"]) and arg_658_1.var_.characterEffect6056ui_story == nil then
				arg_658_1.var_.characterEffect6056ui_story = arg_658_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_0 = 0.200000002980232

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_0 and not isNil(arg_658_1.actors_["6056ui_story"]) then
				if arg_658_1.var_.characterEffect6056ui_story and not isNil(arg_658_1.actors_["6056ui_story"]) then
					arg_658_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_658_1.time_ >= 0 + var_661_0 and arg_658_1.time_ < 0 + var_661_0 + arg_661_0 and not isNil(arg_658_1.actors_["6056ui_story"]) and arg_658_1.var_.characterEffect6056ui_story then
				arg_658_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_661_2 = arg_658_1.actors_["10131ui_story"]

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 and not isNil(var_661_2) and arg_658_1.var_.characterEffect10131ui_story == nil then
				arg_658_1.var_.characterEffect10131ui_story = var_661_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_3 = 0.200000002980232

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_3 and not isNil(var_661_2) then
				if arg_658_1.var_.characterEffect10131ui_story and not isNil(var_661_2) then
					arg_658_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_658_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_658_1.time_ - 0) / var_661_3)
				end
			end

			if arg_658_1.time_ >= 0 + var_661_3 and arg_658_1.time_ < 0 + var_661_3 + arg_661_0 and not isNil(var_661_2) and arg_658_1.var_.characterEffect10131ui_story then
				arg_658_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_658_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action3_2")
			end

			local var_661_4 = 0
			local var_661_5 = 0.15

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_4 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				arg_658_1.leftNameTxt_.text = arg_658_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_6 = arg_658_1:GetWordFromCfg(322281161)
				local var_661_7 = arg_658_1:FormatText(var_661_6.content)

				arg_658_1.text_.text = var_661_7

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_9 = 6 <= 0 and var_661_5 or var_661_5 * (utf8.len(var_661_7) / 6)

				if (6 <= 0 and var_661_5 or var_661_5 * (utf8.len(var_661_7) / 6)) > 0 and var_661_5 < var_661_9 then
					arg_658_1.talkMaxDuration = var_661_9

					if var_661_9 + var_661_4 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_9 + var_661_4
					end
				end

				arg_658_1.text_.text = var_661_7
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281161", "story_v_out_322281.awb") ~= 0 then
					local var_661_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281161", "story_v_out_322281.awb") / 1000

					if var_661_10 + var_661_4 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_10 + var_661_4
					end

					if var_661_6.prefab_name ~= "" and arg_658_1.actors_[var_661_6.prefab_name] ~= nil then
						local var_661_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_6.prefab_name].transform, "story_v_out_322281", "322281161", "story_v_out_322281.awb")

						arg_658_1:RecordAudio("322281161", var_661_11)
						arg_658_1:RecordAudio("322281161", var_661_11)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_out_322281", "322281161", "story_v_out_322281.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_out_322281", "322281161", "story_v_out_322281.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_12 = math.max(var_661_5, arg_658_1.talkMaxDuration)

			if var_661_4 <= arg_658_1.time_ and arg_658_1.time_ < var_661_4 + var_661_12 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_4) / var_661_12

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_4 + var_661_12 and arg_658_1.time_ < var_661_4 + var_661_12 + arg_661_0 then
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
			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 and not isNil(arg_662_1.actors_["10131ui_story"]) and arg_662_1.var_.characterEffect10131ui_story == nil then
				arg_662_1.var_.characterEffect10131ui_story = arg_662_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_0 = 0.200000002980232

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_0 and not isNil(arg_662_1.actors_["10131ui_story"]) then
				if arg_662_1.var_.characterEffect10131ui_story and not isNil(arg_662_1.actors_["10131ui_story"]) then
					arg_662_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_662_1.time_ >= 0 + var_665_0 and arg_662_1.time_ < 0 + var_665_0 + arg_665_0 and not isNil(arg_662_1.actors_["10131ui_story"]) and arg_662_1.var_.characterEffect10131ui_story then
				arg_662_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_665_2 = arg_662_1.actors_["6056ui_story"]

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 and not isNil(var_665_2) and arg_662_1.var_.characterEffect6056ui_story == nil then
				arg_662_1.var_.characterEffect6056ui_story = var_665_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_3 = 0.200000002980232

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_3 and not isNil(var_665_2) then
				if arg_662_1.var_.characterEffect6056ui_story and not isNil(var_665_2) then
					arg_662_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_662_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_662_1.time_ - 0) / var_665_3)
				end
			end

			if arg_662_1.time_ >= 0 + var_665_3 and arg_662_1.time_ < 0 + var_665_3 + arg_665_0 and not isNil(var_665_2) and arg_662_1.var_.characterEffect6056ui_story then
				arg_662_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_662_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_665_4 = 0
			local var_665_5 = 0.075

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_4 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_6 = arg_662_1:GetWordFromCfg(322281162)
				local var_665_7 = arg_662_1:FormatText(var_665_6.content)

				arg_662_1.text_.text = var_665_7

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_9 = 3 <= 0 and var_665_5 or var_665_5 * (utf8.len(var_665_7) / 3)

				if (3 <= 0 and var_665_5 or var_665_5 * (utf8.len(var_665_7) / 3)) > 0 and var_665_5 < var_665_9 then
					arg_662_1.talkMaxDuration = var_665_9

					if var_665_9 + var_665_4 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_9 + var_665_4
					end
				end

				arg_662_1.text_.text = var_665_7
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281162", "story_v_out_322281.awb") ~= 0 then
					local var_665_10 = manager.audio:GetVoiceLength("story_v_out_322281", "322281162", "story_v_out_322281.awb") / 1000

					if var_665_10 + var_665_4 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_10 + var_665_4
					end

					if var_665_6.prefab_name ~= "" and arg_662_1.actors_[var_665_6.prefab_name] ~= nil then
						local var_665_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_6.prefab_name].transform, "story_v_out_322281", "322281162", "story_v_out_322281.awb")

						arg_662_1:RecordAudio("322281162", var_665_11)
						arg_662_1:RecordAudio("322281162", var_665_11)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_out_322281", "322281162", "story_v_out_322281.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_out_322281", "322281162", "story_v_out_322281.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_12 = math.max(var_665_5, arg_662_1.talkMaxDuration)

			if var_665_4 <= arg_662_1.time_ and arg_662_1.time_ < var_665_4 + var_665_12 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_4) / var_665_12

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_4 + var_665_12 and arg_662_1.time_ < var_665_4 + var_665_12 + arg_665_0 then
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
			if arg_666_1.bgs_.I17l == nil then
				local var_669_0 = Object.Instantiate(arg_666_1.paintGo_)

				var_669_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I17l")
				var_669_0.name = "I17l"
				var_669_0.transform.parent = arg_666_1.stage_.transform
				var_669_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_666_1.bgs_.I17l = var_669_0
			end

			if 2 < arg_666_1.time_ and arg_666_1.time_ <= 2 + arg_669_0 then
				local var_669_1 = arg_666_1.bgs_.I17l

				arg_666_1.bgs_.I17l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_669_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_669_2 = var_669_1:GetComponent("SpriteRenderer")

				if var_669_2 and var_669_2.sprite then
					local var_669_3 = 2 * (var_669_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_669_1.transform.localScale = Vector3.New(var_669_3 / var_669_2.sprite.bounds.size.y < var_669_3 * manager.ui.mainCameraCom_.aspect / var_669_2.sprite.bounds.size.x and var_669_3 * manager.ui.mainCameraCom_.aspect / var_669_2.sprite.bounds.size.x or var_669_3 / var_669_2.sprite.bounds.size.y, var_669_3 / var_669_2.sprite.bounds.size.y < var_669_3 * manager.ui.mainCameraCom_.aspect / var_669_2.sprite.bounds.size.x and var_669_3 * manager.ui.mainCameraCom_.aspect / var_669_2.sprite.bounds.size.x or var_669_3 / var_669_2.sprite.bounds.size.y, 0)
				end

				for iter_669_0, iter_669_1 in pairs(arg_666_1.bgs_) do
					if iter_669_0 ~= "I17l" then
						iter_669_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_669_4 = 4

			if 4 < arg_666_1.time_ and arg_666_1.time_ <= var_669_4 + arg_669_0 then
				arg_666_1.allBtn_.enabled = false
			end

			if arg_666_1.time_ >= var_669_4 + 0.766666666666667 and arg_666_1.time_ < var_669_4 + 0.766666666666667 + arg_669_0 then
				arg_666_1.allBtn_.enabled = true
			end

			local var_669_5 = 0

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= var_669_5 + arg_669_0 then
				arg_666_1.mask_.enabled = true
				arg_666_1.mask_.raycastTarget = true

				arg_666_1:SetGaussion(false)
			end

			local var_669_6 = 2

			if var_669_5 <= arg_666_1.time_ and arg_666_1.time_ < var_669_5 + var_669_6 then
				local var_669_7 = Color.New(0, 0, 0)

				var_669_7.a = Mathf.Lerp(0, 1, (arg_666_1.time_ - var_669_5) / var_669_6)
				arg_666_1.mask_.color = var_669_7
			end

			if arg_666_1.time_ >= var_669_5 + var_669_6 and arg_666_1.time_ < var_669_5 + var_669_6 + arg_669_0 then
				local var_669_8 = Color.New(0, 0, 0)

				var_669_8.a = 1
				arg_666_1.mask_.color = var_669_8
			end

			local var_669_9 = 2

			if 2 < arg_666_1.time_ and arg_666_1.time_ <= var_669_9 + arg_669_0 then
				arg_666_1.mask_.enabled = true
				arg_666_1.mask_.raycastTarget = true

				arg_666_1:SetGaussion(false)
			end

			local var_669_10 = 2

			if var_669_9 <= arg_666_1.time_ and arg_666_1.time_ < var_669_9 + var_669_10 then
				local var_669_11 = Color.New(0, 0, 0)

				var_669_11.a = Mathf.Lerp(1, 0, (arg_666_1.time_ - var_669_9) / var_669_10)
				arg_666_1.mask_.color = var_669_11
			end

			if arg_666_1.time_ >= var_669_9 + var_669_10 and arg_666_1.time_ < var_669_9 + var_669_10 + arg_669_0 then
				local var_669_12 = Color.New(0, 0, 0)

				arg_666_1.mask_.enabled = false
				var_669_12.a = 0
				arg_666_1.mask_.color = var_669_12
			end

			local var_669_13 = arg_666_1.actors_["10131ui_story"].transform

			if 2 < arg_666_1.time_ and arg_666_1.time_ <= 2 + arg_669_0 then
				arg_666_1.var_.moveOldPos10131ui_story = var_669_13.localPosition
			end

			local var_669_14 = 0.001

			if 2 <= arg_666_1.time_ and arg_666_1.time_ < 2 + var_669_14 then
				var_669_13.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_666_1.time_ - 2) / var_669_14)
				var_669_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_669_13.position).x, (manager.ui.mainCamera.transform.position - var_669_13.position).y, (manager.ui.mainCamera.transform.position - var_669_13.position).z)
				var_669_13.localEulerAngles.z = 0
				var_669_13.localEulerAngles.x = 0
				var_669_13.localEulerAngles = var_669_13.localEulerAngles
			end

			if arg_666_1.time_ >= 2 + var_669_14 and arg_666_1.time_ < 2 + var_669_14 + arg_669_0 then
				var_669_13.localPosition = Vector3.New(0, 100, 0)
				var_669_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_669_13.position).x, (manager.ui.mainCamera.transform.position - var_669_13.position).y, (manager.ui.mainCamera.transform.position - var_669_13.position).z)
				var_669_13.localEulerAngles.z = 0
				var_669_13.localEulerAngles.x = 0
				var_669_13.localEulerAngles = var_669_13.localEulerAngles
			end

			local var_669_15 = arg_666_1.actors_["6056ui_story"].transform

			if 2 < arg_666_1.time_ and arg_666_1.time_ <= 2 + arg_669_0 then
				arg_666_1.var_.moveOldPos6056ui_story = var_669_15.localPosition
			end

			local var_669_16 = 0.001

			if 2 <= arg_666_1.time_ and arg_666_1.time_ < 2 + var_669_16 then
				var_669_15.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPos6056ui_story, Vector3.New(0, 100, 0), (arg_666_1.time_ - 2) / var_669_16)
				var_669_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_669_15.position).x, (manager.ui.mainCamera.transform.position - var_669_15.position).y, (manager.ui.mainCamera.transform.position - var_669_15.position).z)
				var_669_15.localEulerAngles.z = 0
				var_669_15.localEulerAngles.x = 0
				var_669_15.localEulerAngles = var_669_15.localEulerAngles
			end

			if arg_666_1.time_ >= 2 + var_669_16 and arg_666_1.time_ < 2 + var_669_16 + arg_669_0 then
				var_669_15.localPosition = Vector3.New(0, 100, 0)
				var_669_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_669_15.position).x, (manager.ui.mainCamera.transform.position - var_669_15.position).y, (manager.ui.mainCamera.transform.position - var_669_15.position).z)
				var_669_15.localEulerAngles.z = 0
				var_669_15.localEulerAngles.x = 0
				var_669_15.localEulerAngles = var_669_15.localEulerAngles
			end

			if 0.166666666666667 < arg_666_1.time_ and arg_666_1.time_ <= 0.166666666666667 + arg_669_0 then
				arg_666_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			if 1.6 < arg_666_1.time_ and arg_666_1.time_ <= 1.6 + arg_669_0 then
				arg_666_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_morning_loop", "")
			end

			local var_669_19 = arg_666_1.bgs_.I17l.transform

			if 2 < arg_666_1.time_ and arg_666_1.time_ <= 2 + arg_669_0 then
				arg_666_1.var_.moveOldPosI17l = var_669_19.localPosition
			end

			local var_669_20 = 1.96599999815226

			if 2 <= arg_666_1.time_ and arg_666_1.time_ < 2 + var_669_20 then
				var_669_19.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPosI17l, Vector3.New(0, 1, 9), (arg_666_1.time_ - 2) / var_669_20)
			end

			if arg_666_1.time_ >= 2 + var_669_20 and arg_666_1.time_ < 2 + var_669_20 + arg_669_0 then
				var_669_19.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_666_1.frameCnt_ <= 1 then
				arg_666_1.dialog_:SetActive(false)
			end

			local var_669_21 = 4
			local var_669_22 = 1.025

			if 4 < arg_666_1.time_ and arg_666_1.time_ <= var_669_21 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0

				arg_666_1.dialog_:SetActive(true)

				arg_666_1.dialogCg_.alpha = 0

				local var_669_23 = LeanTween.value(arg_666_1.dialog_, 0, 1, 0.3)

				var_669_23:setOnUpdate(LuaHelper.FloatAction(function(arg_670_0)
					arg_666_1.dialogCg_.alpha = arg_670_0
				end))
				var_669_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_666_1.dialog_)
					var_669_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_666_1.duration_ = arg_666_1.duration_ + 0.3

				SetActive(arg_666_1.leftNameGo_, false)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_24 = arg_666_1:FormatText(arg_666_1:GetWordFromCfg(322281163).content)

				arg_666_1.text_.text = var_669_24

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_26 = 41 <= 0 and var_669_22 or var_669_22 * (utf8.len(var_669_24) / 41)

				if (41 <= 0 and var_669_22 or var_669_22 * (utf8.len(var_669_24) / 41)) > 0 and var_669_22 < var_669_26 then
					arg_666_1.talkMaxDuration = var_669_26
					var_669_21 = var_669_21 + 0.3

					if var_669_26 + var_669_21 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_26 + var_669_21
					end
				end

				arg_666_1.text_.text = var_669_24
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)
				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_27 = var_669_21 + 0.3
			local var_669_28 = math.max(var_669_22, arg_666_1.talkMaxDuration)

			if var_669_21 + 0.3 <= arg_666_1.time_ and arg_666_1.time_ < var_669_27 + var_669_28 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_27) / var_669_28

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_27 + var_669_28 and arg_666_1.time_ < var_669_27 + var_669_28 + arg_669_0 then
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
			local var_675_0 = 0.45

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				arg_672_1.leftNameTxt_.text = arg_672_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_1 = arg_672_1:GetWordFromCfg(322281164)
				local var_675_2 = arg_672_1:FormatText(var_675_1.content)

				arg_672_1.text_.text = var_675_2

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_4 = 18 <= 0 and var_675_0 or var_675_0 * (utf8.len(var_675_2) / 18)

				if (18 <= 0 and var_675_0 or var_675_0 * (utf8.len(var_675_2) / 18)) > 0 and var_675_0 < var_675_4 then
					arg_672_1.talkMaxDuration = var_675_4

					if var_675_4 + 0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_4 + 0
					end
				end

				arg_672_1.text_.text = var_675_2
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281164", "story_v_out_322281.awb") ~= 0 then
					local var_675_5 = manager.audio:GetVoiceLength("story_v_out_322281", "322281164", "story_v_out_322281.awb") / 1000

					if var_675_5 + 0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_5 + 0
					end

					if var_675_1.prefab_name ~= "" and arg_672_1.actors_[var_675_1.prefab_name] ~= nil then
						local var_675_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_1.prefab_name].transform, "story_v_out_322281", "322281164", "story_v_out_322281.awb")

						arg_672_1:RecordAudio("322281164", var_675_6)
						arg_672_1:RecordAudio("322281164", var_675_6)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_out_322281", "322281164", "story_v_out_322281.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_out_322281", "322281164", "story_v_out_322281.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_7 = math.max(var_675_0, arg_672_1.talkMaxDuration)

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_7 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - 0) / var_675_7

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= 0 + var_675_7 and arg_672_1.time_ < 0 + var_675_7 + arg_675_0 then
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
			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 then
				arg_676_1.mask_.enabled = true
				arg_676_1.mask_.raycastTarget = true

				arg_676_1:SetGaussion(false)
			end

			local var_679_0 = 1

			if 0 <= arg_676_1.time_ and arg_676_1.time_ < 0 + var_679_0 then
				local var_679_1 = Color.New(0, 0, 0)

				var_679_1.a = Mathf.Lerp(0, 1, (arg_676_1.time_ - 0) / var_679_0)
				arg_676_1.mask_.color = var_679_1
			end

			if arg_676_1.time_ >= 0 + var_679_0 and arg_676_1.time_ < 0 + var_679_0 + arg_679_0 then
				local var_679_2 = Color.New(0, 0, 0)

				var_679_2.a = 1
				arg_676_1.mask_.color = var_679_2
			end

			local var_679_3 = 1

			if 1 < arg_676_1.time_ and arg_676_1.time_ <= var_679_3 + arg_679_0 then
				arg_676_1.mask_.enabled = true
				arg_676_1.mask_.raycastTarget = true

				arg_676_1:SetGaussion(false)
			end

			local var_679_4 = 1

			if var_679_3 <= arg_676_1.time_ and arg_676_1.time_ < var_679_3 + var_679_4 then
				local var_679_5 = Color.New(0, 0, 0)

				var_679_5.a = Mathf.Lerp(1, 0, (arg_676_1.time_ - var_679_3) / var_679_4)
				arg_676_1.mask_.color = var_679_5
			end

			if arg_676_1.time_ >= var_679_3 + var_679_4 and arg_676_1.time_ < var_679_3 + var_679_4 + arg_679_0 then
				local var_679_6 = Color.New(0, 0, 0)

				arg_676_1.mask_.enabled = false
				var_679_6.a = 0
				arg_676_1.mask_.color = var_679_6
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
			if arg_696_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_699_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_696_1.stage_.transform)

				var_699_0.name = "1020ui_story"
				var_699_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_696_1.actors_["1020ui_story"] = var_699_0

				local var_699_1 = var_699_0:GetComponentInChildren(typeof(CharacterEffect))

				var_699_1.enabled = true

				local var_699_2 = GameObjectTools.GetOrAddComponent(var_699_0, typeof(DynamicBoneHelper))

				if var_699_2 then
					var_699_2:EnableDynamicBone(false)
				end

				arg_696_1:ShowWeapon(var_699_1.transform, false)

				arg_696_1.var_["1020ui_story" .. "Animator"] = var_699_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_696_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_696_1.var_["1020ui_story" .. "LipSync"] = var_699_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 then
				arg_696_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_699_3 = arg_696_1.actors_["1020ui_story"]

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 and not isNil(var_699_3) and arg_696_1.var_.characterEffect1020ui_story == nil then
				arg_696_1.var_.characterEffect1020ui_story = var_699_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_699_4 = 0.200000002980232

			if 0 <= arg_696_1.time_ and arg_696_1.time_ < 0 + var_699_4 and not isNil(var_699_3) then
				if arg_696_1.var_.characterEffect1020ui_story and not isNil(var_699_3) then
					arg_696_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_696_1.time_ >= 0 + var_699_4 and arg_696_1.time_ < 0 + var_699_4 + arg_699_0 and not isNil(var_699_3) and arg_696_1.var_.characterEffect1020ui_story then
				arg_696_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_699_6 = 0
			local var_699_7 = 0.375

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_6 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, true)

				arg_696_1.leftNameTxt_.text = arg_696_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_696_1.leftNameTxt_.transform)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1.leftNameTxt_.text)
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_8 = arg_696_1:GetWordFromCfg(322281063)
				local var_699_9 = arg_696_1:FormatText(var_699_8.content)

				arg_696_1.text_.text = var_699_9

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_11 = 15 <= 0 and var_699_7 or var_699_7 * (utf8.len(var_699_9) / 15)

				if (15 <= 0 and var_699_7 or var_699_7 * (utf8.len(var_699_9) / 15)) > 0 and var_699_7 < var_699_11 then
					arg_696_1.talkMaxDuration = var_699_11

					if var_699_11 + var_699_6 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_11 + var_699_6
					end
				end

				arg_696_1.text_.text = var_699_9
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322281", "322281063", "story_v_out_322281.awb") ~= 0 then
					local var_699_12 = manager.audio:GetVoiceLength("story_v_out_322281", "322281063", "story_v_out_322281.awb") / 1000

					if var_699_12 + var_699_6 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_12 + var_699_6
					end

					if var_699_8.prefab_name ~= "" and arg_696_1.actors_[var_699_8.prefab_name] ~= nil then
						local var_699_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_696_1.actors_[var_699_8.prefab_name].transform, "story_v_out_322281", "322281063", "story_v_out_322281.awb")

						arg_696_1:RecordAudio("322281063", var_699_13)
						arg_696_1:RecordAudio("322281063", var_699_13)
					else
						arg_696_1:AudioAction("play", "voice", "story_v_out_322281", "322281063", "story_v_out_322281.awb")
					end

					arg_696_1:RecordHistoryTalkVoice("story_v_out_322281", "322281063", "story_v_out_322281.awb")
				end

				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_14 = math.max(var_699_7, arg_696_1.talkMaxDuration)

			if var_699_6 <= arg_696_1.time_ and arg_696_1.time_ < var_699_6 + var_699_14 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_6) / var_699_14

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_6 + var_699_14 and arg_696_1.time_ < var_699_6 + var_699_14 + arg_699_0 then
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
