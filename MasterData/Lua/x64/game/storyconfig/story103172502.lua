return {
	Play317252001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317252001
		arg_1_1.duration_ = 16.87

		local var_1_0 = {
			zh = 12.733,
			ja = 16.866
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317252002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST58 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST58")
				var_4_0.name = "ST58"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST58 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST58

				arg_1_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST58" then
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

			local var_4_5 = 2

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

			local var_4_8 = "1049ui_story"

			if arg_1_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1049ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1049ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -1.2, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1049ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1049ui_story == nil then
				arg_1_1.var_.characterEffect1049ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1049ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1049ui_story then
				arg_1_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_4_17 = "1058ui_story"

			if arg_1_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_1_1.stage_.transform)

				var_4_18.name = var_4_17
				var_4_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_17] = var_4_18

				local var_4_19 = var_4_18:GetComponentInChildren(typeof(CharacterEffect))

				var_4_19.enabled = true

				local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_18, typeof(DynamicBoneHelper))

				if var_4_20 then
					var_4_20:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_19.transform, false)

				arg_1_1.var_[var_4_17 .. "Animator"] = var_4_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_17 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_17 .. "LipSync"] = var_4_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_21 = arg_1_1.actors_["1058ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1058ui_story = var_4_21.localPosition
			end

			local var_4_22 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_22 then
				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_1_1.time_ - 2) / var_4_22)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_22 and arg_1_1.time_ < 2 + var_4_22 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0.7, -0.95, -5.88)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			local var_4_23 = arg_1_1.actors_["1058ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1058ui_story == nil then
				arg_1_1.var_.characterEffect1058ui_story = var_4_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_24 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_24 and not isNil(var_4_23) then
				if arg_1_1.var_.characterEffect1058ui_story and not isNil(var_4_23) then
					arg_1_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 2) / var_4_24)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_24 and arg_1_1.time_ < 2 + var_4_24 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1058ui_story then
				arg_1_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_4_25 = 0

			arg_1_1.isInRecall_ = false

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_26 = 0.0166666666666667

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_25) / var_4_26)
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
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

			if 0.325 < arg_1_1.time_ and arg_1_1.time_ <= 0.325 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet.awb")

				local var_4_32 = manager.audio:GetAudioName("bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 1.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(317252001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 47 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_37) / 47)

				if (47 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_37) / 47)) > 0 and var_4_34 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_33 = var_4_33 + 0.3

					if var_4_39 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252001", "story_v_out_317252.awb") ~= 0 then
					local var_4_40 = manager.audio:GetVoiceLength("story_v_out_317252", "317252001", "story_v_out_317252.awb") / 1000

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end

					if var_4_36.prefab_name ~= "" and arg_1_1.actors_[var_4_36.prefab_name] ~= nil then
						local var_4_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_36.prefab_name].transform, "story_v_out_317252", "317252001", "story_v_out_317252.awb")

						arg_1_1:RecordAudio("317252001", var_4_41)
						arg_1_1:RecordAudio("317252001", var_4_41)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_317252", "317252001", "story_v_out_317252.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_317252", "317252001", "story_v_out_317252.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_33 + 0.3
			local var_4_43 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_33 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play317252002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317252002
		arg_9_1.duration_ = 7.73

		local var_9_0 = {
			zh = 5.566,
			ja = 7.733
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317252003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1058ui_story = arg_9_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1058ui_story"].transform.position).z)
				arg_9_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1058ui_story"].transform.localEulerAngles = arg_9_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -5.88)
				arg_9_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1058ui_story"].transform.position).z)
				arg_9_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1058ui_story"].transform.localEulerAngles = arg_9_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1058ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1058ui_story == nil then
				arg_9_1.var_.characterEffect1058ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1058ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1058ui_story then
				arg_9_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_12_4 = arg_9_1.actors_["1049ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.characterEffect1049ui_story == nil then
				arg_9_1.var_.characterEffect1049ui_story = var_12_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_5 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_5 and not isNil(var_12_4) then
				if arg_9_1.var_.characterEffect1049ui_story and not isNil(var_12_4) then
					arg_9_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_5)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_5 and arg_9_1.time_ < 0 + var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.characterEffect1049ui_story then
				arg_9_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_12_6 = 0
			local var_12_7 = 0.6

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_8 = arg_9_1:GetWordFromCfg(317252002)
				local var_12_9 = arg_9_1:FormatText(var_12_8.content)

				arg_9_1.text_.text = var_12_9

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 24 <= 0 and var_12_7 or var_12_7 * (utf8.len(var_12_9) / 24)

				if (24 <= 0 and var_12_7 or var_12_7 * (utf8.len(var_12_9) / 24)) > 0 and var_12_7 < var_12_11 then
					arg_9_1.talkMaxDuration = var_12_11

					if var_12_11 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_11 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_9
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252002", "story_v_out_317252.awb") ~= 0 then
					local var_12_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252002", "story_v_out_317252.awb") / 1000

					if var_12_12 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_6
					end

					if var_12_8.prefab_name ~= "" and arg_9_1.actors_[var_12_8.prefab_name] ~= nil then
						local var_12_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_8.prefab_name].transform, "story_v_out_317252", "317252002", "story_v_out_317252.awb")

						arg_9_1:RecordAudio("317252002", var_12_13)
						arg_9_1:RecordAudio("317252002", var_12_13)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317252", "317252002", "story_v_out_317252.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317252", "317252002", "story_v_out_317252.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_14 and arg_9_1.time_ < var_12_6 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play317252003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317252003
		arg_13_1.duration_ = 2.23

		local var_13_0 = {
			zh = 2.233,
			ja = 2.2
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317252004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1049ui_story = arg_13_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).z)
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles = arg_13_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_13_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).z)
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles = arg_13_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1049ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1049ui_story == nil then
				arg_13_1.var_.characterEffect1049ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1049ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1049ui_story then
				arg_13_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_4 = arg_13_1.actors_["1058ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1058ui_story == nil then
				arg_13_1.var_.characterEffect1058ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_5 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 and not isNil(var_16_4) then
				if arg_13_1.var_.characterEffect1058ui_story and not isNil(var_16_4) then
					arg_13_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_5)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1058ui_story then
				arg_13_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_16_6 = 0
			local var_16_7 = 0.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(317252003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 9 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 9)

				if (9 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 9)) > 0 and var_16_7 < var_16_11 then
					arg_13_1.talkMaxDuration = var_16_11

					if var_16_11 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252003", "story_v_out_317252.awb") ~= 0 then
					local var_16_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252003", "story_v_out_317252.awb") / 1000

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end

					if var_16_8.prefab_name ~= "" and arg_13_1.actors_[var_16_8.prefab_name] ~= nil then
						local var_16_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_8.prefab_name].transform, "story_v_out_317252", "317252003", "story_v_out_317252.awb")

						arg_13_1:RecordAudio("317252003", var_16_13)
						arg_13_1:RecordAudio("317252003", var_16_13)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317252", "317252003", "story_v_out_317252.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317252", "317252003", "story_v_out_317252.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play317252004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317252004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317252005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1058ui_story = arg_17_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1058ui_story"].transform.position).z)
				arg_17_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1058ui_story"].transform.localEulerAngles = arg_17_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -5.88)
				arg_17_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1058ui_story"].transform.position).z)
				arg_17_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1058ui_story"].transform.localEulerAngles = arg_17_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1058ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1058ui_story == nil then
				arg_17_1.var_.characterEffect1058ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1058ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1058ui_story then
				arg_17_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = arg_17_1.actors_["1049ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1049ui_story == nil then
				arg_17_1.var_.characterEffect1049ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect1049ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1049ui_story then
				arg_17_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_20_6 = 0
			local var_20_7 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(317252004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 3 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 3)

				if (3 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 3)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252004", "story_v_out_317252.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252004", "story_v_out_317252.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_317252", "317252004", "story_v_out_317252.awb")

						arg_17_1:RecordAudio("317252004", var_20_13)
						arg_17_1:RecordAudio("317252004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317252", "317252004", "story_v_out_317252.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317252", "317252004", "story_v_out_317252.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play317252005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317252005
		arg_21_1.duration_ = 3.53

		local var_21_0 = {
			zh = 3.533,
			ja = 2.933
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317252006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1049ui_story = arg_21_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1049ui_story"].transform.position).z)
				arg_21_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1049ui_story"].transform.localEulerAngles = arg_21_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_21_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1049ui_story"].transform.position).z)
				arg_21_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1049ui_story"].transform.localEulerAngles = arg_21_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1049ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1049ui_story == nil then
				arg_21_1.var_.characterEffect1049ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1049ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1049ui_story then
				arg_21_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = arg_21_1.actors_["1058ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1058ui_story == nil then
				arg_21_1.var_.characterEffect1058ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect1058ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1058ui_story then
				arg_21_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_24_6 = 0
			local var_24_7 = 0.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(317252005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 7 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 7)

				if (7 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 7)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252005", "story_v_out_317252.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252005", "story_v_out_317252.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_317252", "317252005", "story_v_out_317252.awb")

						arg_21_1:RecordAudio("317252005", var_24_13)
						arg_21_1:RecordAudio("317252005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317252", "317252005", "story_v_out_317252.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317252", "317252005", "story_v_out_317252.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play317252006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317252006
		arg_25_1.duration_ = 14.57

		local var_25_0 = {
			zh = 7.466,
			ja = 14.566
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317252007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1058ui_story = arg_25_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1058ui_story"].transform.position).z)
				arg_25_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1058ui_story"].transform.localEulerAngles = arg_25_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -5.88)
				arg_25_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1058ui_story"].transform.position).z)
				arg_25_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1058ui_story"].transform.localEulerAngles = arg_25_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1058ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1058ui_story == nil then
				arg_25_1.var_.characterEffect1058ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1058ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1058ui_story then
				arg_25_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = arg_25_1.actors_["1049ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1049ui_story == nil then
				arg_25_1.var_.characterEffect1049ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect1049ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1049ui_story then
				arg_25_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_28_6 = 0
			local var_28_7 = 0.925

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(317252006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 37 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 37)

				if (37 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 37)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252006", "story_v_out_317252.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252006", "story_v_out_317252.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_317252", "317252006", "story_v_out_317252.awb")

						arg_25_1:RecordAudio("317252006", var_28_13)
						arg_25_1:RecordAudio("317252006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317252", "317252006", "story_v_out_317252.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317252", "317252006", "story_v_out_317252.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play317252007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317252007
		arg_29_1.duration_ = 6.23

		local var_29_0 = {
			zh = 5.066,
			ja = 6.233
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play317252008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(317252007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 21)

				if (21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 21)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252007", "story_v_out_317252.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252007", "story_v_out_317252.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_317252", "317252007", "story_v_out_317252.awb")

						arg_29_1:RecordAudio("317252007", var_32_6)
						arg_29_1:RecordAudio("317252007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317252", "317252007", "story_v_out_317252.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317252", "317252007", "story_v_out_317252.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play317252008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317252008
		arg_33_1.duration_ = 7.33

		local var_33_0 = {
			zh = 7.333,
			ja = 4.5
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317252009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1049ui_story = arg_33_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).z)
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles = arg_33_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_33_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).z)
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles = arg_33_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1049ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1049ui_story == nil then
				arg_33_1.var_.characterEffect1049ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1049ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1049ui_story then
				arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(317252008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 25 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 25)

				if (25 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 25)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252008", "story_v_out_317252.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252008", "story_v_out_317252.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_317252", "317252008", "story_v_out_317252.awb")

						arg_33_1:RecordAudio("317252008", var_36_11)
						arg_33_1:RecordAudio("317252008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317252", "317252008", "story_v_out_317252.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317252", "317252008", "story_v_out_317252.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play317252009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317252009
		arg_37_1.duration_ = 16.07

		local var_37_0 = {
			zh = 11.466,
			ja = 16.066
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play317252010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1058ui_story = arg_37_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).z)
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles = arg_37_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -5.88)
				arg_37_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).z)
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles = arg_37_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1058ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1058ui_story == nil then
				arg_37_1.var_.characterEffect1058ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1058ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1058ui_story then
				arg_37_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_40_4 = arg_37_1.actors_["1049ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1049ui_story == nil then
				arg_37_1.var_.characterEffect1049ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect1049ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1049ui_story then
				arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_40_6 = 0
			local var_40_7 = 1.35

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(317252009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 54 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 54)

				if (54 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 54)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252009", "story_v_out_317252.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252009", "story_v_out_317252.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_317252", "317252009", "story_v_out_317252.awb")

						arg_37_1:RecordAudio("317252009", var_40_13)
						arg_37_1:RecordAudio("317252009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317252", "317252009", "story_v_out_317252.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317252", "317252009", "story_v_out_317252.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play317252010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317252010
		arg_41_1.duration_ = 12.97

		local var_41_0 = {
			zh = 11.8,
			ja = 12.966
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317252011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1049ui_story = arg_41_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1049ui_story"].transform.position).z)
				arg_41_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1049ui_story"].transform.localEulerAngles = arg_41_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_41_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1049ui_story"].transform.position).z)
				arg_41_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1049ui_story"].transform.localEulerAngles = arg_41_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1049ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1049ui_story == nil then
				arg_41_1.var_.characterEffect1049ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1049ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1049ui_story then
				arg_41_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_44_4 = arg_41_1.actors_["1058ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1058ui_story == nil then
				arg_41_1.var_.characterEffect1058ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1058ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1058ui_story then
				arg_41_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_44_6 = 0
			local var_44_7 = 1.05

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(317252010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 42 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 42)

				if (42 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 42)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252010", "story_v_out_317252.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252010", "story_v_out_317252.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_317252", "317252010", "story_v_out_317252.awb")

						arg_41_1:RecordAudio("317252010", var_44_13)
						arg_41_1:RecordAudio("317252010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317252", "317252010", "story_v_out_317252.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317252", "317252010", "story_v_out_317252.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play317252011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317252011
		arg_45_1.duration_ = 9.47

		local var_45_0 = {
			zh = 5.366,
			ja = 9.466
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317252012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1058ui_story = arg_45_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).z)
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles = arg_45_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -5.88)
				arg_45_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).z)
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles = arg_45_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1058ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1058ui_story == nil then
				arg_45_1.var_.characterEffect1058ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1058ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1058ui_story then
				arg_45_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action6_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = arg_45_1.actors_["1049ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1049ui_story == nil then
				arg_45_1.var_.characterEffect1049ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect1049ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1049ui_story then
				arg_45_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_48_6 = 0
			local var_48_7 = 0.7

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(317252011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 28 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 28)

				if (28 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 28)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252011", "story_v_out_317252.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252011", "story_v_out_317252.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_317252", "317252011", "story_v_out_317252.awb")

						arg_45_1:RecordAudio("317252011", var_48_13)
						arg_45_1:RecordAudio("317252011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317252", "317252011", "story_v_out_317252.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317252", "317252011", "story_v_out_317252.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play317252012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317252012
		arg_49_1.duration_ = 3.7

		local var_49_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play317252013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1049ui_story = arg_49_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1049ui_story"].transform.position).z)
				arg_49_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1049ui_story"].transform.localEulerAngles = arg_49_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_49_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1049ui_story"].transform.position).z)
				arg_49_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1049ui_story"].transform.localEulerAngles = arg_49_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1049ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1049ui_story == nil then
				arg_49_1.var_.characterEffect1049ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1049ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1049ui_story then
				arg_49_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["1058ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1058ui_story == nil then
				arg_49_1.var_.characterEffect1058ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1058ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1058ui_story then
				arg_49_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.2

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(317252012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 8 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 8)

				if (8 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 8)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252012", "story_v_out_317252.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252012", "story_v_out_317252.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_317252", "317252012", "story_v_out_317252.awb")

						arg_49_1:RecordAudio("317252012", var_52_13)
						arg_49_1:RecordAudio("317252012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317252", "317252012", "story_v_out_317252.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317252", "317252012", "story_v_out_317252.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play317252013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317252013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play317252014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1058ui_story = arg_53_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).z)
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles = arg_53_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -5.88)
				arg_53_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).z)
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles = arg_53_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1058ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1058ui_story == nil then
				arg_53_1.var_.characterEffect1058ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1058ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1058ui_story then
				arg_53_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_56_4 = arg_53_1.actors_["1049ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1049ui_story == nil then
				arg_53_1.var_.characterEffect1049ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_5 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and not isNil(var_56_4) then
				if arg_53_1.var_.characterEffect1049ui_story and not isNil(var_56_4) then
					arg_53_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_5)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1049ui_story then
				arg_53_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_56_6 = 0
			local var_56_7 = 0.075

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(317252013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 3 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 3)

				if (3 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 3)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252013", "story_v_out_317252.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252013", "story_v_out_317252.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_317252", "317252013", "story_v_out_317252.awb")

						arg_53_1:RecordAudio("317252013", var_56_13)
						arg_53_1:RecordAudio("317252013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317252", "317252013", "story_v_out_317252.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317252", "317252013", "story_v_out_317252.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play317252014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317252014
		arg_57_1.duration_ = 7.33

		local var_57_0 = {
			zh = 7.333,
			ja = 5.533
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play317252015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1049ui_story = arg_57_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1049ui_story"].transform.position).z)
				arg_57_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1049ui_story"].transform.localEulerAngles = arg_57_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_57_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1049ui_story"].transform.position).z)
				arg_57_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1049ui_story"].transform.localEulerAngles = arg_57_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1049ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1049ui_story == nil then
				arg_57_1.var_.characterEffect1049ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1049ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1049ui_story then
				arg_57_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = arg_57_1.actors_["1058ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1058ui_story == nil then
				arg_57_1.var_.characterEffect1058ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect1058ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1058ui_story then
				arg_57_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_60_6 = 0
			local var_60_7 = 0.775

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(317252014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 31 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 31)

				if (31 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 31)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252014", "story_v_out_317252.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252014", "story_v_out_317252.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_317252", "317252014", "story_v_out_317252.awb")

						arg_57_1:RecordAudio("317252014", var_60_13)
						arg_57_1:RecordAudio("317252014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317252", "317252014", "story_v_out_317252.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317252", "317252014", "story_v_out_317252.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play317252015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317252015
		arg_61_1.duration_ = 13.23

		local var_61_0 = {
			zh = 8.7,
			ja = 13.233
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317252016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.875

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(317252015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 35 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 35)

				if (35 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 35)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252015", "story_v_out_317252.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252015", "story_v_out_317252.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_317252", "317252015", "story_v_out_317252.awb")

						arg_61_1:RecordAudio("317252015", var_64_6)
						arg_61_1:RecordAudio("317252015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317252", "317252015", "story_v_out_317252.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317252", "317252015", "story_v_out_317252.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play317252016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317252016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317252017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1049ui_story = arg_65_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1049ui_story"].transform.position).z)
				arg_65_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1049ui_story"].transform.localEulerAngles = arg_65_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1049ui_story"].transform.position).z)
				arg_65_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1049ui_story"].transform.localEulerAngles = arg_65_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1058ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1058ui_story = var_68_1.localPosition
			end

			local var_68_2 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 then
				var_68_1.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_2)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 then
				var_68_1.localPosition = Vector3.New(0, 100, 0)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			local var_68_3 = 0
			local var_68_4 = 0.4

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(317252016).content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 16 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 16)

				if (16 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 16)) > 0 and var_68_4 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_3) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_3 + var_68_8 and arg_65_1.time_ < var_68_3 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play317252017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317252017
		arg_69_1.duration_ = 3.97

		local var_69_0 = {
			zh = 2.333,
			ja = 3.966
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317252018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1049ui_story = arg_69_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1049ui_story"].transform.position).z)
				arg_69_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1049ui_story"].transform.localEulerAngles = arg_69_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_69_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1049ui_story"].transform.position).z)
				arg_69_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1049ui_story"].transform.localEulerAngles = arg_69_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1049ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1049ui_story == nil then
				arg_69_1.var_.characterEffect1049ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1049ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1049ui_story then
				arg_69_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.275

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(317252017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 12 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 12)

				if (12 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 12)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252017", "story_v_out_317252.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252017", "story_v_out_317252.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_317252", "317252017", "story_v_out_317252.awb")

						arg_69_1:RecordAudio("317252017", var_72_11)
						arg_69_1:RecordAudio("317252017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317252", "317252017", "story_v_out_317252.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317252", "317252017", "story_v_out_317252.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play317252018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317252018
		arg_73_1.duration_ = 3.9

		local var_73_0 = {
			zh = 2.6,
			ja = 3.9
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317252019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.actors_["1158ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1158ui_story"))) then
				local var_76_0 = Object.Instantiate(Asset.Load("Char/" .. "1158ui_story"), arg_73_1.stage_.transform)

				var_76_0.name = "1158ui_story"
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1158ui_story"] = var_76_0

				local var_76_1 = var_76_0:GetComponentInChildren(typeof(CharacterEffect))

				var_76_1.enabled = true

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_1.transform, false)

				arg_73_1.var_["1158ui_story" .. "Animator"] = var_76_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_["1158ui_story" .. "Animator"].applyRootMotion = true
				arg_73_1.var_["1158ui_story" .. "LipSync"] = var_76_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_3 = arg_73_1.actors_["1158ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1158ui_story = var_76_3.localPosition
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_73_1.time_ - 0) / var_76_4)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0, -0.95, -6)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			local var_76_5 = arg_73_1.actors_["1158ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1158ui_story == nil then
				arg_73_1.var_.characterEffect1158ui_story = var_76_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.characterEffect1158ui_story and not isNil(var_76_5) then
					arg_73_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1158ui_story then
				arg_73_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action3_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_8 = arg_73_1.actors_["1049ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1049ui_story = var_76_8.localPosition
			end

			local var_76_9 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 then
				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_9)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(0, 100, 0)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles
			end

			local var_76_10 = arg_73_1.actors_["1049ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_10) and arg_73_1.var_.characterEffect1049ui_story == nil then
				arg_73_1.var_.characterEffect1049ui_story = var_76_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_11 and not isNil(var_76_10) then
				if arg_73_1.var_.characterEffect1049ui_story and not isNil(var_76_10) then
					arg_73_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_11)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_11 and arg_73_1.time_ < 0 + var_76_11 + arg_76_0 and not isNil(var_76_10) and arg_73_1.var_.characterEffect1049ui_story then
				arg_73_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_76_12 = 0
			local var_76_13 = 0.325

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(317252018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 13 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 13)

				if (13 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 13)) > 0 and var_76_13 < var_76_17 then
					arg_73_1.talkMaxDuration = var_76_17

					if var_76_17 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252018", "story_v_out_317252.awb") ~= 0 then
					local var_76_18 = manager.audio:GetVoiceLength("story_v_out_317252", "317252018", "story_v_out_317252.awb") / 1000

					if var_76_18 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_12
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_317252", "317252018", "story_v_out_317252.awb")

						arg_73_1:RecordAudio("317252018", var_76_19)
						arg_73_1:RecordAudio("317252018", var_76_19)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317252", "317252018", "story_v_out_317252.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317252", "317252018", "story_v_out_317252.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_20 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_20 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_20

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_20 and arg_73_1.time_ < var_76_12 + var_76_20 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play317252019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317252019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play317252020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1158ui_story = arg_77_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1158ui_story"].transform.position).z)
				arg_77_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1158ui_story"].transform.localEulerAngles = arg_77_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1158ui_story"].transform.position).z)
				arg_77_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1158ui_story"].transform.localEulerAngles = arg_77_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_80_1 = 0
			local var_80_2 = 1.225

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(317252019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 49 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 49)

				if (49 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 49)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play317252020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317252020
		arg_81_1.duration_ = 11.97

		local var_81_0 = {
			zh = 7.466,
			ja = 11.966
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317252021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1049ui_story = arg_81_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1049ui_story"].transform.position).z)
				arg_81_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1049ui_story"].transform.localEulerAngles = arg_81_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_81_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1049ui_story"].transform.position).z)
				arg_81_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1049ui_story"].transform.localEulerAngles = arg_81_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1049ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1049ui_story == nil then
				arg_81_1.var_.characterEffect1049ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1049ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1049ui_story then
				arg_81_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_84_3 = arg_81_1.actors_["1158ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1158ui_story = var_84_3.localPosition
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_3.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1158ui_story, Vector3.New(0.7, -0.95, -6), (arg_81_1.time_ - 0) / var_84_4)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_3.localPosition = Vector3.New(0.7, -0.95, -6)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			local var_84_5 = arg_81_1.actors_["1158ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1158ui_story == nil then
				arg_81_1.var_.characterEffect1158ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.characterEffect1158ui_story and not isNil(var_84_5) then
					arg_81_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1158ui_story then
				arg_81_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_84_8 = 0
			local var_84_9 = 0.9

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(317252020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 36 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 36)

				if (36 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 36)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252020", "story_v_out_317252.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_317252", "317252020", "story_v_out_317252.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_317252", "317252020", "story_v_out_317252.awb")

						arg_81_1:RecordAudio("317252020", var_84_15)
						arg_81_1:RecordAudio("317252020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_317252", "317252020", "story_v_out_317252.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_317252", "317252020", "story_v_out_317252.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play317252021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317252021
		arg_85_1.duration_ = 13.37

		local var_85_0 = {
			zh = 10.033,
			ja = 13.366
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play317252022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1158ui_story = arg_85_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1158ui_story, Vector3.New(0.7, -0.95, -6), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1158ui_story"].transform.position).z)
				arg_85_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1158ui_story"].transform.localEulerAngles = arg_85_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6)
				arg_85_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1158ui_story"].transform.position).z)
				arg_85_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1158ui_story"].transform.localEulerAngles = arg_85_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1158ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1158ui_story == nil then
				arg_85_1.var_.characterEffect1158ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1158ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1158ui_story then
				arg_85_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action3_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = 0
			local var_88_5 = 1.05

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(317252021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 42 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 42)

				if (42 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 42)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252021", "story_v_out_317252.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252021", "story_v_out_317252.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_317252", "317252021", "story_v_out_317252.awb")

						arg_85_1:RecordAudio("317252021", var_88_11)
						arg_85_1:RecordAudio("317252021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317252", "317252021", "story_v_out_317252.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317252", "317252021", "story_v_out_317252.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play317252022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317252022
		arg_89_1.duration_ = 4.1

		local var_89_0 = {
			zh = 4.1,
			ja = 2.133
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317252023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1049ui_story = arg_89_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).z)
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles = arg_89_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_89_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).z)
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles = arg_89_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1049ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1049ui_story == nil then
				arg_89_1.var_.characterEffect1049ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1049ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1049ui_story then
				arg_89_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_4 = arg_89_1.actors_["1158ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1158ui_story = var_92_4.localPosition
			end

			local var_92_5 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 then
				var_92_4.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_5)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 then
				var_92_4.localPosition = Vector3.New(0, 100, 0)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			local var_92_6 = arg_89_1.actors_["1158ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1158ui_story == nil then
				arg_89_1.var_.characterEffect1158ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_7 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 and not isNil(var_92_6) then
				if arg_89_1.var_.characterEffect1158ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_7)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1158ui_story then
				arg_89_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_92_8 = 0
			local var_92_9 = 0.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(317252022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 16 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 16)

				if (16 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 16)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252022", "story_v_out_317252.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_317252", "317252022", "story_v_out_317252.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_317252", "317252022", "story_v_out_317252.awb")

						arg_89_1:RecordAudio("317252022", var_92_15)
						arg_89_1:RecordAudio("317252022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_317252", "317252022", "story_v_out_317252.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_317252", "317252022", "story_v_out_317252.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_16 and arg_89_1.time_ < var_92_8 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play317252023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317252023
		arg_93_1.duration_ = 22.97

		local var_93_0 = {
			zh = 9.933,
			ja = 22.966
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play317252024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1158ui_story = arg_93_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1158ui_story"].transform.position).z)
				arg_93_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1158ui_story"].transform.localEulerAngles = arg_93_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_93_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1158ui_story"].transform.position).z)
				arg_93_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1158ui_story"].transform.localEulerAngles = arg_93_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1158ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1158ui_story == nil then
				arg_93_1.var_.characterEffect1158ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1158ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1158ui_story then
				arg_93_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action7_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = arg_93_1.actors_["1049ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1049ui_story = var_96_4.localPosition
			end

			local var_96_5 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 then
				var_96_4.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_5)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 then
				var_96_4.localPosition = Vector3.New(0, 100, 0)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			local var_96_6 = arg_93_1.actors_["1049ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1049ui_story == nil then
				arg_93_1.var_.characterEffect1049ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 and not isNil(var_96_6) then
				if arg_93_1.var_.characterEffect1049ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_7)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1049ui_story then
				arg_93_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_96_8 = 0
			local var_96_9 = 1.1

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(317252023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 44 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 44)

				if (44 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 44)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252023", "story_v_out_317252.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_317252", "317252023", "story_v_out_317252.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_317252", "317252023", "story_v_out_317252.awb")

						arg_93_1:RecordAudio("317252023", var_96_15)
						arg_93_1:RecordAudio("317252023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_317252", "317252023", "story_v_out_317252.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_317252", "317252023", "story_v_out_317252.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play317252024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317252024
		arg_97_1.duration_ = 8.23

		local var_97_0 = {
			zh = 4.866,
			ja = 8.233
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play317252025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_0 = 0
			local var_100_1 = 0.45

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(317252024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 18 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 18)

				if (18 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 18)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252024", "story_v_out_317252.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_317252", "317252024", "story_v_out_317252.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_317252", "317252024", "story_v_out_317252.awb")

						arg_97_1:RecordAudio("317252024", var_100_7)
						arg_97_1:RecordAudio("317252024", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_317252", "317252024", "story_v_out_317252.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_317252", "317252024", "story_v_out_317252.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play317252025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317252025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play317252026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1158ui_story = arg_101_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1158ui_story"].transform.position).z)
				arg_101_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1158ui_story"].transform.localEulerAngles = arg_101_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1158ui_story"].transform.position).z)
				arg_101_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1158ui_story"].transform.localEulerAngles = arg_101_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1158ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1158ui_story == nil then
				arg_101_1.var_.characterEffect1158ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1158ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_2)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1158ui_story then
				arg_101_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_104_3 = 0
			local var_104_4 = 0.85

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_5 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(317252025).content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 34 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 34)

				if (34 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 34)) > 0 and var_104_4 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_3 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_3
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_4, arg_101_1.talkMaxDuration)

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_3) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_3 + var_104_8 and arg_101_1.time_ < var_104_3 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play317252026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317252026
		arg_105_1.duration_ = 6.27

		local var_105_0 = {
			zh = 6.266,
			ja = 3.733
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play317252027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1049ui_story = arg_105_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1049ui_story"].transform.position).z)
				arg_105_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1049ui_story"].transform.localEulerAngles = arg_105_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_105_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1049ui_story"].transform.position).z)
				arg_105_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1049ui_story"].transform.localEulerAngles = arg_105_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1049ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1049ui_story == nil then
				arg_105_1.var_.characterEffect1049ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1049ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1049ui_story then
				arg_105_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(317252026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 19 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 19)

				if (19 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 19)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252026", "story_v_out_317252.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252026", "story_v_out_317252.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_317252", "317252026", "story_v_out_317252.awb")

						arg_105_1:RecordAudio("317252026", var_108_11)
						arg_105_1:RecordAudio("317252026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317252", "317252026", "story_v_out_317252.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317252", "317252026", "story_v_out_317252.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play317252027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317252027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play317252028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1049ui_story = arg_109_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).z)
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles = arg_109_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).z)
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles = arg_109_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1049ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1049ui_story == nil then
				arg_109_1.var_.characterEffect1049ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1049ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1049ui_story then
				arg_109_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_112_3 = 0
			local var_112_4 = 0.725

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(317252027).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 29 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 29)

				if (29 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 29)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play317252028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317252028
		arg_113_1.duration_ = 6.3

		local var_113_0 = {
			zh = 3.7,
			ja = 6.3
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play317252029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1058ui_story = arg_113_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1058ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1058ui_story"].transform.position).z)
				arg_113_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1058ui_story"].transform.localEulerAngles = arg_113_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				arg_113_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1058ui_story"].transform.position).z)
				arg_113_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1058ui_story"].transform.localEulerAngles = arg_113_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1058ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1058ui_story == nil then
				arg_113_1.var_.characterEffect1058ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1058ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1058ui_story then
				arg_113_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_4 = arg_113_1.actors_["1158ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1158ui_story = var_116_4.localPosition
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1158ui_story, Vector3.New(0.7, -0.95, -6), (arg_113_1.time_ - 0) / var_116_5)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(0.7, -0.95, -6)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			local var_116_6 = arg_113_1.actors_["1158ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1158ui_story == nil then
				arg_113_1.var_.characterEffect1158ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 and not isNil(var_116_6) then
				if arg_113_1.var_.characterEffect1158ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_7)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1158ui_story then
				arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_116_8 = 0
			local var_116_9 = 0.5

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(317252028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 20 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 20)

				if (20 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 20)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252028", "story_v_out_317252.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_317252", "317252028", "story_v_out_317252.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_317252", "317252028", "story_v_out_317252.awb")

						arg_113_1:RecordAudio("317252028", var_116_15)
						arg_113_1:RecordAudio("317252028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_317252", "317252028", "story_v_out_317252.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_317252", "317252028", "story_v_out_317252.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play317252029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317252029
		arg_117_1.duration_ = 6.97

		local var_117_0 = {
			zh = 3.266,
			ja = 6.966
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play317252030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1158ui_story = arg_117_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1158ui_story, Vector3.New(0.7, -0.95, -6), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1158ui_story"].transform.position).z)
				arg_117_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1158ui_story"].transform.localEulerAngles = arg_117_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6)
				arg_117_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1158ui_story"].transform.position).z)
				arg_117_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1158ui_story"].transform.localEulerAngles = arg_117_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1158ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1158ui_story == nil then
				arg_117_1.var_.characterEffect1158ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1158ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1158ui_story then
				arg_117_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action7_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = arg_117_1.actors_["1058ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1058ui_story == nil then
				arg_117_1.var_.characterEffect1058ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect1058ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1058ui_story then
				arg_117_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_120_6 = 0
			local var_120_7 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(317252029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 13 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 13)

				if (13 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 13)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252029", "story_v_out_317252.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252029", "story_v_out_317252.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_317252", "317252029", "story_v_out_317252.awb")

						arg_117_1:RecordAudio("317252029", var_120_13)
						arg_117_1:RecordAudio("317252029", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_317252", "317252029", "story_v_out_317252.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_317252", "317252029", "story_v_out_317252.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play317252030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317252030
		arg_121_1.duration_ = 4.7

		local var_121_0 = {
			zh = 3.033,
			ja = 4.7
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play317252031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1058ui_story = arg_121_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1058ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1058ui_story"].transform.position).z)
				arg_121_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1058ui_story"].transform.localEulerAngles = arg_121_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				arg_121_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1058ui_story"].transform.position).z)
				arg_121_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1058ui_story"].transform.localEulerAngles = arg_121_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1058ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1058ui_story == nil then
				arg_121_1.var_.characterEffect1058ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1058ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1058ui_story then
				arg_121_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_4 = arg_121_1.actors_["1158ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1158ui_story == nil then
				arg_121_1.var_.characterEffect1158ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect1158ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1158ui_story then
				arg_121_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_124_6 = 0
			local var_124_7 = 0.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(317252030)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 7 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 7)

				if (7 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 7)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252030", "story_v_out_317252.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252030", "story_v_out_317252.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_317252", "317252030", "story_v_out_317252.awb")

						arg_121_1:RecordAudio("317252030", var_124_13)
						arg_121_1:RecordAudio("317252030", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_317252", "317252030", "story_v_out_317252.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_317252", "317252030", "story_v_out_317252.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play317252031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317252031
		arg_125_1.duration_ = 7

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317252032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.bgs_.STblack == nil then
				local var_128_0 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_128_0.name = "STblack"
				var_128_0.transform.parent = arg_125_1.stage_.transform
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_.STblack = var_128_0
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				local var_128_1 = arg_125_1.bgs_.STblack

				arg_125_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_2 = var_128_1:GetComponent("SpriteRenderer")

				if var_128_2 and var_128_2.sprite then
					local var_128_3 = 2 * (var_128_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_1.transform.localScale = Vector3.New(var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "STblack" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_4 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_5 = 2

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_5 then
				local var_128_6 = Color.New(0, 0, 0)

				var_128_6.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_4) / var_128_5)
				arg_125_1.mask_.color = var_128_6
			end

			if arg_125_1.time_ >= var_128_4 + var_128_5 and arg_125_1.time_ < var_128_4 + var_128_5 + arg_128_0 then
				local var_128_7 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_7.a = 0
				arg_125_1.mask_.color = var_128_7
			end

			local var_128_8 = arg_125_1.actors_["1058ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1058ui_story = var_128_8.localPosition
			end

			local var_128_9 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 then
				var_128_8.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_9)
				var_128_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_8.position).x, (manager.ui.mainCamera.transform.position - var_128_8.position).y, (manager.ui.mainCamera.transform.position - var_128_8.position).z)
				var_128_8.localEulerAngles.z = 0
				var_128_8.localEulerAngles.x = 0
				var_128_8.localEulerAngles = var_128_8.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 then
				var_128_8.localPosition = Vector3.New(0, 100, 0)
				var_128_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_8.position).x, (manager.ui.mainCamera.transform.position - var_128_8.position).y, (manager.ui.mainCamera.transform.position - var_128_8.position).z)
				var_128_8.localEulerAngles.z = 0
				var_128_8.localEulerAngles.x = 0
				var_128_8.localEulerAngles = var_128_8.localEulerAngles
			end

			local var_128_10 = arg_125_1.actors_["1158ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1158ui_story = var_128_10.localPosition
			end

			local var_128_11 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_11 then
				var_128_10.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_11)
				var_128_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_10.position).x, (manager.ui.mainCamera.transform.position - var_128_10.position).y, (manager.ui.mainCamera.transform.position - var_128_10.position).z)
				var_128_10.localEulerAngles.z = 0
				var_128_10.localEulerAngles.x = 0
				var_128_10.localEulerAngles = var_128_10.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_11 and arg_125_1.time_ < 0 + var_128_11 + arg_128_0 then
				var_128_10.localPosition = Vector3.New(0, 100, 0)
				var_128_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_10.position).x, (manager.ui.mainCamera.transform.position - var_128_10.position).y, (manager.ui.mainCamera.transform.position - var_128_10.position).z)
				var_128_10.localEulerAngles.z = 0
				var_128_10.localEulerAngles.x = 0
				var_128_10.localEulerAngles = var_128_10.localEulerAngles
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_12 = 2
			local var_128_13 = 1.05

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_14 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_14:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(317252031).content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 42 <= 0 and var_128_13 or var_128_13 * (utf8.len(var_128_15) / 42)

				if (42 <= 0 and var_128_13 or var_128_13 * (utf8.len(var_128_15) / 42)) > 0 and var_128_13 < var_128_17 then
					arg_125_1.talkMaxDuration = var_128_17
					var_128_12 = var_128_12 + 0.3

					if var_128_17 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_18 = var_128_12 + 0.3
			local var_128_19 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_19 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_18) / var_128_19

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_18 + var_128_19 and arg_125_1.time_ < var_128_18 + var_128_19 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play317252032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 317252032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play317252033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.3

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(317252032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 52 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 52)

				if (52 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 52)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play317252033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 317252033
		arg_135_1.duration_ = 1.67

		local var_135_0 = {
			zh = 1.666,
			ja = 1.2
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play317252034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_138_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_135_1.bgmTxt_.text ~= var_138_2 and arg_135_1.bgmTxt_.text ~= "" then
						if arg_135_1.bgmTxt2_.text ~= "" then
							arg_135_1.bgmTxt_.text = arg_135_1.bgmTxt2_.text
						end

						arg_135_1.bgmTxt2_.text = var_138_2

						arg_135_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_135_1.bgmTxt_.text = var_138_2
						arg_135_1.bgmTxt2_.text = var_138_2
					end

					if arg_135_1.bgmTimer then
						arg_135_1.bgmTimer:Stop()

						arg_135_1.bgmTimer = nil
					end

					if arg_135_1.settingData.show_music_name == 1 then
						arg_135_1.musicController:SetSelectedState("show")
						arg_135_1.musicAnimator_:Play("open", 0, 0)

						if arg_135_1.settingData.music_time ~= 0 then
							arg_135_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_135_1.settingData.music_time), function()
								if arg_135_1 == nil or isNil(arg_135_1.bgmTxt_) then
									return
								end

								arg_135_1.musicController:SetSelectedState("hide")
								arg_135_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_138_3 = 0
			local var_138_4 = 0.125

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1158")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_5 = arg_135_1:GetWordFromCfg(317252033)
				local var_138_6 = arg_135_1:FormatText(var_138_5.content)

				arg_135_1.text_.text = var_138_6

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_8 = 5 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_6) / 5)

				if (5 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_6) / 5)) > 0 and var_138_4 < var_138_8 then
					arg_135_1.talkMaxDuration = var_138_8

					if var_138_8 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_3
					end
				end

				arg_135_1.text_.text = var_138_6
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252033", "story_v_out_317252.awb") ~= 0 then
					local var_138_9 = manager.audio:GetVoiceLength("story_v_out_317252", "317252033", "story_v_out_317252.awb") / 1000

					if var_138_9 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_3
					end

					if var_138_5.prefab_name ~= "" and arg_135_1.actors_[var_138_5.prefab_name] ~= nil then
						local var_138_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_5.prefab_name].transform, "story_v_out_317252", "317252033", "story_v_out_317252.awb")

						arg_135_1:RecordAudio("317252033", var_138_10)
						arg_135_1:RecordAudio("317252033", var_138_10)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_317252", "317252033", "story_v_out_317252.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_317252", "317252033", "story_v_out_317252.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_11 = math.max(var_138_4, arg_135_1.talkMaxDuration)

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_11 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_3) / var_138_11

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_3 + var_138_11 and arg_135_1.time_ < var_138_3 + var_138_11 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play317252034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 317252034
		arg_140_1.duration_ = 7

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play317252035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if arg_140_1.bgs_.STwhite == nil then
				local var_143_0 = Object.Instantiate(arg_140_1.paintGo_)

				var_143_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_143_0.name = "STwhite"
				var_143_0.transform.parent = arg_140_1.stage_.transform
				var_143_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.bgs_.STwhite = var_143_0
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				local var_143_1 = arg_140_1.bgs_.STwhite

				arg_140_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_143_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_2 = var_143_1:GetComponent("SpriteRenderer")

				if var_143_2 and var_143_2.sprite then
					local var_143_3 = 2 * (var_143_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_143_1.transform.localScale = Vector3.New(var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "STwhite" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_4 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_5 = 2

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_5 then
				local var_143_6 = Color.New(0, 0, 0)

				var_143_6.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_4) / var_143_5)
				arg_140_1.mask_.color = var_143_6
			end

			if arg_140_1.time_ >= var_143_4 + var_143_5 and arg_140_1.time_ < var_143_4 + var_143_5 + arg_143_0 then
				local var_143_7 = Color.New(0, 0, 0)

				arg_140_1.mask_.enabled = false
				var_143_7.a = 0
				arg_140_1.mask_.color = var_143_7
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:AudioAction("play", "effect", "se_story_127", "se_story_127_glass", "")
			end

			local var_143_9 = 0

			arg_140_1.isInRecall_ = false

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.screenFilterGo_:SetActive(false)

				for iter_143_2, iter_143_3 in pairs(arg_140_1.actors_) do
					for iter_143_4, iter_143_5 in ipairs((iter_143_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_143_5.color = iter_143_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_143_10 = 0.0166666666666667

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_10 then
				arg_140_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_9) / var_143_10)
			end

			if arg_140_1.time_ >= var_143_9 + var_143_10 and arg_140_1.time_ < var_143_9 + var_143_10 + arg_143_0 then
				arg_140_1.screenFilterEffect_.weight = 0
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_143_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_140_1.bgmTxt_.text ~= var_143_13 and arg_140_1.bgmTxt_.text ~= "" then
						if arg_140_1.bgmTxt2_.text ~= "" then
							arg_140_1.bgmTxt_.text = arg_140_1.bgmTxt2_.text
						end

						arg_140_1.bgmTxt2_.text = var_143_13

						arg_140_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_140_1.bgmTxt_.text = var_143_13
						arg_140_1.bgmTxt2_.text = var_143_13
					end

					if arg_140_1.bgmTimer then
						arg_140_1.bgmTimer:Stop()

						arg_140_1.bgmTimer = nil
					end

					if arg_140_1.settingData.show_music_name == 1 then
						arg_140_1.musicController:SetSelectedState("show")
						arg_140_1.musicAnimator_:Play("open", 0, 0)

						if arg_140_1.settingData.music_time ~= 0 then
							arg_140_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_140_1.settingData.music_time), function()
								if arg_140_1 == nil or isNil(arg_140_1.bgmTxt_) then
									return
								end

								arg_140_1.musicController:SetSelectedState("hide")
								arg_140_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_14 = 2
			local var_143_15 = 0.55

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_14 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_16 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_16:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_140_1.dialogCg_.alpha = arg_145_0
				end))
				var_143_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_17 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(317252034).content)

				arg_140_1.text_.text = var_143_17

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_19 = 22 <= 0 and var_143_15 or var_143_15 * (utf8.len(var_143_17) / 22)

				if (22 <= 0 and var_143_15 or var_143_15 * (utf8.len(var_143_17) / 22)) > 0 and var_143_15 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19
					var_143_14 = var_143_14 + 0.3

					if var_143_19 + var_143_14 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_14
					end
				end

				arg_140_1.text_.text = var_143_17
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_20 = var_143_14 + 0.3
			local var_143_21 = math.max(var_143_15, arg_140_1.talkMaxDuration)

			if var_143_14 + 0.3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_20 + var_143_21 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_20) / var_143_21

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_20 + var_143_21 and arg_140_1.time_ < var_143_20 + var_143_21 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play317252035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 317252035
		arg_147_1.duration_ = 7

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play317252036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.YA0204 == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0204")
				var_150_0.name = "YA0204"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.YA0204 = var_150_0
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.YA0204

				arg_147_1.bgs_.YA0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "YA0204" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_5 = 2

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_5 then
				local var_150_6 = Color.New(1, 1, 1)

				var_150_6.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_4) / var_150_5)
				arg_147_1.mask_.color = var_150_6
			end

			if arg_147_1.time_ >= var_150_4 + var_150_5 and arg_147_1.time_ < var_150_4 + var_150_5 + arg_150_0 then
				local var_150_7 = Color.New(1, 1, 1)

				arg_147_1.mask_.enabled = false
				var_150_7.a = 0
				arg_147_1.mask_.color = var_150_7
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_150_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_147_1.bgmTxt_.text ~= var_150_10 and arg_147_1.bgmTxt_.text ~= "" then
						if arg_147_1.bgmTxt2_.text ~= "" then
							arg_147_1.bgmTxt_.text = arg_147_1.bgmTxt2_.text
						end

						arg_147_1.bgmTxt2_.text = var_150_10

						arg_147_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_147_1.bgmTxt_.text = var_150_10
						arg_147_1.bgmTxt2_.text = var_150_10
					end

					if arg_147_1.bgmTimer then
						arg_147_1.bgmTimer:Stop()

						arg_147_1.bgmTimer = nil
					end

					if arg_147_1.settingData.show_music_name == 1 then
						arg_147_1.musicController:SetSelectedState("show")
						arg_147_1.musicAnimator_:Play("open", 0, 0)

						if arg_147_1.settingData.music_time ~= 0 then
							arg_147_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_147_1.settingData.music_time), function()
								if arg_147_1 == nil or isNil(arg_147_1.bgmTxt_) then
									return
								end

								arg_147_1.musicController:SetSelectedState("hide")
								arg_147_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.733333333333333 < arg_147_1.time_ and arg_147_1.time_ <= 0.733333333333333 + arg_150_0 then
				arg_147_1:AudioAction("play", "music", "bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang.awb")

				local var_150_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang")

				if "" ~= "" then
					if arg_147_1.bgmTxt_.text ~= var_150_13 and arg_147_1.bgmTxt_.text ~= "" then
						if arg_147_1.bgmTxt2_.text ~= "" then
							arg_147_1.bgmTxt_.text = arg_147_1.bgmTxt2_.text
						end

						arg_147_1.bgmTxt2_.text = var_150_13

						arg_147_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_147_1.bgmTxt_.text = var_150_13
						arg_147_1.bgmTxt2_.text = var_150_13
					end

					if arg_147_1.bgmTimer then
						arg_147_1.bgmTimer:Stop()

						arg_147_1.bgmTimer = nil
					end

					if arg_147_1.settingData.show_music_name == 1 then
						arg_147_1.musicController:SetSelectedState("show")
						arg_147_1.musicAnimator_:Play("open", 0, 0)

						if arg_147_1.settingData.music_time ~= 0 then
							arg_147_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_147_1.settingData.music_time), function()
								if arg_147_1 == nil or isNil(arg_147_1.bgmTxt_) then
									return
								end

								arg_147_1.musicController:SetSelectedState("hide")
								arg_147_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_14 = 2
			local var_150_15 = 0.775

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_16 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_16:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_147_1.dialogCg_.alpha = arg_153_0
				end))
				var_150_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_17 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(317252035).content)

				arg_147_1.text_.text = var_150_17

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_19 = 31 <= 0 and var_150_15 or var_150_15 * (utf8.len(var_150_17) / 31)

				if (31 <= 0 and var_150_15 or var_150_15 * (utf8.len(var_150_17) / 31)) > 0 and var_150_15 < var_150_19 then
					arg_147_1.talkMaxDuration = var_150_19
					var_150_14 = var_150_14 + 0.3

					if var_150_19 + var_150_14 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_14
					end
				end

				arg_147_1.text_.text = var_150_17
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_20 = var_150_14 + 0.3
			local var_150_21 = math.max(var_150_15, arg_147_1.talkMaxDuration)

			if var_150_14 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_20 + var_150_21 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_20) / var_150_21

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_20 + var_150_21 and arg_147_1.time_ < var_150_20 + var_150_21 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play317252036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 317252036
		arg_155_1.duration_ = 8.7

		local var_155_0 = {
			zh = 7.966,
			ja = 8.7
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play317252037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.875

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(317252036)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 35 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 35)

				if (35 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 35)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252036", "story_v_out_317252.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252036", "story_v_out_317252.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_317252", "317252036", "story_v_out_317252.awb")

						arg_155_1:RecordAudio("317252036", var_158_6)
						arg_155_1:RecordAudio("317252036", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_317252", "317252036", "story_v_out_317252.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_317252", "317252036", "story_v_out_317252.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play317252037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 317252037
		arg_159_1.duration_ = 11.8

		local var_159_0 = {
			zh = 11,
			ja = 11.8
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play317252038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.05

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(317252037)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 42 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 42)

				if (42 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 42)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252037", "story_v_out_317252.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252037", "story_v_out_317252.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_317252", "317252037", "story_v_out_317252.awb")

						arg_159_1:RecordAudio("317252037", var_162_6)
						arg_159_1:RecordAudio("317252037", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_317252", "317252037", "story_v_out_317252.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_317252", "317252037", "story_v_out_317252.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play317252038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 317252038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play317252039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.65

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(317252038).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 26 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 26)

				if (26 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 26)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play317252039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 317252039
		arg_167_1.duration_ = 2.57

		local var_167_0 = {
			zh = 1.6,
			ja = 2.566
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play317252040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.075

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(317252039)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 3 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 3)

				if (3 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 3)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252039", "story_v_out_317252.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252039", "story_v_out_317252.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_317252", "317252039", "story_v_out_317252.awb")

						arg_167_1:RecordAudio("317252039", var_170_6)
						arg_167_1:RecordAudio("317252039", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_317252", "317252039", "story_v_out_317252.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_317252", "317252039", "story_v_out_317252.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play317252040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 317252040
		arg_171_1.duration_ = 2.17

		local var_171_0 = {
			zh = 2.166,
			ja = 1.9
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play317252041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.125

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(317252040)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 5 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 5)

				if (5 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 5)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252040", "story_v_out_317252.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252040", "story_v_out_317252.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_317252", "317252040", "story_v_out_317252.awb")

						arg_171_1:RecordAudio("317252040", var_174_6)
						arg_171_1:RecordAudio("317252040", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_317252", "317252040", "story_v_out_317252.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_317252", "317252040", "story_v_out_317252.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play317252041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 317252041
		arg_175_1.duration_ = 9.77

		local var_175_0 = {
			zh = 5.566,
			ja = 9.766
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play317252042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.3

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(317252041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 12 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 12)

				if (12 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 12)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252041", "story_v_out_317252.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252041", "story_v_out_317252.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_317252", "317252041", "story_v_out_317252.awb")

						arg_175_1:RecordAudio("317252041", var_178_6)
						arg_175_1:RecordAudio("317252041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_317252", "317252041", "story_v_out_317252.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_317252", "317252041", "story_v_out_317252.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play317252042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317252042
		arg_179_1.duration_ = 3.23

		local var_179_0 = {
			zh = 3.166,
			ja = 3.233
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317252043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.275

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(317252042)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 11 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 11)

				if (11 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 11)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252042", "story_v_out_317252.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252042", "story_v_out_317252.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_317252", "317252042", "story_v_out_317252.awb")

						arg_179_1:RecordAudio("317252042", var_182_6)
						arg_179_1:RecordAudio("317252042", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_317252", "317252042", "story_v_out_317252.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_317252", "317252042", "story_v_out_317252.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play317252043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 317252043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play317252044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.475

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(317252043).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 59 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 59)

				if (59 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 59)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play317252044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 317252044
		arg_187_1.duration_ = 8.97

		local var_187_0 = {
			zh = 5.4,
			ja = 8.966
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play317252045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.3

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(317252044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 12 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 12)

				if (12 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 12)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252044", "story_v_out_317252.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252044", "story_v_out_317252.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_317252", "317252044", "story_v_out_317252.awb")

						arg_187_1:RecordAudio("317252044", var_190_6)
						arg_187_1:RecordAudio("317252044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_317252", "317252044", "story_v_out_317252.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_317252", "317252044", "story_v_out_317252.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play317252045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317252045
		arg_191_1.duration_ = 18.67

		local var_191_0 = {
			zh = 10.133,
			ja = 18.666
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play317252046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.825

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:GetWordFromCfg(317252045)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 33 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 33)

				if (33 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 33)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252045", "story_v_out_317252.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252045", "story_v_out_317252.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_317252", "317252045", "story_v_out_317252.awb")

						arg_191_1:RecordAudio("317252045", var_194_6)
						arg_191_1:RecordAudio("317252045", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_317252", "317252045", "story_v_out_317252.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_317252", "317252045", "story_v_out_317252.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play317252046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317252046
		arg_195_1.duration_ = 16.6

		local var_195_0 = {
			zh = 10.733,
			ja = 16.6
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play317252047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.75

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(317252046)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 30 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 30)

				if (30 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 30)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252046", "story_v_out_317252.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252046", "story_v_out_317252.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_317252", "317252046", "story_v_out_317252.awb")

						arg_195_1:RecordAudio("317252046", var_198_6)
						arg_195_1:RecordAudio("317252046", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_317252", "317252046", "story_v_out_317252.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_317252", "317252046", "story_v_out_317252.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play317252047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317252047
		arg_199_1.duration_ = 20.5

		local var_199_0 = {
			zh = 7.8,
			ja = 20.5
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play317252048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.45

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(317252047)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 18 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 18)

				if (18 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 18)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252047", "story_v_out_317252.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252047", "story_v_out_317252.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_317252", "317252047", "story_v_out_317252.awb")

						arg_199_1:RecordAudio("317252047", var_202_6)
						arg_199_1:RecordAudio("317252047", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_317252", "317252047", "story_v_out_317252.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_317252", "317252047", "story_v_out_317252.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play317252048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317252048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play317252049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(317252048).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 47 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 47)

				if (47 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 47)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play317252049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317252049
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play317252050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(317252049).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 40 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 40)

				if (40 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 40)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play317252050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317252050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play317252051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.325

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(317252050).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 13 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 13)

				if (13 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 13)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play317252051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317252051
		arg_215_1.duration_ = 4

		local var_215_0 = {
			zh = 1.533,
			ja = 4
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play317252052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.125

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(317252051)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 5 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 5)

				if (5 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 5)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252051", "story_v_out_317252.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252051", "story_v_out_317252.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_317252", "317252051", "story_v_out_317252.awb")

						arg_215_1:RecordAudio("317252051", var_218_6)
						arg_215_1:RecordAudio("317252051", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317252", "317252051", "story_v_out_317252.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317252", "317252051", "story_v_out_317252.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play317252052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317252052
		arg_219_1.duration_ = 7

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play317252053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				local var_222_0 = arg_219_1.bgs_.STblack

				arg_219_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_1 = var_222_0:GetComponent("SpriteRenderer")

				if var_222_1 and var_222_1.sprite then
					local var_222_2 = 2 * (var_222_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_0.transform.localScale = Vector3.New(var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "STblack" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_3 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_4 = 2

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_4 then
				local var_222_5 = Color.New(0, 0, 0)

				var_222_5.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_3) / var_222_4)
				arg_219_1.mask_.color = var_222_5
			end

			if arg_219_1.time_ >= var_222_3 + var_222_4 and arg_219_1.time_ < var_222_3 + var_222_4 + arg_222_0 then
				local var_222_6 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_6.a = 0
				arg_219_1.mask_.color = var_222_6
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_7 = 2
			local var_222_8 = 0.65

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_9 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_9:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(317252052).content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_12 = 26 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_10) / 26)

				if (26 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_10) / 26)) > 0 and var_222_8 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12
					var_222_7 = var_222_7 + 0.3

					if var_222_12 + var_222_7 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_7
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_13 = var_222_7 + 0.3
			local var_222_14 = math.max(var_222_8, arg_219_1.talkMaxDuration)

			if var_222_7 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_13 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_13) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_13 + var_222_14 and arg_219_1.time_ < var_222_13 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play317252053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 317252053
		arg_225_1.duration_ = 6.97

		local var_225_0 = {
			zh = 3.733,
			ja = 6.966
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play317252054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if arg_225_1.bgs_.K12f == nil then
				local var_228_0 = Object.Instantiate(arg_225_1.paintGo_)

				var_228_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K12f")
				var_228_0.name = "K12f"
				var_228_0.transform.parent = arg_225_1.stage_.transform
				var_228_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.bgs_.K12f = var_228_0
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				local var_228_1 = arg_225_1.bgs_.K12f

				arg_225_1.bgs_.K12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_228_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_2 = var_228_1:GetComponent("SpriteRenderer")

				if var_228_2 and var_228_2.sprite then
					local var_228_3 = 2 * (var_228_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_228_1.transform.localScale = Vector3.New(var_228_3 / var_228_2.sprite.bounds.size.y < var_228_3 * manager.ui.mainCameraCom_.aspect / var_228_2.sprite.bounds.size.x and var_228_3 * manager.ui.mainCameraCom_.aspect / var_228_2.sprite.bounds.size.x or var_228_3 / var_228_2.sprite.bounds.size.y, var_228_3 / var_228_2.sprite.bounds.size.y < var_228_3 * manager.ui.mainCameraCom_.aspect / var_228_2.sprite.bounds.size.x and var_228_3 * manager.ui.mainCameraCom_.aspect / var_228_2.sprite.bounds.size.x or var_228_3 / var_228_2.sprite.bounds.size.y, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "K12f" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_4 = 0

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_5 = 2

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_5 then
				local var_228_6 = Color.New(0, 0, 0)

				var_228_6.a = Mathf.Lerp(1, 0, (arg_225_1.time_ - var_228_4) / var_228_5)
				arg_225_1.mask_.color = var_228_6
			end

			if arg_225_1.time_ >= var_228_4 + var_228_5 and arg_225_1.time_ < var_228_4 + var_228_5 + arg_228_0 then
				local var_228_7 = Color.New(0, 0, 0)

				arg_225_1.mask_.enabled = false
				var_228_7.a = 0
				arg_225_1.mask_.color = var_228_7
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_8 = 2
			local var_228_9 = 0.15

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_10 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_10:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_11 = arg_225_1:GetWordFromCfg(317252053)
				local var_228_12 = arg_225_1:FormatText(var_228_11.content)

				arg_225_1.text_.text = var_228_12

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_14 = 6 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_12) / 6)

				if (6 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_12) / 6)) > 0 and var_228_9 < var_228_14 then
					arg_225_1.talkMaxDuration = var_228_14
					var_228_8 = var_228_8 + 0.3

					if var_228_14 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_12
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252053", "story_v_out_317252.awb") ~= 0 then
					local var_228_15 = manager.audio:GetVoiceLength("story_v_out_317252", "317252053", "story_v_out_317252.awb") / 1000

					if var_228_15 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_15 + var_228_8
					end

					if var_228_11.prefab_name ~= "" and arg_225_1.actors_[var_228_11.prefab_name] ~= nil then
						local var_228_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_11.prefab_name].transform, "story_v_out_317252", "317252053", "story_v_out_317252.awb")

						arg_225_1:RecordAudio("317252053", var_228_16)
						arg_225_1:RecordAudio("317252053", var_228_16)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_317252", "317252053", "story_v_out_317252.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_317252", "317252053", "story_v_out_317252.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_17 = var_228_8 + 0.3
			local var_228_18 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 + 0.3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_17 + var_228_18 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_17) / var_228_18

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_17 + var_228_18 and arg_225_1.time_ < var_228_17 + var_228_18 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play317252054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317252054
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play317252055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.7

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(317252054).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 28 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 28)

				if (28 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 28)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play317252055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 317252055
		arg_235_1.duration_ = 9.33

		local var_235_0 = {
			zh = 9.333,
			ja = 8.8
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play317252056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1158ui_story = arg_235_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1158ui_story"].transform.position).z)
				arg_235_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1158ui_story"].transform.localEulerAngles = arg_235_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_235_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1158ui_story"].transform.position).z)
				arg_235_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1158ui_story"].transform.localEulerAngles = arg_235_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1158ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1158ui_story == nil then
				arg_235_1.var_.characterEffect1158ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1158ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1158ui_story then
				arg_235_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action5_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_4 = 0
			local var_238_5 = 0.975

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(317252055)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 39 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 39)

				if (39 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 39)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252055", "story_v_out_317252.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252055", "story_v_out_317252.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_out_317252", "317252055", "story_v_out_317252.awb")

						arg_235_1:RecordAudio("317252055", var_238_11)
						arg_235_1:RecordAudio("317252055", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_317252", "317252055", "story_v_out_317252.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_317252", "317252055", "story_v_out_317252.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play317252056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 317252056
		arg_239_1.duration_ = 3

		local var_239_0 = {
			zh = 2.8,
			ja = 3
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play317252057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1158ui_story"]) and arg_239_1.var_.characterEffect1158ui_story == nil then
				arg_239_1.var_.characterEffect1158ui_story = arg_239_1.actors_["1158ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1158ui_story"]) then
				if arg_239_1.var_.characterEffect1158ui_story and not isNil(arg_239_1.actors_["1158ui_story"]) then
					arg_239_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1158ui_story"]) and arg_239_1.var_.characterEffect1158ui_story then
				arg_239_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.2

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(317252056)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 8 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_4) / 8)

				if (8 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_4) / 8)) > 0 and var_242_2 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252056", "story_v_out_317252.awb") ~= 0 then
					local var_242_7 = manager.audio:GetVoiceLength("story_v_out_317252", "317252056", "story_v_out_317252.awb") / 1000

					if var_242_7 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_1
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_317252", "317252056", "story_v_out_317252.awb")

						arg_239_1:RecordAudio("317252056", var_242_8)
						arg_239_1:RecordAudio("317252056", var_242_8)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_317252", "317252056", "story_v_out_317252.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_317252", "317252056", "story_v_out_317252.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_9 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_9 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_9

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_9 and arg_239_1.time_ < var_242_1 + var_242_9 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play317252057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 317252057
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play317252058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1158ui_story = arg_243_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1158ui_story"].transform.position).z)
				arg_243_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1158ui_story"].transform.localEulerAngles = arg_243_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1158ui_story"].transform.position).z)
				arg_243_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1158ui_story"].transform.localEulerAngles = arg_243_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_246_1 = 0
			local var_246_2 = 0.525

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(317252057).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 21 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 21)

				if (21 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 21)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play317252058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 317252058
		arg_247_1.duration_ = 5.7

		local var_247_0 = {
			zh = 5.5,
			ja = 5.7
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play317252059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1158ui_story = arg_247_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1158ui_story"].transform.position).z)
				arg_247_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1158ui_story"].transform.localEulerAngles = arg_247_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_247_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1158ui_story"].transform.position).z)
				arg_247_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1158ui_story"].transform.localEulerAngles = arg_247_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1158ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1158ui_story == nil then
				arg_247_1.var_.characterEffect1158ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1158ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1158ui_story then
				arg_247_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action5_2")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_250_4 = 0
			local var_250_5 = 0.675

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(317252058)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 27 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 27)

				if (27 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 27)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252058", "story_v_out_317252.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252058", "story_v_out_317252.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_317252", "317252058", "story_v_out_317252.awb")

						arg_247_1:RecordAudio("317252058", var_250_11)
						arg_247_1:RecordAudio("317252058", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_317252", "317252058", "story_v_out_317252.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_317252", "317252058", "story_v_out_317252.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play317252059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 317252059
		arg_251_1.duration_ = 9

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play317252060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 2 < arg_251_1.time_ and arg_251_1.time_ <= 2 + arg_254_0 then
				local var_254_0 = arg_251_1.bgs_.STblack

				arg_251_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_1 = var_254_0:GetComponent("SpriteRenderer")

				if var_254_1 and var_254_1.sprite then
					local var_254_2 = 2 * (var_254_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_0.transform.localScale = Vector3.New(var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "STblack" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_3 = 0

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_4 = 2

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_4 then
				local var_254_5 = Color.New(0, 0, 0)

				var_254_5.a = Mathf.Lerp(0, 1, (arg_251_1.time_ - var_254_3) / var_254_4)
				arg_251_1.mask_.color = var_254_5
			end

			if arg_251_1.time_ >= var_254_3 + var_254_4 and arg_251_1.time_ < var_254_3 + var_254_4 + arg_254_0 then
				local var_254_6 = Color.New(0, 0, 0)

				var_254_6.a = 1
				arg_251_1.mask_.color = var_254_6
			end

			local var_254_7 = 2

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_8 = 2

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_8 then
				local var_254_9 = Color.New(0, 0, 0)

				var_254_9.a = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_7) / var_254_8)
				arg_251_1.mask_.color = var_254_9
			end

			if arg_251_1.time_ >= var_254_7 + var_254_8 and arg_251_1.time_ < var_254_7 + var_254_8 + arg_254_0 then
				local var_254_10 = Color.New(0, 0, 0)

				arg_251_1.mask_.enabled = false
				var_254_10.a = 0
				arg_251_1.mask_.color = var_254_10
			end

			local var_254_11 = arg_251_1.actors_["1158ui_story"].transform

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= 2 + arg_254_0 then
				arg_251_1.var_.moveOldPos1158ui_story = var_254_11.localPosition
			end

			local var_254_12 = 0.001

			if 2 <= arg_251_1.time_ and arg_251_1.time_ < 2 + var_254_12 then
				var_254_11.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 2) / var_254_12)
				var_254_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_11.position).x, (manager.ui.mainCamera.transform.position - var_254_11.position).y, (manager.ui.mainCamera.transform.position - var_254_11.position).z)
				var_254_11.localEulerAngles.z = 0
				var_254_11.localEulerAngles.x = 0
				var_254_11.localEulerAngles = var_254_11.localEulerAngles
			end

			if arg_251_1.time_ >= 2 + var_254_12 and arg_251_1.time_ < 2 + var_254_12 + arg_254_0 then
				var_254_11.localPosition = Vector3.New(0, 100, 0)
				var_254_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_11.position).x, (manager.ui.mainCamera.transform.position - var_254_11.position).y, (manager.ui.mainCamera.transform.position - var_254_11.position).z)
				var_254_11.localEulerAngles.z = 0
				var_254_11.localEulerAngles.x = 0
				var_254_11.localEulerAngles = var_254_11.localEulerAngles
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_13 = 4
			local var_254_14 = 1.425

			if 4 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_15 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_15:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_16 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(317252059).content)

				arg_251_1.text_.text = var_254_16

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_18 = 57 <= 0 and var_254_14 or var_254_14 * (utf8.len(var_254_16) / 57)

				if (57 <= 0 and var_254_14 or var_254_14 * (utf8.len(var_254_16) / 57)) > 0 and var_254_14 < var_254_18 then
					arg_251_1.talkMaxDuration = var_254_18
					var_254_13 = var_254_13 + 0.3

					if var_254_18 + var_254_13 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_18 + var_254_13
					end
				end

				arg_251_1.text_.text = var_254_16
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_19 = var_254_13 + 0.3
			local var_254_20 = math.max(var_254_14, arg_251_1.talkMaxDuration)

			if var_254_13 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_19 + var_254_20 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_19) / var_254_20

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_19 + var_254_20 and arg_251_1.time_ < var_254_19 + var_254_20 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play317252060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 317252060
		arg_257_1.duration_ = 7

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play317252061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				local var_260_0 = arg_257_1.bgs_.K12f

				arg_257_1.bgs_.K12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_1 = var_260_0:GetComponent("SpriteRenderer")

				if var_260_1 and var_260_1.sprite then
					local var_260_2 = 2 * (var_260_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_0.transform.localScale = Vector3.New(var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "K12f" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_3 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_4 = 2

			if var_260_3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_3 + var_260_4 then
				local var_260_5 = Color.New(0, 0, 0)

				var_260_5.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_3) / var_260_4)
				arg_257_1.mask_.color = var_260_5
			end

			if arg_257_1.time_ >= var_260_3 + var_260_4 and arg_257_1.time_ < var_260_3 + var_260_4 + arg_260_0 then
				local var_260_6 = Color.New(0, 0, 0)

				arg_257_1.mask_.enabled = false
				var_260_6.a = 0
				arg_257_1.mask_.color = var_260_6
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_7 = 2
			local var_260_8 = 0.775

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_7 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_9 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_9:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(317252060).content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_12 = 31 <= 0 and var_260_8 or var_260_8 * (utf8.len(var_260_10) / 31)

				if (31 <= 0 and var_260_8 or var_260_8 * (utf8.len(var_260_10) / 31)) > 0 and var_260_8 < var_260_12 then
					arg_257_1.talkMaxDuration = var_260_12
					var_260_7 = var_260_7 + 0.3

					if var_260_12 + var_260_7 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_7
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_13 = var_260_7 + 0.3
			local var_260_14 = math.max(var_260_8, arg_257_1.talkMaxDuration)

			if var_260_7 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_13 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_13) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_13 + var_260_14 and arg_257_1.time_ < var_260_13 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play317252061 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 317252061
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play317252062(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.725

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(317252061).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 29 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 29)

				if (29 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 29)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play317252062 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 317252062
		arg_267_1.duration_ = 6.4

		local var_267_0 = {
			zh = 5.366,
			ja = 6.4
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play317252063(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.8

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[157].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomermc")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:GetWordFromCfg(317252062)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 32 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 32)

				if (32 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 32)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252062", "story_v_out_317252.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252062", "story_v_out_317252.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_317252", "317252062", "story_v_out_317252.awb")

						arg_267_1:RecordAudio("317252062", var_270_6)
						arg_267_1:RecordAudio("317252062", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_317252", "317252062", "story_v_out_317252.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_317252", "317252062", "story_v_out_317252.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play317252063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 317252063
		arg_271_1.duration_ = 12.97

		local var_271_0 = {
			zh = 8.966,
			ja = 12.966
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play317252064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_274_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_271_1.stage_.transform)

				var_274_0.name = "10053ui_story"
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.actors_["10053ui_story"] = var_274_0

				local var_274_1 = var_274_0:GetComponentInChildren(typeof(CharacterEffect))

				var_274_1.enabled = true

				local var_274_2 = GameObjectTools.GetOrAddComponent(var_274_0, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(false)
				end

				arg_271_1:ShowWeapon(var_274_1.transform, false)

				arg_271_1.var_["10053ui_story" .. "Animator"] = var_274_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_271_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_271_1.var_["10053ui_story" .. "LipSync"] = var_274_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_274_3 = arg_271_1.actors_["10053ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10053ui_story = var_274_3.localPosition
			end

			local var_274_4 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				var_274_3.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_271_1.time_ - 0) / var_274_4)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				var_274_3.localPosition = Vector3.New(0, -1.12, -5.99)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			local var_274_5 = arg_271_1.actors_["10053ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect10053ui_story == nil then
				arg_271_1.var_.characterEffect10053ui_story = var_274_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_6 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_6 and not isNil(var_274_5) then
				if arg_271_1.var_.characterEffect10053ui_story and not isNil(var_274_5) then
					arg_271_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_6 and arg_271_1.time_ < 0 + var_274_6 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect10053ui_story then
				arg_271_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action34_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_8 = 0
			local var_274_9 = 1.1

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:GetWordFromCfg(317252063)
				local var_274_11 = arg_271_1:FormatText(var_274_10.content)

				arg_271_1.text_.text = var_274_11

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 44 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 44)

				if (44 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 44)) > 0 and var_274_9 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_11
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252063", "story_v_out_317252.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_317252", "317252063", "story_v_out_317252.awb") / 1000

					if var_274_14 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_8
					end

					if var_274_10.prefab_name ~= "" and arg_271_1.actors_[var_274_10.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_10.prefab_name].transform, "story_v_out_317252", "317252063", "story_v_out_317252.awb")

						arg_271_1:RecordAudio("317252063", var_274_15)
						arg_271_1:RecordAudio("317252063", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_317252", "317252063", "story_v_out_317252.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_317252", "317252063", "story_v_out_317252.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play317252064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 317252064
		arg_275_1.duration_ = 1

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play317252065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10053ui_story"]) and arg_275_1.var_.characterEffect10053ui_story == nil then
				arg_275_1.var_.characterEffect10053ui_story = arg_275_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10053ui_story"]) then
				if arg_275_1.var_.characterEffect10053ui_story and not isNil(arg_275_1.actors_["10053ui_story"]) then
					arg_275_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10053ui_story"]) and arg_275_1.var_.characterEffect10053ui_story then
				arg_275_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.075

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[157].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomermc")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(317252064)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 3 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_4) / 3)

				if (3 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_4) / 3)) > 0 and var_278_2 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252064", "story_v_out_317252.awb") ~= 0 then
					local var_278_7 = manager.audio:GetVoiceLength("story_v_out_317252", "317252064", "story_v_out_317252.awb") / 1000

					if var_278_7 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_1
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_317252", "317252064", "story_v_out_317252.awb")

						arg_275_1:RecordAudio("317252064", var_278_8)
						arg_275_1:RecordAudio("317252064", var_278_8)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_317252", "317252064", "story_v_out_317252.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_317252", "317252064", "story_v_out_317252.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_9 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_9 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_9

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_9 and arg_275_1.time_ < var_278_1 + var_278_9 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play317252065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 317252065
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play317252066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.425

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(317252065).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 17 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 17)

				if (17 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 17)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play317252066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 317252066
		arg_283_1.duration_ = 7.4

		local var_283_0 = {
			zh = 7.4,
			ja = 7.066
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play317252067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10053ui_story = arg_283_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10053ui_story"].transform.position).z)
				arg_283_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10053ui_story"].transform.localEulerAngles = arg_283_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_283_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10053ui_story"].transform.position).z)
				arg_283_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10053ui_story"].transform.localEulerAngles = arg_283_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["10053ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10053ui_story == nil then
				arg_283_1.var_.characterEffect10053ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect10053ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10053ui_story then
				arg_283_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action34_2")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_286_4 = 0
			local var_286_5 = 0.55

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(317252066)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 22 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 22)

				if (22 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 22)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252066", "story_v_out_317252.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252066", "story_v_out_317252.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_317252", "317252066", "story_v_out_317252.awb")

						arg_283_1:RecordAudio("317252066", var_286_11)
						arg_283_1:RecordAudio("317252066", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_317252", "317252066", "story_v_out_317252.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_317252", "317252066", "story_v_out_317252.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play317252067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 317252067
		arg_287_1.duration_ = 4.73

		local var_287_0 = {
			zh = 4.733,
			ja = 4.366
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play317252068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.275

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(317252067)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 11 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 11)

				if (11 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 11)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252067", "story_v_out_317252.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252067", "story_v_out_317252.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_317252", "317252067", "story_v_out_317252.awb")

						arg_287_1:RecordAudio("317252067", var_290_6)
						arg_287_1:RecordAudio("317252067", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_317252", "317252067", "story_v_out_317252.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_317252", "317252067", "story_v_out_317252.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play317252068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 317252068
		arg_291_1.duration_ = 10.9

		local var_291_0 = {
			zh = 8.9,
			ja = 10.9
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play317252069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.85

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(317252068)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 34 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 34)

				if (34 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 34)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252068", "story_v_out_317252.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252068", "story_v_out_317252.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_317252", "317252068", "story_v_out_317252.awb")

						arg_291_1:RecordAudio("317252068", var_294_6)
						arg_291_1:RecordAudio("317252068", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_317252", "317252068", "story_v_out_317252.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_317252", "317252068", "story_v_out_317252.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play317252069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 317252069
		arg_295_1.duration_ = 2.77

		local var_295_0 = {
			zh = 2.766,
			ja = 1.999999999999
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play317252070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10053ui_story = arg_295_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10053ui_story"].transform.position).z)
				arg_295_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10053ui_story"].transform.localEulerAngles = arg_295_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_295_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10053ui_story"].transform.position).z)
				arg_295_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10053ui_story"].transform.localEulerAngles = arg_295_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["10053ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect10053ui_story == nil then
				arg_295_1.var_.characterEffect10053ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect10053ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect10053ui_story then
				arg_295_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_4 = 0
			local var_298_5 = 0.1

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(317252069)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 4 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 4)

				if (4 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 4)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252069", "story_v_out_317252.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252069", "story_v_out_317252.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_out_317252", "317252069", "story_v_out_317252.awb")

						arg_295_1:RecordAudio("317252069", var_298_11)
						arg_295_1:RecordAudio("317252069", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_317252", "317252069", "story_v_out_317252.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_317252", "317252069", "story_v_out_317252.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play317252070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 317252070
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play317252071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["10053ui_story"]) and arg_299_1.var_.characterEffect10053ui_story == nil then
				arg_299_1.var_.characterEffect10053ui_story = arg_299_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["10053ui_story"]) then
				if arg_299_1.var_.characterEffect10053ui_story and not isNil(arg_299_1.actors_["10053ui_story"]) then
					arg_299_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_299_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["10053ui_story"]) and arg_299_1.var_.characterEffect10053ui_story then
				arg_299_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_299_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 1.025

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(317252070).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 41 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 41)

				if (41 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 41)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play317252071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 317252071
		arg_303_1.duration_ = 2

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play317252072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10053ui_story = arg_303_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10053ui_story"].transform.position).z)
				arg_303_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["10053ui_story"].transform.localEulerAngles = arg_303_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_303_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10053ui_story"].transform.position).z)
				arg_303_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["10053ui_story"].transform.localEulerAngles = arg_303_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["10053ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect10053ui_story == nil then
				arg_303_1.var_.characterEffect10053ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect10053ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect10053ui_story then
				arg_303_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_4 = 0
			local var_306_5 = 0.075

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(317252071)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 3 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 3)

				if (3 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 3)) > 0 and var_306_5 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252071", "story_v_out_317252.awb") ~= 0 then
					local var_306_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252071", "story_v_out_317252.awb") / 1000

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end

					if var_306_6.prefab_name ~= "" and arg_303_1.actors_[var_306_6.prefab_name] ~= nil then
						local var_306_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_6.prefab_name].transform, "story_v_out_317252", "317252071", "story_v_out_317252.awb")

						arg_303_1:RecordAudio("317252071", var_306_11)
						arg_303_1:RecordAudio("317252071", var_306_11)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_317252", "317252071", "story_v_out_317252.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_317252", "317252071", "story_v_out_317252.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_12 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_12 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_12

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_12 and arg_303_1.time_ < var_306_4 + var_306_12 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play317252072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 317252072
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play317252073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos10053ui_story = arg_307_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10053ui_story"].transform.position).z)
				arg_307_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["10053ui_story"].transform.localEulerAngles = arg_307_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10053ui_story"].transform.position).z)
				arg_307_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["10053ui_story"].transform.localEulerAngles = arg_307_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["10053ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect10053ui_story == nil then
				arg_307_1.var_.characterEffect10053ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect10053ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_2)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect10053ui_story then
				arg_307_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_310_3 = 0
			local var_310_4 = 1.35

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_5 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(317252072).content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 54 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_5) / 54)

				if (54 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_5) / 54)) > 0 and var_310_4 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_3
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_4, arg_307_1.talkMaxDuration)

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_3) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_3 + var_310_8 and arg_307_1.time_ < var_310_3 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play317252073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 317252073
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play317252074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.775

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(317252073).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 31 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 31)

				if (31 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 31)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play317252074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 317252074
		arg_315_1.duration_ = 20.37

		local var_315_0 = {
			zh = 9.4,
			ja = 20.366
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play317252075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_318_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_315_1.bgmTxt_.text ~= var_318_2 and arg_315_1.bgmTxt_.text ~= "" then
						if arg_315_1.bgmTxt2_.text ~= "" then
							arg_315_1.bgmTxt_.text = arg_315_1.bgmTxt2_.text
						end

						arg_315_1.bgmTxt2_.text = var_318_2

						arg_315_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_315_1.bgmTxt_.text = var_318_2
						arg_315_1.bgmTxt2_.text = var_318_2
					end

					if arg_315_1.bgmTimer then
						arg_315_1.bgmTimer:Stop()

						arg_315_1.bgmTimer = nil
					end

					if arg_315_1.settingData.show_music_name == 1 then
						arg_315_1.musicController:SetSelectedState("show")
						arg_315_1.musicAnimator_:Play("open", 0, 0)

						if arg_315_1.settingData.music_time ~= 0 then
							arg_315_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_315_1.settingData.music_time), function()
								if arg_315_1 == nil or isNil(arg_315_1.bgmTxt_) then
									return
								end

								arg_315_1.musicController:SetSelectedState("hide")
								arg_315_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_318_3 = 0
			local var_318_4 = 0.7

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_5 = arg_315_1:GetWordFromCfg(317252074)
				local var_318_6 = arg_315_1:FormatText(var_318_5.content)

				arg_315_1.text_.text = var_318_6

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_8 = 28 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_6) / 28)

				if (28 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_6) / 28)) > 0 and var_318_4 < var_318_8 then
					arg_315_1.talkMaxDuration = var_318_8

					if var_318_8 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_3
					end
				end

				arg_315_1.text_.text = var_318_6
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252074", "story_v_out_317252.awb") ~= 0 then
					local var_318_9 = manager.audio:GetVoiceLength("story_v_out_317252", "317252074", "story_v_out_317252.awb") / 1000

					if var_318_9 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_3
					end

					if var_318_5.prefab_name ~= "" and arg_315_1.actors_[var_318_5.prefab_name] ~= nil then
						local var_318_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_5.prefab_name].transform, "story_v_out_317252", "317252074", "story_v_out_317252.awb")

						arg_315_1:RecordAudio("317252074", var_318_10)
						arg_315_1:RecordAudio("317252074", var_318_10)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_317252", "317252074", "story_v_out_317252.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_317252", "317252074", "story_v_out_317252.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_11 = math.max(var_318_4, arg_315_1.talkMaxDuration)

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_11 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_3) / var_318_11

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_3 + var_318_11 and arg_315_1.time_ < var_318_3 + var_318_11 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play317252075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 317252075
		arg_320_1.duration_ = 13.97

		local var_320_0 = {
			zh = 9.433,
			ja = 13.966
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
				arg_320_0:Play317252076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.85

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(317252075)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 34 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 34)

				if (34 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 34)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252075", "story_v_out_317252.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252075", "story_v_out_317252.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_317252", "317252075", "story_v_out_317252.awb")

						arg_320_1:RecordAudio("317252075", var_323_6)
						arg_320_1:RecordAudio("317252075", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_317252", "317252075", "story_v_out_317252.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_317252", "317252075", "story_v_out_317252.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play317252076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 317252076
		arg_324_1.duration_ = 10.5

		local var_324_0 = {
			zh = 9.233,
			ja = 10.5
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
				arg_324_0:Play317252077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 2 < arg_324_1.time_ and arg_324_1.time_ <= 2 + arg_327_0 then
				local var_327_0 = arg_324_1.bgs_.STblack

				arg_324_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_327_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_1 = var_327_0:GetComponent("SpriteRenderer")

				if var_327_1 and var_327_1.sprite then
					local var_327_2 = 2 * (var_327_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_327_0.transform.localScale = Vector3.New(var_327_2 / var_327_1.sprite.bounds.size.y < var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x and var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x or var_327_2 / var_327_1.sprite.bounds.size.y, var_327_2 / var_327_1.sprite.bounds.size.y < var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x and var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x or var_327_2 / var_327_1.sprite.bounds.size.y, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "STblack" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_3 = 0

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_3 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_4 = 2

			if var_327_3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_3 + var_327_4 then
				local var_327_5 = Color.New(0, 0, 0)

				var_327_5.a = Mathf.Lerp(0, 1, (arg_324_1.time_ - var_327_3) / var_327_4)
				arg_324_1.mask_.color = var_327_5
			end

			if arg_324_1.time_ >= var_327_3 + var_327_4 and arg_324_1.time_ < var_327_3 + var_327_4 + arg_327_0 then
				local var_327_6 = Color.New(0, 0, 0)

				var_327_6.a = 1
				arg_324_1.mask_.color = var_327_6
			end

			local var_327_7 = 2

			if 2 < arg_324_1.time_ and arg_324_1.time_ <= var_327_7 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_8 = 2

			if var_327_7 <= arg_324_1.time_ and arg_324_1.time_ < var_327_7 + var_327_8 then
				local var_327_9 = Color.New(0, 0, 0)

				var_327_9.a = Mathf.Lerp(1, 0, (arg_324_1.time_ - var_327_7) / var_327_8)
				arg_324_1.mask_.color = var_327_9
			end

			if arg_324_1.time_ >= var_327_7 + var_327_8 and arg_324_1.time_ < var_327_7 + var_327_8 + arg_327_0 then
				local var_327_10 = Color.New(0, 0, 0)

				arg_324_1.mask_.enabled = false
				var_327_10.a = 0
				arg_324_1.mask_.color = var_327_10
			end

			if arg_324_1.frameCnt_ <= 1 then
				arg_324_1.dialog_:SetActive(false)
			end

			local var_327_11 = 4
			local var_327_12 = 0.35

			if 4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_11 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				arg_324_1.dialog_:SetActive(true)

				arg_324_1.dialogCg_.alpha = 0

				local var_327_13 = LeanTween.value(arg_324_1.dialog_, 0, 1, 0.3)

				var_327_13:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_324_1.dialogCg_.alpha = arg_328_0
				end))
				var_327_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_324_1.dialog_)
					var_327_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_324_1.duration_ = arg_324_1.duration_ + 0.3

				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_14 = arg_324_1:GetWordFromCfg(317252076)
				local var_327_15 = arg_324_1:FormatText(var_327_14.content)

				arg_324_1.text_.text = var_327_15

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_17 = 14 <= 0 and var_327_12 or var_327_12 * (utf8.len(var_327_15) / 14)

				if (14 <= 0 and var_327_12 or var_327_12 * (utf8.len(var_327_15) / 14)) > 0 and var_327_12 < var_327_17 then
					arg_324_1.talkMaxDuration = var_327_17
					var_327_11 = var_327_11 + 0.3

					if var_327_17 + var_327_11 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_17 + var_327_11
					end
				end

				arg_324_1.text_.text = var_327_15
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252076", "story_v_out_317252.awb") ~= 0 then
					local var_327_18 = manager.audio:GetVoiceLength("story_v_out_317252", "317252076", "story_v_out_317252.awb") / 1000

					if var_327_18 + var_327_11 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_18 + var_327_11
					end

					if var_327_14.prefab_name ~= "" and arg_324_1.actors_[var_327_14.prefab_name] ~= nil then
						local var_327_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_14.prefab_name].transform, "story_v_out_317252", "317252076", "story_v_out_317252.awb")

						arg_324_1:RecordAudio("317252076", var_327_19)
						arg_324_1:RecordAudio("317252076", var_327_19)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_317252", "317252076", "story_v_out_317252.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_317252", "317252076", "story_v_out_317252.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_20 = var_327_11 + 0.3
			local var_327_21 = math.max(var_327_12, arg_324_1.talkMaxDuration)

			if var_327_11 + 0.3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_20 + var_327_21 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_20) / var_327_21

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_20 + var_327_21 and arg_324_1.time_ < var_327_20 + var_327_21 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play317252077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 317252077
		arg_330_1.duration_ = 7

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play317252078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if arg_330_1.bgs_.K11f == nil then
				local var_333_0 = Object.Instantiate(arg_330_1.paintGo_)

				var_333_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11f")
				var_333_0.name = "K11f"
				var_333_0.transform.parent = arg_330_1.stage_.transform
				var_333_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_330_1.bgs_.K11f = var_333_0
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				local var_333_1 = arg_330_1.bgs_.K11f

				arg_330_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_333_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_333_2 = var_333_1:GetComponent("SpriteRenderer")

				if var_333_2 and var_333_2.sprite then
					local var_333_3 = 2 * (var_333_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_333_1.transform.localScale = Vector3.New(var_333_3 / var_333_2.sprite.bounds.size.y < var_333_3 * manager.ui.mainCameraCom_.aspect / var_333_2.sprite.bounds.size.x and var_333_3 * manager.ui.mainCameraCom_.aspect / var_333_2.sprite.bounds.size.x or var_333_3 / var_333_2.sprite.bounds.size.y, var_333_3 / var_333_2.sprite.bounds.size.y < var_333_3 * manager.ui.mainCameraCom_.aspect / var_333_2.sprite.bounds.size.x and var_333_3 * manager.ui.mainCameraCom_.aspect / var_333_2.sprite.bounds.size.x or var_333_3 / var_333_2.sprite.bounds.size.y, 0)
				end

				for iter_333_0, iter_333_1 in pairs(arg_330_1.bgs_) do
					if iter_333_0 ~= "K11f" then
						iter_333_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_333_4 = 0

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.mask_.enabled = true
				arg_330_1.mask_.raycastTarget = true

				arg_330_1:SetGaussion(false)
			end

			local var_333_5 = 2

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_5 then
				local var_333_6 = Color.New(0, 0, 0)

				var_333_6.a = Mathf.Lerp(1, 0, (arg_330_1.time_ - var_333_4) / var_333_5)
				arg_330_1.mask_.color = var_333_6
			end

			if arg_330_1.time_ >= var_333_4 + var_333_5 and arg_330_1.time_ < var_333_4 + var_333_5 + arg_333_0 then
				local var_333_7 = Color.New(0, 0, 0)

				arg_330_1.mask_.enabled = false
				var_333_7.a = 0
				arg_330_1.mask_.color = var_333_7
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_333_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_330_1.bgmTxt_.text ~= var_333_10 and arg_330_1.bgmTxt_.text ~= "" then
						if arg_330_1.bgmTxt2_.text ~= "" then
							arg_330_1.bgmTxt_.text = arg_330_1.bgmTxt2_.text
						end

						arg_330_1.bgmTxt2_.text = var_333_10

						arg_330_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_330_1.bgmTxt_.text = var_333_10
						arg_330_1.bgmTxt2_.text = var_333_10
					end

					if arg_330_1.bgmTimer then
						arg_330_1.bgmTimer:Stop()

						arg_330_1.bgmTimer = nil
					end

					if arg_330_1.settingData.show_music_name == 1 then
						arg_330_1.musicController:SetSelectedState("show")
						arg_330_1.musicAnimator_:Play("open", 0, 0)

						if arg_330_1.settingData.music_time ~= 0 then
							arg_330_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_330_1.settingData.music_time), function()
								if arg_330_1 == nil or isNil(arg_330_1.bgmTxt_) then
									return
								end

								arg_330_1.musicController:SetSelectedState("hide")
								arg_330_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_330_1.time_ and arg_330_1.time_ <= 0.3 + arg_333_0 then
				arg_330_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_333_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

				if "" ~= "" then
					if arg_330_1.bgmTxt_.text ~= var_333_13 and arg_330_1.bgmTxt_.text ~= "" then
						if arg_330_1.bgmTxt2_.text ~= "" then
							arg_330_1.bgmTxt_.text = arg_330_1.bgmTxt2_.text
						end

						arg_330_1.bgmTxt2_.text = var_333_13

						arg_330_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_330_1.bgmTxt_.text = var_333_13
						arg_330_1.bgmTxt2_.text = var_333_13
					end

					if arg_330_1.bgmTimer then
						arg_330_1.bgmTimer:Stop()

						arg_330_1.bgmTimer = nil
					end

					if arg_330_1.settingData.show_music_name == 1 then
						arg_330_1.musicController:SetSelectedState("show")
						arg_330_1.musicAnimator_:Play("open", 0, 0)

						if arg_330_1.settingData.music_time ~= 0 then
							arg_330_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_330_1.settingData.music_time), function()
								if arg_330_1 == nil or isNil(arg_330_1.bgmTxt_) then
									return
								end

								arg_330_1.musicController:SetSelectedState("hide")
								arg_330_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_330_1.frameCnt_ <= 1 then
				arg_330_1.dialog_:SetActive(false)
			end

			local var_333_14 = 2
			local var_333_15 = 0.775

			if 2 < arg_330_1.time_ and arg_330_1.time_ <= var_333_14 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				arg_330_1.dialog_:SetActive(true)

				arg_330_1.dialogCg_.alpha = 0

				local var_333_16 = LeanTween.value(arg_330_1.dialog_, 0, 1, 0.3)

				var_333_16:setOnUpdate(LuaHelper.FloatAction(function(arg_336_0)
					arg_330_1.dialogCg_.alpha = arg_336_0
				end))
				var_333_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_330_1.dialog_)
					var_333_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_330_1.duration_ = arg_330_1.duration_ + 0.3

				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_17 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(317252077).content)

				arg_330_1.text_.text = var_333_17

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_19 = 31 <= 0 and var_333_15 or var_333_15 * (utf8.len(var_333_17) / 31)

				if (31 <= 0 and var_333_15 or var_333_15 * (utf8.len(var_333_17) / 31)) > 0 and var_333_15 < var_333_19 then
					arg_330_1.talkMaxDuration = var_333_19
					var_333_14 = var_333_14 + 0.3

					if var_333_19 + var_333_14 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_19 + var_333_14
					end
				end

				arg_330_1.text_.text = var_333_17
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_20 = var_333_14 + 0.3
			local var_333_21 = math.max(var_333_15, arg_330_1.talkMaxDuration)

			if var_333_14 + 0.3 <= arg_330_1.time_ and arg_330_1.time_ < var_333_20 + var_333_21 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_20) / var_333_21

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_20 + var_333_21 and arg_330_1.time_ < var_333_20 + var_333_21 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play317252078 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 317252078
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play317252079(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.575

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(317252078).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 23 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 23)

				if (23 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 23)) > 0 and var_341_0 < var_341_3 then
					arg_338_1.talkMaxDuration = var_341_3

					if var_341_3 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_3 + 0
					end
				end

				arg_338_1.text_.text = var_341_1
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_4 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_4

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play317252079 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 317252079
		arg_342_1.duration_ = 3.3

		local var_342_0 = {
			zh = 1.8,
			ja = 3.3
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play317252080(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if arg_342_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_345_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_342_1.stage_.transform)

				var_345_0.name = "2079ui_story"
				var_345_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.actors_["2079ui_story"] = var_345_0

				local var_345_1 = var_345_0:GetComponentInChildren(typeof(CharacterEffect))

				var_345_1.enabled = true

				local var_345_2 = GameObjectTools.GetOrAddComponent(var_345_0, typeof(DynamicBoneHelper))

				if var_345_2 then
					var_345_2:EnableDynamicBone(false)
				end

				arg_342_1:ShowWeapon(var_345_1.transform, false)

				arg_342_1.var_["2079ui_story" .. "Animator"] = var_345_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_342_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_342_1.var_["2079ui_story" .. "LipSync"] = var_345_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_345_3 = arg_342_1.actors_["2079ui_story"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos2079ui_story = var_345_3.localPosition
			end

			local var_345_4 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				var_345_3.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos2079ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_342_1.time_ - 0) / var_345_4)
				var_345_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_3.position).x, (manager.ui.mainCamera.transform.position - var_345_3.position).y, (manager.ui.mainCamera.transform.position - var_345_3.position).z)
				var_345_3.localEulerAngles.z = 0
				var_345_3.localEulerAngles.x = 0
				var_345_3.localEulerAngles = var_345_3.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				var_345_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_345_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_3.position).x, (manager.ui.mainCamera.transform.position - var_345_3.position).y, (manager.ui.mainCamera.transform.position - var_345_3.position).z)
				var_345_3.localEulerAngles.z = 0
				var_345_3.localEulerAngles.x = 0
				var_345_3.localEulerAngles = var_345_3.localEulerAngles
			end

			local var_345_5 = arg_342_1.actors_["2079ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_5) and arg_342_1.var_.characterEffect2079ui_story == nil then
				arg_342_1.var_.characterEffect2079ui_story = var_345_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_6 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_6 and not isNil(var_345_5) then
				if arg_342_1.var_.characterEffect2079ui_story and not isNil(var_345_5) then
					arg_342_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_6 and arg_342_1.time_ < 0 + var_345_6 + arg_345_0 and not isNil(var_345_5) and arg_342_1.var_.characterEffect2079ui_story then
				arg_342_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_345_8 = "2078ui_story"

			if arg_342_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_345_9 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_342_1.stage_.transform)

				var_345_9.name = var_345_8
				var_345_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.actors_[var_345_8] = var_345_9

				local var_345_10 = var_345_9:GetComponentInChildren(typeof(CharacterEffect))

				var_345_10.enabled = true

				local var_345_11 = GameObjectTools.GetOrAddComponent(var_345_9, typeof(DynamicBoneHelper))

				if var_345_11 then
					var_345_11:EnableDynamicBone(false)
				end

				arg_342_1:ShowWeapon(var_345_10.transform, false)

				arg_342_1.var_[var_345_8 .. "Animator"] = var_345_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_342_1.var_[var_345_8 .. "Animator"].applyRootMotion = true
				arg_342_1.var_[var_345_8 .. "LipSync"] = var_345_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_345_12 = arg_342_1.actors_["2078ui_story"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos2078ui_story = var_345_12.localPosition
			end

			local var_345_13 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_13 then
				var_345_12.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_342_1.time_ - 0) / var_345_13)
				var_345_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_12.position).x, (manager.ui.mainCamera.transform.position - var_345_12.position).y, (manager.ui.mainCamera.transform.position - var_345_12.position).z)
				var_345_12.localEulerAngles.z = 0
				var_345_12.localEulerAngles.x = 0
				var_345_12.localEulerAngles = var_345_12.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_13 and arg_342_1.time_ < 0 + var_345_13 + arg_345_0 then
				var_345_12.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_345_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_12.position).x, (manager.ui.mainCamera.transform.position - var_345_12.position).y, (manager.ui.mainCamera.transform.position - var_345_12.position).z)
				var_345_12.localEulerAngles.z = 0
				var_345_12.localEulerAngles.x = 0
				var_345_12.localEulerAngles = var_345_12.localEulerAngles
			end

			local var_345_14 = arg_342_1.actors_["2078ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_14) and arg_342_1.var_.characterEffect2078ui_story == nil then
				arg_342_1.var_.characterEffect2078ui_story = var_345_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_15 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_15 and not isNil(var_345_14) then
				if arg_342_1.var_.characterEffect2078ui_story and not isNil(var_345_14) then
					arg_342_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_342_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_15)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_15 and arg_342_1.time_ < 0 + var_345_15 + arg_345_0 and not isNil(var_345_14) and arg_342_1.var_.characterEffect2078ui_story then
				arg_342_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_342_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_345_16 = 0
			local var_345_17 = 0.25

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_16 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_18 = arg_342_1:GetWordFromCfg(317252079)
				local var_345_19 = arg_342_1:FormatText(var_345_18.content)

				arg_342_1.text_.text = var_345_19

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_21 = 10 <= 0 and var_345_17 or var_345_17 * (utf8.len(var_345_19) / 10)

				if (10 <= 0 and var_345_17 or var_345_17 * (utf8.len(var_345_19) / 10)) > 0 and var_345_17 < var_345_21 then
					arg_342_1.talkMaxDuration = var_345_21

					if var_345_21 + var_345_16 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_21 + var_345_16
					end
				end

				arg_342_1.text_.text = var_345_19
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252079", "story_v_out_317252.awb") ~= 0 then
					local var_345_22 = manager.audio:GetVoiceLength("story_v_out_317252", "317252079", "story_v_out_317252.awb") / 1000

					if var_345_22 + var_345_16 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_22 + var_345_16
					end

					if var_345_18.prefab_name ~= "" and arg_342_1.actors_[var_345_18.prefab_name] ~= nil then
						local var_345_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_18.prefab_name].transform, "story_v_out_317252", "317252079", "story_v_out_317252.awb")

						arg_342_1:RecordAudio("317252079", var_345_23)
						arg_342_1:RecordAudio("317252079", var_345_23)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_317252", "317252079", "story_v_out_317252.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_317252", "317252079", "story_v_out_317252.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_24 = math.max(var_345_17, arg_342_1.talkMaxDuration)

			if var_345_16 <= arg_342_1.time_ and arg_342_1.time_ < var_345_16 + var_345_24 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_16) / var_345_24

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_16 + var_345_24 and arg_342_1.time_ < var_345_16 + var_345_24 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play317252080 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 317252080
		arg_346_1.duration_ = 5.27

		local var_346_0 = {
			zh = 5.266,
			ja = 3.8
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play317252081(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos2078ui_story = arg_346_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["2078ui_story"].transform.position).z)
				arg_346_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["2078ui_story"].transform.localEulerAngles = arg_346_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_346_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["2078ui_story"].transform.position).z)
				arg_346_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["2078ui_story"].transform.localEulerAngles = arg_346_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_349_1 = arg_346_1.actors_["2078ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect2078ui_story == nil then
				arg_346_1.var_.characterEffect2078ui_story = var_349_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 and not isNil(var_349_1) then
				if arg_346_1.var_.characterEffect2078ui_story and not isNil(var_349_1) then
					arg_346_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect2078ui_story then
				arg_346_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_349_4 = arg_346_1.actors_["2079ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_4) and arg_346_1.var_.characterEffect2079ui_story == nil then
				arg_346_1.var_.characterEffect2079ui_story = var_349_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_5 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_5 and not isNil(var_349_4) then
				if arg_346_1.var_.characterEffect2079ui_story and not isNil(var_349_4) then
					arg_346_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_346_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_5)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_5 and arg_346_1.time_ < 0 + var_349_5 + arg_349_0 and not isNil(var_349_4) and arg_346_1.var_.characterEffect2079ui_story then
				arg_346_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_346_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_349_6 = 0
			local var_349_7 = 0.55

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_8 = arg_346_1:GetWordFromCfg(317252080)
				local var_349_9 = arg_346_1:FormatText(var_349_8.content)

				arg_346_1.text_.text = var_349_9

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_11 = 22 <= 0 and var_349_7 or var_349_7 * (utf8.len(var_349_9) / 22)

				if (22 <= 0 and var_349_7 or var_349_7 * (utf8.len(var_349_9) / 22)) > 0 and var_349_7 < var_349_11 then
					arg_346_1.talkMaxDuration = var_349_11

					if var_349_11 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_9
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252080", "story_v_out_317252.awb") ~= 0 then
					local var_349_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252080", "story_v_out_317252.awb") / 1000

					if var_349_12 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_6
					end

					if var_349_8.prefab_name ~= "" and arg_346_1.actors_[var_349_8.prefab_name] ~= nil then
						local var_349_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_8.prefab_name].transform, "story_v_out_317252", "317252080", "story_v_out_317252.awb")

						arg_346_1:RecordAudio("317252080", var_349_13)
						arg_346_1:RecordAudio("317252080", var_349_13)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_317252", "317252080", "story_v_out_317252.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_317252", "317252080", "story_v_out_317252.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_14 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_14 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_14

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_14 and arg_346_1.time_ < var_349_6 + var_349_14 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play317252081 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 317252081
		arg_350_1.duration_ = 5.8

		local var_350_0 = {
			zh = 4.8,
			ja = 5.8
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play317252082(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos2079ui_story = arg_350_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2079ui_story"].transform.position).z)
				arg_350_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["2079ui_story"].transform.localEulerAngles = arg_350_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_350_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["2079ui_story"].transform.position).z)
				arg_350_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["2079ui_story"].transform.localEulerAngles = arg_350_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_353_1 = arg_350_1.actors_["2079ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect2079ui_story == nil then
				arg_350_1.var_.characterEffect2079ui_story = var_353_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 and not isNil(var_353_1) then
				if arg_350_1.var_.characterEffect2079ui_story and not isNil(var_353_1) then
					arg_350_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect2079ui_story then
				arg_350_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_353_4 = arg_350_1.actors_["2078ui_story"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos2078ui_story = var_353_4.localPosition
			end

			local var_353_5 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_5 then
				var_353_4.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_5)
				var_353_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_4.position).x, (manager.ui.mainCamera.transform.position - var_353_4.position).y, (manager.ui.mainCamera.transform.position - var_353_4.position).z)
				var_353_4.localEulerAngles.z = 0
				var_353_4.localEulerAngles.x = 0
				var_353_4.localEulerAngles = var_353_4.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_5 and arg_350_1.time_ < 0 + var_353_5 + arg_353_0 then
				var_353_4.localPosition = Vector3.New(0, 100, 0)
				var_353_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_4.position).x, (manager.ui.mainCamera.transform.position - var_353_4.position).y, (manager.ui.mainCamera.transform.position - var_353_4.position).z)
				var_353_4.localEulerAngles.z = 0
				var_353_4.localEulerAngles.x = 0
				var_353_4.localEulerAngles = var_353_4.localEulerAngles
			end

			local var_353_6 = 0
			local var_353_7 = 0.55

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_8 = arg_350_1:GetWordFromCfg(317252081)
				local var_353_9 = arg_350_1:FormatText(var_353_8.content)

				arg_350_1.text_.text = var_353_9

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_11 = 22 <= 0 and var_353_7 or var_353_7 * (utf8.len(var_353_9) / 22)

				if (22 <= 0 and var_353_7 or var_353_7 * (utf8.len(var_353_9) / 22)) > 0 and var_353_7 < var_353_11 then
					arg_350_1.talkMaxDuration = var_353_11

					if var_353_11 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_11 + var_353_6
					end
				end

				arg_350_1.text_.text = var_353_9
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252081", "story_v_out_317252.awb") ~= 0 then
					local var_353_12 = manager.audio:GetVoiceLength("story_v_out_317252", "317252081", "story_v_out_317252.awb") / 1000

					if var_353_12 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_12 + var_353_6
					end

					if var_353_8.prefab_name ~= "" and arg_350_1.actors_[var_353_8.prefab_name] ~= nil then
						local var_353_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_8.prefab_name].transform, "story_v_out_317252", "317252081", "story_v_out_317252.awb")

						arg_350_1:RecordAudio("317252081", var_353_13)
						arg_350_1:RecordAudio("317252081", var_353_13)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_317252", "317252081", "story_v_out_317252.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_317252", "317252081", "story_v_out_317252.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_14 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_14 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_14

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_14 and arg_350_1.time_ < var_353_6 + var_353_14 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play317252082 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 317252082
		arg_354_1.duration_ = 2.37

		local var_354_0 = {
			zh = 2.366,
			ja = 1.8
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play317252083(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos2078ui_story = arg_354_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).z)
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles = arg_354_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["2078ui_story"].transform.position).z)
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["2078ui_story"].transform.localEulerAngles = arg_354_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["2078ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect2078ui_story == nil then
				arg_354_1.var_.characterEffect2078ui_story = var_357_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_2 and not isNil(var_357_1) then
				if arg_354_1.var_.characterEffect2078ui_story and not isNil(var_357_1) then
					arg_354_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_354_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_2)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_2 and arg_354_1.time_ < 0 + var_357_2 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect2078ui_story then
				arg_354_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_354_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_357_3 = arg_354_1.actors_["2079ui_story"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos2079ui_story = var_357_3.localPosition
			end

			local var_357_4 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				var_357_3.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_354_1.time_ - 0) / var_357_4)
				var_357_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_3.position).x, (manager.ui.mainCamera.transform.position - var_357_3.position).y, (manager.ui.mainCamera.transform.position - var_357_3.position).z)
				var_357_3.localEulerAngles.z = 0
				var_357_3.localEulerAngles.x = 0
				var_357_3.localEulerAngles = var_357_3.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				var_357_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_357_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_3.position).x, (manager.ui.mainCamera.transform.position - var_357_3.position).y, (manager.ui.mainCamera.transform.position - var_357_3.position).z)
				var_357_3.localEulerAngles.z = 0
				var_357_3.localEulerAngles.x = 0
				var_357_3.localEulerAngles = var_357_3.localEulerAngles
			end

			local var_357_5 = arg_354_1.actors_["2079ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_5) and arg_354_1.var_.characterEffect2079ui_story == nil then
				arg_354_1.var_.characterEffect2079ui_story = var_357_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_6 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_6 and not isNil(var_357_5) then
				if arg_354_1.var_.characterEffect2079ui_story and not isNil(var_357_5) then
					arg_354_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_6 and arg_354_1.time_ < 0 + var_357_6 + arg_357_0 and not isNil(var_357_5) and arg_354_1.var_.characterEffect2079ui_story then
				arg_354_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_357_8 = 0
			local var_357_9 = 0.175

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_10 = arg_354_1:GetWordFromCfg(317252082)
				local var_357_11 = arg_354_1:FormatText(var_357_10.content)

				arg_354_1.text_.text = var_357_11

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_13 = 7 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 7)

				if (7 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 7)) > 0 and var_357_9 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_11
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252082", "story_v_out_317252.awb") ~= 0 then
					local var_357_14 = manager.audio:GetVoiceLength("story_v_out_317252", "317252082", "story_v_out_317252.awb") / 1000

					if var_357_14 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_8
					end

					if var_357_10.prefab_name ~= "" and arg_354_1.actors_[var_357_10.prefab_name] ~= nil then
						local var_357_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_10.prefab_name].transform, "story_v_out_317252", "317252082", "story_v_out_317252.awb")

						arg_354_1:RecordAudio("317252082", var_357_15)
						arg_354_1:RecordAudio("317252082", var_357_15)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_317252", "317252082", "story_v_out_317252.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_317252", "317252082", "story_v_out_317252.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_8 <= arg_354_1.time_ and arg_354_1.time_ < var_357_8 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_8) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_8 + var_357_16 and arg_354_1.time_ < var_357_8 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play317252083 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 317252083
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play317252084(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["2079ui_story"]) and arg_358_1.var_.characterEffect2079ui_story == nil then
				arg_358_1.var_.characterEffect2079ui_story = arg_358_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["2079ui_story"]) then
				if arg_358_1.var_.characterEffect2079ui_story and not isNil(arg_358_1.actors_["2079ui_story"]) then
					arg_358_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_358_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_0)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["2079ui_story"]) and arg_358_1.var_.characterEffect2079ui_story then
				arg_358_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_358_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_361_1 = 0
			local var_361_2 = 0.65

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(317252083).content)

				arg_358_1.text_.text = var_361_3

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 26 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 26)

				if (26 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 26)) > 0 and var_361_2 < var_361_5 then
					arg_358_1.talkMaxDuration = var_361_5

					if var_361_5 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + var_361_1
					end
				end

				arg_358_1.text_.text = var_361_3
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_6 = math.max(var_361_2, arg_358_1.talkMaxDuration)

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_6 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_1) / var_361_6

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_1 + var_361_6 and arg_358_1.time_ < var_361_1 + var_361_6 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play317252084 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 317252084
		arg_362_1.duration_ = 2.17

		local var_362_0 = {
			zh = 1.999999999999,
			ja = 2.166
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play317252085(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos2079ui_story = arg_362_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_365_0 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 then
				arg_362_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_362_1.time_ - 0) / var_365_0)
				arg_362_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2079ui_story"].transform.position).z)
				arg_362_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["2079ui_story"].transform.localEulerAngles = arg_362_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 then
				arg_362_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_362_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["2079ui_story"].transform.position).z)
				arg_362_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["2079ui_story"].transform.localEulerAngles = arg_362_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_365_1 = arg_362_1.actors_["2079ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect2079ui_story == nil then
				arg_362_1.var_.characterEffect2079ui_story = var_365_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_2 and not isNil(var_365_1) then
				if arg_362_1.var_.characterEffect2079ui_story and not isNil(var_365_1) then
					arg_362_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_2 and arg_362_1.time_ < 0 + var_365_2 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect2079ui_story then
				arg_362_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_365_4 = 0
			local var_365_5 = 0.225

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_6 = arg_362_1:GetWordFromCfg(317252084)
				local var_365_7 = arg_362_1:FormatText(var_365_6.content)

				arg_362_1.text_.text = var_365_7

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_9 = 9 <= 0 and var_365_5 or var_365_5 * (utf8.len(var_365_7) / 9)

				if (9 <= 0 and var_365_5 or var_365_5 * (utf8.len(var_365_7) / 9)) > 0 and var_365_5 < var_365_9 then
					arg_362_1.talkMaxDuration = var_365_9

					if var_365_9 + var_365_4 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_9 + var_365_4
					end
				end

				arg_362_1.text_.text = var_365_7
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252084", "story_v_out_317252.awb") ~= 0 then
					local var_365_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252084", "story_v_out_317252.awb") / 1000

					if var_365_10 + var_365_4 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_4
					end

					if var_365_6.prefab_name ~= "" and arg_362_1.actors_[var_365_6.prefab_name] ~= nil then
						local var_365_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_6.prefab_name].transform, "story_v_out_317252", "317252084", "story_v_out_317252.awb")

						arg_362_1:RecordAudio("317252084", var_365_11)
						arg_362_1:RecordAudio("317252084", var_365_11)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_317252", "317252084", "story_v_out_317252.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_317252", "317252084", "story_v_out_317252.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_12 = math.max(var_365_5, arg_362_1.talkMaxDuration)

			if var_365_4 <= arg_362_1.time_ and arg_362_1.time_ < var_365_4 + var_365_12 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_4) / var_365_12

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_4 + var_365_12 and arg_362_1.time_ < var_365_4 + var_365_12 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play317252085 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 317252085
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play317252086(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos2079ui_story = arg_366_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).z)
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles = arg_366_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_366_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["2079ui_story"].transform.position).z)
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["2079ui_story"].transform.localEulerAngles = arg_366_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_369_1 = 0
			local var_369_2 = 0.85

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_3 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(317252085).content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 34 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 34)

				if (34 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 34)) > 0 and var_369_2 < var_369_5 then
					arg_366_1.talkMaxDuration = var_369_5

					if var_369_5 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + var_369_1
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_6 = math.max(var_369_2, arg_366_1.talkMaxDuration)

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_6 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_1) / var_369_6

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_1 + var_369_6 and arg_366_1.time_ < var_369_1 + var_369_6 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play317252086 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 317252086
		arg_370_1.duration_ = 4.33

		local var_370_0 = {
			zh = 4.333,
			ja = 3.766
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play317252087(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1158ui_story = arg_370_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_373_0 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 then
				arg_370_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_370_1.time_ - 0) / var_373_0)
				arg_370_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1158ui_story"].transform.position).z)
				arg_370_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1158ui_story"].transform.localEulerAngles = arg_370_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 then
				arg_370_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_370_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1158ui_story"].transform.position).z)
				arg_370_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1158ui_story"].transform.localEulerAngles = arg_370_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_373_1 = arg_370_1.actors_["1158ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1158ui_story == nil then
				arg_370_1.var_.characterEffect1158ui_story = var_373_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_2 and not isNil(var_373_1) then
				if arg_370_1.var_.characterEffect1158ui_story and not isNil(var_373_1) then
					arg_370_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_2 and arg_370_1.time_ < 0 + var_373_2 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1158ui_story then
				arg_370_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_373_4 = 0
			local var_373_5 = 0.6

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_6 = arg_370_1:GetWordFromCfg(317252086)
				local var_373_7 = arg_370_1:FormatText(var_373_6.content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_9 = 24 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 24)

				if (24 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 24)) > 0 and var_373_5 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_4
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252086", "story_v_out_317252.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252086", "story_v_out_317252.awb") / 1000

					if var_373_10 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_4
					end

					if var_373_6.prefab_name ~= "" and arg_370_1.actors_[var_373_6.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_6.prefab_name].transform, "story_v_out_317252", "317252086", "story_v_out_317252.awb")

						arg_370_1:RecordAudio("317252086", var_373_11)
						arg_370_1:RecordAudio("317252086", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_317252", "317252086", "story_v_out_317252.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_317252", "317252086", "story_v_out_317252.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_5, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_4) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_12 and arg_370_1.time_ < var_373_4 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play317252087 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 317252087
		arg_374_1.duration_ = 7

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play317252088(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				local var_377_0 = arg_374_1.bgs_.STblack

				arg_374_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_377_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_377_1 = var_377_0:GetComponent("SpriteRenderer")

				if var_377_1 and var_377_1.sprite then
					local var_377_2 = 2 * (var_377_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_377_0.transform.localScale = Vector3.New(var_377_2 / var_377_1.sprite.bounds.size.y < var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x and var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x or var_377_2 / var_377_1.sprite.bounds.size.y, var_377_2 / var_377_1.sprite.bounds.size.y < var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x and var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x or var_377_2 / var_377_1.sprite.bounds.size.y, 0)
				end

				for iter_377_0, iter_377_1 in pairs(arg_374_1.bgs_) do
					if iter_377_0 ~= "STblack" then
						iter_377_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_377_3 = 0

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_3 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_4 = 2

			if var_377_3 <= arg_374_1.time_ and arg_374_1.time_ < var_377_3 + var_377_4 then
				local var_377_5 = Color.New(0, 0, 0)

				var_377_5.a = Mathf.Lerp(1, 0, (arg_374_1.time_ - var_377_3) / var_377_4)
				arg_374_1.mask_.color = var_377_5
			end

			if arg_374_1.time_ >= var_377_3 + var_377_4 and arg_374_1.time_ < var_377_3 + var_377_4 + arg_377_0 then
				local var_377_6 = Color.New(0, 0, 0)

				arg_374_1.mask_.enabled = false
				var_377_6.a = 0
				arg_374_1.mask_.color = var_377_6
			end

			local var_377_7 = arg_374_1.actors_["1158ui_story"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1158ui_story = var_377_7.localPosition
			end

			local var_377_8 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_8 then
				var_377_7.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_374_1.time_ - 0) / var_377_8)
				var_377_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_377_7.position).x, (manager.ui.mainCamera.transform.position - var_377_7.position).y, (manager.ui.mainCamera.transform.position - var_377_7.position).z)
				var_377_7.localEulerAngles.z = 0
				var_377_7.localEulerAngles.x = 0
				var_377_7.localEulerAngles = var_377_7.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_8 and arg_374_1.time_ < 0 + var_377_8 + arg_377_0 then
				var_377_7.localPosition = Vector3.New(0, 100, 0)
				var_377_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_377_7.position).x, (manager.ui.mainCamera.transform.position - var_377_7.position).y, (manager.ui.mainCamera.transform.position - var_377_7.position).z)
				var_377_7.localEulerAngles.z = 0
				var_377_7.localEulerAngles.x = 0
				var_377_7.localEulerAngles = var_377_7.localEulerAngles
			end

			if arg_374_1.frameCnt_ <= 1 then
				arg_374_1.dialog_:SetActive(false)
			end

			local var_377_9 = 2
			local var_377_10 = 1.1

			if 2 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				arg_374_1.dialog_:SetActive(true)

				arg_374_1.dialogCg_.alpha = 0

				local var_377_11 = LeanTween.value(arg_374_1.dialog_, 0, 1, 0.3)

				var_377_11:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_374_1.dialogCg_.alpha = arg_378_0
				end))
				var_377_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_374_1.dialog_)
					var_377_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_374_1.duration_ = arg_374_1.duration_ + 0.3

				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_12 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(317252087).content)

				arg_374_1.text_.text = var_377_12

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_14 = 44 <= 0 and var_377_10 or var_377_10 * (utf8.len(var_377_12) / 44)

				if (44 <= 0 and var_377_10 or var_377_10 * (utf8.len(var_377_12) / 44)) > 0 and var_377_10 < var_377_14 then
					arg_374_1.talkMaxDuration = var_377_14
					var_377_9 = var_377_9 + 0.3

					if var_377_14 + var_377_9 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_14 + var_377_9
					end
				end

				arg_374_1.text_.text = var_377_12
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_15 = var_377_9 + 0.3
			local var_377_16 = math.max(var_377_10, arg_374_1.talkMaxDuration)

			if var_377_9 + 0.3 <= arg_374_1.time_ and arg_374_1.time_ < var_377_15 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_15) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_15 + var_377_16 and arg_374_1.time_ < var_377_15 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play317252088 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 317252088
		arg_380_1.duration_ = 4.3

		local var_380_0 = {
			zh = 4.233,
			ja = 4.3
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play317252089(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				local var_383_0 = arg_380_1.bgs_.K11f

				arg_380_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_383_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_383_1 = var_383_0:GetComponent("SpriteRenderer")

				if var_383_1 and var_383_1.sprite then
					local var_383_2 = 2 * (var_383_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_383_0.transform.localScale = Vector3.New(var_383_2 / var_383_1.sprite.bounds.size.y < var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x and var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x or var_383_2 / var_383_1.sprite.bounds.size.y, var_383_2 / var_383_1.sprite.bounds.size.y < var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x and var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x or var_383_2 / var_383_1.sprite.bounds.size.y, 0)
				end

				for iter_383_0, iter_383_1 in pairs(arg_380_1.bgs_) do
					if iter_383_0 ~= "K11f" then
						iter_383_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_383_3 = 0

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_3 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_4 = 2

			if var_383_3 <= arg_380_1.time_ and arg_380_1.time_ < var_383_3 + var_383_4 then
				local var_383_5 = Color.New(0, 0, 0)

				var_383_5.a = Mathf.Lerp(1, 0, (arg_380_1.time_ - var_383_3) / var_383_4)
				arg_380_1.mask_.color = var_383_5
			end

			if arg_380_1.time_ >= var_383_3 + var_383_4 and arg_380_1.time_ < var_383_3 + var_383_4 + arg_383_0 then
				local var_383_6 = Color.New(0, 0, 0)

				arg_380_1.mask_.enabled = false
				var_383_6.a = 0
				arg_380_1.mask_.color = var_383_6
			end

			local var_383_7 = arg_380_1.actors_["1158ui_story"].transform

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= 2 + arg_383_0 then
				arg_380_1.var_.moveOldPos1158ui_story = var_383_7.localPosition
			end

			local var_383_8 = 0.001

			if 2 <= arg_380_1.time_ and arg_380_1.time_ < 2 + var_383_8 then
				var_383_7.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_380_1.time_ - 2) / var_383_8)
				var_383_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_7.position).x, (manager.ui.mainCamera.transform.position - var_383_7.position).y, (manager.ui.mainCamera.transform.position - var_383_7.position).z)
				var_383_7.localEulerAngles.z = 0
				var_383_7.localEulerAngles.x = 0
				var_383_7.localEulerAngles = var_383_7.localEulerAngles
			end

			if arg_380_1.time_ >= 2 + var_383_8 and arg_380_1.time_ < 2 + var_383_8 + arg_383_0 then
				var_383_7.localPosition = Vector3.New(0, -0.95, -6)
				var_383_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_7.position).x, (manager.ui.mainCamera.transform.position - var_383_7.position).y, (manager.ui.mainCamera.transform.position - var_383_7.position).z)
				var_383_7.localEulerAngles.z = 0
				var_383_7.localEulerAngles.x = 0
				var_383_7.localEulerAngles = var_383_7.localEulerAngles
			end

			local var_383_9 = arg_380_1.actors_["1158ui_story"]

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= 2 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1158ui_story == nil then
				arg_380_1.var_.characterEffect1158ui_story = var_383_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_10 = 0.200000002980232

			if 2 <= arg_380_1.time_ and arg_380_1.time_ < 2 + var_383_10 and not isNil(var_383_9) then
				if arg_380_1.var_.characterEffect1158ui_story and not isNil(var_383_9) then
					arg_380_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 2 + var_383_10 and arg_380_1.time_ < 2 + var_383_10 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1158ui_story then
				arg_380_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= 2 + arg_383_0 then
				arg_380_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action2_1")
			end

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= 2 + arg_383_0 then
				arg_380_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_12 = 2
			local var_383_13 = 0.325

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= var_383_12 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_14 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_14:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_15 = arg_380_1:GetWordFromCfg(317252088)
				local var_383_16 = arg_380_1:FormatText(var_383_15.content)

				arg_380_1.text_.text = var_383_16

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_18 = 13 <= 0 and var_383_13 or var_383_13 * (utf8.len(var_383_16) / 13)

				if (13 <= 0 and var_383_13 or var_383_13 * (utf8.len(var_383_16) / 13)) > 0 and var_383_13 < var_383_18 then
					arg_380_1.talkMaxDuration = var_383_18
					var_383_12 = var_383_12 + 0.3

					if var_383_18 + var_383_12 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_18 + var_383_12
					end
				end

				arg_380_1.text_.text = var_383_16
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252088", "story_v_out_317252.awb") ~= 0 then
					local var_383_19 = manager.audio:GetVoiceLength("story_v_out_317252", "317252088", "story_v_out_317252.awb") / 1000

					if var_383_19 + var_383_12 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_19 + var_383_12
					end

					if var_383_15.prefab_name ~= "" and arg_380_1.actors_[var_383_15.prefab_name] ~= nil then
						local var_383_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_15.prefab_name].transform, "story_v_out_317252", "317252088", "story_v_out_317252.awb")

						arg_380_1:RecordAudio("317252088", var_383_20)
						arg_380_1:RecordAudio("317252088", var_383_20)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_317252", "317252088", "story_v_out_317252.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_317252", "317252088", "story_v_out_317252.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_21 = var_383_12 + 0.3
			local var_383_22 = math.max(var_383_13, arg_380_1.talkMaxDuration)

			if var_383_12 + 0.3 <= arg_380_1.time_ and arg_380_1.time_ < var_383_21 + var_383_22 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_21) / var_383_22

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_21 + var_383_22 and arg_380_1.time_ < var_383_21 + var_383_22 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play317252089 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 317252089
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play317252090(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1158ui_story"]) and arg_386_1.var_.characterEffect1158ui_story == nil then
				arg_386_1.var_.characterEffect1158ui_story = arg_386_1.actors_["1158ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1158ui_story"]) then
				if arg_386_1.var_.characterEffect1158ui_story and not isNil(arg_386_1.actors_["1158ui_story"]) then
					arg_386_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_0)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1158ui_story"]) and arg_386_1.var_.characterEffect1158ui_story then
				arg_386_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_389_1 = 0
			local var_389_2 = 1.375

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(317252089).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 55 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 55)

				if (55 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 55)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play317252090 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 317252090
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play317252091(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.2

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(317252090).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 8)

				if (8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 8)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play317252091 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 317252091
		arg_394_1.duration_ = 4.13

		local var_394_0 = {
			zh = 2.066,
			ja = 4.133
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play317252092(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1158ui_story = arg_394_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_397_0 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 then
				arg_394_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_394_1.time_ - 0) / var_397_0)
				arg_394_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1158ui_story"].transform.position).z)
				arg_394_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["1158ui_story"].transform.localEulerAngles = arg_394_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 then
				arg_394_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_394_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1158ui_story"].transform.position).z)
				arg_394_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["1158ui_story"].transform.localEulerAngles = arg_394_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_397_1 = arg_394_1.actors_["1158ui_story"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_1) and arg_394_1.var_.characterEffect1158ui_story == nil then
				arg_394_1.var_.characterEffect1158ui_story = var_397_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_2 and not isNil(var_397_1) then
				if arg_394_1.var_.characterEffect1158ui_story and not isNil(var_397_1) then
					arg_394_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_2 and arg_394_1.time_ < 0 + var_397_2 + arg_397_0 and not isNil(var_397_1) and arg_394_1.var_.characterEffect1158ui_story then
				arg_394_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_397_4 = 0
			local var_397_5 = 0.3

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_6 = arg_394_1:GetWordFromCfg(317252091)
				local var_397_7 = arg_394_1:FormatText(var_397_6.content)

				arg_394_1.text_.text = var_397_7

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_9 = 12 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 12)

				if (12 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 12)) > 0 and var_397_5 < var_397_9 then
					arg_394_1.talkMaxDuration = var_397_9

					if var_397_9 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_9 + var_397_4
					end
				end

				arg_394_1.text_.text = var_397_7
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252091", "story_v_out_317252.awb") ~= 0 then
					local var_397_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252091", "story_v_out_317252.awb") / 1000

					if var_397_10 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_10 + var_397_4
					end

					if var_397_6.prefab_name ~= "" and arg_394_1.actors_[var_397_6.prefab_name] ~= nil then
						local var_397_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_6.prefab_name].transform, "story_v_out_317252", "317252091", "story_v_out_317252.awb")

						arg_394_1:RecordAudio("317252091", var_397_11)
						arg_394_1:RecordAudio("317252091", var_397_11)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_317252", "317252091", "story_v_out_317252.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_317252", "317252091", "story_v_out_317252.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_12 = math.max(var_397_5, arg_394_1.talkMaxDuration)

			if var_397_4 <= arg_394_1.time_ and arg_394_1.time_ < var_397_4 + var_397_12 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_4) / var_397_12

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_4 + var_397_12 and arg_394_1.time_ < var_397_4 + var_397_12 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play317252092 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 317252092
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play317252093(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1158ui_story"]) and arg_398_1.var_.characterEffect1158ui_story == nil then
				arg_398_1.var_.characterEffect1158ui_story = arg_398_1.actors_["1158ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1158ui_story"]) then
				if arg_398_1.var_.characterEffect1158ui_story and not isNil(arg_398_1.actors_["1158ui_story"]) then
					arg_398_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_398_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_398_1.time_ - 0) / var_401_0)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1158ui_story"]) and arg_398_1.var_.characterEffect1158ui_story then
				arg_398_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_398_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_401_1 = arg_398_1.actors_["1158ui_story"].transform

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1158ui_story = var_401_1.localPosition
			end

			local var_401_2 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 then
				var_401_1.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_398_1.time_ - 0) / var_401_2)
				var_401_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_401_1.position).x, (manager.ui.mainCamera.transform.position - var_401_1.position).y, (manager.ui.mainCamera.transform.position - var_401_1.position).z)
				var_401_1.localEulerAngles.z = 0
				var_401_1.localEulerAngles.x = 0
				var_401_1.localEulerAngles = var_401_1.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 then
				var_401_1.localPosition = Vector3.New(0, 100, 0)
				var_401_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_401_1.position).x, (manager.ui.mainCamera.transform.position - var_401_1.position).y, (manager.ui.mainCamera.transform.position - var_401_1.position).z)
				var_401_1.localEulerAngles.z = 0
				var_401_1.localEulerAngles.x = 0
				var_401_1.localEulerAngles = var_401_1.localEulerAngles
			end

			local var_401_3 = 0
			local var_401_4 = 1.15

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_3 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_5 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(317252092).content)

				arg_398_1.text_.text = var_401_5

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_7 = 46 <= 0 and var_401_4 or var_401_4 * (utf8.len(var_401_5) / 46)

				if (46 <= 0 and var_401_4 or var_401_4 * (utf8.len(var_401_5) / 46)) > 0 and var_401_4 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_3 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_3
					end
				end

				arg_398_1.text_.text = var_401_5
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_4, arg_398_1.talkMaxDuration)

			if var_401_3 <= arg_398_1.time_ and arg_398_1.time_ < var_401_3 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_3) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_3 + var_401_8 and arg_398_1.time_ < var_401_3 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play317252093 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 317252093
		arg_402_1.duration_ = 11.97

		local var_402_0 = {
			zh = 10.733,
			ja = 11.966
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play317252094(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos1158ui_story = arg_402_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_405_0 = 0.001

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 then
				arg_402_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_402_1.time_ - 0) / var_405_0)
				arg_402_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1158ui_story"].transform.position).z)
				arg_402_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["1158ui_story"].transform.localEulerAngles = arg_402_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 then
				arg_402_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_402_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1158ui_story"].transform.position).z)
				arg_402_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["1158ui_story"].transform.localEulerAngles = arg_402_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_405_1 = arg_402_1.actors_["1158ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_1) and arg_402_1.var_.characterEffect1158ui_story == nil then
				arg_402_1.var_.characterEffect1158ui_story = var_405_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_2 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_2 and not isNil(var_405_1) then
				if arg_402_1.var_.characterEffect1158ui_story and not isNil(var_405_1) then
					arg_402_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_2 and arg_402_1.time_ < 0 + var_405_2 + arg_405_0 and not isNil(var_405_1) and arg_402_1.var_.characterEffect1158ui_story then
				arg_402_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action5_1")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_405_4 = 0
			local var_405_5 = 1.275

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_4 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_6 = arg_402_1:GetWordFromCfg(317252093)
				local var_405_7 = arg_402_1:FormatText(var_405_6.content)

				arg_402_1.text_.text = var_405_7

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_9 = 51 <= 0 and var_405_5 or var_405_5 * (utf8.len(var_405_7) / 51)

				if (51 <= 0 and var_405_5 or var_405_5 * (utf8.len(var_405_7) / 51)) > 0 and var_405_5 < var_405_9 then
					arg_402_1.talkMaxDuration = var_405_9

					if var_405_9 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_9 + var_405_4
					end
				end

				arg_402_1.text_.text = var_405_7
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252093", "story_v_out_317252.awb") ~= 0 then
					local var_405_10 = manager.audio:GetVoiceLength("story_v_out_317252", "317252093", "story_v_out_317252.awb") / 1000

					if var_405_10 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_4
					end

					if var_405_6.prefab_name ~= "" and arg_402_1.actors_[var_405_6.prefab_name] ~= nil then
						local var_405_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_6.prefab_name].transform, "story_v_out_317252", "317252093", "story_v_out_317252.awb")

						arg_402_1:RecordAudio("317252093", var_405_11)
						arg_402_1:RecordAudio("317252093", var_405_11)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_317252", "317252093", "story_v_out_317252.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_317252", "317252093", "story_v_out_317252.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_12 = math.max(var_405_5, arg_402_1.talkMaxDuration)

			if var_405_4 <= arg_402_1.time_ and arg_402_1.time_ < var_405_4 + var_405_12 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_4) / var_405_12

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_4 + var_405_12 and arg_402_1.time_ < var_405_4 + var_405_12 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play317252094 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 317252094
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play317252095(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1158ui_story"]) and arg_406_1.var_.characterEffect1158ui_story == nil then
				arg_406_1.var_.characterEffect1158ui_story = arg_406_1.actors_["1158ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1158ui_story"]) then
				if arg_406_1.var_.characterEffect1158ui_story and not isNil(arg_406_1.actors_["1158ui_story"]) then
					arg_406_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_0)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1158ui_story"]) and arg_406_1.var_.characterEffect1158ui_story then
				arg_406_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_409_1 = 0
			local var_409_2 = 0.6

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_3 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(317252094).content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 24 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 24)

				if (24 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 24)) > 0 and var_409_2 < var_409_5 then
					arg_406_1.talkMaxDuration = var_409_5

					if var_409_5 + var_409_1 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + var_409_1
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_6 = math.max(var_409_2, arg_406_1.talkMaxDuration)

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_6 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_1) / var_409_6

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_1 + var_409_6 and arg_406_1.time_ < var_409_1 + var_409_6 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play317252095 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 317252095
		arg_410_1.duration_ = 3.83

		local var_410_0 = {
			zh = 3.833,
			ja = 2.4
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play317252096(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1158ui_story"]) and arg_410_1.var_.characterEffect1158ui_story == nil then
				arg_410_1.var_.characterEffect1158ui_story = arg_410_1.actors_["1158ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1158ui_story"]) then
				if arg_410_1.var_.characterEffect1158ui_story and not isNil(arg_410_1.actors_["1158ui_story"]) then
					arg_410_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1158ui_story"]) and arg_410_1.var_.characterEffect1158ui_story then
				arg_410_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_413_2 = 0
			local var_413_3 = 0.425

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_2 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_4 = arg_410_1:GetWordFromCfg(317252095)
				local var_413_5 = arg_410_1:FormatText(var_413_4.content)

				arg_410_1.text_.text = var_413_5

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_7 = 17 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 17)

				if (17 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 17)) > 0 and var_413_3 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_2
					end
				end

				arg_410_1.text_.text = var_413_5
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252095", "story_v_out_317252.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_317252", "317252095", "story_v_out_317252.awb") / 1000

					if var_413_8 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_2
					end

					if var_413_4.prefab_name ~= "" and arg_410_1.actors_[var_413_4.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_4.prefab_name].transform, "story_v_out_317252", "317252095", "story_v_out_317252.awb")

						arg_410_1:RecordAudio("317252095", var_413_9)
						arg_410_1:RecordAudio("317252095", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_317252", "317252095", "story_v_out_317252.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_317252", "317252095", "story_v_out_317252.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_3, arg_410_1.talkMaxDuration)

			if var_413_2 <= arg_410_1.time_ and arg_410_1.time_ < var_413_2 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_2) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_2 + var_413_10 and arg_410_1.time_ < var_413_2 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play317252096 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 317252096
		arg_414_1.duration_ = 3.9

		local var_414_0 = {
			zh = 2.2,
			ja = 3.9
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play317252097(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action5_2")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_417_0 = 0
			local var_417_1 = 0.25

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_2 = arg_414_1:GetWordFromCfg(317252096)
				local var_417_3 = arg_414_1:FormatText(var_417_2.content)

				arg_414_1.text_.text = var_417_3

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 10 <= 0 and var_417_1 or var_417_1 * (utf8.len(var_417_3) / 10)

				if (10 <= 0 and var_417_1 or var_417_1 * (utf8.len(var_417_3) / 10)) > 0 and var_417_1 < var_417_5 then
					arg_414_1.talkMaxDuration = var_417_5

					if var_417_5 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_3
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252096", "story_v_out_317252.awb") ~= 0 then
					local var_417_6 = manager.audio:GetVoiceLength("story_v_out_317252", "317252096", "story_v_out_317252.awb") / 1000

					if var_417_6 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_0
					end

					if var_417_2.prefab_name ~= "" and arg_414_1.actors_[var_417_2.prefab_name] ~= nil then
						local var_417_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_2.prefab_name].transform, "story_v_out_317252", "317252096", "story_v_out_317252.awb")

						arg_414_1:RecordAudio("317252096", var_417_7)
						arg_414_1:RecordAudio("317252096", var_417_7)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_317252", "317252096", "story_v_out_317252.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_317252", "317252096", "story_v_out_317252.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_8 and arg_414_1.time_ < var_417_0 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play317252097 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 317252097
		arg_418_1.duration_ = 9.27

		local var_418_0 = {
			zh = 4.9,
			ja = 9.266
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play317252098(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_421_0 = 0
			local var_421_1 = 0.675

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:GetWordFromCfg(317252097)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 27 <= 0 and var_421_1 or var_421_1 * (utf8.len(var_421_3) / 27)

				if (27 <= 0 and var_421_1 or var_421_1 * (utf8.len(var_421_3) / 27)) > 0 and var_421_1 < var_421_5 then
					arg_418_1.talkMaxDuration = var_421_5

					if var_421_5 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252097", "story_v_out_317252.awb") ~= 0 then
					local var_421_6 = manager.audio:GetVoiceLength("story_v_out_317252", "317252097", "story_v_out_317252.awb") / 1000

					if var_421_6 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_0
					end

					if var_421_2.prefab_name ~= "" and arg_418_1.actors_[var_421_2.prefab_name] ~= nil then
						local var_421_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_2.prefab_name].transform, "story_v_out_317252", "317252097", "story_v_out_317252.awb")

						arg_418_1:RecordAudio("317252097", var_421_7)
						arg_418_1:RecordAudio("317252097", var_421_7)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_317252", "317252097", "story_v_out_317252.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_317252", "317252097", "story_v_out_317252.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_8 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_8 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_8

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_8 and arg_418_1.time_ < var_421_0 + var_421_8 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play317252098 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 317252098
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play317252099(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1158ui_story = arg_422_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_425_0 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 then
				arg_422_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_422_1.time_ - 0) / var_425_0)
				arg_422_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1158ui_story"].transform.position).z)
				arg_422_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1158ui_story"].transform.localEulerAngles = arg_422_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 then
				arg_422_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1158ui_story"].transform.position).z)
				arg_422_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1158ui_story"].transform.localEulerAngles = arg_422_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_425_1 = 0
			local var_425_2 = 0.525

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_3 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(317252098).content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 21 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_3) / 21)

				if (21 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_3) / 21)) > 0 and var_425_2 < var_425_5 then
					arg_422_1.talkMaxDuration = var_425_5

					if var_425_5 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + var_425_1
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_6 = math.max(var_425_2, arg_422_1.talkMaxDuration)

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_6 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_1) / var_425_6

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_1 + var_425_6 and arg_422_1.time_ < var_425_1 + var_425_6 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play317252099 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 317252099
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play317252100(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.875

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(317252099).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 35 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 35)

				if (35 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 35)) > 0 and var_429_0 < var_429_3 then
					arg_426_1.talkMaxDuration = var_429_3

					if var_429_3 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_3 + 0
					end
				end

				arg_426_1.text_.text = var_429_1
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_4 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_4

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play317252100 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 317252100
		arg_430_1.duration_ = 8.9

		local var_430_0 = {
			zh = 8.9,
			ja = 6.6
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play317252101(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0.9

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_1 = arg_430_1:GetWordFromCfg(317252100)
				local var_433_2 = arg_430_1:FormatText(var_433_1.content)

				arg_430_1.text_.text = var_433_2

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 36 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 36)

				if (36 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 36)) > 0 and var_433_0 < var_433_4 then
					arg_430_1.talkMaxDuration = var_433_4

					if var_433_4 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_4 + 0
					end
				end

				arg_430_1.text_.text = var_433_2
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252100", "story_v_out_317252.awb") ~= 0 then
					local var_433_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252100", "story_v_out_317252.awb") / 1000

					if var_433_5 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_5 + 0
					end

					if var_433_1.prefab_name ~= "" and arg_430_1.actors_[var_433_1.prefab_name] ~= nil then
						local var_433_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_1.prefab_name].transform, "story_v_out_317252", "317252100", "story_v_out_317252.awb")

						arg_430_1:RecordAudio("317252100", var_433_6)
						arg_430_1:RecordAudio("317252100", var_433_6)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_317252", "317252100", "story_v_out_317252.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_317252", "317252100", "story_v_out_317252.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play317252101 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 317252101
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play317252102(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.175

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(317252101).content)

				arg_434_1.text_.text = var_437_1

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_3 = 7 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 7)

				if (7 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 7)) > 0 and var_437_0 < var_437_3 then
					arg_434_1.talkMaxDuration = var_437_3

					if var_437_3 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_3 + 0
					end
				end

				arg_434_1.text_.text = var_437_1
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_4 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_4

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play317252102 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 317252102
		arg_438_1.duration_ = 2.17

		local var_438_0 = {
			zh = 1.566,
			ja = 2.166
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play317252103(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.075

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:GetWordFromCfg(317252102)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 3 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 3)

				if (3 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 3)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252102", "story_v_out_317252.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252102", "story_v_out_317252.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_out_317252", "317252102", "story_v_out_317252.awb")

						arg_438_1:RecordAudio("317252102", var_441_6)
						arg_438_1:RecordAudio("317252102", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_317252", "317252102", "story_v_out_317252.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_317252", "317252102", "story_v_out_317252.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_7 and arg_438_1.time_ < 0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play317252103 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 317252103
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play317252104(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.6

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_1 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(317252103).content)

				arg_442_1.text_.text = var_445_1

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_3 = 24 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_1) / 24)

				if (24 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_1) / 24)) > 0 and var_445_0 < var_445_3 then
					arg_442_1.talkMaxDuration = var_445_3

					if var_445_3 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_3 + 0
					end
				end

				arg_442_1.text_.text = var_445_1
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_4 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_4 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_4

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_4 and arg_442_1.time_ < 0 + var_445_4 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play317252104 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 317252104
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play317252105(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.875

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_1 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(317252104).content)

				arg_446_1.text_.text = var_449_1

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_3 = 35 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 35)

				if (35 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 35)) > 0 and var_449_0 < var_449_3 then
					arg_446_1.talkMaxDuration = var_449_3

					if var_449_3 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_3 + 0
					end
				end

				arg_446_1.text_.text = var_449_1
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_4 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_4 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_4

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_4 and arg_446_1.time_ < 0 + var_449_4 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play317252105 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 317252105
		arg_450_1.duration_ = 11.07

		local var_450_0 = {
			zh = 11.066,
			ja = 10.933
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
			arg_450_1.auto_ = false
		end

		function arg_450_1.playNext_(arg_452_0)
			arg_450_1.onStoryFinished_()
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 1.175

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:GetWordFromCfg(317252105)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 47 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 47)

				if (47 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 47)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317252", "317252105", "story_v_out_317252.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_out_317252", "317252105", "story_v_out_317252.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_out_317252", "317252105", "story_v_out_317252.awb")

						arg_450_1:RecordAudio("317252105", var_453_6)
						arg_450_1:RecordAudio("317252105", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_317252", "317252105", "story_v_out_317252.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_317252", "317252105", "story_v_out_317252.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST58",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/YA0204",
		"TextureConfig/Background/K12f",
		"TextureConfig/Background/K11f"
	},
	voices = {
		"story_v_out_317252.awb"
	}
}
