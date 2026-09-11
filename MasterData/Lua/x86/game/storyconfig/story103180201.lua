return {
	Play318021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K10g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K10g")
				var_4_0.name = "K10g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K10g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K10g

				arg_1_1.bgs_.K10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K10g" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(318021001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 53 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 53)

				if (53 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 53)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318021002
		arg_9_1.duration_ = 4.17

		local var_9_0 = {
			zh = 3.533,
			ja = 4.166
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
				arg_9_0:Play318021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1049ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1049ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1049ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1049ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1049ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1049ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1049ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.2, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1049ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1049ui_story == nil then
				arg_9_1.var_.characterEffect1049ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1049ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1049ui_story then
				arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.4

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(318021002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 16 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 16)

				if (16 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 16)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021002", "story_v_out_318021.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021002", "story_v_out_318021.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_318021", "318021002", "story_v_out_318021.awb")

						arg_9_1:RecordAudio("318021002", var_12_15)
						arg_9_1:RecordAudio("318021002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318021", "318021002", "story_v_out_318021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318021", "318021002", "story_v_out_318021.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play318021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318021003
		arg_13_1.duration_ = 5.87

		local var_13_0 = {
			zh = 5.866,
			ja = 4.466
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
				arg_13_0:Play318021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10053ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10053ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10053ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10053ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10053ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10053ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -1.12, -5.99)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10053ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10053ui_story == nil then
				arg_13_1.var_.characterEffect10053ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10053ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10053ui_story then
				arg_13_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = arg_13_1.actors_["1049ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1049ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(-0.7, -1.2, -6)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = arg_13_1.actors_["1049ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1049ui_story == nil then
				arg_13_1.var_.characterEffect1049ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect1049ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1049ui_story then
				arg_13_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_16_12 = 0
			local var_16_13 = 0.65

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(318021003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 26 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 26)

				if (26 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 26)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021003", "story_v_out_318021.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_318021", "318021003", "story_v_out_318021.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_318021", "318021003", "story_v_out_318021.awb")

						arg_13_1:RecordAudio("318021003", var_16_19)
						arg_13_1:RecordAudio("318021003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318021", "318021003", "story_v_out_318021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318021", "318021003", "story_v_out_318021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_20 and arg_13_1.time_ < var_16_12 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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

		arg_13_1:InitPlayNodeList()
	end,
	Play318021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318021004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10053ui_story"]) and arg_17_1.var_.characterEffect10053ui_story == nil then
				arg_17_1.var_.characterEffect10053ui_story = arg_17_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10053ui_story"]) then
				if arg_17_1.var_.characterEffect10053ui_story and not isNil(arg_17_1.actors_["10053ui_story"]) then
					arg_17_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10053ui_story"]) and arg_17_1.var_.characterEffect10053ui_story then
				arg_17_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.675

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(318021004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 27 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 27)

				if (27 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 27)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play318021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318021005
		arg_21_1.duration_ = 10.23

		local var_21_0 = {
			zh = 6.733,
			ja = 10.233
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
				arg_21_0:Play318021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10053ui_story"]) and arg_21_1.var_.characterEffect10053ui_story == nil then
				arg_21_1.var_.characterEffect10053ui_story = arg_21_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10053ui_story"]) then
				if arg_21_1.var_.characterEffect10053ui_story and not isNil(arg_21_1.actors_["10053ui_story"]) then
					arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10053ui_story"]) and arg_21_1.var_.characterEffect10053ui_story then
				arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 0.7

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(318021005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 28 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 28)

				if (28 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 28)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021005", "story_v_out_318021.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_318021", "318021005", "story_v_out_318021.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_318021", "318021005", "story_v_out_318021.awb")

						arg_21_1:RecordAudio("318021005", var_24_9)
						arg_21_1:RecordAudio("318021005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318021", "318021005", "story_v_out_318021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318021", "318021005", "story_v_out_318021.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play318021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318021006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10053ui_story"]) and arg_25_1.var_.characterEffect10053ui_story == nil then
				arg_25_1.var_.characterEffect10053ui_story = arg_25_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10053ui_story"]) then
				if arg_25_1.var_.characterEffect10053ui_story and not isNil(arg_25_1.actors_["10053ui_story"]) then
					arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10053ui_story"]) and arg_25_1.var_.characterEffect10053ui_story then
				arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.125

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(318021006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 5 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 5)

				if (5 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 5)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318021007
		arg_29_1.duration_ = 9.13

		local var_29_0 = {
			zh = 5.9,
			ja = 9.133
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
				arg_29_0:Play318021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10053ui_story"]) and arg_29_1.var_.characterEffect10053ui_story == nil then
				arg_29_1.var_.characterEffect10053ui_story = arg_29_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10053ui_story"]) then
				if arg_29_1.var_.characterEffect10053ui_story and not isNil(arg_29_1.actors_["10053ui_story"]) then
					arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10053ui_story"]) and arg_29_1.var_.characterEffect10053ui_story then
				arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action4415")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_2 = 0
			local var_32_3 = 0.625

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(318021007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 25 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 25)

				if (25 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 25)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021007", "story_v_out_318021.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_318021", "318021007", "story_v_out_318021.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_318021", "318021007", "story_v_out_318021.awb")

						arg_29_1:RecordAudio("318021007", var_32_9)
						arg_29_1:RecordAudio("318021007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318021", "318021007", "story_v_out_318021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318021", "318021007", "story_v_out_318021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318021008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play318021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10053ui_story"]) and arg_33_1.var_.characterEffect10053ui_story == nil then
				arg_33_1.var_.characterEffect10053ui_story = arg_33_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10053ui_story"]) then
				if arg_33_1.var_.characterEffect10053ui_story and not isNil(arg_33_1.actors_["10053ui_story"]) then
					arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10053ui_story"]) and arg_33_1.var_.characterEffect10053ui_story then
				arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(318021008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 5 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 5)

				if (5 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 5)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play318021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318021009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(318021009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 45 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 45)

				if (45 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 45)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play318021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318021010
		arg_41_1.duration_ = 7.07

		local var_41_0 = {
			zh = 7.066,
			ja = 5.3
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
				arg_41_0:Play318021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1049ui_story"]) and arg_41_1.var_.characterEffect1049ui_story == nil then
				arg_41_1.var_.characterEffect1049ui_story = arg_41_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1049ui_story"]) then
				if arg_41_1.var_.characterEffect1049ui_story and not isNil(arg_41_1.actors_["1049ui_story"]) then
					arg_41_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1049ui_story"]) and arg_41_1.var_.characterEffect1049ui_story then
				arg_41_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_2")
			end

			local var_44_2 = 0
			local var_44_3 = 0.8

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
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

				local var_44_4 = arg_41_1:GetWordFromCfg(318021010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 32 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 32)

				if (32 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 32)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021010", "story_v_out_318021.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_318021", "318021010", "story_v_out_318021.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_318021", "318021010", "story_v_out_318021.awb")

						arg_41_1:RecordAudio("318021010", var_44_9)
						arg_41_1:RecordAudio("318021010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_318021", "318021010", "story_v_out_318021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_318021", "318021010", "story_v_out_318021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318021011
		arg_45_1.duration_ = 10.2

		local var_45_0 = {
			zh = 10.2,
			ja = 9.966
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
				arg_45_0:Play318021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.85

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(318021011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 34 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 34)

				if (34 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 34)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021011", "story_v_out_318021.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_318021", "318021011", "story_v_out_318021.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_318021", "318021011", "story_v_out_318021.awb")

						arg_45_1:RecordAudio("318021011", var_48_6)
						arg_45_1:RecordAudio("318021011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_318021", "318021011", "story_v_out_318021.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_318021", "318021011", "story_v_out_318021.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318021012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play318021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10053ui_story"]) and arg_49_1.var_.characterEffect10053ui_story == nil then
				arg_49_1.var_.characterEffect10053ui_story = arg_49_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10053ui_story"]) then
				if arg_49_1.var_.characterEffect10053ui_story and not isNil(arg_49_1.actors_["10053ui_story"]) then
					arg_49_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10053ui_story"]) and arg_49_1.var_.characterEffect10053ui_story then
				arg_49_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action41534")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_2 = arg_49_1.actors_["1049ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1049ui_story == nil then
				arg_49_1.var_.characterEffect1049ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1049ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1049ui_story then
				arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 0.075

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(318021012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 3 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 3)

				if (3 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 3)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021012", "story_v_out_318021.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_318021", "318021012", "story_v_out_318021.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_318021", "318021012", "story_v_out_318021.awb")

						arg_49_1:RecordAudio("318021012", var_52_11)
						arg_49_1:RecordAudio("318021012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318021", "318021012", "story_v_out_318021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318021", "318021012", "story_v_out_318021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play318021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318021013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play318021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10053ui_story"]) and arg_53_1.var_.characterEffect10053ui_story == nil then
				arg_53_1.var_.characterEffect10053ui_story = arg_53_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10053ui_story"]) then
				if arg_53_1.var_.characterEffect10053ui_story and not isNil(arg_53_1.actors_["10053ui_story"]) then
					arg_53_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10053ui_story"]) and arg_53_1.var_.characterEffect10053ui_story then
				arg_53_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_56_2 = arg_53_1.actors_["1049ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1049ui_story = var_56_2.localPosition
			end

			local var_56_3 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_3)
				var_56_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_2.position).x, (manager.ui.mainCamera.transform.position - var_56_2.position).y, (manager.ui.mainCamera.transform.position - var_56_2.position).z)
				var_56_2.localEulerAngles.z = 0
				var_56_2.localEulerAngles.x = 0
				var_56_2.localEulerAngles = var_56_2.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, 100, 0)
				var_56_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_2.position).x, (manager.ui.mainCamera.transform.position - var_56_2.position).y, (manager.ui.mainCamera.transform.position - var_56_2.position).z)
				var_56_2.localEulerAngles.z = 0
				var_56_2.localEulerAngles.x = 0
				var_56_2.localEulerAngles = var_56_2.localEulerAngles
			end

			local var_56_4 = arg_53_1.actors_["10053ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10053ui_story = var_56_4.localPosition
			end

			local var_56_5 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 then
				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_5)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(0, 100, 0)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			local var_56_6 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_7 = 1

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 then
				local var_56_8 = Color.New(1, 1, 1)

				var_56_8.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_6) / var_56_7)
				arg_53_1.mask_.color = var_56_8
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				local var_56_9 = Color.New(1, 1, 1)

				arg_53_1.mask_.enabled = false
				var_56_9.a = 0
				arg_53_1.mask_.color = var_56_9
			end

			local var_56_10 = manager.ui.mainCamera.transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_10.localPosition
			end

			local var_56_11 = 1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_11 then
				local var_56_12, var_56_13 = math.modf((arg_53_1.time_ - 0) / 0.066)

				var_56_10.localPosition = Vector3.New(var_56_13 * 0.13, var_56_13 * 0.13, var_56_13 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0 + var_56_11 and arg_53_1.time_ < 0 + var_56_11 + arg_56_0 then
				var_56_10.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_14 = 0
			local var_56_15 = 1.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_16 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(318021013).content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_18 = 47 <= 0 and var_56_15 or var_56_15 * (utf8.len(var_56_16) / 47)

				if (47 <= 0 and var_56_15 or var_56_15 * (utf8.len(var_56_16) / 47)) > 0 and var_56_15 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_14 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_14
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_19 = math.max(var_56_15, arg_53_1.talkMaxDuration)

			if var_56_14 <= arg_53_1.time_ and arg_53_1.time_ < var_56_14 + var_56_19 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_14) / var_56_19

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_14 + var_56_19 and arg_53_1.time_ < var_56_14 + var_56_19 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play318021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318021014
		arg_57_1.duration_ = 9

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play318021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.bgs_.K11g == nil then
				local var_60_0 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11g")
				var_60_0.name = "K11g"
				var_60_0.transform.parent = arg_57_1.stage_.transform
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_.K11g = var_60_0
			end

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 then
				local var_60_1 = arg_57_1.bgs_.K11g

				arg_57_1.bgs_.K11g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_2 = var_60_1:GetComponent("SpriteRenderer")

				if var_60_2 and var_60_2.sprite then
					local var_60_3 = 2 * (var_60_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_1.transform.localScale = Vector3.New(var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "K11g" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_4 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_5 = 2

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_5 then
				local var_60_6 = Color.New(0, 0, 0)

				var_60_6.a = Mathf.Lerp(0, 1, (arg_57_1.time_ - var_60_4) / var_60_5)
				arg_57_1.mask_.color = var_60_6
			end

			if arg_57_1.time_ >= var_60_4 + var_60_5 and arg_57_1.time_ < var_60_4 + var_60_5 + arg_60_0 then
				local var_60_7 = Color.New(0, 0, 0)

				var_60_7.a = 1
				arg_57_1.mask_.color = var_60_7
			end

			local var_60_8 = 2

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_9 = 2

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 then
				local var_60_10 = Color.New(0, 0, 0)

				var_60_10.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_8) / var_60_9)
				arg_57_1.mask_.color = var_60_10
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 then
				local var_60_11 = Color.New(0, 0, 0)

				arg_57_1.mask_.enabled = false
				var_60_11.a = 0
				arg_57_1.mask_.color = var_60_11
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_blast_loop", "")
			end

			local var_60_13 = arg_57_1.actors_["1049ui_story"].transform

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 then
				arg_57_1.var_.moveOldPos1049ui_story = var_60_13.localPosition
			end

			local var_60_14 = 0.001

			if 2 <= arg_57_1.time_ and arg_57_1.time_ < 2 + var_60_14 then
				var_60_13.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 2) / var_60_14)
				var_60_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_13.position).x, (manager.ui.mainCamera.transform.position - var_60_13.position).y, (manager.ui.mainCamera.transform.position - var_60_13.position).z)
				var_60_13.localEulerAngles.z = 0
				var_60_13.localEulerAngles.x = 0
				var_60_13.localEulerAngles = var_60_13.localEulerAngles
			end

			if arg_57_1.time_ >= 2 + var_60_14 and arg_57_1.time_ < 2 + var_60_14 + arg_60_0 then
				var_60_13.localPosition = Vector3.New(0, 100, 0)
				var_60_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_13.position).x, (manager.ui.mainCamera.transform.position - var_60_13.position).y, (manager.ui.mainCamera.transform.position - var_60_13.position).z)
				var_60_13.localEulerAngles.z = 0
				var_60_13.localEulerAngles.x = 0
				var_60_13.localEulerAngles = var_60_13.localEulerAngles
			end

			local var_60_15 = arg_57_1.actors_["10053ui_story"].transform

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 then
				arg_57_1.var_.moveOldPos10053ui_story = var_60_15.localPosition
			end

			local var_60_16 = 0.001

			if 2 <= arg_57_1.time_ and arg_57_1.time_ < 2 + var_60_16 then
				var_60_15.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 2) / var_60_16)
				var_60_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_15.position).x, (manager.ui.mainCamera.transform.position - var_60_15.position).y, (manager.ui.mainCamera.transform.position - var_60_15.position).z)
				var_60_15.localEulerAngles.z = 0
				var_60_15.localEulerAngles.x = 0
				var_60_15.localEulerAngles = var_60_15.localEulerAngles
			end

			if arg_57_1.time_ >= 2 + var_60_16 and arg_57_1.time_ < 2 + var_60_16 + arg_60_0 then
				var_60_15.localPosition = Vector3.New(0, 100, 0)
				var_60_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_15.position).x, (manager.ui.mainCamera.transform.position - var_60_15.position).y, (manager.ui.mainCamera.transform.position - var_60_15.position).z)
				var_60_15.localEulerAngles.z = 0
				var_60_15.localEulerAngles.x = 0
				var_60_15.localEulerAngles = var_60_15.localEulerAngles
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_17 = 4
			local var_60_18 = 0.1

			if 4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_19 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_19:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_20 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(318021014).content)

				arg_57_1.text_.text = var_60_20

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_22 = 4 <= 0 and var_60_18 or var_60_18 * (utf8.len(var_60_20) / 4)

				if (4 <= 0 and var_60_18 or var_60_18 * (utf8.len(var_60_20) / 4)) > 0 and var_60_18 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22
					var_60_17 = var_60_17 + 0.3

					if var_60_22 + var_60_17 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_17
					end
				end

				arg_57_1.text_.text = var_60_20
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_23 = var_60_17 + 0.3
			local var_60_24 = math.max(var_60_18, arg_57_1.talkMaxDuration)

			if var_60_17 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_23) / var_60_24

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 then
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
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play318021015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 318021015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play318021016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(318021015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 59 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 59)

				if (59 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 59)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play318021016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 318021016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play318021017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.875

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(318021016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 35 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 35)

				if (35 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 35)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play318021017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 318021017
		arg_71_1.duration_ = 4.57

		local var_71_0 = {
			zh = 2.733,
			ja = 4.566
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play318021018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_74_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_71_1.stage_.transform)

				var_74_0.name = "1015ui_story"
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1015ui_story"] = var_74_0

				local var_74_1 = var_74_0:GetComponentInChildren(typeof(CharacterEffect))

				var_74_1.enabled = true

				local var_74_2 = GameObjectTools.GetOrAddComponent(var_74_0, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(false)
				end

				arg_71_1:ShowWeapon(var_74_1.transform, false)

				arg_71_1.var_["1015ui_story" .. "Animator"] = var_74_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_71_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_71_1.var_["1015ui_story" .. "LipSync"] = var_74_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_74_3 = arg_71_1.actors_["1015ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1015ui_story = var_74_3.localPosition
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_3.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_71_1.time_ - 0) / var_74_4)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			local var_74_5 = arg_71_1.actors_["1015ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1015ui_story == nil then
				arg_71_1.var_.characterEffect1015ui_story = var_74_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.characterEffect1015ui_story and not isNil(var_74_5) then
					arg_71_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1015ui_story then
				arg_71_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_74_8 = 0
			local var_74_9 = 0.375

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:GetWordFromCfg(318021017)
				local var_74_11 = arg_71_1:FormatText(var_74_10.content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 15 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 15)

				if (15 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 15)) > 0 and var_74_9 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021017", "story_v_out_318021.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021017", "story_v_out_318021.awb") / 1000

					if var_74_14 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_8
					end

					if var_74_10.prefab_name ~= "" and arg_71_1.actors_[var_74_10.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_10.prefab_name].transform, "story_v_out_318021", "318021017", "story_v_out_318021.awb")

						arg_71_1:RecordAudio("318021017", var_74_15)
						arg_71_1:RecordAudio("318021017", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_318021", "318021017", "story_v_out_318021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_318021", "318021017", "story_v_out_318021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_16 and arg_71_1.time_ < var_74_8 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play318021018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 318021018
		arg_75_1.duration_ = 4

		local var_75_0 = {
			zh = 2.9,
			ja = 4
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play318021019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "1093ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1093ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["1093ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["1093ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_78_3 = arg_75_1.actors_["1015ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1015ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_75_1.time_ - 0) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			local var_78_5 = arg_75_1.actors_["1015ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect1015ui_story == nil then
				arg_75_1.var_.characterEffect1015ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.characterEffect1015ui_story and not isNil(var_78_5) then
					arg_75_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_6)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect1015ui_story then
				arg_75_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_78_7 = 0
			local var_78_8 = 0.4

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(318021018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_12 = 16 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 16)

				if (16 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 16)) > 0 and var_78_8 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_7
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021018", "story_v_out_318021.awb") ~= 0 then
					local var_78_13 = manager.audio:GetVoiceLength("story_v_out_318021", "318021018", "story_v_out_318021.awb") / 1000

					if var_78_13 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_7
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_318021", "318021018", "story_v_out_318021.awb")

						arg_75_1:RecordAudio("318021018", var_78_14)
						arg_75_1:RecordAudio("318021018", var_78_14)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_318021", "318021018", "story_v_out_318021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_318021", "318021018", "story_v_out_318021.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_15 = math.max(var_78_8, arg_75_1.talkMaxDuration)

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_15 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_7) / var_78_15

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_7 + var_78_15 and arg_75_1.time_ < var_78_7 + var_78_15 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play318021019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 318021019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play318021020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.025

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(318021019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 41 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 41)

				if (41 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 41)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play318021020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 318021020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play318021021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.5

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(318021020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 60 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 60)

				if (60 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 60)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play318021021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 318021021
		arg_87_1.duration_ = 3.4

		local var_87_0 = {
			zh = 2.466,
			ja = 3.4
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play318021022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1015ui_story"]) and arg_87_1.var_.characterEffect1015ui_story == nil then
				arg_87_1.var_.characterEffect1015ui_story = arg_87_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1015ui_story"]) then
				if arg_87_1.var_.characterEffect1015ui_story and not isNil(arg_87_1.actors_["1015ui_story"]) then
					arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1015ui_story"]) and arg_87_1.var_.characterEffect1015ui_story then
				arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_90_2 = 0
			local var_90_3 = 0.35

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(318021021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 14 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 14)

				if (14 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 14)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021021", "story_v_out_318021.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_318021", "318021021", "story_v_out_318021.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_318021", "318021021", "story_v_out_318021.awb")

						arg_87_1:RecordAudio("318021021", var_90_9)
						arg_87_1:RecordAudio("318021021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_318021", "318021021", "story_v_out_318021.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_318021", "318021021", "story_v_out_318021.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play318021022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 318021022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play318021023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1015ui_story"]) and arg_91_1.var_.characterEffect1015ui_story == nil then
				arg_91_1.var_.characterEffect1015ui_story = arg_91_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1015ui_story"]) then
				if arg_91_1.var_.characterEffect1015ui_story and not isNil(arg_91_1.actors_["1015ui_story"]) then
					arg_91_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1015ui_story"]) and arg_91_1.var_.characterEffect1015ui_story then
				arg_91_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.525

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(318021022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 21 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 21)

				if (21 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 21)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play318021023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 318021023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play318021024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1015ui_story = arg_95_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).z)
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles = arg_95_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).z)
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles = arg_95_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_98_1 = 0
			local var_98_2 = 1.25

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(318021023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 50 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 50)

				if (50 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 50)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play318021024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 318021024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play318021025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_102_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_99_1.stage_.transform)

				var_102_0.name = "1199ui_story"
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1199ui_story"] = var_102_0

				local var_102_1 = var_102_0:GetComponentInChildren(typeof(CharacterEffect))

				var_102_1.enabled = true

				local var_102_2 = GameObjectTools.GetOrAddComponent(var_102_0, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_1.transform, false)

				arg_99_1.var_["1199ui_story" .. "Animator"] = var_102_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_99_1.var_["1199ui_story" .. "LipSync"] = var_102_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_3 = arg_99_1.actors_["1199ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1199ui_story = var_102_3.localPosition
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_3.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_99_1.time_ - 0) / var_102_4)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			local var_102_5 = arg_99_1.actors_["1199ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect1199ui_story == nil then
				arg_99_1.var_.characterEffect1199ui_story = var_102_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 and not isNil(var_102_5) then
				if arg_99_1.var_.characterEffect1199ui_story and not isNil(var_102_5) then
					arg_99_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect1199ui_story then
				arg_99_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action5_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_102_8 = 0
			local var_102_9 = 0.15

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_10 = arg_99_1:GetWordFromCfg(318021024)
				local var_102_11 = arg_99_1:FormatText(var_102_10.content)

				arg_99_1.text_.text = var_102_11

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 6 <= 0 and var_102_9 or var_102_9 * (utf8.len(var_102_11) / 6)

				if (6 <= 0 and var_102_9 or var_102_9 * (utf8.len(var_102_11) / 6)) > 0 and var_102_9 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_8
					end
				end

				arg_99_1.text_.text = var_102_11
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021024", "story_v_out_318021.awb") ~= 0 then
					local var_102_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021024", "story_v_out_318021.awb") / 1000

					if var_102_14 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_8
					end

					if var_102_10.prefab_name ~= "" and arg_99_1.actors_[var_102_10.prefab_name] ~= nil then
						local var_102_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_10.prefab_name].transform, "story_v_out_318021", "318021024", "story_v_out_318021.awb")

						arg_99_1:RecordAudio("318021024", var_102_15)
						arg_99_1:RecordAudio("318021024", var_102_15)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_318021", "318021024", "story_v_out_318021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_318021", "318021024", "story_v_out_318021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_9, arg_99_1.talkMaxDuration)

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_8) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_8 + var_102_16 and arg_99_1.time_ < var_102_8 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play318021025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 318021025
		arg_103_1.duration_ = 3.1

		local var_103_0 = {
			zh = 2.666,
			ja = 3.1
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play318021026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1093ui_story = arg_103_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1093ui_story"].transform.position).z)
				arg_103_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1093ui_story"].transform.localEulerAngles = arg_103_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_103_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1093ui_story"].transform.position).z)
				arg_103_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1093ui_story"].transform.localEulerAngles = arg_103_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1093ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1093ui_story == nil then
				arg_103_1.var_.characterEffect1093ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1093ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1093ui_story then
				arg_103_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_106_4 = arg_103_1.actors_["1199ui_story"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1199ui_story = var_106_4.localPosition
			end

			local var_106_5 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_5 then
				var_106_4.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_103_1.time_ - 0) / var_106_5)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_5 and arg_103_1.time_ < 0 + var_106_5 + arg_106_0 then
				var_106_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			local var_106_6 = arg_103_1.actors_["1199ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1199ui_story == nil then
				arg_103_1.var_.characterEffect1199ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 and not isNil(var_106_6) then
				if arg_103_1.var_.characterEffect1199ui_story and not isNil(var_106_6) then
					arg_103_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_7)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1199ui_story then
				arg_103_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_106_8 = 0
			local var_106_9 = 0.2

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(318021025)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 8 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 8)

				if (8 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 8)) > 0 and var_106_9 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021025", "story_v_out_318021.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021025", "story_v_out_318021.awb") / 1000

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_318021", "318021025", "story_v_out_318021.awb")

						arg_103_1:RecordAudio("318021025", var_106_15)
						arg_103_1:RecordAudio("318021025", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_318021", "318021025", "story_v_out_318021.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_318021", "318021025", "story_v_out_318021.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_16 and arg_103_1.time_ < var_106_8 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play318021026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 318021026
		arg_107_1.duration_ = 12.77

		local var_107_0 = {
			zh = 12.766,
			ja = 9.066
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play318021027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1093ui_story"]) and arg_107_1.var_.characterEffect1093ui_story == nil then
				arg_107_1.var_.characterEffect1093ui_story = arg_107_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1093ui_story"]) then
				if arg_107_1.var_.characterEffect1093ui_story and not isNil(arg_107_1.actors_["1093ui_story"]) then
					arg_107_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1093ui_story"]) and arg_107_1.var_.characterEffect1093ui_story then
				arg_107_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_110_2 = 0
			local var_110_3 = 1.075

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(318021026)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 43 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 43)

				if (43 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 43)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021026", "story_v_out_318021.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_318021", "318021026", "story_v_out_318021.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_318021", "318021026", "story_v_out_318021.awb")

						arg_107_1:RecordAudio("318021026", var_110_9)
						arg_107_1:RecordAudio("318021026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_318021", "318021026", "story_v_out_318021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_318021", "318021026", "story_v_out_318021.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_10 and arg_107_1.time_ < var_110_2 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play318021027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 318021027
		arg_111_1.duration_ = 8.3

		local var_111_0 = {
			zh = 4.7,
			ja = 8.3
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play318021028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1015ui_story = arg_111_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1015ui_story"].transform.position).z)
				arg_111_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1015ui_story"].transform.localEulerAngles = arg_111_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_111_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1015ui_story"].transform.position).z)
				arg_111_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1015ui_story"].transform.localEulerAngles = arg_111_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["1015ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1015ui_story == nil then
				arg_111_1.var_.characterEffect1015ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect1015ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1015ui_story then
				arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_114_4 = arg_111_1.actors_["1093ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1093ui_story = var_114_4.localPosition
			end

			local var_114_5 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 then
				var_114_4.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_5)
				var_114_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_4.position).x, (manager.ui.mainCamera.transform.position - var_114_4.position).y, (manager.ui.mainCamera.transform.position - var_114_4.position).z)
				var_114_4.localEulerAngles.z = 0
				var_114_4.localEulerAngles.x = 0
				var_114_4.localEulerAngles = var_114_4.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 then
				var_114_4.localPosition = Vector3.New(0, 100, 0)
				var_114_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_4.position).x, (manager.ui.mainCamera.transform.position - var_114_4.position).y, (manager.ui.mainCamera.transform.position - var_114_4.position).z)
				var_114_4.localEulerAngles.z = 0
				var_114_4.localEulerAngles.x = 0
				var_114_4.localEulerAngles = var_114_4.localEulerAngles
			end

			local var_114_6 = arg_111_1.actors_["1093ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_6) and arg_111_1.var_.characterEffect1093ui_story == nil then
				arg_111_1.var_.characterEffect1093ui_story = var_114_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_7 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 and not isNil(var_114_6) then
				if arg_111_1.var_.characterEffect1093ui_story and not isNil(var_114_6) then
					arg_111_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_7)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 and not isNil(var_114_6) and arg_111_1.var_.characterEffect1093ui_story then
				arg_111_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_114_8 = arg_111_1.actors_["1199ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1199ui_story = var_114_8.localPosition
			end

			local var_114_9 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 then
				var_114_8.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_9)
				var_114_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_8.position).x, (manager.ui.mainCamera.transform.position - var_114_8.position).y, (manager.ui.mainCamera.transform.position - var_114_8.position).z)
				var_114_8.localEulerAngles.z = 0
				var_114_8.localEulerAngles.x = 0
				var_114_8.localEulerAngles = var_114_8.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 then
				var_114_8.localPosition = Vector3.New(0, 100, 0)
				var_114_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_8.position).x, (manager.ui.mainCamera.transform.position - var_114_8.position).y, (manager.ui.mainCamera.transform.position - var_114_8.position).z)
				var_114_8.localEulerAngles.z = 0
				var_114_8.localEulerAngles.x = 0
				var_114_8.localEulerAngles = var_114_8.localEulerAngles
			end

			local var_114_10 = 0
			local var_114_11 = 0.775

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_12 = arg_111_1:GetWordFromCfg(318021027)
				local var_114_13 = arg_111_1:FormatText(var_114_12.content)

				arg_111_1.text_.text = var_114_13

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 31 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 31)

				if (31 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 31)) > 0 and var_114_11 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_10
					end
				end

				arg_111_1.text_.text = var_114_13
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021027", "story_v_out_318021.awb") ~= 0 then
					local var_114_16 = manager.audio:GetVoiceLength("story_v_out_318021", "318021027", "story_v_out_318021.awb") / 1000

					if var_114_16 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_10
					end

					if var_114_12.prefab_name ~= "" and arg_111_1.actors_[var_114_12.prefab_name] ~= nil then
						local var_114_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_12.prefab_name].transform, "story_v_out_318021", "318021027", "story_v_out_318021.awb")

						arg_111_1:RecordAudio("318021027", var_114_17)
						arg_111_1:RecordAudio("318021027", var_114_17)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_318021", "318021027", "story_v_out_318021.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_318021", "318021027", "story_v_out_318021.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_18 = math.max(var_114_11, arg_111_1.talkMaxDuration)

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_18 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_10) / var_114_18

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_10 + var_114_18 and arg_111_1.time_ < var_114_10 + var_114_18 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play318021028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 318021028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play318021029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1015ui_story"]) and arg_115_1.var_.characterEffect1015ui_story == nil then
				arg_115_1.var_.characterEffect1015ui_story = arg_115_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1015ui_story"]) then
				if arg_115_1.var_.characterEffect1015ui_story and not isNil(arg_115_1.actors_["1015ui_story"]) then
					arg_115_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1015ui_story"]) and arg_115_1.var_.characterEffect1015ui_story then
				arg_115_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_118_1 = 0
			local var_118_2 = 0.6

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(318021028).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 24 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 24)

				if (24 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 24)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_6 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_6 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_6

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_6 and arg_115_1.time_ < var_118_1 + var_118_6 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play318021029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 318021029
		arg_119_1.duration_ = 7.23

		local var_119_0 = {
			zh = 6.2,
			ja = 7.233
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play318021030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				local var_122_0 = arg_119_1.bgs_.K10g

				arg_119_1.bgs_.K10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_1 = var_122_0:GetComponent("SpriteRenderer")

				if var_122_1 and var_122_1.sprite then
					local var_122_2 = 2 * (var_122_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_0.transform.localScale = Vector3.New(var_122_2 / var_122_1.sprite.bounds.size.y < var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x and var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x or var_122_2 / var_122_1.sprite.bounds.size.y, var_122_2 / var_122_1.sprite.bounds.size.y < var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x and var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x or var_122_2 / var_122_1.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "K10g" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_3 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_4 = 2

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_4 then
				local var_122_5 = Color.New(0, 0, 0)

				var_122_5.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - var_122_3) / var_122_4)
				arg_119_1.mask_.color = var_122_5
			end

			if arg_119_1.time_ >= var_122_3 + var_122_4 and arg_119_1.time_ < var_122_3 + var_122_4 + arg_122_0 then
				local var_122_6 = Color.New(0, 0, 0)

				var_122_6.a = 1
				arg_119_1.mask_.color = var_122_6
			end

			local var_122_7 = 2

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_8 = 2

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 then
				local var_122_9 = Color.New(0, 0, 0)

				var_122_9.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_7) / var_122_8)
				arg_119_1.mask_.color = var_122_9
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 then
				local var_122_10 = Color.New(0, 0, 0)

				arg_119_1.mask_.enabled = false
				var_122_10.a = 0
				arg_119_1.mask_.color = var_122_10
			end

			local var_122_11 = arg_119_1.actors_["1049ui_story"].transform

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= 4 + arg_122_0 then
				arg_119_1.var_.moveOldPos1049ui_story = var_122_11.localPosition
			end

			local var_122_12 = 0.001

			if 4 <= arg_119_1.time_ and arg_119_1.time_ < 4 + var_122_12 then
				var_122_11.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_119_1.time_ - 4) / var_122_12)
				var_122_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_11.position).x, (manager.ui.mainCamera.transform.position - var_122_11.position).y, (manager.ui.mainCamera.transform.position - var_122_11.position).z)
				var_122_11.localEulerAngles.z = 0
				var_122_11.localEulerAngles.x = 0
				var_122_11.localEulerAngles = var_122_11.localEulerAngles
			end

			if arg_119_1.time_ >= 4 + var_122_12 and arg_119_1.time_ < 4 + var_122_12 + arg_122_0 then
				var_122_11.localPosition = Vector3.New(0, -1.2, -6)
				var_122_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_11.position).x, (manager.ui.mainCamera.transform.position - var_122_11.position).y, (manager.ui.mainCamera.transform.position - var_122_11.position).z)
				var_122_11.localEulerAngles.z = 0
				var_122_11.localEulerAngles.x = 0
				var_122_11.localEulerAngles = var_122_11.localEulerAngles
			end

			local var_122_13 = arg_119_1.actors_["1049ui_story"]

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= 4 + arg_122_0 and not isNil(var_122_13) and arg_119_1.var_.characterEffect1049ui_story == nil then
				arg_119_1.var_.characterEffect1049ui_story = var_122_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_14 = 0.200000002980232

			if 4 <= arg_119_1.time_ and arg_119_1.time_ < 4 + var_122_14 and not isNil(var_122_13) then
				if arg_119_1.var_.characterEffect1049ui_story and not isNil(var_122_13) then
					arg_119_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 4 + var_122_14 and arg_119_1.time_ < 4 + var_122_14 + arg_122_0 and not isNil(var_122_13) and arg_119_1.var_.characterEffect1049ui_story then
				arg_119_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= 4 + arg_122_0 then
				arg_119_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_2")
			end

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= 4 + arg_122_0 then
				arg_119_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_122_16 = arg_119_1.actors_["1015ui_story"].transform

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				arg_119_1.var_.moveOldPos1015ui_story = var_122_16.localPosition
			end

			local var_122_17 = 0.001

			if 2 <= arg_119_1.time_ and arg_119_1.time_ < 2 + var_122_17 then
				var_122_16.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 2) / var_122_17)
				var_122_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_16.position).x, (manager.ui.mainCamera.transform.position - var_122_16.position).y, (manager.ui.mainCamera.transform.position - var_122_16.position).z)
				var_122_16.localEulerAngles.z = 0
				var_122_16.localEulerAngles.x = 0
				var_122_16.localEulerAngles = var_122_16.localEulerAngles
			end

			if arg_119_1.time_ >= 2 + var_122_17 and arg_119_1.time_ < 2 + var_122_17 + arg_122_0 then
				var_122_16.localPosition = Vector3.New(0, 100, 0)
				var_122_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_16.position).x, (manager.ui.mainCamera.transform.position - var_122_16.position).y, (manager.ui.mainCamera.transform.position - var_122_16.position).z)
				var_122_16.localEulerAngles.z = 0
				var_122_16.localEulerAngles.x = 0
				var_122_16.localEulerAngles = var_122_16.localEulerAngles
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_18 = 4
			local var_122_19 = 0.15

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_20 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_20:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_21 = arg_119_1:GetWordFromCfg(318021029)
				local var_122_22 = arg_119_1:FormatText(var_122_21.content)

				arg_119_1.text_.text = var_122_22

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_24 = 6 <= 0 and var_122_19 or var_122_19 * (utf8.len(var_122_22) / 6)

				if (6 <= 0 and var_122_19 or var_122_19 * (utf8.len(var_122_22) / 6)) > 0 and var_122_19 < var_122_24 then
					arg_119_1.talkMaxDuration = var_122_24
					var_122_18 = var_122_18 + 0.3

					if var_122_24 + var_122_18 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_24 + var_122_18
					end
				end

				arg_119_1.text_.text = var_122_22
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021029", "story_v_out_318021.awb") ~= 0 then
					local var_122_25 = manager.audio:GetVoiceLength("story_v_out_318021", "318021029", "story_v_out_318021.awb") / 1000

					if var_122_25 + var_122_18 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_25 + var_122_18
					end

					if var_122_21.prefab_name ~= "" and arg_119_1.actors_[var_122_21.prefab_name] ~= nil then
						local var_122_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_21.prefab_name].transform, "story_v_out_318021", "318021029", "story_v_out_318021.awb")

						arg_119_1:RecordAudio("318021029", var_122_26)
						arg_119_1:RecordAudio("318021029", var_122_26)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_318021", "318021029", "story_v_out_318021.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_318021", "318021029", "story_v_out_318021.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_27 = var_122_18 + 0.3
			local var_122_28 = math.max(var_122_19, arg_119_1.talkMaxDuration)

			if var_122_18 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_27 + var_122_28 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_27) / var_122_28

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_27 + var_122_28 and arg_119_1.time_ < var_122_27 + var_122_28 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play318021030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318021030
		arg_125_1.duration_ = 6.93

		local var_125_0 = {
			zh = 6.933,
			ja = 4.266
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318021031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10053ui_story = arg_125_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10053ui_story"].transform.position).z)
				arg_125_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10053ui_story"].transform.localEulerAngles = arg_125_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_125_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10053ui_story"].transform.position).z)
				arg_125_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10053ui_story"].transform.localEulerAngles = arg_125_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10053ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10053ui_story == nil then
				arg_125_1.var_.characterEffect10053ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect10053ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10053ui_story then
				arg_125_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action34_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_128_4 = arg_125_1.actors_["1049ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1049ui_story = var_128_4.localPosition
			end

			local var_128_5 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				var_128_4.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_125_1.time_ - 0) / var_128_5)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				var_128_4.localPosition = Vector3.New(-0.7, -1.2, -6)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			local var_128_6 = arg_125_1.actors_["1049ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1049ui_story == nil then
				arg_125_1.var_.characterEffect1049ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect1049ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1049ui_story then
				arg_125_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_128_8 = 0
			local var_128_9 = 0.325

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(318021030)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 13 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 13)

				if (13 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 13)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021030", "story_v_out_318021.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021030", "story_v_out_318021.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_318021", "318021030", "story_v_out_318021.awb")

						arg_125_1:RecordAudio("318021030", var_128_15)
						arg_125_1:RecordAudio("318021030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318021", "318021030", "story_v_out_318021.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318021", "318021030", "story_v_out_318021.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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

		arg_125_1:InitPlayNodeList()
	end,
	Play318021031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318021031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318021032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10053ui_story"]) and arg_129_1.var_.characterEffect10053ui_story == nil then
				arg_129_1.var_.characterEffect10053ui_story = arg_129_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10053ui_story"]) then
				if arg_129_1.var_.characterEffect10053ui_story and not isNil(arg_129_1.actors_["10053ui_story"]) then
					arg_129_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10053ui_story"]) and arg_129_1.var_.characterEffect10053ui_story then
				arg_129_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 1.875

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(318021031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 75 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 75)

				if (75 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 75)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play318021032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318021032
		arg_133_1.duration_ = 2

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318021033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if arg_133_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_136_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_133_1.stage_.transform)

				var_136_0.name = "1058ui_story"
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1058ui_story"] = var_136_0

				local var_136_1 = var_136_0:GetComponentInChildren(typeof(CharacterEffect))

				var_136_1.enabled = true

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end

				arg_133_1:ShowWeapon(var_136_1.transform, false)

				arg_133_1.var_["1058ui_story" .. "Animator"] = var_136_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_133_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_133_1.var_["1058ui_story" .. "LipSync"] = var_136_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_136_3 = arg_133_1.actors_["1058ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1058ui_story = var_136_3.localPosition
			end

			local var_136_4 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				var_136_3.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_133_1.time_ - 0) / var_136_4)
				var_136_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_3.position).x, (manager.ui.mainCamera.transform.position - var_136_3.position).y, (manager.ui.mainCamera.transform.position - var_136_3.position).z)
				var_136_3.localEulerAngles.z = 0
				var_136_3.localEulerAngles.x = 0
				var_136_3.localEulerAngles = var_136_3.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				var_136_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_136_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_3.position).x, (manager.ui.mainCamera.transform.position - var_136_3.position).y, (manager.ui.mainCamera.transform.position - var_136_3.position).z)
				var_136_3.localEulerAngles.z = 0
				var_136_3.localEulerAngles.x = 0
				var_136_3.localEulerAngles = var_136_3.localEulerAngles
			end

			local var_136_5 = arg_133_1.actors_["1058ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect1058ui_story == nil then
				arg_133_1.var_.characterEffect1058ui_story = var_136_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_5) then
				if arg_133_1.var_.characterEffect1058ui_story and not isNil(var_136_5) then
					arg_133_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect1058ui_story then
				arg_133_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_136_8 = arg_133_1.actors_["10053ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10053ui_story = var_136_8.localPosition
			end

			local var_136_9 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_9 then
				var_136_8.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_9)
				var_136_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_8.position).x, (manager.ui.mainCamera.transform.position - var_136_8.position).y, (manager.ui.mainCamera.transform.position - var_136_8.position).z)
				var_136_8.localEulerAngles.z = 0
				var_136_8.localEulerAngles.x = 0
				var_136_8.localEulerAngles = var_136_8.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_9 and arg_133_1.time_ < 0 + var_136_9 + arg_136_0 then
				var_136_8.localPosition = Vector3.New(0, 100, 0)
				var_136_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_8.position).x, (manager.ui.mainCamera.transform.position - var_136_8.position).y, (manager.ui.mainCamera.transform.position - var_136_8.position).z)
				var_136_8.localEulerAngles.z = 0
				var_136_8.localEulerAngles.x = 0
				var_136_8.localEulerAngles = var_136_8.localEulerAngles
			end

			local var_136_10 = arg_133_1.actors_["1049ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1049ui_story = var_136_10.localPosition
			end

			local var_136_11 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_11 then
				var_136_10.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_11)
				var_136_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_10.position).x, (manager.ui.mainCamera.transform.position - var_136_10.position).y, (manager.ui.mainCamera.transform.position - var_136_10.position).z)
				var_136_10.localEulerAngles.z = 0
				var_136_10.localEulerAngles.x = 0
				var_136_10.localEulerAngles = var_136_10.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_11 and arg_133_1.time_ < 0 + var_136_11 + arg_136_0 then
				var_136_10.localPosition = Vector3.New(0, 100, 0)
				var_136_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_10.position).x, (manager.ui.mainCamera.transform.position - var_136_10.position).y, (manager.ui.mainCamera.transform.position - var_136_10.position).z)
				var_136_10.localEulerAngles.z = 0
				var_136_10.localEulerAngles.x = 0
				var_136_10.localEulerAngles = var_136_10.localEulerAngles
			end

			local var_136_12 = 0
			local var_136_13 = 0.125

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_14 = arg_133_1:GetWordFromCfg(318021032)
				local var_136_15 = arg_133_1:FormatText(var_136_14.content)

				arg_133_1.text_.text = var_136_15

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 5 <= 0 and var_136_13 or var_136_13 * (utf8.len(var_136_15) / 5)

				if (5 <= 0 and var_136_13 or var_136_13 * (utf8.len(var_136_15) / 5)) > 0 and var_136_13 < var_136_17 then
					arg_133_1.talkMaxDuration = var_136_17

					if var_136_17 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_17 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_15
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021032", "story_v_out_318021.awb") ~= 0 then
					local var_136_18 = manager.audio:GetVoiceLength("story_v_out_318021", "318021032", "story_v_out_318021.awb") / 1000

					if var_136_18 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_12
					end

					if var_136_14.prefab_name ~= "" and arg_133_1.actors_[var_136_14.prefab_name] ~= nil then
						local var_136_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_14.prefab_name].transform, "story_v_out_318021", "318021032", "story_v_out_318021.awb")

						arg_133_1:RecordAudio("318021032", var_136_19)
						arg_133_1:RecordAudio("318021032", var_136_19)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_318021", "318021032", "story_v_out_318021.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_318021", "318021032", "story_v_out_318021.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_20 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_20 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_20

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_20 and arg_133_1.time_ < var_136_12 + var_136_20 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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
				actorName = "10053ui_story",
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

		arg_133_1:InitPlayNodeList()
	end,
	Play318021033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318021033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318021034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_9001
			local var_140_9000

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1058ui_story = arg_137_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1058ui_story"].transform.position).z)
				arg_137_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1058ui_story"].transform.localEulerAngles = arg_137_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1058ui_story"].transform.position).z)
				arg_137_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1058ui_story"].transform.localEulerAngles = arg_137_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1058ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1058ui_story == nil then
				arg_137_1.var_.characterEffect1058ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1058ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_2)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1058ui_story then
				arg_137_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				local var_140_3 = arg_137_1.var_.effecthuoyan1

				if not arg_137_1.var_.effecthuoyan1 then
					var_140_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_140_3.name = "huoyan1"
					arg_137_1.var_.effecthuoyan1 = var_140_3
				else
					var_140_3.transform:SetParent(var_140_9001)
				end

				var_140_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_140_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				if arg_137_1.var_.effecthuoyan1 then
					Object.Destroy(arg_137_1.var_.effecthuoyan1)

					arg_137_1.var_.effecthuoyan1 = nil
				end
			end

			local var_140_6 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = false

				arg_137_1:SetGaussion(false)
			end

			local var_140_7 = 0.5

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_7 then
				local var_140_8 = Color.New(1, 0.4079707, 0.03301889)

				var_140_8.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_6) / var_140_7)
				arg_137_1.mask_.color = var_140_8
			end

			if arg_137_1.time_ >= var_140_6 + var_140_7 and arg_137_1.time_ < var_140_6 + var_140_7 + arg_140_0 then
				local var_140_9 = Color.New(1, 0.4079707, 0.03301889)

				arg_137_1.mask_.enabled = false
				var_140_9.a = 0
				arg_137_1.mask_.color = var_140_9
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				local var_140_10 = arg_137_1.var_.effectjiajutuhuoyan1

				if not arg_137_1.var_.effectjiajutuhuoyan1 then
					var_140_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_140_10.name = "jiajutuhuoyan1"
					arg_137_1.var_.effectjiajutuhuoyan1 = var_140_10
				else
					var_140_10.transform:SetParent(var_140_9000)
				end

				var_140_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_140_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_140_13 = 0
			local var_140_14 = 1.75

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(318021033).content)

				arg_137_1.text_.text = var_140_15

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 70 <= 0 and var_140_14 or var_140_14 * (utf8.len(var_140_15) / 70)

				if (70 <= 0 and var_140_14 or var_140_14 * (utf8.len(var_140_15) / 70)) > 0 and var_140_14 < var_140_17 then
					arg_137_1.talkMaxDuration = var_140_17

					if var_140_17 + var_140_13 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_13
					end
				end

				arg_137_1.text_.text = var_140_15
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = math.max(var_140_14, arg_137_1.talkMaxDuration)

			if var_140_13 <= arg_137_1.time_ and arg_137_1.time_ < var_140_13 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_13) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_13 + var_140_18 and arg_137_1.time_ < var_140_13 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play318021034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318021034
		arg_141_1.duration_ = 3.3

		local var_141_0 = {
			zh = 3.3,
			ja = 2.866
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play318021035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1049ui_story = arg_141_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1049ui_story"].transform.position).z)
				arg_141_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1049ui_story"].transform.localEulerAngles = arg_141_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_141_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1049ui_story"].transform.position).z)
				arg_141_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1049ui_story"].transform.localEulerAngles = arg_141_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1049ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1049ui_story == nil then
				arg_141_1.var_.characterEffect1049ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1049ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1049ui_story then
				arg_141_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				if arg_141_1.var_.effectjiajutuhuoyan1 then
					Object.Destroy(arg_141_1.var_.effectjiajutuhuoyan1)

					arg_141_1.var_.effectjiajutuhuoyan1 = nil
				end
			end

			local var_144_5 = 0
			local var_144_6 = 0.2

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(318021034)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 8 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 8)

				if (8 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 8)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021034", "story_v_out_318021.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_318021", "318021034", "story_v_out_318021.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_318021", "318021034", "story_v_out_318021.awb")

						arg_141_1:RecordAudio("318021034", var_144_12)
						arg_141_1:RecordAudio("318021034", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318021", "318021034", "story_v_out_318021.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318021", "318021034", "story_v_out_318021.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_13 and arg_141_1.time_ < var_144_5 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play318021035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318021035
		arg_145_1.duration_ = 10.6

		local var_145_0 = {
			zh = 10.6,
			ja = 8.633
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318021036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10053ui_story = arg_145_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10053ui_story"].transform.position).z)
				arg_145_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10053ui_story"].transform.localEulerAngles = arg_145_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_145_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10053ui_story"].transform.position).z)
				arg_145_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10053ui_story"].transform.localEulerAngles = arg_145_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10053ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10053ui_story == nil then
				arg_145_1.var_.characterEffect10053ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10053ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10053ui_story then
				arg_145_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["1049ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1049ui_story = var_148_4.localPosition
			end

			local var_148_5 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 then
				var_148_4.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_145_1.time_ - 0) / var_148_5)
				var_148_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_4.position).x, (manager.ui.mainCamera.transform.position - var_148_4.position).y, (manager.ui.mainCamera.transform.position - var_148_4.position).z)
				var_148_4.localEulerAngles.z = 0
				var_148_4.localEulerAngles.x = 0
				var_148_4.localEulerAngles = var_148_4.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 then
				var_148_4.localPosition = Vector3.New(-0.7, -1.2, -6)
				var_148_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_4.position).x, (manager.ui.mainCamera.transform.position - var_148_4.position).y, (manager.ui.mainCamera.transform.position - var_148_4.position).z)
				var_148_4.localEulerAngles.z = 0
				var_148_4.localEulerAngles.x = 0
				var_148_4.localEulerAngles = var_148_4.localEulerAngles
			end

			local var_148_6 = arg_145_1.actors_["1049ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1049ui_story == nil then
				arg_145_1.var_.characterEffect1049ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_7 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 and not isNil(var_148_6) then
				if arg_145_1.var_.characterEffect1049ui_story and not isNil(var_148_6) then
					arg_145_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_7)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1049ui_story then
				arg_145_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_148_8 = 0
			local var_148_9 = 0.8

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(318021035)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 32 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 32)

				if (32 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 32)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021035", "story_v_out_318021.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021035", "story_v_out_318021.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_318021", "318021035", "story_v_out_318021.awb")

						arg_145_1:RecordAudio("318021035", var_148_15)
						arg_145_1:RecordAudio("318021035", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_318021", "318021035", "story_v_out_318021.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_318021", "318021035", "story_v_out_318021.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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

		arg_145_1:InitPlayNodeList()
	end,
	Play318021036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318021036
		arg_149_1.duration_ = 5

		local var_149_0 = {
			zh = 4.533,
			ja = 5
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318021037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1049ui_story = arg_149_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1049ui_story"].transform.position).z)
				arg_149_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1049ui_story"].transform.localEulerAngles = arg_149_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_149_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1049ui_story"].transform.position).z)
				arg_149_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1049ui_story"].transform.localEulerAngles = arg_149_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1049ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1049ui_story == nil then
				arg_149_1.var_.characterEffect1049ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1049ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1049ui_story then
				arg_149_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["10053ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10053ui_story == nil then
				arg_149_1.var_.characterEffect10053ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect10053ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10053ui_story then
				arg_149_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_152_6 = 0
			local var_152_7 = 0.4

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(318021036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 16 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 16)

				if (16 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 16)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021036", "story_v_out_318021.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_318021", "318021036", "story_v_out_318021.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_318021", "318021036", "story_v_out_318021.awb")

						arg_149_1:RecordAudio("318021036", var_152_13)
						arg_149_1:RecordAudio("318021036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_318021", "318021036", "story_v_out_318021.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_318021", "318021036", "story_v_out_318021.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play318021037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318021037
		arg_153_1.duration_ = 8.83

		local var_153_0 = {
			zh = 8.833,
			ja = 4.5
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play318021038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1049ui_story = arg_153_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1049ui_story"].transform.position).z)
				arg_153_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1049ui_story"].transform.localEulerAngles = arg_153_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(-0.7, -1.2, -6)
				arg_153_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1049ui_story"].transform.position).z)
				arg_153_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1049ui_story"].transform.localEulerAngles = arg_153_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1049ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1049ui_story == nil then
				arg_153_1.var_.characterEffect1049ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1049ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1049ui_story then
				arg_153_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			local var_156_4 = 0
			local var_156_5 = 0.7

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(318021037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 28 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 28)

				if (28 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 28)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021037", "story_v_out_318021.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_318021", "318021037", "story_v_out_318021.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_318021", "318021037", "story_v_out_318021.awb")

						arg_153_1:RecordAudio("318021037", var_156_11)
						arg_153_1:RecordAudio("318021037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_318021", "318021037", "story_v_out_318021.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_318021", "318021037", "story_v_out_318021.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play318021038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318021038
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318021039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10053ui_story = arg_157_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10053ui_story"].transform.position).z)
				arg_157_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10053ui_story"].transform.localEulerAngles = arg_157_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_157_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10053ui_story"].transform.position).z)
				arg_157_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10053ui_story"].transform.localEulerAngles = arg_157_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["10053ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10053ui_story == nil then
				arg_157_1.var_.characterEffect10053ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect10053ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10053ui_story then
				arg_157_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action34_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_160_4 = arg_157_1.actors_["1049ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1049ui_story == nil then
				arg_157_1.var_.characterEffect1049ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect1049ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1049ui_story then
				arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_160_6 = 0
			local var_160_7 = 0.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(318021038)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 4 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 4)

				if (4 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 4)) > 0 and var_160_7 < var_160_11 then
					arg_157_1.talkMaxDuration = var_160_11

					if var_160_11 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021038", "story_v_out_318021.awb") ~= 0 then
					local var_160_12 = manager.audio:GetVoiceLength("story_v_out_318021", "318021038", "story_v_out_318021.awb") / 1000

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end

					if var_160_8.prefab_name ~= "" and arg_157_1.actors_[var_160_8.prefab_name] ~= nil then
						local var_160_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_8.prefab_name].transform, "story_v_out_318021", "318021038", "story_v_out_318021.awb")

						arg_157_1:RecordAudio("318021038", var_160_13)
						arg_157_1:RecordAudio("318021038", var_160_13)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_318021", "318021038", "story_v_out_318021.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_318021", "318021038", "story_v_out_318021.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play318021039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318021039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318021040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10053ui_story = arg_161_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10053ui_story"].transform.position).z)
				arg_161_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10053ui_story"].transform.localEulerAngles = arg_161_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10053ui_story"].transform.position).z)
				arg_161_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10053ui_story"].transform.localEulerAngles = arg_161_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["10053ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect10053ui_story == nil then
				arg_161_1.var_.characterEffect10053ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect10053ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect10053ui_story then
				arg_161_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_164_3 = arg_161_1.actors_["1049ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1049ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(0, 100, 0)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["1049ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1049ui_story == nil then
				arg_161_1.var_.characterEffect1049ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect1049ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_6)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1049ui_story then
				arg_161_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_164_7 = 0
			local var_164_8 = 1.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_7 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(318021039).content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 57 <= 0 and var_164_8 or var_164_8 * (utf8.len(var_164_9) / 57)

				if (57 <= 0 and var_164_8 or var_164_8 * (utf8.len(var_164_9) / 57)) > 0 and var_164_8 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_7 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_7
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_8, arg_161_1.talkMaxDuration)

			if var_164_7 <= arg_161_1.time_ and arg_161_1.time_ < var_164_7 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_7) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_7 + var_164_12 and arg_161_1.time_ < var_164_7 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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

		arg_161_1:InitPlayNodeList()
	end,
	Play318021040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318021040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318021041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.65

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(318021040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 66 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 66)

				if (66 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 66)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play318021041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318021041
		arg_169_1.duration_ = 4.17

		local var_169_0 = {
			zh = 1.999999999999,
			ja = 4.166
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play318021042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1049ui_story = arg_169_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1049ui_story"].transform.position).z)
				arg_169_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1049ui_story"].transform.localEulerAngles = arg_169_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_169_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1049ui_story"].transform.position).z)
				arg_169_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1049ui_story"].transform.localEulerAngles = arg_169_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1049ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1049ui_story == nil then
				arg_169_1.var_.characterEffect1049ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1049ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1049ui_story then
				arg_169_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.25

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(318021041)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 10 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 10)

				if (10 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 10)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021041", "story_v_out_318021.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_318021", "318021041", "story_v_out_318021.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_318021", "318021041", "story_v_out_318021.awb")

						arg_169_1:RecordAudio("318021041", var_172_11)
						arg_169_1:RecordAudio("318021041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_318021", "318021041", "story_v_out_318021.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_318021", "318021041", "story_v_out_318021.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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

		arg_169_1:InitPlayNodeList()
	end,
	Play318021042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318021042
		arg_173_1.duration_ = 8.77

		local var_173_0 = {
			zh = 5.733,
			ja = 8.766
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play318021043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10053ui_story = arg_173_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10053ui_story"].transform.position).z)
				arg_173_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10053ui_story"].transform.localEulerAngles = arg_173_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_173_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10053ui_story"].transform.position).z)
				arg_173_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10053ui_story"].transform.localEulerAngles = arg_173_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["10053ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10053ui_story == nil then
				arg_173_1.var_.characterEffect10053ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect10053ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10053ui_story then
				arg_173_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = arg_173_1.actors_["1049ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1049ui_story = var_176_4.localPosition
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_4.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_173_1.time_ - 0) / var_176_5)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_4.localPosition = Vector3.New(-0.7, -1.2, -6)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			local var_176_6 = arg_173_1.actors_["1049ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1049ui_story == nil then
				arg_173_1.var_.characterEffect1049ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect1049ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1049ui_story then
				arg_173_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_176_8 = 0
			local var_176_9 = 0.475

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(318021042)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 19 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 19)

				if (19 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 19)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021042", "story_v_out_318021.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021042", "story_v_out_318021.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_318021", "318021042", "story_v_out_318021.awb")

						arg_173_1:RecordAudio("318021042", var_176_15)
						arg_173_1:RecordAudio("318021042", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_318021", "318021042", "story_v_out_318021.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_318021", "318021042", "story_v_out_318021.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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

		arg_173_1:InitPlayNodeList()
	end,
	Play318021043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318021043
		arg_177_1.duration_ = 7.5

		local var_177_0 = {
			zh = 7.5,
			ja = 7.333
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play318021044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1049ui_story"]) and arg_177_1.var_.characterEffect1049ui_story == nil then
				arg_177_1.var_.characterEffect1049ui_story = arg_177_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1049ui_story"]) then
				if arg_177_1.var_.characterEffect1049ui_story and not isNil(arg_177_1.actors_["1049ui_story"]) then
					arg_177_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1049ui_story"]) and arg_177_1.var_.characterEffect1049ui_story then
				arg_177_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["10053ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect10053ui_story == nil then
				arg_177_1.var_.characterEffect10053ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect10053ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect10053ui_story then
				arg_177_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_180_4 = 0
			local var_180_5 = 0.875

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(318021043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 35 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 35)

				if (35 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 35)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021043", "story_v_out_318021.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_318021", "318021043", "story_v_out_318021.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_318021", "318021043", "story_v_out_318021.awb")

						arg_177_1:RecordAudio("318021043", var_180_11)
						arg_177_1:RecordAudio("318021043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_318021", "318021043", "story_v_out_318021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_318021", "318021043", "story_v_out_318021.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play318021044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318021044
		arg_181_1.duration_ = 1.83

		local var_181_0 = {
			zh = 1.5,
			ja = 1.833
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play318021045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1049ui_story = arg_181_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1049ui_story"].transform.position).z)
				arg_181_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1049ui_story"].transform.localEulerAngles = arg_181_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1049ui_story"].transform.position).z)
				arg_181_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1049ui_story"].transform.localEulerAngles = arg_181_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1049ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1049ui_story == nil then
				arg_181_1.var_.characterEffect1049ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1049ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1049ui_story then
				arg_181_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_184_3 = arg_181_1.actors_["10053ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10053ui_story = var_184_3.localPosition
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_3.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_4)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_3.localPosition = Vector3.New(0, 100, 0)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			local var_184_5 = 0
			local var_184_6 = 0.175

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_7 = arg_181_1:GetWordFromCfg(318021044)
				local var_184_8 = arg_181_1:FormatText(var_184_7.content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 7 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 7)

				if (7 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 7)) > 0 and var_184_6 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021044", "story_v_out_318021.awb") ~= 0 then
					local var_184_11 = manager.audio:GetVoiceLength("story_v_out_318021", "318021044", "story_v_out_318021.awb") / 1000

					if var_184_11 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_5
					end

					if var_184_7.prefab_name ~= "" and arg_181_1.actors_[var_184_7.prefab_name] ~= nil then
						local var_184_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_7.prefab_name].transform, "story_v_out_318021", "318021044", "story_v_out_318021.awb")

						arg_181_1:RecordAudio("318021044", var_184_12)
						arg_181_1:RecordAudio("318021044", var_184_12)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_318021", "318021044", "story_v_out_318021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_318021", "318021044", "story_v_out_318021.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_13 and arg_181_1.time_ < var_184_5 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play318021045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318021045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play318021046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1015ui_story"]) and arg_185_1.var_.characterEffect1015ui_story == nil then
				arg_185_1.var_.characterEffect1015ui_story = arg_185_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1015ui_story"]) then
				if arg_185_1.var_.characterEffect1015ui_story and not isNil(arg_185_1.actors_["1015ui_story"]) then
					arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1015ui_story"]) and arg_185_1.var_.characterEffect1015ui_story then
				arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0
			local var_188_2 = 0.85

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(318021045).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 34 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 34)

				if (34 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 34)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play318021046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318021046
		arg_189_1.duration_ = 2.37

		local var_189_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play318021047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1049ui_story = arg_189_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1049ui_story"].transform.position).z)
				arg_189_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1049ui_story"].transform.localEulerAngles = arg_189_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_189_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1049ui_story"].transform.position).z)
				arg_189_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1049ui_story"].transform.localEulerAngles = arg_189_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1049ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1049ui_story == nil then
				arg_189_1.var_.characterEffect1049ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1049ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1049ui_story then
				arg_189_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_4 = arg_189_1.actors_["1015ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1015ui_story = var_192_4.localPosition
			end

			local var_192_5 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_5 then
				var_192_4.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_5)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_5 and arg_189_1.time_ < 0 + var_192_5 + arg_192_0 then
				var_192_4.localPosition = Vector3.New(0, 100, 0)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles
			end

			local var_192_6 = 0
			local var_192_7 = 0.1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(318021046)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 4 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 4)

				if (4 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 4)) > 0 and var_192_7 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021046", "story_v_out_318021.awb") ~= 0 then
					local var_192_12 = manager.audio:GetVoiceLength("story_v_out_318021", "318021046", "story_v_out_318021.awb") / 1000

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end

					if var_192_8.prefab_name ~= "" and arg_189_1.actors_[var_192_8.prefab_name] ~= nil then
						local var_192_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_8.prefab_name].transform, "story_v_out_318021", "318021046", "story_v_out_318021.awb")

						arg_189_1:RecordAudio("318021046", var_192_13)
						arg_189_1:RecordAudio("318021046", var_192_13)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_318021", "318021046", "story_v_out_318021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_318021", "318021046", "story_v_out_318021.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play318021047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318021047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play318021048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1049ui_story"]) and arg_193_1.var_.characterEffect1049ui_story == nil then
				arg_193_1.var_.characterEffect1049ui_story = arg_193_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1049ui_story"]) then
				if arg_193_1.var_.characterEffect1049ui_story and not isNil(arg_193_1.actors_["1049ui_story"]) then
					arg_193_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1049ui_story"]) and arg_193_1.var_.characterEffect1049ui_story then
				arg_193_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(318021047).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 14 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 14)

				if (14 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 14)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play318021048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318021048
		arg_197_1.duration_ = 9.33

		local var_197_0 = {
			zh = 4.166,
			ja = 9.333
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play318021049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10053ui_story = arg_197_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10053ui_story"].transform.position).z)
				arg_197_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10053ui_story"].transform.localEulerAngles = arg_197_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_197_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10053ui_story"].transform.position).z)
				arg_197_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10053ui_story"].transform.localEulerAngles = arg_197_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["10053ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10053ui_story == nil then
				arg_197_1.var_.characterEffect10053ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect10053ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10053ui_story then
				arg_197_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_4 = arg_197_1.actors_["1049ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1049ui_story = var_200_4.localPosition
			end

			local var_200_5 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 then
				var_200_4.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1049ui_story, Vector3.New(-0.7, -1.2, -6), (arg_197_1.time_ - 0) / var_200_5)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 then
				var_200_4.localPosition = Vector3.New(-0.7, -1.2, -6)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			local var_200_6 = 0
			local var_200_7 = 0.35

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(318021048)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 14 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 14)

				if (14 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 14)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021048", "story_v_out_318021.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_318021", "318021048", "story_v_out_318021.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_318021", "318021048", "story_v_out_318021.awb")

						arg_197_1:RecordAudio("318021048", var_200_13)
						arg_197_1:RecordAudio("318021048", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_318021", "318021048", "story_v_out_318021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_318021", "318021048", "story_v_out_318021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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

		arg_197_1:InitPlayNodeList()
	end,
	Play318021049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 318021049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play318021050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10053ui_story"]) and arg_201_1.var_.characterEffect10053ui_story == nil then
				arg_201_1.var_.characterEffect10053ui_story = arg_201_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10053ui_story"]) then
				if arg_201_1.var_.characterEffect10053ui_story and not isNil(arg_201_1.actors_["10053ui_story"]) then
					arg_201_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10053ui_story"]) and arg_201_1.var_.characterEffect10053ui_story then
				arg_201_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 1.175

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(318021049).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 47 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 47)

				if (47 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 47)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play318021050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 318021050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.35

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(318021050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 14 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 14)

				if (14 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 14)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K10g",
		"TextureConfig/Background/K11g"
	},
	voices = {
		"story_v_out_318021.awb"
	}
}
