return {
	Play411171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411171001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.B10b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10b")
				var_4_0.name = "B10b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B10b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B10b

				arg_1_1.bgs_.B10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10b" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_rain02_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.var_.effect工厂雨

				if not arg_1_1.var_.effect工厂雨 then
					var_4_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), manager.ui.mainCamera.transform)
					var_4_12.name = "工厂雨"
					arg_1_1.var_.effect工厂雨 = var_4_12
				else
					var_4_12.transform:SetParent(var_4_9000)
				end

				var_4_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			local var_4_20 = 2
			local var_4_21 = 1.075

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411171001).content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 43 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 43)

				if (43 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 43)) > 0 and var_4_21 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_20 = var_4_20 + 0.3

					if var_4_25 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_20 + 0.3
			local var_4_27 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411171002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 411171002
		arg_10_1.duration_ = 9.1

		local var_10_0 = {
			zh = 6.066,
			ja = 9.1
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play411171003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_13_0 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_10_1.stage_.transform)

				var_13_0.name = "1024ui_story"
				var_13_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_10_1.actors_["1024ui_story"] = var_13_0

				local var_13_1 = var_13_0:GetComponentInChildren(typeof(CharacterEffect))

				var_13_1.enabled = true

				local var_13_2 = GameObjectTools.GetOrAddComponent(var_13_0, typeof(DynamicBoneHelper))

				if var_13_2 then
					var_13_2:EnableDynamicBone(false)
				end

				arg_10_1:ShowWeapon(var_13_1.transform, false)

				arg_10_1.var_["1024ui_story" .. "Animator"] = var_13_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_10_1.var_["1024ui_story" .. "Animator"].applyRootMotion = true
				arg_10_1.var_["1024ui_story" .. "LipSync"] = var_13_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_13_3 = arg_10_1.actors_["1024ui_story"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos1024ui_story = var_13_3.localPosition

				arg_10_1:ShowWeapon(arg_10_1.var_["1024ui_story" .. "Animator"].transform, false)
			end

			local var_13_4 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				var_13_3.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_10_1.time_ - 0) / var_13_4)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				var_13_3.localPosition = Vector3.New(0, -1, -6.05)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			local var_13_5 = arg_10_1.actors_["1024ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect1024ui_story == nil then
				arg_10_1.var_.characterEffect1024ui_story = var_13_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_6 = 0.200000002980232

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_6 and not isNil(var_13_5) then
				if arg_10_1.var_.characterEffect1024ui_story and not isNil(var_13_5) then
					arg_10_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= 0 + var_13_6 and arg_10_1.time_ < 0 + var_13_6 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect1024ui_story then
				arg_10_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_13_8 = 0
			local var_13_9 = 0.9

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[714].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_10 = arg_10_1:GetWordFromCfg(411171002)
				local var_13_11 = arg_10_1:FormatText(var_13_10.content)

				arg_10_1.text_.text = var_13_11

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 36 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 36)

				if (36 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 36)) > 0 and var_13_9 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_11
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171002", "story_v_out_411171.awb") ~= 0 then
					local var_13_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171002", "story_v_out_411171.awb") / 1000

					if var_13_14 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_14 + var_13_8
					end

					if var_13_10.prefab_name ~= "" and arg_10_1.actors_[var_13_10.prefab_name] ~= nil then
						local var_13_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_10.prefab_name].transform, "story_v_out_411171", "411171002", "story_v_out_411171.awb")

						arg_10_1:RecordAudio("411171002", var_13_15)
						arg_10_1:RecordAudio("411171002", var_13_15)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_411171", "411171002", "story_v_out_411171.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_411171", "411171002", "story_v_out_411171.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_16 = math.max(var_13_9, arg_10_1.talkMaxDuration)

			if var_13_8 <= arg_10_1.time_ and arg_10_1.time_ < var_13_8 + var_13_16 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_8) / var_13_16

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_8 + var_13_16 and arg_10_1.time_ < var_13_8 + var_13_16 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play411171003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 411171003
		arg_14_1.duration_ = 2.8

		local var_14_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play411171004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_17_0 = 0
			local var_17_1 = 0.225

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[714].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_2 = arg_14_1:GetWordFromCfg(411171003)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 9 <= 0 and var_17_1 or var_17_1 * (utf8.len(var_17_3) / 9)

				if (9 <= 0 and var_17_1 or var_17_1 * (utf8.len(var_17_3) / 9)) > 0 and var_17_1 < var_17_5 then
					arg_14_1.talkMaxDuration = var_17_5

					if var_17_5 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171003", "story_v_out_411171.awb") ~= 0 then
					local var_17_6 = manager.audio:GetVoiceLength("story_v_out_411171", "411171003", "story_v_out_411171.awb") / 1000

					if var_17_6 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_0
					end

					if var_17_2.prefab_name ~= "" and arg_14_1.actors_[var_17_2.prefab_name] ~= nil then
						local var_17_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_2.prefab_name].transform, "story_v_out_411171", "411171003", "story_v_out_411171.awb")

						arg_14_1:RecordAudio("411171003", var_17_7)
						arg_14_1:RecordAudio("411171003", var_17_7)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_411171", "411171003", "story_v_out_411171.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_411171", "411171003", "story_v_out_411171.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_8 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_8 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_8

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_8 and arg_14_1.time_ < var_17_0 + var_17_8 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play411171004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 411171004
		arg_18_1.duration_ = 9.7

		local var_18_0 = {
			zh = 5.133,
			ja = 9.7
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
				arg_18_0:Play411171005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if arg_18_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_21_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_18_1.stage_.transform)

				var_21_0.name = "2078ui_story"
				var_21_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.actors_["2078ui_story"] = var_21_0

				local var_21_1 = var_21_0:GetComponentInChildren(typeof(CharacterEffect))

				var_21_1.enabled = true

				local var_21_2 = GameObjectTools.GetOrAddComponent(var_21_0, typeof(DynamicBoneHelper))

				if var_21_2 then
					var_21_2:EnableDynamicBone(false)
				end

				arg_18_1:ShowWeapon(var_21_1.transform, false)

				arg_18_1.var_["2078ui_story" .. "Animator"] = var_21_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_18_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_18_1.var_["2078ui_story" .. "LipSync"] = var_21_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_21_3 = arg_18_1.actors_["2078ui_story"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos2078ui_story = var_21_3.localPosition
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_3.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_18_1.time_ - 0) / var_21_4)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			local var_21_5 = arg_18_1.actors_["2078ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect2078ui_story == nil then
				arg_18_1.var_.characterEffect2078ui_story = var_21_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_6 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_6 and not isNil(var_21_5) then
				if arg_18_1.var_.characterEffect2078ui_story and not isNil(var_21_5) then
					arg_18_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_6 and arg_18_1.time_ < 0 + var_21_6 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect2078ui_story then
				arg_18_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_21_8 = arg_18_1.actors_["1024ui_story"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1024ui_story = var_21_8.localPosition
			end

			local var_21_9 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_9 then
				var_21_8.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_18_1.time_ - 0) / var_21_9)
				var_21_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_8.position).x, (manager.ui.mainCamera.transform.position - var_21_8.position).y, (manager.ui.mainCamera.transform.position - var_21_8.position).z)
				var_21_8.localEulerAngles.z = 0
				var_21_8.localEulerAngles.x = 0
				var_21_8.localEulerAngles = var_21_8.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_9 and arg_18_1.time_ < 0 + var_21_9 + arg_21_0 then
				var_21_8.localPosition = Vector3.New(0, 100, 0)
				var_21_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_8.position).x, (manager.ui.mainCamera.transform.position - var_21_8.position).y, (manager.ui.mainCamera.transform.position - var_21_8.position).z)
				var_21_8.localEulerAngles.z = 0
				var_21_8.localEulerAngles.x = 0
				var_21_8.localEulerAngles = var_21_8.localEulerAngles
			end

			local var_21_10 = arg_18_1.actors_["1024ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_10) and arg_18_1.var_.characterEffect1024ui_story == nil then
				arg_18_1.var_.characterEffect1024ui_story = var_21_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_11 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_11 and not isNil(var_21_10) then
				if arg_18_1.var_.characterEffect1024ui_story and not isNil(var_21_10) then
					arg_18_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_18_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_18_1.time_ - 0) / var_21_11)
				end
			end

			if arg_18_1.time_ >= 0 + var_21_11 and arg_18_1.time_ < 0 + var_21_11 + arg_21_0 and not isNil(var_21_10) and arg_18_1.var_.characterEffect1024ui_story then
				arg_18_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_18_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_21_12 = 0
			local var_21_13 = 0.575

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_12 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_14 = arg_18_1:GetWordFromCfg(411171004)
				local var_21_15 = arg_18_1:FormatText(var_21_14.content)

				arg_18_1.text_.text = var_21_15

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_17 = 23 <= 0 and var_21_13 or var_21_13 * (utf8.len(var_21_15) / 23)

				if (23 <= 0 and var_21_13 or var_21_13 * (utf8.len(var_21_15) / 23)) > 0 and var_21_13 < var_21_17 then
					arg_18_1.talkMaxDuration = var_21_17

					if var_21_17 + var_21_12 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_17 + var_21_12
					end
				end

				arg_18_1.text_.text = var_21_15
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171004", "story_v_out_411171.awb") ~= 0 then
					local var_21_18 = manager.audio:GetVoiceLength("story_v_out_411171", "411171004", "story_v_out_411171.awb") / 1000

					if var_21_18 + var_21_12 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_18 + var_21_12
					end

					if var_21_14.prefab_name ~= "" and arg_18_1.actors_[var_21_14.prefab_name] ~= nil then
						local var_21_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_14.prefab_name].transform, "story_v_out_411171", "411171004", "story_v_out_411171.awb")

						arg_18_1:RecordAudio("411171004", var_21_19)
						arg_18_1:RecordAudio("411171004", var_21_19)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_411171", "411171004", "story_v_out_411171.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_411171", "411171004", "story_v_out_411171.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_20 = math.max(var_21_13, arg_18_1.talkMaxDuration)

			if var_21_12 <= arg_18_1.time_ and arg_18_1.time_ < var_21_12 + var_21_20 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_12) / var_21_20

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_12 + var_21_20 and arg_18_1.time_ < var_21_12 + var_21_20 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
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
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play411171005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 411171005
		arg_22_1.duration_ = 3.6

		local var_22_0 = {
			zh = 3.6,
			ja = 2.833
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play411171006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos2078ui_story = arg_22_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_25_0 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 then
				arg_22_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_22_1.time_ - 0) / var_25_0)
				arg_22_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["2078ui_story"].transform.position).z)
				arg_22_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["2078ui_story"].transform.localEulerAngles = arg_22_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 then
				arg_22_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_22_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["2078ui_story"].transform.position).z)
				arg_22_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["2078ui_story"].transform.localEulerAngles = arg_22_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_25_1 = arg_22_1.actors_["2078ui_story"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_1) and arg_22_1.var_.characterEffect2078ui_story == nil then
				arg_22_1.var_.characterEffect2078ui_story = var_25_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.200000002980232

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_2 and not isNil(var_25_1) then
				if arg_22_1.var_.characterEffect2078ui_story and not isNil(var_25_1) then
					arg_22_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_22_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_22_1.time_ - 0) / var_25_2)
				end
			end

			if arg_22_1.time_ >= 0 + var_25_2 and arg_22_1.time_ < 0 + var_25_2 + arg_25_0 and not isNil(var_25_1) and arg_22_1.var_.characterEffect2078ui_story then
				arg_22_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_22_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_25_3 = arg_22_1.actors_["1024ui_story"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1024ui_story = var_25_3.localPosition
			end

			local var_25_4 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				var_25_3.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1024ui_story, Vector3.New(-0.7, -1, -6.05), (arg_22_1.time_ - 0) / var_25_4)
				var_25_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_3.position).x, (manager.ui.mainCamera.transform.position - var_25_3.position).y, (manager.ui.mainCamera.transform.position - var_25_3.position).z)
				var_25_3.localEulerAngles.z = 0
				var_25_3.localEulerAngles.x = 0
				var_25_3.localEulerAngles = var_25_3.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				var_25_3.localPosition = Vector3.New(-0.7, -1, -6.05)
				var_25_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_3.position).x, (manager.ui.mainCamera.transform.position - var_25_3.position).y, (manager.ui.mainCamera.transform.position - var_25_3.position).z)
				var_25_3.localEulerAngles.z = 0
				var_25_3.localEulerAngles.x = 0
				var_25_3.localEulerAngles = var_25_3.localEulerAngles
			end

			local var_25_5 = arg_22_1.actors_["1024ui_story"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_5) and arg_22_1.var_.characterEffect1024ui_story == nil then
				arg_22_1.var_.characterEffect1024ui_story = var_25_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_6 = 0.200000002980232

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_6 and not isNil(var_25_5) then
				if arg_22_1.var_.characterEffect1024ui_story and not isNil(var_25_5) then
					arg_22_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= 0 + var_25_6 and arg_22_1.time_ < 0 + var_25_6 + arg_25_0 and not isNil(var_25_5) and arg_22_1.var_.characterEffect1024ui_story then
				arg_22_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_25_8 = 0
			local var_25_9 = 0.55

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_10 = arg_22_1:GetWordFromCfg(411171005)
				local var_25_11 = arg_22_1:FormatText(var_25_10.content)

				arg_22_1.text_.text = var_25_11

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 22 <= 0 and var_25_9 or var_25_9 * (utf8.len(var_25_11) / 22)

				if (22 <= 0 and var_25_9 or var_25_9 * (utf8.len(var_25_11) / 22)) > 0 and var_25_9 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_8
					end
				end

				arg_22_1.text_.text = var_25_11
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171005", "story_v_out_411171.awb") ~= 0 then
					local var_25_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171005", "story_v_out_411171.awb") / 1000

					if var_25_14 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_14 + var_25_8
					end

					if var_25_10.prefab_name ~= "" and arg_22_1.actors_[var_25_10.prefab_name] ~= nil then
						local var_25_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_10.prefab_name].transform, "story_v_out_411171", "411171005", "story_v_out_411171.awb")

						arg_22_1:RecordAudio("411171005", var_25_15)
						arg_22_1:RecordAudio("411171005", var_25_15)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_411171", "411171005", "story_v_out_411171.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_411171", "411171005", "story_v_out_411171.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_16 = math.max(var_25_9, arg_22_1.talkMaxDuration)

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_16 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_8) / var_25_16

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_8 + var_25_16 and arg_22_1.time_ < var_25_8 + var_25_16 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
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
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play411171006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 411171006
		arg_26_1.duration_ = 5.43

		local var_26_0 = {
			zh = 5.433,
			ja = 3.733
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play411171007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["1024ui_story"]) and arg_26_1.var_.characterEffect1024ui_story == nil then
				arg_26_1.var_.characterEffect1024ui_story = arg_26_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["1024ui_story"]) then
				if arg_26_1.var_.characterEffect1024ui_story and not isNil(arg_26_1.actors_["1024ui_story"]) then
					arg_26_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_0)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["1024ui_story"]) and arg_26_1.var_.characterEffect1024ui_story then
				arg_26_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_29_1 = arg_26_1.actors_["2078ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect2078ui_story == nil then
				arg_26_1.var_.characterEffect2078ui_story = var_29_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_2 and not isNil(var_29_1) then
				if arg_26_1.var_.characterEffect2078ui_story and not isNil(var_29_1) then
					arg_26_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_2 and arg_26_1.time_ < 0 + var_29_2 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect2078ui_story then
				arg_26_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_29_4 = 0
			local var_29_5 = 0.75

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(411171006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 30 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 30)

				if (30 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 30)) > 0 and var_29_5 < var_29_9 then
					arg_26_1.talkMaxDuration = var_29_9

					if var_29_9 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171006", "story_v_out_411171.awb") ~= 0 then
					local var_29_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171006", "story_v_out_411171.awb") / 1000

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end

					if var_29_6.prefab_name ~= "" and arg_26_1.actors_[var_29_6.prefab_name] ~= nil then
						local var_29_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_6.prefab_name].transform, "story_v_out_411171", "411171006", "story_v_out_411171.awb")

						arg_26_1:RecordAudio("411171006", var_29_11)
						arg_26_1:RecordAudio("411171006", var_29_11)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_411171", "411171006", "story_v_out_411171.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_411171", "411171006", "story_v_out_411171.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_12 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_12 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_12

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_12 and arg_26_1.time_ < var_29_4 + var_29_12 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play411171007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 411171007
		arg_30_1.duration_ = 1.13

		local var_30_0 = {
			zh = 0.999999999999,
			ja = 1.133
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play411171008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["2078ui_story"]) and arg_30_1.var_.characterEffect2078ui_story == nil then
				arg_30_1.var_.characterEffect2078ui_story = arg_30_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["2078ui_story"]) then
				if arg_30_1.var_.characterEffect2078ui_story and not isNil(arg_30_1.actors_["2078ui_story"]) then
					arg_30_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_30_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_0)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["2078ui_story"]) and arg_30_1.var_.characterEffect2078ui_story then
				arg_30_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_30_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_33_1 = arg_30_1.actors_["1024ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect1024ui_story == nil then
				arg_30_1.var_.characterEffect1024ui_story = var_33_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_2 and not isNil(var_33_1) then
				if arg_30_1.var_.characterEffect1024ui_story and not isNil(var_33_1) then
					arg_30_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_2 and arg_30_1.time_ < 0 + var_33_2 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect1024ui_story then
				arg_30_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_33_4 = 0
			local var_33_5 = 0.05

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(411171007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 2 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 2)

				if (2 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 2)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171007", "story_v_out_411171.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171007", "story_v_out_411171.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_out_411171", "411171007", "story_v_out_411171.awb")

						arg_30_1:RecordAudio("411171007", var_33_11)
						arg_30_1:RecordAudio("411171007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_411171", "411171007", "story_v_out_411171.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_411171", "411171007", "story_v_out_411171.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play411171008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 411171008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play411171009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos2078ui_story = arg_34_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_0)
				arg_34_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["2078ui_story"].transform.position).z)
				arg_34_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["2078ui_story"].transform.localEulerAngles = arg_34_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["2078ui_story"].transform.position).z)
				arg_34_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["2078ui_story"].transform.localEulerAngles = arg_34_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_37_1 = arg_34_1.actors_["2078ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect2078ui_story == nil then
				arg_34_1.var_.characterEffect2078ui_story = var_37_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_2 and not isNil(var_37_1) then
				if arg_34_1.var_.characterEffect2078ui_story and not isNil(var_37_1) then
					arg_34_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_34_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_2)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_2 and arg_34_1.time_ < 0 + var_37_2 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect2078ui_story then
				arg_34_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_34_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_37_3 = arg_34_1.actors_["1024ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1024ui_story = var_37_3.localPosition
			end

			local var_37_4 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_3.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_4)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_3.localPosition = Vector3.New(0, 100, 0)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			local var_37_5 = arg_34_1.actors_["1024ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1024ui_story == nil then
				arg_34_1.var_.characterEffect1024ui_story = var_37_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_6 and not isNil(var_37_5) then
				if arg_34_1.var_.characterEffect1024ui_story and not isNil(var_37_5) then
					arg_34_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_6)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_6 and arg_34_1.time_ < 0 + var_37_6 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1024ui_story then
				arg_34_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_37_7 = 0
			local var_37_8 = 0.85

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_7 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_9 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(411171008).content)

				arg_34_1.text_.text = var_37_9

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 34 <= 0 and var_37_8 or var_37_8 * (utf8.len(var_37_9) / 34)

				if (34 <= 0 and var_37_8 or var_37_8 * (utf8.len(var_37_9) / 34)) > 0 and var_37_8 < var_37_11 then
					arg_34_1.talkMaxDuration = var_37_11

					if var_37_11 + var_37_7 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_7
					end
				end

				arg_34_1.text_.text = var_37_9
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_8, arg_34_1.talkMaxDuration)

			if var_37_7 <= arg_34_1.time_ and arg_34_1.time_ < var_37_7 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_7) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_7 + var_37_12 and arg_34_1.time_ < var_37_7 + var_37_12 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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
				actorName = "1024ui_story",
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
	Play411171009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 411171009
		arg_38_1.duration_ = 5.75

		local var_38_0 = {
			zh = 5.41666666666667,
			ja = 5.74966666666667
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play411171010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 3.30274141416885 < arg_38_1.time_ and arg_38_1.time_ <= 3.30274141416885 + arg_41_0 then
				arg_38_1.var_.moveOldPos2078ui_story = arg_38_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_41_0 = 0.001

			if 3.30274141416885 <= arg_38_1.time_ and arg_38_1.time_ < 3.30274141416885 + var_41_0 then
				arg_38_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_38_1.time_ - 3.30274141416885) / var_41_0)
				arg_38_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["2078ui_story"].transform.position).z)
				arg_38_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["2078ui_story"].transform.localEulerAngles = arg_38_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 3.30274141416885 + var_41_0 and arg_38_1.time_ < 3.30274141416885 + var_41_0 + arg_41_0 then
				arg_38_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_38_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["2078ui_story"].transform.position).z)
				arg_38_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["2078ui_story"].transform.localEulerAngles = arg_38_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_41_1 = arg_38_1.actors_["2078ui_story"]

			if 3.30274141416885 < arg_38_1.time_ and arg_38_1.time_ <= 3.30274141416885 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect2078ui_story == nil then
				arg_38_1.var_.characterEffect2078ui_story = var_41_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if 3.30274141416885 <= arg_38_1.time_ and arg_38_1.time_ < 3.30274141416885 + var_41_2 and not isNil(var_41_1) then
				if arg_38_1.var_.characterEffect2078ui_story and not isNil(var_41_1) then
					arg_38_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 3.30274141416885 + var_41_2 and arg_38_1.time_ < 3.30274141416885 + var_41_2 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect2078ui_story then
				arg_38_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 3.30274141416885 < arg_38_1.time_ and arg_38_1.time_ <= 3.30274141416885 + arg_41_0 then
				arg_38_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 3.30274141416885 < arg_38_1.time_ and arg_38_1.time_ <= 3.30274141416885 + arg_41_0 then
				arg_38_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 2 < arg_38_1.time_ and arg_38_1.time_ <= 2 + arg_41_0 then
				local var_41_4 = arg_38_1.bgs_.B10b

				arg_38_1.bgs_.B10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_41_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_5 = var_41_4:GetComponent("SpriteRenderer")

				if var_41_5 and var_41_5.sprite then
					local var_41_6 = 2 * (var_41_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_41_4.transform.localScale = Vector3.New(var_41_6 / var_41_5.sprite.bounds.size.y < var_41_6 * manager.ui.mainCameraCom_.aspect / var_41_5.sprite.bounds.size.x and var_41_6 * manager.ui.mainCameraCom_.aspect / var_41_5.sprite.bounds.size.x or var_41_6 / var_41_5.sprite.bounds.size.y, var_41_6 / var_41_5.sprite.bounds.size.y < var_41_6 * manager.ui.mainCameraCom_.aspect / var_41_5.sprite.bounds.size.x and var_41_6 * manager.ui.mainCameraCom_.aspect / var_41_5.sprite.bounds.size.x or var_41_6 / var_41_5.sprite.bounds.size.y, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "B10b" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_7 = 0

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_8 = 2

			if var_41_7 <= arg_38_1.time_ and arg_38_1.time_ < var_41_7 + var_41_8 then
				local var_41_9 = Color.New(0, 0, 0)

				var_41_9.a = Mathf.Lerp(0, 1, (arg_38_1.time_ - var_41_7) / var_41_8)
				arg_38_1.mask_.color = var_41_9
			end

			if arg_38_1.time_ >= var_41_7 + var_41_8 and arg_38_1.time_ < var_41_7 + var_41_8 + arg_41_0 then
				local var_41_10 = Color.New(0, 0, 0)

				var_41_10.a = 1
				arg_38_1.mask_.color = var_41_10
			end

			local var_41_11 = 2

			if 2 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_12 = 1.41666666666667

			if var_41_11 <= arg_38_1.time_ and arg_38_1.time_ < var_41_11 + var_41_12 then
				local var_41_13 = Color.New(0, 0, 0)

				var_41_13.a = Mathf.Lerp(1, 0, (arg_38_1.time_ - var_41_11) / var_41_12)
				arg_38_1.mask_.color = var_41_13
			end

			if arg_38_1.time_ >= var_41_11 + var_41_12 and arg_38_1.time_ < var_41_11 + var_41_12 + arg_41_0 then
				local var_41_14 = Color.New(0, 0, 0)

				arg_38_1.mask_.enabled = false
				var_41_14.a = 0
				arg_38_1.mask_.color = var_41_14
			end

			local var_41_15 = arg_38_1.actors_["2078ui_story"].transform

			if 2 < arg_38_1.time_ and arg_38_1.time_ <= 2 + arg_41_0 then
				arg_38_1.var_.moveOldPos2078ui_story = var_41_15.localPosition
			end

			local var_41_16 = 0.001

			if 2 <= arg_38_1.time_ and arg_38_1.time_ < 2 + var_41_16 then
				var_41_15.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_38_1.time_ - 2) / var_41_16)
				var_41_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_15.position).x, (manager.ui.mainCamera.transform.position - var_41_15.position).y, (manager.ui.mainCamera.transform.position - var_41_15.position).z)
				var_41_15.localEulerAngles.z = 0
				var_41_15.localEulerAngles.x = 0
				var_41_15.localEulerAngles = var_41_15.localEulerAngles
			end

			if arg_38_1.time_ >= 2 + var_41_16 and arg_38_1.time_ < 2 + var_41_16 + arg_41_0 then
				var_41_15.localPosition = Vector3.New(0, 100, 0)
				var_41_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_15.position).x, (manager.ui.mainCamera.transform.position - var_41_15.position).y, (manager.ui.mainCamera.transform.position - var_41_15.position).z)
				var_41_15.localEulerAngles.z = 0
				var_41_15.localEulerAngles.x = 0
				var_41_15.localEulerAngles = var_41_15.localEulerAngles
			end

			local var_41_17 = arg_38_1.actors_["1024ui_story"].transform

			if 2 < arg_38_1.time_ and arg_38_1.time_ <= 2 + arg_41_0 then
				arg_38_1.var_.moveOldPos1024ui_story = var_41_17.localPosition
			end

			local var_41_18 = 0.001

			if 2 <= arg_38_1.time_ and arg_38_1.time_ < 2 + var_41_18 then
				var_41_17.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_38_1.time_ - 2) / var_41_18)
				var_41_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_17.position).x, (manager.ui.mainCamera.transform.position - var_41_17.position).y, (manager.ui.mainCamera.transform.position - var_41_17.position).z)
				var_41_17.localEulerAngles.z = 0
				var_41_17.localEulerAngles.x = 0
				var_41_17.localEulerAngles = var_41_17.localEulerAngles
			end

			if arg_38_1.time_ >= 2 + var_41_18 and arg_38_1.time_ < 2 + var_41_18 + arg_41_0 then
				var_41_17.localPosition = Vector3.New(0, 100, 0)
				var_41_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_17.position).x, (manager.ui.mainCamera.transform.position - var_41_17.position).y, (manager.ui.mainCamera.transform.position - var_41_17.position).z)
				var_41_17.localEulerAngles.z = 0
				var_41_17.localEulerAngles.x = 0
				var_41_17.localEulerAngles = var_41_17.localEulerAngles
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_19 = 3.41666666666667
			local var_41_20 = 0.275

			if 3.41666666666667 < arg_38_1.time_ and arg_38_1.time_ <= var_41_19 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_21 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_21:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_38_1.dialogCg_.alpha = arg_42_0
				end))
				var_41_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_22 = arg_38_1:GetWordFromCfg(411171009)
				local var_41_23 = arg_38_1:FormatText(var_41_22.content)

				arg_38_1.text_.text = var_41_23

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_25 = 11 <= 0 and var_41_20 or var_41_20 * (utf8.len(var_41_23) / 11)

				if (11 <= 0 and var_41_20 or var_41_20 * (utf8.len(var_41_23) / 11)) > 0 and var_41_20 < var_41_25 then
					arg_38_1.talkMaxDuration = var_41_25
					var_41_19 = var_41_19 + 0.3

					if var_41_25 + var_41_19 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_25 + var_41_19
					end
				end

				arg_38_1.text_.text = var_41_23
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171009", "story_v_out_411171.awb") ~= 0 then
					local var_41_26 = manager.audio:GetVoiceLength("story_v_out_411171", "411171009", "story_v_out_411171.awb") / 1000

					if var_41_26 + var_41_19 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_26 + var_41_19
					end

					if var_41_22.prefab_name ~= "" and arg_38_1.actors_[var_41_22.prefab_name] ~= nil then
						local var_41_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_22.prefab_name].transform, "story_v_out_411171", "411171009", "story_v_out_411171.awb")

						arg_38_1:RecordAudio("411171009", var_41_27)
						arg_38_1:RecordAudio("411171009", var_41_27)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_411171", "411171009", "story_v_out_411171.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_411171", "411171009", "story_v_out_411171.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_28 = var_41_19 + 0.3
			local var_41_29 = math.max(var_41_20, arg_38_1.talkMaxDuration)

			if var_41_19 + 0.3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_28 + var_41_29 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_28) / var_41_29

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_28 + var_41_29 and arg_38_1.time_ < var_41_28 + var_41_29 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.30274141416885,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play411171010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 411171010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play411171011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1024ui_story = arg_44_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1024ui_story"].transform.position).z)
				arg_44_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1024ui_story"].transform.localEulerAngles = arg_44_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1024ui_story"].transform.position).z)
				arg_44_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1024ui_story"].transform.localEulerAngles = arg_44_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1024ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1024ui_story == nil then
				arg_44_1.var_.characterEffect1024ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1024ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_2)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1024ui_story then
				arg_44_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_47_3 = arg_44_1.actors_["2078ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos2078ui_story = var_47_3.localPosition
			end

			local var_47_4 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				var_47_3.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_4)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				var_47_3.localPosition = Vector3.New(0, 100, 0)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			local var_47_5 = arg_44_1.actors_["2078ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect2078ui_story == nil then
				arg_44_1.var_.characterEffect2078ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_6 and not isNil(var_47_5) then
				if arg_44_1.var_.characterEffect2078ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_44_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_6)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_6 and arg_44_1.time_ < 0 + var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect2078ui_story then
				arg_44_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_44_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_47_7 = 0
			local var_47_8 = 0.825

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(411171010).content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 33 <= 0 and var_47_8 or var_47_8 * (utf8.len(var_47_9) / 33)

				if (33 <= 0 and var_47_8 or var_47_8 * (utf8.len(var_47_9) / 33)) > 0 and var_47_8 < var_47_11 then
					arg_44_1.talkMaxDuration = var_47_11

					if var_47_11 + var_47_7 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_7
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_8, arg_44_1.talkMaxDuration)

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_7) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_7 + var_47_12 and arg_44_1.time_ < var_47_7 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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

		arg_44_1:InitPlayNodeList()
	end,
	Play411171011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 411171011
		arg_48_1.duration_ = 2

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play411171012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1024ui_story = arg_48_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1024ui_story"].transform.position).z)
				arg_48_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1024ui_story"].transform.localEulerAngles = arg_48_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_48_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1024ui_story"].transform.position).z)
				arg_48_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1024ui_story"].transform.localEulerAngles = arg_48_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1024ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1024ui_story == nil then
				arg_48_1.var_.characterEffect1024ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1024ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1024ui_story then
				arg_48_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_51_4 = 0
			local var_51_5 = 0.125

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(411171011)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 5 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 5)

				if (5 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 5)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171011", "story_v_out_411171.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171011", "story_v_out_411171.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_411171", "411171011", "story_v_out_411171.awb")

						arg_48_1:RecordAudio("411171011", var_51_11)
						arg_48_1:RecordAudio("411171011", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_411171", "411171011", "story_v_out_411171.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_411171", "411171011", "story_v_out_411171.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play411171012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 411171012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play411171013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1024ui_story = arg_52_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1024ui_story"].transform.position).z)
				arg_52_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1024ui_story"].transform.localEulerAngles = arg_52_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1024ui_story"].transform.position).z)
				arg_52_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1024ui_story"].transform.localEulerAngles = arg_52_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1024ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1024ui_story == nil then
				arg_52_1.var_.characterEffect1024ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1024ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_2)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1024ui_story then
				arg_52_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_55_3 = arg_52_1.actors_["2078ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos2078ui_story = var_55_3.localPosition
			end

			local var_55_4 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_4)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(0, 100, 0)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			local var_55_5 = arg_52_1.actors_["2078ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect2078ui_story == nil then
				arg_52_1.var_.characterEffect2078ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_6 and not isNil(var_55_5) then
				if arg_52_1.var_.characterEffect2078ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_52_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_6)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_6 and arg_52_1.time_ < 0 + var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect2078ui_story then
				arg_52_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_52_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_55_7 = 0
			local var_55_8 = 1.1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(411171012).content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 44 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_9) / 44)

				if (44 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_9) / 44)) > 0 and var_55_8 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_7 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_7
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_8, arg_52_1.talkMaxDuration)

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_7) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_7 + var_55_12 and arg_52_1.time_ < var_55_7 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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

		arg_52_1:InitPlayNodeList()
	end,
	Play411171013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 411171013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play411171014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.875

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(411171013).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 35 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 35)

				if (35 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 35)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play411171014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 411171014
		arg_60_1.duration_ = 5.67

		local var_60_0 = {
			zh = 4.6,
			ja = 5.666
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play411171015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos2078ui_story = arg_60_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["2078ui_story"].transform.position).z)
				arg_60_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["2078ui_story"].transform.localEulerAngles = arg_60_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_60_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["2078ui_story"].transform.position).z)
				arg_60_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["2078ui_story"].transform.localEulerAngles = arg_60_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["2078ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect2078ui_story == nil then
				arg_60_1.var_.characterEffect2078ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect2078ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect2078ui_story then
				arg_60_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_4 = 0
			local var_63_5 = 0.625

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(411171014)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 25 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 25)

				if (25 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 25)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171014", "story_v_out_411171.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171014", "story_v_out_411171.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_411171", "411171014", "story_v_out_411171.awb")

						arg_60_1:RecordAudio("411171014", var_63_11)
						arg_60_1:RecordAudio("411171014", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_411171", "411171014", "story_v_out_411171.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_411171", "411171014", "story_v_out_411171.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play411171015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 411171015
		arg_64_1.duration_ = 2.7

		local var_64_0 = {
			zh = 2.36666666666667,
			ja = 2.69966666666667
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play411171016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1024ui_story = arg_64_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1024ui_story"].transform.position).z)
				arg_64_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1024ui_story"].transform.localEulerAngles = arg_64_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_64_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1024ui_story"].transform.position).z)
				arg_64_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1024ui_story"].transform.localEulerAngles = arg_64_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1024ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1024ui_story == nil then
				arg_64_1.var_.characterEffect1024ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect1024ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1024ui_story then
				arg_64_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_67_4 = arg_64_1.actors_["2078ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos2078ui_story = var_67_4.localPosition
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_4.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_5)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_4.localPosition = Vector3.New(0, 100, 0)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			local var_67_6 = arg_64_1.actors_["2078ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_6) and arg_64_1.var_.characterEffect2078ui_story == nil then
				arg_64_1.var_.characterEffect2078ui_story = var_67_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_7 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 and not isNil(var_67_6) then
				if arg_64_1.var_.characterEffect2078ui_story and not isNil(var_67_6) then
					arg_64_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_64_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_7)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 and not isNil(var_67_6) and arg_64_1.var_.characterEffect2078ui_story then
				arg_64_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_64_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_8 = 0.566666666666667
			local var_67_9 = 0.3

			if 0.566666666666667 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_10 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_10:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_11 = arg_64_1:GetWordFromCfg(411171015)
				local var_67_12 = arg_64_1:FormatText(var_67_11.content)

				arg_64_1.text_.text = var_67_12

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_14 = 12 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_12) / 12)

				if (12 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_12) / 12)) > 0 and var_67_9 < var_67_14 then
					arg_64_1.talkMaxDuration = var_67_14
					var_67_8 = var_67_8 + 0.3

					if var_67_14 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_8
					end
				end

				arg_64_1.text_.text = var_67_12
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171015", "story_v_out_411171.awb") ~= 0 then
					local var_67_15 = manager.audio:GetVoiceLength("story_v_out_411171", "411171015", "story_v_out_411171.awb") / 1000

					if var_67_15 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_8
					end

					if var_67_11.prefab_name ~= "" and arg_64_1.actors_[var_67_11.prefab_name] ~= nil then
						local var_67_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_11.prefab_name].transform, "story_v_out_411171", "411171015", "story_v_out_411171.awb")

						arg_64_1:RecordAudio("411171015", var_67_16)
						arg_64_1:RecordAudio("411171015", var_67_16)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_411171", "411171015", "story_v_out_411171.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_411171", "411171015", "story_v_out_411171.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_17 = var_67_8 + 0.3
			local var_67_18 = math.max(var_67_9, arg_64_1.talkMaxDuration)

			if var_67_8 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_17) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_17 + var_67_18 and arg_64_1.time_ < var_67_17 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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

		arg_64_1:InitPlayNodeList()
	end,
	Play411171016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 411171016
		arg_70_1.duration_ = 11.5

		local var_70_0 = {
			zh = 11.2,
			ja = 11.5
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play411171017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.bgs_.ST75 == nil then
				local var_73_0 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST75")
				var_73_0.name = "ST75"
				var_73_0.transform.parent = arg_70_1.stage_.transform
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_.ST75 = var_73_0
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				local var_73_1 = arg_70_1.bgs_.ST75

				arg_70_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_2 = var_73_1:GetComponent("SpriteRenderer")

				if var_73_2 and var_73_2.sprite then
					local var_73_3 = 2 * (var_73_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_1.transform.localScale = Vector3.New(var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST75" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_4 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_5 = 2

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_5 then
				local var_73_6 = Color.New(0, 0, 0)

				var_73_6.a = Mathf.Lerp(0, 1, (arg_70_1.time_ - var_73_4) / var_73_5)
				arg_70_1.mask_.color = var_73_6
			end

			if arg_70_1.time_ >= var_73_4 + var_73_5 and arg_70_1.time_ < var_73_4 + var_73_5 + arg_73_0 then
				local var_73_7 = Color.New(0, 0, 0)

				var_73_7.a = 1
				arg_70_1.mask_.color = var_73_7
			end

			local var_73_8 = 2

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_9 = 2

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_9 then
				local var_73_10 = Color.New(0, 0, 0)

				var_73_10.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_8) / var_73_9)
				arg_70_1.mask_.color = var_73_10
			end

			if arg_70_1.time_ >= var_73_8 + var_73_9 and arg_70_1.time_ < var_73_8 + var_73_9 + arg_73_0 then
				local var_73_11 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_11.a = 0
				arg_70_1.mask_.color = var_73_11
			end

			local var_73_12 = arg_70_1.actors_["1024ui_story"].transform

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				arg_70_1.var_.moveOldPos1024ui_story = var_73_12.localPosition
			end

			local var_73_13 = 0.001

			if 2 <= arg_70_1.time_ and arg_70_1.time_ < 2 + var_73_13 then
				var_73_12.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 2) / var_73_13)
				var_73_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_12.position).x, (manager.ui.mainCamera.transform.position - var_73_12.position).y, (manager.ui.mainCamera.transform.position - var_73_12.position).z)
				var_73_12.localEulerAngles.z = 0
				var_73_12.localEulerAngles.x = 0
				var_73_12.localEulerAngles = var_73_12.localEulerAngles
			end

			if arg_70_1.time_ >= 2 + var_73_13 and arg_70_1.time_ < 2 + var_73_13 + arg_73_0 then
				var_73_12.localPosition = Vector3.New(0, 100, 0)
				var_73_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_12.position).x, (manager.ui.mainCamera.transform.position - var_73_12.position).y, (manager.ui.mainCamera.transform.position - var_73_12.position).z)
				var_73_12.localEulerAngles.z = 0
				var_73_12.localEulerAngles.x = 0
				var_73_12.localEulerAngles = var_73_12.localEulerAngles
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				if arg_70_1.var_.effect工厂雨 then
					Object.Destroy(arg_70_1.var_.effect工厂雨)

					arg_70_1.var_.effect工厂雨 = nil
				end
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_15 = 4
			local var_73_16 = 0.875

			if 4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_17 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_17:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_18 = arg_70_1:GetWordFromCfg(411171016)
				local var_73_19 = arg_70_1:FormatText(var_73_18.content)

				arg_70_1.text_.text = var_73_19

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_21 = 35 <= 0 and var_73_16 or var_73_16 * (utf8.len(var_73_19) / 35)

				if (35 <= 0 and var_73_16 or var_73_16 * (utf8.len(var_73_19) / 35)) > 0 and var_73_16 < var_73_21 then
					arg_70_1.talkMaxDuration = var_73_21
					var_73_15 = var_73_15 + 0.3

					if var_73_21 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_21 + var_73_15
					end
				end

				arg_70_1.text_.text = var_73_19
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171016", "story_v_out_411171.awb") ~= 0 then
					local var_73_22 = manager.audio:GetVoiceLength("story_v_out_411171", "411171016", "story_v_out_411171.awb") / 1000

					if var_73_22 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_22 + var_73_15
					end

					if var_73_18.prefab_name ~= "" and arg_70_1.actors_[var_73_18.prefab_name] ~= nil then
						local var_73_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_18.prefab_name].transform, "story_v_out_411171", "411171016", "story_v_out_411171.awb")

						arg_70_1:RecordAudio("411171016", var_73_23)
						arg_70_1:RecordAudio("411171016", var_73_23)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_411171", "411171016", "story_v_out_411171.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_411171", "411171016", "story_v_out_411171.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_24 = var_73_15 + 0.3
			local var_73_25 = math.max(var_73_16, arg_70_1.talkMaxDuration)

			if var_73_15 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_24 + var_73_25 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_24) / var_73_25

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_24 + var_73_25 and arg_70_1.time_ < var_73_24 + var_73_25 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play411171017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 411171017
		arg_76_1.duration_ = 3.2

		local var_76_0 = {
			zh = 3.2,
			ja = 1.3
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play411171018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_79_0 = 0.6

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				local var_79_1, var_79_2 = math.modf((arg_76_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_79_2 * 0.13, var_79_2 * 0.13, var_79_2 * 0.13) + arg_76_1.var_.shakeOldPos
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				manager.ui.mainCamera.transform.localPosition = arg_76_1.var_.shakeOldPos
			end

			local var_79_3 = 0

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			if arg_76_1.time_ >= var_79_3 + 0.6 and arg_76_1.time_ < var_79_3 + 0.6 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_4 = 0
			local var_79_5 = 0.175

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_6 = arg_76_1:GetWordFromCfg(411171017)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 7 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 7)

				if (7 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 7)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171017", "story_v_out_411171.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171017", "story_v_out_411171.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_411171", "411171017", "story_v_out_411171.awb")

						arg_76_1:RecordAudio("411171017", var_79_11)
						arg_76_1:RecordAudio("411171017", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_411171", "411171017", "story_v_out_411171.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_411171", "411171017", "story_v_out_411171.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play411171018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411171018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play411171019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if arg_80_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_83_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_80_1.stage_.transform)

				var_83_0.name = "4010ui_story"
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["4010ui_story"] = var_83_0

				local var_83_1 = var_83_0:GetComponentInChildren(typeof(CharacterEffect))

				var_83_1.enabled = true

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_1.transform, false)

				arg_80_1.var_["4010ui_story" .. "Animator"] = var_83_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_80_1.var_["4010ui_story" .. "LipSync"] = var_83_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_3 = arg_80_1.actors_["4010ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos4010ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0, 100, 0)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			local var_83_5 = arg_80_1.actors_["4010ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect4010ui_story == nil then
				arg_80_1.var_.characterEffect4010ui_story = var_83_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_6 and not isNil(var_83_5) then
				if arg_80_1.var_.characterEffect4010ui_story and not isNil(var_83_5) then
					arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_80_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_6)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_6 and arg_80_1.time_ < 0 + var_83_6 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect4010ui_story then
				arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_80_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_83_7 = 0
			local var_83_8 = 1.125

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_9 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(411171018).content)

				arg_80_1.text_.text = var_83_9

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 45 <= 0 and var_83_8 or var_83_8 * (utf8.len(var_83_9) / 45)

				if (45 <= 0 and var_83_8 or var_83_8 * (utf8.len(var_83_9) / 45)) > 0 and var_83_8 < var_83_11 then
					arg_80_1.talkMaxDuration = var_83_11

					if var_83_11 + var_83_7 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_7
					end
				end

				arg_80_1.text_.text = var_83_9
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_8, arg_80_1.talkMaxDuration)

			if var_83_7 <= arg_80_1.time_ and arg_80_1.time_ < var_83_7 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_7) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_7 + var_83_12 and arg_80_1.time_ < var_83_7 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play411171019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411171019
		arg_84_1.duration_ = 4

		local var_84_0 = {
			zh = 4,
			ja = 3.3
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play411171020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos4010ui_story = arg_84_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4010ui_story"].transform.position).z)
				arg_84_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["4010ui_story"].transform.localEulerAngles = arg_84_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_84_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4010ui_story"].transform.position).z)
				arg_84_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["4010ui_story"].transform.localEulerAngles = arg_84_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["4010ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect4010ui_story == nil then
				arg_84_1.var_.characterEffect4010ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect4010ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect4010ui_story then
				arg_84_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_4 = 0
			local var_87_5 = 0.425

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(411171019)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 17 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 17)

				if (17 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 17)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171019", "story_v_out_411171.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171019", "story_v_out_411171.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_411171", "411171019", "story_v_out_411171.awb")

						arg_84_1:RecordAudio("411171019", var_87_11)
						arg_84_1:RecordAudio("411171019", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_411171", "411171019", "story_v_out_411171.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_411171", "411171019", "story_v_out_411171.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play411171020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411171020
		arg_88_1.duration_ = 7.23

		local var_88_0 = {
			zh = 6,
			ja = 7.233
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play411171021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["4010ui_story"]) and arg_88_1.var_.characterEffect4010ui_story == nil then
				arg_88_1.var_.characterEffect4010ui_story = arg_88_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["4010ui_story"]) then
				if arg_88_1.var_.characterEffect4010ui_story and not isNil(arg_88_1.actors_["4010ui_story"]) then
					arg_88_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_88_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["4010ui_story"]) and arg_88_1.var_.characterEffect4010ui_story then
				arg_88_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_88_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_91_1 = "1095ui_story"

			if arg_88_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_91_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_88_1.stage_.transform)

				var_91_2.name = var_91_1
				var_91_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_[var_91_1] = var_91_2

				local var_91_3 = var_91_2:GetComponentInChildren(typeof(CharacterEffect))

				var_91_3.enabled = true

				local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_2, typeof(DynamicBoneHelper))

				if var_91_4 then
					var_91_4:EnableDynamicBone(false)
				end

				arg_88_1:ShowWeapon(var_91_3.transform, false)

				arg_88_1.var_[var_91_1 .. "Animator"] = var_91_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_88_1.var_[var_91_1 .. "Animator"].applyRootMotion = true
				arg_88_1.var_[var_91_1 .. "LipSync"] = var_91_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_91_5 = arg_88_1.actors_["1095ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1095ui_story == nil then
				arg_88_1.var_.characterEffect1095ui_story = var_91_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_6 and not isNil(var_91_5) then
				if arg_88_1.var_.characterEffect1095ui_story and not isNil(var_91_5) then
					arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_6 and arg_88_1.time_ < 0 + var_91_6 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1095ui_story then
				arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_91_8 = arg_88_1.actors_["1095ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1095ui_story = var_91_8.localPosition
			end

			local var_91_9 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_9 then
				var_91_8.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_88_1.time_ - 0) / var_91_9)
				var_91_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_8.position).x, (manager.ui.mainCamera.transform.position - var_91_8.position).y, (manager.ui.mainCamera.transform.position - var_91_8.position).z)
				var_91_8.localEulerAngles.z = 0
				var_91_8.localEulerAngles.x = 0
				var_91_8.localEulerAngles = var_91_8.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_9 and arg_88_1.time_ < 0 + var_91_9 + arg_91_0 then
				var_91_8.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_91_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_8.position).x, (manager.ui.mainCamera.transform.position - var_91_8.position).y, (manager.ui.mainCamera.transform.position - var_91_8.position).z)
				var_91_8.localEulerAngles.z = 0
				var_91_8.localEulerAngles.x = 0
				var_91_8.localEulerAngles = var_91_8.localEulerAngles
			end

			local var_91_10 = 0
			local var_91_11 = 0.625

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_12 = arg_88_1:GetWordFromCfg(411171020)
				local var_91_13 = arg_88_1:FormatText(var_91_12.content)

				arg_88_1.text_.text = var_91_13

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_15 = 25 <= 0 and var_91_11 or var_91_11 * (utf8.len(var_91_13) / 25)

				if (25 <= 0 and var_91_11 or var_91_11 * (utf8.len(var_91_13) / 25)) > 0 and var_91_11 < var_91_15 then
					arg_88_1.talkMaxDuration = var_91_15

					if var_91_15 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_10
					end
				end

				arg_88_1.text_.text = var_91_13
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171020", "story_v_out_411171.awb") ~= 0 then
					local var_91_16 = manager.audio:GetVoiceLength("story_v_out_411171", "411171020", "story_v_out_411171.awb") / 1000

					if var_91_16 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_16 + var_91_10
					end

					if var_91_12.prefab_name ~= "" and arg_88_1.actors_[var_91_12.prefab_name] ~= nil then
						local var_91_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_12.prefab_name].transform, "story_v_out_411171", "411171020", "story_v_out_411171.awb")

						arg_88_1:RecordAudio("411171020", var_91_17)
						arg_88_1:RecordAudio("411171020", var_91_17)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_411171", "411171020", "story_v_out_411171.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_411171", "411171020", "story_v_out_411171.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_18 = math.max(var_91_11, arg_88_1.talkMaxDuration)

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_18 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_10) / var_91_18

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_10 + var_91_18 and arg_88_1.time_ < var_91_10 + var_91_18 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play411171021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411171021
		arg_92_1.duration_ = 3.43

		local var_92_0 = {
			zh = 3.433,
			ja = 2.466
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play411171022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["4010ui_story"]) and arg_92_1.var_.characterEffect4010ui_story == nil then
				arg_92_1.var_.characterEffect4010ui_story = arg_92_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["4010ui_story"]) then
				if arg_92_1.var_.characterEffect4010ui_story and not isNil(arg_92_1.actors_["4010ui_story"]) then
					arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["4010ui_story"]) and arg_92_1.var_.characterEffect4010ui_story then
				arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["1095ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1095ui_story == nil then
				arg_92_1.var_.characterEffect1095ui_story = var_95_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.characterEffect1095ui_story and not isNil(var_95_2) then
					arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_3)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1095ui_story then
				arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_95_4 = 0
			local var_95_5 = 0.35

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(411171021)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 14 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 14)

				if (14 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 14)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171021", "story_v_out_411171.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171021", "story_v_out_411171.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_out_411171", "411171021", "story_v_out_411171.awb")

						arg_92_1:RecordAudio("411171021", var_95_11)
						arg_92_1:RecordAudio("411171021", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_411171", "411171021", "story_v_out_411171.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_411171", "411171021", "story_v_out_411171.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_12 and arg_92_1.time_ < var_95_4 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play411171022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 411171022
		arg_96_1.duration_ = 9.5

		local var_96_0 = {
			zh = 4,
			ja = 9.5
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play411171023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["4010ui_story"]) and arg_96_1.var_.characterEffect4010ui_story == nil then
				arg_96_1.var_.characterEffect4010ui_story = arg_96_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["4010ui_story"]) then
				if arg_96_1.var_.characterEffect4010ui_story and not isNil(arg_96_1.actors_["4010ui_story"]) then
					arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_96_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["4010ui_story"]) and arg_96_1.var_.characterEffect4010ui_story then
				arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_96_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_99_1 = arg_96_1.actors_["1095ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1095ui_story == nil then
				arg_96_1.var_.characterEffect1095ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1095ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1095ui_story then
				arg_96_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_99_4 = 0
			local var_99_5 = 0.575

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(411171022)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 23 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 23)

				if (23 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 23)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171022", "story_v_out_411171.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171022", "story_v_out_411171.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_411171", "411171022", "story_v_out_411171.awb")

						arg_96_1:RecordAudio("411171022", var_99_11)
						arg_96_1:RecordAudio("411171022", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_411171", "411171022", "story_v_out_411171.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_411171", "411171022", "story_v_out_411171.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play411171023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 411171023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play411171024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1095ui_story"]) and arg_100_1.var_.characterEffect1095ui_story == nil then
				arg_100_1.var_.characterEffect1095ui_story = arg_100_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1095ui_story"]) then
				if arg_100_1.var_.characterEffect1095ui_story and not isNil(arg_100_1.actors_["1095ui_story"]) then
					arg_100_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1095ui_story"]) and arg_100_1.var_.characterEffect1095ui_story then
				arg_100_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.925

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(411171023).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 37 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 37)

				if (37 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 37)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play411171024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 411171024
		arg_104_1.duration_ = 7.97

		local var_104_0 = {
			zh = 3.466,
			ja = 7.966
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play411171025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["4010ui_story"]) and arg_104_1.var_.characterEffect4010ui_story == nil then
				arg_104_1.var_.characterEffect4010ui_story = arg_104_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["4010ui_story"]) then
				if arg_104_1.var_.characterEffect4010ui_story and not isNil(arg_104_1.actors_["4010ui_story"]) then
					arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["4010ui_story"]) and arg_104_1.var_.characterEffect4010ui_story then
				arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_107_2 = 0
			local var_107_3 = 0.425

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(411171024)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 17 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 17)

				if (17 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 17)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171024", "story_v_out_411171.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171024", "story_v_out_411171.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_411171", "411171024", "story_v_out_411171.awb")

						arg_104_1:RecordAudio("411171024", var_107_9)
						arg_104_1:RecordAudio("411171024", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_411171", "411171024", "story_v_out_411171.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_411171", "411171024", "story_v_out_411171.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play411171025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 411171025
		arg_108_1.duration_ = 7.5

		local var_108_0 = {
			zh = 7.5,
			ja = 5.9
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play411171026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1095ui_story"]) and arg_108_1.var_.characterEffect1095ui_story == nil then
				arg_108_1.var_.characterEffect1095ui_story = arg_108_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1095ui_story"]) then
				if arg_108_1.var_.characterEffect1095ui_story and not isNil(arg_108_1.actors_["1095ui_story"]) then
					arg_108_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1095ui_story"]) and arg_108_1.var_.characterEffect1095ui_story then
				arg_108_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_111_2 = arg_108_1.actors_["4010ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect4010ui_story == nil then
				arg_108_1.var_.characterEffect4010ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect4010ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect4010ui_story then
				arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_111_4 = 0
			local var_111_5 = 0.95

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(411171025)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 38 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 38)

				if (38 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 38)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171025", "story_v_out_411171.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171025", "story_v_out_411171.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_411171", "411171025", "story_v_out_411171.awb")

						arg_108_1:RecordAudio("411171025", var_111_11)
						arg_108_1:RecordAudio("411171025", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_411171", "411171025", "story_v_out_411171.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_411171", "411171025", "story_v_out_411171.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play411171026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 411171026
		arg_112_1.duration_ = 7.67

		local var_112_0 = {
			zh = 4.533,
			ja = 7.666
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play411171027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.65

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:GetWordFromCfg(411171026)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 26 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 26)

				if (26 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 26)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171026", "story_v_out_411171.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171026", "story_v_out_411171.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_411171", "411171026", "story_v_out_411171.awb")

						arg_112_1:RecordAudio("411171026", var_115_6)
						arg_112_1:RecordAudio("411171026", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_411171", "411171026", "story_v_out_411171.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_411171", "411171026", "story_v_out_411171.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play411171027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 411171027
		arg_116_1.duration_ = 11.9

		local var_116_0 = {
			zh = 7.166,
			ja = 11.9
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play411171028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["4010ui_story"]) and arg_116_1.var_.characterEffect4010ui_story == nil then
				arg_116_1.var_.characterEffect4010ui_story = arg_116_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["4010ui_story"]) then
				if arg_116_1.var_.characterEffect4010ui_story and not isNil(arg_116_1.actors_["4010ui_story"]) then
					arg_116_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["4010ui_story"]) and arg_116_1.var_.characterEffect4010ui_story then
				arg_116_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_119_2 = arg_116_1.actors_["1095ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1095ui_story == nil then
				arg_116_1.var_.characterEffect1095ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.characterEffect1095ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_3)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1095ui_story then
				arg_116_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_119_4 = 0
			local var_119_5 = 0.875

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(411171027)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 35 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 35)

				if (35 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 35)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171027", "story_v_out_411171.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171027", "story_v_out_411171.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_411171", "411171027", "story_v_out_411171.awb")

						arg_116_1:RecordAudio("411171027", var_119_11)
						arg_116_1:RecordAudio("411171027", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_411171", "411171027", "story_v_out_411171.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_411171", "411171027", "story_v_out_411171.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play411171028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 411171028
		arg_120_1.duration_ = 3.87

		local var_120_0 = {
			zh = 1.999999999999,
			ja = 3.866
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
				arg_120_0:Play411171029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["4010ui_story"]) and arg_120_1.var_.characterEffect4010ui_story == nil then
				arg_120_1.var_.characterEffect4010ui_story = arg_120_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["4010ui_story"]) then
				if arg_120_1.var_.characterEffect4010ui_story and not isNil(arg_120_1.actors_["4010ui_story"]) then
					arg_120_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_120_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["4010ui_story"]) and arg_120_1.var_.characterEffect4010ui_story then
				arg_120_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_120_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_123_1 = arg_120_1.actors_["1095ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1095ui_story == nil then
				arg_120_1.var_.characterEffect1095ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect1095ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1095ui_story then
				arg_120_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_123_4 = 0
			local var_123_5 = 0.175

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(411171028)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 7 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 7)

				if (7 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 7)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171028", "story_v_out_411171.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171028", "story_v_out_411171.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_411171", "411171028", "story_v_out_411171.awb")

						arg_120_1:RecordAudio("411171028", var_123_11)
						arg_120_1:RecordAudio("411171028", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_411171", "411171028", "story_v_out_411171.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_411171", "411171028", "story_v_out_411171.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play411171029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 411171029
		arg_124_1.duration_ = 8.33

		local var_124_0 = {
			zh = 5.733,
			ja = 8.333
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play411171030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.825

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(411171029)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 33 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 33)

				if (33 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 33)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171029", "story_v_out_411171.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171029", "story_v_out_411171.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_411171", "411171029", "story_v_out_411171.awb")

						arg_124_1:RecordAudio("411171029", var_127_6)
						arg_124_1:RecordAudio("411171029", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_411171", "411171029", "story_v_out_411171.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_411171", "411171029", "story_v_out_411171.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play411171030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 411171030
		arg_128_1.duration_ = 4.97

		local var_128_0 = {
			zh = 1.999999999999,
			ja = 4.966
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play411171031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["4010ui_story"]) and arg_128_1.var_.characterEffect4010ui_story == nil then
				arg_128_1.var_.characterEffect4010ui_story = arg_128_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["4010ui_story"]) then
				if arg_128_1.var_.characterEffect4010ui_story and not isNil(arg_128_1.actors_["4010ui_story"]) then
					arg_128_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["4010ui_story"]) and arg_128_1.var_.characterEffect4010ui_story then
				arg_128_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1095ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1095ui_story == nil then
				arg_128_1.var_.characterEffect1095ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1095ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1095ui_story then
				arg_128_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_131_4 = 0
			local var_131_5 = 0.2

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(411171030)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 8 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 8)

				if (8 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 8)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171030", "story_v_out_411171.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171030", "story_v_out_411171.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_411171", "411171030", "story_v_out_411171.awb")

						arg_128_1:RecordAudio("411171030", var_131_11)
						arg_128_1:RecordAudio("411171030", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_411171", "411171030", "story_v_out_411171.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_411171", "411171030", "story_v_out_411171.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play411171031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 411171031
		arg_132_1.duration_ = 5.6

		local var_132_0 = {
			zh = 5.6,
			ja = 4.333
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
				arg_132_0:Play411171032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["4010ui_story"]) and arg_132_1.var_.characterEffect4010ui_story == nil then
				arg_132_1.var_.characterEffect4010ui_story = arg_132_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["4010ui_story"]) then
				if arg_132_1.var_.characterEffect4010ui_story and not isNil(arg_132_1.actors_["4010ui_story"]) then
					arg_132_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_132_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["4010ui_story"]) and arg_132_1.var_.characterEffect4010ui_story then
				arg_132_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_132_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_135_1 = arg_132_1.actors_["1095ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1095ui_story == nil then
				arg_132_1.var_.characterEffect1095ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1095ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1095ui_story then
				arg_132_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_4 = 0
			local var_135_5 = 0.725

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(411171031)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 29 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 29)

				if (29 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 29)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171031", "story_v_out_411171.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171031", "story_v_out_411171.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_411171", "411171031", "story_v_out_411171.awb")

						arg_132_1:RecordAudio("411171031", var_135_11)
						arg_132_1:RecordAudio("411171031", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_411171", "411171031", "story_v_out_411171.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_411171", "411171031", "story_v_out_411171.awb")
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

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play411171032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 411171032
		arg_136_1.duration_ = 4.03

		local var_136_0 = {
			zh = 1.999999999999,
			ja = 4.033
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play411171033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["4010ui_story"]) and arg_136_1.var_.characterEffect4010ui_story == nil then
				arg_136_1.var_.characterEffect4010ui_story = arg_136_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["4010ui_story"]) then
				if arg_136_1.var_.characterEffect4010ui_story and not isNil(arg_136_1.actors_["4010ui_story"]) then
					arg_136_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["4010ui_story"]) and arg_136_1.var_.characterEffect4010ui_story then
				arg_136_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1095ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1095ui_story == nil then
				arg_136_1.var_.characterEffect1095ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1095ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1095ui_story then
				arg_136_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_139_4 = 0
			local var_139_5 = 0.175

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(411171032)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 7 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 7)

				if (7 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 7)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171032", "story_v_out_411171.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171032", "story_v_out_411171.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_411171", "411171032", "story_v_out_411171.awb")

						arg_136_1:RecordAudio("411171032", var_139_11)
						arg_136_1:RecordAudio("411171032", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_411171", "411171032", "story_v_out_411171.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_411171", "411171032", "story_v_out_411171.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play411171033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 411171033
		arg_140_1.duration_ = 10.6

		local var_140_0 = {
			zh = 9.7,
			ja = 10.6
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
				arg_140_0:Play411171034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 1.05

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:GetWordFromCfg(411171033)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 42 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 42)

				if (42 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 42)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171033", "story_v_out_411171.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171033", "story_v_out_411171.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_411171", "411171033", "story_v_out_411171.awb")

						arg_140_1:RecordAudio("411171033", var_143_6)
						arg_140_1:RecordAudio("411171033", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_411171", "411171033", "story_v_out_411171.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_411171", "411171033", "story_v_out_411171.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play411171034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 411171034
		arg_144_1.duration_ = 1.87

		local var_144_0 = {
			zh = 0.999999999999,
			ja = 1.866
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
				arg_144_0:Play411171035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["4010ui_story"]) and arg_144_1.var_.characterEffect4010ui_story == nil then
				arg_144_1.var_.characterEffect4010ui_story = arg_144_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["4010ui_story"]) then
				if arg_144_1.var_.characterEffect4010ui_story and not isNil(arg_144_1.actors_["4010ui_story"]) then
					arg_144_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_144_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["4010ui_story"]) and arg_144_1.var_.characterEffect4010ui_story then
				arg_144_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_144_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_147_1 = arg_144_1.actors_["1095ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 and not isNil(var_147_1) then
				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_1) then
					arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1095ui_story then
				arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 0.05

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(411171034)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 2 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 2)

				if (2 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 2)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171034", "story_v_out_411171.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171034", "story_v_out_411171.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_411171", "411171034", "story_v_out_411171.awb")

						arg_144_1:RecordAudio("411171034", var_147_11)
						arg_144_1:RecordAudio("411171034", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_411171", "411171034", "story_v_out_411171.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_411171", "411171034", "story_v_out_411171.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_12 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_12 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_12

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_12 and arg_144_1.time_ < var_147_4 + var_147_12 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play411171035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 411171035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play411171036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1095ui_story = arg_148_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1095ui_story"].transform.position).z)
				arg_148_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1095ui_story"].transform.localEulerAngles = arg_148_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1095ui_story"].transform.position).z)
				arg_148_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1095ui_story"].transform.localEulerAngles = arg_148_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1095ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1095ui_story == nil then
				arg_148_1.var_.characterEffect1095ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect1095ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_2)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1095ui_story then
				arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_151_3 = arg_148_1.actors_["4010ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos4010ui_story = var_151_3.localPosition
			end

			local var_151_4 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				var_151_3.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_4)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				var_151_3.localPosition = Vector3.New(0, 100, 0)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles
			end

			local var_151_5 = arg_148_1.actors_["4010ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_5) and arg_148_1.var_.characterEffect4010ui_story == nil then
				arg_148_1.var_.characterEffect4010ui_story = var_151_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_6 and not isNil(var_151_5) then
				if arg_148_1.var_.characterEffect4010ui_story and not isNil(var_151_5) then
					arg_148_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_148_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_6)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_6 and arg_148_1.time_ < 0 + var_151_6 + arg_151_0 and not isNil(var_151_5) and arg_148_1.var_.characterEffect4010ui_story then
				arg_148_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_148_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_151_7 = 0
			local var_151_8 = 0.4

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(411171035).content)

				arg_148_1.text_.text = var_151_9

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 16 <= 0 and var_151_8 or var_151_8 * (utf8.len(var_151_9) / 16)

				if (16 <= 0 and var_151_8 or var_151_8 * (utf8.len(var_151_9) / 16)) > 0 and var_151_8 < var_151_11 then
					arg_148_1.talkMaxDuration = var_151_11

					if var_151_11 + var_151_7 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_7
					end
				end

				arg_148_1.text_.text = var_151_9
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_8, arg_148_1.talkMaxDuration)

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_7) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_7 + var_151_12 and arg_148_1.time_ < var_151_7 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play411171036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411171036
		arg_152_1.duration_ = 3.37

		local var_152_0 = {
			zh = 2.4,
			ja = 3.366
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
				arg_152_0:Play411171037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1095ui_story = arg_152_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1095ui_story"].transform.position).z)
				arg_152_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1095ui_story"].transform.localEulerAngles = arg_152_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_152_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1095ui_story"].transform.position).z)
				arg_152_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1095ui_story"].transform.localEulerAngles = arg_152_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["1095ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1095ui_story == nil then
				arg_152_1.var_.characterEffect1095ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1095ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1095ui_story then
				arg_152_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_155_4 = 0
			local var_155_5 = 0.3

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(411171036)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 12 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 12)

				if (12 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 12)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171036", "story_v_out_411171.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171036", "story_v_out_411171.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_411171", "411171036", "story_v_out_411171.awb")

						arg_152_1:RecordAudio("411171036", var_155_11)
						arg_152_1:RecordAudio("411171036", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_411171", "411171036", "story_v_out_411171.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_411171", "411171036", "story_v_out_411171.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play411171037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 411171037
		arg_156_1.duration_ = 4.63

		local var_156_0 = {
			zh = 4.2,
			ja = 4.633
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play411171038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_0 = 0
			local var_159_1 = 0.375

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(411171037)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 15 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 15)

				if (15 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 15)) > 0 and var_159_1 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171037", "story_v_out_411171.awb") ~= 0 then
					local var_159_6 = manager.audio:GetVoiceLength("story_v_out_411171", "411171037", "story_v_out_411171.awb") / 1000

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end

					if var_159_2.prefab_name ~= "" and arg_156_1.actors_[var_159_2.prefab_name] ~= nil then
						local var_159_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_2.prefab_name].transform, "story_v_out_411171", "411171037", "story_v_out_411171.awb")

						arg_156_1:RecordAudio("411171037", var_159_7)
						arg_156_1:RecordAudio("411171037", var_159_7)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_411171", "411171037", "story_v_out_411171.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_411171", "411171037", "story_v_out_411171.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play411171038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 411171038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play411171039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1095ui_story"]) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = arg_160_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1095ui_story"]) then
				if arg_160_1.var_.characterEffect1095ui_story and not isNil(arg_160_1.actors_["1095ui_story"]) then
					arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1095ui_story"]) and arg_160_1.var_.characterEffect1095ui_story then
				arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 0.9

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(411171038).content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 36 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 36)

				if (36 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 36)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_6 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_6 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_6

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_6 and arg_160_1.time_ < var_163_1 + var_163_6 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play411171039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 411171039
		arg_164_1.duration_ = 8.53

		local var_164_0 = {
			zh = 8.433,
			ja = 8.533
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play411171040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1095ui_story"]) and arg_164_1.var_.characterEffect1095ui_story == nil then
				arg_164_1.var_.characterEffect1095ui_story = arg_164_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1095ui_story"]) then
				if arg_164_1.var_.characterEffect1095ui_story and not isNil(arg_164_1.actors_["1095ui_story"]) then
					arg_164_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1095ui_story"]) and arg_164_1.var_.characterEffect1095ui_story then
				arg_164_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_167_2 = 0
			local var_167_3 = 1.025

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_4 = arg_164_1:GetWordFromCfg(411171039)
				local var_167_5 = arg_164_1:FormatText(var_167_4.content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 41 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 41)

				if (41 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 41)) > 0 and var_167_3 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_2
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171039", "story_v_out_411171.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171039", "story_v_out_411171.awb") / 1000

					if var_167_8 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_2
					end

					if var_167_4.prefab_name ~= "" and arg_164_1.actors_[var_167_4.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_4.prefab_name].transform, "story_v_out_411171", "411171039", "story_v_out_411171.awb")

						arg_164_1:RecordAudio("411171039", var_167_9)
						arg_164_1:RecordAudio("411171039", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_411171", "411171039", "story_v_out_411171.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_411171", "411171039", "story_v_out_411171.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_3, arg_164_1.talkMaxDuration)

			if var_167_2 <= arg_164_1.time_ and arg_164_1.time_ < var_167_2 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_2) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_2 + var_167_10 and arg_164_1.time_ < var_167_2 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play411171040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 411171040
		arg_168_1.duration_ = 4.4

		local var_168_0 = {
			zh = 3.766,
			ja = 4.4
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
				arg_168_0:Play411171041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos4010ui_story = arg_168_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["4010ui_story"].transform.position).z)
				arg_168_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["4010ui_story"].transform.localEulerAngles = arg_168_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_168_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["4010ui_story"].transform.position).z)
				arg_168_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["4010ui_story"].transform.localEulerAngles = arg_168_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["4010ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect4010ui_story == nil then
				arg_168_1.var_.characterEffect4010ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect4010ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect4010ui_story then
				arg_168_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_4 = arg_168_1.actors_["1095ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1095ui_story = var_171_4.localPosition
			end

			local var_171_5 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 then
				var_171_4.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_168_1.time_ - 0) / var_171_5)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 then
				var_171_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			local var_171_6 = arg_168_1.actors_["1095ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1095ui_story == nil then
				arg_168_1.var_.characterEffect1095ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_7 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 and not isNil(var_171_6) then
				if arg_168_1.var_.characterEffect1095ui_story and not isNil(var_171_6) then
					arg_168_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_7)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1095ui_story then
				arg_168_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_171_8 = 0
			local var_171_9 = 0.4

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_10 = arg_168_1:GetWordFromCfg(411171040)
				local var_171_11 = arg_168_1:FormatText(var_171_10.content)

				arg_168_1.text_.text = var_171_11

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_13 = 16 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 16)

				if (16 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 16)) > 0 and var_171_9 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_8
					end
				end

				arg_168_1.text_.text = var_171_11
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171040", "story_v_out_411171.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171040", "story_v_out_411171.awb") / 1000

					if var_171_14 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_8
					end

					if var_171_10.prefab_name ~= "" and arg_168_1.actors_[var_171_10.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_10.prefab_name].transform, "story_v_out_411171", "411171040", "story_v_out_411171.awb")

						arg_168_1:RecordAudio("411171040", var_171_15)
						arg_168_1:RecordAudio("411171040", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_411171", "411171040", "story_v_out_411171.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_411171", "411171040", "story_v_out_411171.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_16 and arg_168_1.time_ < var_171_8 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play411171041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 411171041
		arg_172_1.duration_ = 6.17

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play411171042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_9000

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["4010ui_story"]) and arg_172_1.var_.characterEffect4010ui_story == nil then
				arg_172_1.var_.characterEffect4010ui_story = arg_172_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["4010ui_story"]) then
				if arg_172_1.var_.characterEffect4010ui_story and not isNil(arg_172_1.actors_["4010ui_story"]) then
					arg_172_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_172_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["4010ui_story"]) and arg_172_1.var_.characterEffect4010ui_story then
				arg_172_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_172_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				local var_175_1 = arg_172_1.var_.effect991

				if not arg_172_1.var_.effect991 then
					var_175_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_175_1.name = "991"
					arg_172_1.var_.effect991 = var_175_1
				else
					var_175_1.transform:SetParent(var_175_9000)
				end

				var_175_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_175_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_175_3 = arg_172_1.actors_["1095ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1095ui_story = var_175_3.localPosition
			end

			local var_175_4 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				var_175_3.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_4)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				var_175_3.localPosition = Vector3.New(0, 100, 0)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles
			end

			local var_175_5 = arg_172_1.actors_["4010ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos4010ui_story = var_175_5.localPosition
			end

			local var_175_6 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_6 then
				var_175_5.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_6)
				var_175_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_5.position).x, (manager.ui.mainCamera.transform.position - var_175_5.position).y, (manager.ui.mainCamera.transform.position - var_175_5.position).z)
				var_175_5.localEulerAngles.z = 0
				var_175_5.localEulerAngles.x = 0
				var_175_5.localEulerAngles = var_175_5.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_6 and arg_172_1.time_ < 0 + var_175_6 + arg_175_0 then
				var_175_5.localPosition = Vector3.New(0, 100, 0)
				var_175_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_5.position).x, (manager.ui.mainCamera.transform.position - var_175_5.position).y, (manager.ui.mainCamera.transform.position - var_175_5.position).z)
				var_175_5.localEulerAngles.z = 0
				var_175_5.localEulerAngles.x = 0
				var_175_5.localEulerAngles = var_175_5.localEulerAngles
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_7 = 1.16666666666667
			local var_175_8 = 1.125

			if 1.16666666666667 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_9 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_9:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_172_1.dialogCg_.alpha = arg_176_0
				end))
				var_175_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_10 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(411171041).content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_12 = 45 <= 0 and var_175_8 or var_175_8 * (utf8.len(var_175_10) / 45)

				if (45 <= 0 and var_175_8 or var_175_8 * (utf8.len(var_175_10) / 45)) > 0 and var_175_8 < var_175_12 then
					arg_172_1.talkMaxDuration = var_175_12
					var_175_7 = var_175_7 + 0.3

					if var_175_12 + var_175_7 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_7
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = var_175_7 + 0.3
			local var_175_14 = math.max(var_175_8, arg_172_1.talkMaxDuration)

			if var_175_7 + 0.3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_13 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_13) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_13 + var_175_14 and arg_172_1.time_ < var_175_13 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play411171042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 411171042
		arg_178_1.duration_ = 6.3

		local var_178_0 = {
			zh = 6.29966666666667,
			ja = 4.96666666666667
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play411171043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 2.41666666666667 < arg_178_1.time_ and arg_178_1.time_ <= 2.41666666666667 + arg_181_0 then
				arg_178_1.var_.moveOldPos4010ui_story = arg_178_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 2.41666666666667 <= arg_178_1.time_ and arg_178_1.time_ < 2.41666666666667 + var_181_0 then
				arg_178_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_178_1.time_ - 2.41666666666667) / var_181_0)
				arg_178_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["4010ui_story"].transform.position).z)
				arg_178_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["4010ui_story"].transform.localEulerAngles = arg_178_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 2.41666666666667 + var_181_0 and arg_178_1.time_ < 2.41666666666667 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_178_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["4010ui_story"].transform.position).z)
				arg_178_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["4010ui_story"].transform.localEulerAngles = arg_178_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if 1.51666666666667 < arg_178_1.time_ and arg_178_1.time_ <= 1.51666666666667 + arg_181_0 then
				local var_181_1 = arg_178_1.bgs_.ST75

				arg_178_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_181_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_2 = var_181_1:GetComponent("SpriteRenderer")

				if var_181_2 and var_181_2.sprite then
					local var_181_3 = 2 * (var_181_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_181_1.transform.localScale = Vector3.New(var_181_3 / var_181_2.sprite.bounds.size.y < var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x and var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x or var_181_3 / var_181_2.sprite.bounds.size.y, var_181_3 / var_181_2.sprite.bounds.size.y < var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x and var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x or var_181_3 / var_181_2.sprite.bounds.size.y, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "ST75" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_4 = 0

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_5 = 1.51666666666667

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_5 then
				local var_181_6 = Color.New(0, 0, 0)

				var_181_6.a = Mathf.Lerp(0, 1, (arg_178_1.time_ - var_181_4) / var_181_5)
				arg_178_1.mask_.color = var_181_6
			end

			if arg_178_1.time_ >= var_181_4 + var_181_5 and arg_178_1.time_ < var_181_4 + var_181_5 + arg_181_0 then
				local var_181_7 = Color.New(0, 0, 0)

				var_181_7.a = 1
				arg_178_1.mask_.color = var_181_7
			end

			local var_181_8 = 1.51666666666667

			if 1.51666666666667 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_9 = 1

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_9 then
				local var_181_10 = Color.New(0, 0, 0)

				var_181_10.a = Mathf.Lerp(1, 0, (arg_178_1.time_ - var_181_8) / var_181_9)
				arg_178_1.mask_.color = var_181_10
			end

			if arg_178_1.time_ >= var_181_8 + var_181_9 and arg_178_1.time_ < var_181_8 + var_181_9 + arg_181_0 then
				local var_181_11 = Color.New(0, 0, 0)

				arg_178_1.mask_.enabled = false
				var_181_11.a = 0
				arg_178_1.mask_.color = var_181_11
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				if arg_178_1.var_.effect991 then
					Object.Destroy(arg_178_1.var_.effect991)

					arg_178_1.var_.effect991 = nil
				end
			end

			if 2.41666666666667 < arg_178_1.time_ and arg_178_1.time_ <= 2.41666666666667 + arg_181_0 then
				arg_178_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			if 2.41666666666667 < arg_178_1.time_ and arg_178_1.time_ <= 2.41666666666667 + arg_181_0 then
				arg_178_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_181_13 = arg_178_1.actors_["4010ui_story"]

			if 2.41666666666667 < arg_178_1.time_ and arg_178_1.time_ <= 2.41666666666667 + arg_181_0 and not isNil(var_181_13) and arg_178_1.var_.characterEffect4010ui_story == nil then
				arg_178_1.var_.characterEffect4010ui_story = var_181_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_14 = 0.2

			if 2.41666666666667 <= arg_178_1.time_ and arg_178_1.time_ < 2.41666666666667 + var_181_14 and not isNil(var_181_13) then
				if arg_178_1.var_.characterEffect4010ui_story and not isNil(var_181_13) then
					arg_178_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 2.41666666666667 + var_181_14 and arg_178_1.time_ < 2.41666666666667 + var_181_14 + arg_181_0 and not isNil(var_181_13) and arg_178_1.var_.characterEffect4010ui_story then
				arg_178_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_16 = 2.56666666666667
			local var_181_17 = 0.35

			if 2.56666666666667 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_18 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_18:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_19 = arg_178_1:GetWordFromCfg(411171042)
				local var_181_20 = arg_178_1:FormatText(var_181_19.content)

				arg_178_1.text_.text = var_181_20

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_22 = 14 <= 0 and var_181_17 or var_181_17 * (utf8.len(var_181_20) / 14)

				if (14 <= 0 and var_181_17 or var_181_17 * (utf8.len(var_181_20) / 14)) > 0 and var_181_17 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22
					var_181_16 = var_181_16 + 0.3

					if var_181_22 + var_181_16 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_16
					end
				end

				arg_178_1.text_.text = var_181_20
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171042", "story_v_out_411171.awb") ~= 0 then
					local var_181_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171042", "story_v_out_411171.awb") / 1000

					if var_181_23 + var_181_16 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_16
					end

					if var_181_19.prefab_name ~= "" and arg_178_1.actors_[var_181_19.prefab_name] ~= nil then
						local var_181_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_19.prefab_name].transform, "story_v_out_411171", "411171042", "story_v_out_411171.awb")

						arg_178_1:RecordAudio("411171042", var_181_24)
						arg_178_1:RecordAudio("411171042", var_181_24)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_411171", "411171042", "story_v_out_411171.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_411171", "411171042", "story_v_out_411171.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_25 = var_181_16 + 0.3
			local var_181_26 = math.max(var_181_17, arg_178_1.talkMaxDuration)

			if var_181_16 + 0.3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_25 + var_181_26 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_25) / var_181_26

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_25 + var_181_26 and arg_178_1.time_ < var_181_25 + var_181_26 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.41666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play411171043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 411171043
		arg_184_1.duration_ = 3.43

		local var_184_0 = {
			zh = 3.433,
			ja = 2.9
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
				arg_184_0:Play411171044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1095ui_story"]) and arg_184_1.var_.characterEffect1095ui_story == nil then
				arg_184_1.var_.characterEffect1095ui_story = arg_184_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1095ui_story"]) then
				if arg_184_1.var_.characterEffect1095ui_story and not isNil(arg_184_1.actors_["1095ui_story"]) then
					arg_184_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1095ui_story"]) and arg_184_1.var_.characterEffect1095ui_story then
				arg_184_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_2 = arg_184_1.actors_["4010ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect4010ui_story == nil then
				arg_184_1.var_.characterEffect4010ui_story = var_187_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_3 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.characterEffect4010ui_story and not isNil(var_187_2) then
					arg_184_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_184_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_3)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect4010ui_story then
				arg_184_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_184_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_187_4 = arg_184_1.actors_["4010ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos4010ui_story = var_187_4.localPosition
			end

			local var_187_5 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_5 then
				var_187_4.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_184_1.time_ - 0) / var_187_5)
				var_187_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_4.position).x, (manager.ui.mainCamera.transform.position - var_187_4.position).y, (manager.ui.mainCamera.transform.position - var_187_4.position).z)
				var_187_4.localEulerAngles.z = 0
				var_187_4.localEulerAngles.x = 0
				var_187_4.localEulerAngles = var_187_4.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_5 and arg_184_1.time_ < 0 + var_187_5 + arg_187_0 then
				var_187_4.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_187_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_4.position).x, (manager.ui.mainCamera.transform.position - var_187_4.position).y, (manager.ui.mainCamera.transform.position - var_187_4.position).z)
				var_187_4.localEulerAngles.z = 0
				var_187_4.localEulerAngles.x = 0
				var_187_4.localEulerAngles = var_187_4.localEulerAngles
			end

			local var_187_6 = arg_184_1.actors_["1095ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1095ui_story = var_187_6.localPosition
			end

			local var_187_7 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				var_187_6.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_184_1.time_ - 0) / var_187_7)
				var_187_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_6.position).x, (manager.ui.mainCamera.transform.position - var_187_6.position).y, (manager.ui.mainCamera.transform.position - var_187_6.position).z)
				var_187_6.localEulerAngles.z = 0
				var_187_6.localEulerAngles.x = 0
				var_187_6.localEulerAngles = var_187_6.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				var_187_6.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_187_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_6.position).x, (manager.ui.mainCamera.transform.position - var_187_6.position).y, (manager.ui.mainCamera.transform.position - var_187_6.position).z)
				var_187_6.localEulerAngles.z = 0
				var_187_6.localEulerAngles.x = 0
				var_187_6.localEulerAngles = var_187_6.localEulerAngles
			end

			local var_187_8 = 0
			local var_187_9 = 0.325

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_10 = arg_184_1:GetWordFromCfg(411171043)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 13 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 13)

				if (13 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 13)) > 0 and var_187_9 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171043", "story_v_out_411171.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171043", "story_v_out_411171.awb") / 1000

					if var_187_14 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_8
					end

					if var_187_10.prefab_name ~= "" and arg_184_1.actors_[var_187_10.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_10.prefab_name].transform, "story_v_out_411171", "411171043", "story_v_out_411171.awb")

						arg_184_1:RecordAudio("411171043", var_187_15)
						arg_184_1:RecordAudio("411171043", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_411171", "411171043", "story_v_out_411171.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_411171", "411171043", "story_v_out_411171.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_16 and arg_184_1.time_ < var_187_8 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play411171044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 411171044
		arg_188_1.duration_ = 2

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play411171045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["4010ui_story"]) and arg_188_1.var_.characterEffect4010ui_story == nil then
				arg_188_1.var_.characterEffect4010ui_story = arg_188_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["4010ui_story"]) then
				if arg_188_1.var_.characterEffect4010ui_story and not isNil(arg_188_1.actors_["4010ui_story"]) then
					arg_188_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["4010ui_story"]) and arg_188_1.var_.characterEffect4010ui_story then
				arg_188_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_191_2 = arg_188_1.actors_["1095ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1095ui_story == nil then
				arg_188_1.var_.characterEffect1095ui_story = var_191_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_3 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.characterEffect1095ui_story and not isNil(var_191_2) then
					arg_188_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_3)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1095ui_story then
				arg_188_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_191_4 = 0
			local var_191_5 = 0.125

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_6 = arg_188_1:GetWordFromCfg(411171044)
				local var_191_7 = arg_188_1:FormatText(var_191_6.content)

				arg_188_1.text_.text = var_191_7

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_9 = 5 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 5)

				if (5 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 5)) > 0 and var_191_5 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_4
					end
				end

				arg_188_1.text_.text = var_191_7
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171044", "story_v_out_411171.awb") ~= 0 then
					local var_191_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171044", "story_v_out_411171.awb") / 1000

					if var_191_10 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_4
					end

					if var_191_6.prefab_name ~= "" and arg_188_1.actors_[var_191_6.prefab_name] ~= nil then
						local var_191_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_6.prefab_name].transform, "story_v_out_411171", "411171044", "story_v_out_411171.awb")

						arg_188_1:RecordAudio("411171044", var_191_11)
						arg_188_1:RecordAudio("411171044", var_191_11)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_411171", "411171044", "story_v_out_411171.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_411171", "411171044", "story_v_out_411171.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_12 = math.max(var_191_5, arg_188_1.talkMaxDuration)

			if var_191_4 <= arg_188_1.time_ and arg_188_1.time_ < var_191_4 + var_191_12 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_4) / var_191_12

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_4 + var_191_12 and arg_188_1.time_ < var_191_4 + var_191_12 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play411171045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 411171045
		arg_192_1.duration_ = 5.82

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play411171046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["4010ui_story"]) and arg_192_1.var_.characterEffect4010ui_story == nil then
				arg_192_1.var_.characterEffect4010ui_story = arg_192_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["4010ui_story"]) then
				if arg_192_1.var_.characterEffect4010ui_story and not isNil(arg_192_1.actors_["4010ui_story"]) then
					arg_192_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_192_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_0)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["4010ui_story"]) and arg_192_1.var_.characterEffect4010ui_story then
				arg_192_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_192_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_195_1 = arg_192_1.actors_["4010ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos4010ui_story = var_195_1.localPosition
			end

			local var_195_2 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_2 then
				var_195_1.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_2)
				var_195_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_1.position).x, (manager.ui.mainCamera.transform.position - var_195_1.position).y, (manager.ui.mainCamera.transform.position - var_195_1.position).z)
				var_195_1.localEulerAngles.z = 0
				var_195_1.localEulerAngles.x = 0
				var_195_1.localEulerAngles = var_195_1.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_2 and arg_192_1.time_ < 0 + var_195_2 + arg_195_0 then
				var_195_1.localPosition = Vector3.New(0, 100, 0)
				var_195_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_1.position).x, (manager.ui.mainCamera.transform.position - var_195_1.position).y, (manager.ui.mainCamera.transform.position - var_195_1.position).z)
				var_195_1.localEulerAngles.z = 0
				var_195_1.localEulerAngles.x = 0
				var_195_1.localEulerAngles = var_195_1.localEulerAngles
			end

			local var_195_3 = arg_192_1.actors_["1095ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1095ui_story = var_195_3.localPosition
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_3.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_4)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_3.localPosition = Vector3.New(0, 100, 0)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles
			end

			local var_195_5 = manager.ui.mainCamera.transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.shakeOldPos = var_195_5.localPosition
			end

			local var_195_6 = 0.816666666666667

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_6 then
				local var_195_7, var_195_8 = math.modf((arg_192_1.time_ - 0) / 0.066)

				var_195_5.localPosition = Vector3.New(var_195_8 * 0.13, var_195_8 * 0.13, var_195_8 * 0.13) + arg_192_1.var_.shakeOldPos
			end

			if arg_192_1.time_ >= 0 + var_195_6 and arg_192_1.time_ < 0 + var_195_6 + arg_195_0 then
				var_195_5.localPosition = arg_192_1.var_.shakeOldPos
			end

			local var_195_9 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			if arg_192_1.time_ >= var_195_9 + 0.816666666666667 and arg_192_1.time_ < var_195_9 + 0.816666666666667 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_10 = 0.816666666666667
			local var_195_11 = 0.675

			if 0.816666666666667 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_12 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_12:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_13 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(411171045).content)

				arg_192_1.text_.text = var_195_13

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_15 = 27 <= 0 and var_195_11 or var_195_11 * (utf8.len(var_195_13) / 27)

				if (27 <= 0 and var_195_11 or var_195_11 * (utf8.len(var_195_13) / 27)) > 0 and var_195_11 < var_195_15 then
					arg_192_1.talkMaxDuration = var_195_15
					var_195_10 = var_195_10 + 0.3

					if var_195_15 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_10
					end
				end

				arg_192_1.text_.text = var_195_13
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = var_195_10 + 0.3
			local var_195_17 = math.max(var_195_11, arg_192_1.talkMaxDuration)

			if var_195_10 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_17 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_16) / var_195_17

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play411171046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 411171046
		arg_198_1.duration_ = 4.63

		local var_198_0 = {
			zh = 1.999999999999,
			ja = 4.633
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play411171047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1095ui_story = arg_198_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1095ui_story"].transform.position).z)
				arg_198_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1095ui_story"].transform.localEulerAngles = arg_198_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_198_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1095ui_story"].transform.position).z)
				arg_198_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1095ui_story"].transform.localEulerAngles = arg_198_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1095ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1095ui_story == nil then
				arg_198_1.var_.characterEffect1095ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect1095ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1095ui_story then
				arg_198_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_201_4 = 0
			local var_201_5 = 0.3

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(411171046)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 12 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 12)

				if (12 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 12)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171046", "story_v_out_411171.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171046", "story_v_out_411171.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_out_411171", "411171046", "story_v_out_411171.awb")

						arg_198_1:RecordAudio("411171046", var_201_11)
						arg_198_1:RecordAudio("411171046", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_411171", "411171046", "story_v_out_411171.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_411171", "411171046", "story_v_out_411171.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play411171047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 411171047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play411171048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1095ui_story = arg_202_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).z)
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles = arg_202_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).z)
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles = arg_202_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1095ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1095ui_story == nil then
				arg_202_1.var_.characterEffect1095ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1095ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_2)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1095ui_story then
				arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_205_3 = 0
			local var_205_4 = 0.6

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_5 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(411171047).content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 24 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 24)

				if (24 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 24)) > 0 and var_205_4 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_8 and arg_202_1.time_ < var_205_3 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play411171048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 411171048
		arg_206_1.duration_ = 9.53

		local var_206_0 = {
			zh = 9.2,
			ja = 9.533
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play411171049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1095ui_story"]) and arg_206_1.var_.characterEffect1095ui_story == nil then
				arg_206_1.var_.characterEffect1095ui_story = arg_206_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1095ui_story"]) then
				if arg_206_1.var_.characterEffect1095ui_story and not isNil(arg_206_1.actors_["1095ui_story"]) then
					arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1095ui_story"]) and arg_206_1.var_.characterEffect1095ui_story then
				arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_209_2 = arg_206_1.actors_["1095ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1095ui_story = var_209_2.localPosition
			end

			local var_209_3 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 then
				var_209_2.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_206_1.time_ - 0) / var_209_3)
				var_209_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_2.position).x, (manager.ui.mainCamera.transform.position - var_209_2.position).y, (manager.ui.mainCamera.transform.position - var_209_2.position).z)
				var_209_2.localEulerAngles.z = 0
				var_209_2.localEulerAngles.x = 0
				var_209_2.localEulerAngles = var_209_2.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 then
				var_209_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_209_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_2.position).x, (manager.ui.mainCamera.transform.position - var_209_2.position).y, (manager.ui.mainCamera.transform.position - var_209_2.position).z)
				var_209_2.localEulerAngles.z = 0
				var_209_2.localEulerAngles.x = 0
				var_209_2.localEulerAngles = var_209_2.localEulerAngles
			end

			local var_209_4 = 0
			local var_209_5 = 1.15

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:GetWordFromCfg(411171048)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 46 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 46)

				if (46 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 46)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171048", "story_v_out_411171.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171048", "story_v_out_411171.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_out_411171", "411171048", "story_v_out_411171.awb")

						arg_206_1:RecordAudio("411171048", var_209_11)
						arg_206_1:RecordAudio("411171048", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_411171", "411171048", "story_v_out_411171.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_411171", "411171048", "story_v_out_411171.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_12 and arg_206_1.time_ < var_209_4 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play411171049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 411171049
		arg_210_1.duration_ = 9.37

		local var_210_0 = {
			zh = 8.2,
			ja = 9.366
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play411171050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 1.1

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:GetWordFromCfg(411171049)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 44 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 44)

				if (44 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 44)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171049", "story_v_out_411171.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171049", "story_v_out_411171.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_411171", "411171049", "story_v_out_411171.awb")

						arg_210_1:RecordAudio("411171049", var_213_6)
						arg_210_1:RecordAudio("411171049", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_411171", "411171049", "story_v_out_411171.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_411171", "411171049", "story_v_out_411171.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play411171050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 411171050
		arg_214_1.duration_ = 4.5

		local var_214_0 = {
			zh = 4.5,
			ja = 2.566
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play411171051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos4010ui_story = arg_214_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["4010ui_story"].transform.position).z)
				arg_214_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["4010ui_story"].transform.localEulerAngles = arg_214_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_214_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["4010ui_story"].transform.position).z)
				arg_214_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["4010ui_story"].transform.localEulerAngles = arg_214_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["4010ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect4010ui_story == nil then
				arg_214_1.var_.characterEffect4010ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect4010ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect4010ui_story then
				arg_214_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_217_4 = arg_214_1.actors_["1095ui_story"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1095ui_story = var_217_4.localPosition
			end

			local var_217_5 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_5 then
				var_217_4.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_214_1.time_ - 0) / var_217_5)
				var_217_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_4.position).x, (manager.ui.mainCamera.transform.position - var_217_4.position).y, (manager.ui.mainCamera.transform.position - var_217_4.position).z)
				var_217_4.localEulerAngles.z = 0
				var_217_4.localEulerAngles.x = 0
				var_217_4.localEulerAngles = var_217_4.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_5 and arg_214_1.time_ < 0 + var_217_5 + arg_217_0 then
				var_217_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_217_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_4.position).x, (manager.ui.mainCamera.transform.position - var_217_4.position).y, (manager.ui.mainCamera.transform.position - var_217_4.position).z)
				var_217_4.localEulerAngles.z = 0
				var_217_4.localEulerAngles.x = 0
				var_217_4.localEulerAngles = var_217_4.localEulerAngles
			end

			local var_217_6 = arg_214_1.actors_["1095ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_6) and arg_214_1.var_.characterEffect1095ui_story == nil then
				arg_214_1.var_.characterEffect1095ui_story = var_217_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_7 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 and not isNil(var_217_6) then
				if arg_214_1.var_.characterEffect1095ui_story and not isNil(var_217_6) then
					arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_7)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 and not isNil(var_217_6) and arg_214_1.var_.characterEffect1095ui_story then
				arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_217_8 = 0
			local var_217_9 = 0.575

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_10 = arg_214_1:GetWordFromCfg(411171050)
				local var_217_11 = arg_214_1:FormatText(var_217_10.content)

				arg_214_1.text_.text = var_217_11

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_13 = 23 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 23)

				if (23 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 23)) > 0 and var_217_9 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_8
					end
				end

				arg_214_1.text_.text = var_217_11
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171050", "story_v_out_411171.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171050", "story_v_out_411171.awb") / 1000

					if var_217_14 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_8
					end

					if var_217_10.prefab_name ~= "" and arg_214_1.actors_[var_217_10.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_10.prefab_name].transform, "story_v_out_411171", "411171050", "story_v_out_411171.awb")

						arg_214_1:RecordAudio("411171050", var_217_15)
						arg_214_1:RecordAudio("411171050", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_411171", "411171050", "story_v_out_411171.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_411171", "411171050", "story_v_out_411171.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_9, arg_214_1.talkMaxDuration)

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_8) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_8 + var_217_16 and arg_214_1.time_ < var_217_8 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play411171051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 411171051
		arg_218_1.duration_ = 6.1

		local var_218_0 = {
			zh = 5.633,
			ja = 6.1
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play411171052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["4010ui_story"]) and arg_218_1.var_.characterEffect4010ui_story == nil then
				arg_218_1.var_.characterEffect4010ui_story = arg_218_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["4010ui_story"]) then
				if arg_218_1.var_.characterEffect4010ui_story and not isNil(arg_218_1.actors_["4010ui_story"]) then
					arg_218_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_218_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_0)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["4010ui_story"]) and arg_218_1.var_.characterEffect4010ui_story then
				arg_218_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_218_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_221_1 = arg_218_1.actors_["1095ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1095ui_story == nil then
				arg_218_1.var_.characterEffect1095ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1095ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1095ui_story then
				arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_221_4 = 0
			local var_221_5 = 0.65

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(411171051)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 26 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 26)

				if (26 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 26)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171051", "story_v_out_411171.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171051", "story_v_out_411171.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_411171", "411171051", "story_v_out_411171.awb")

						arg_218_1:RecordAudio("411171051", var_221_11)
						arg_218_1:RecordAudio("411171051", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_411171", "411171051", "story_v_out_411171.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_411171", "411171051", "story_v_out_411171.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play411171052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 411171052
		arg_222_1.duration_ = 5

		local var_222_0 = {
			zh = 5,
			ja = 3.7
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play411171053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["4010ui_story"]) and arg_222_1.var_.characterEffect4010ui_story == nil then
				arg_222_1.var_.characterEffect4010ui_story = arg_222_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["4010ui_story"]) then
				if arg_222_1.var_.characterEffect4010ui_story and not isNil(arg_222_1.actors_["4010ui_story"]) then
					arg_222_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["4010ui_story"]) and arg_222_1.var_.characterEffect4010ui_story then
				arg_222_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_225_2 = arg_222_1.actors_["1095ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1095ui_story == nil then
				arg_222_1.var_.characterEffect1095ui_story = var_225_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_3 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.characterEffect1095ui_story and not isNil(var_225_2) then
					arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_3)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1095ui_story then
				arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_225_4 = 0
			local var_225_5 = 0.6

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(411171052)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 24 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 24)

				if (24 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 24)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171052", "story_v_out_411171.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171052", "story_v_out_411171.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_out_411171", "411171052", "story_v_out_411171.awb")

						arg_222_1:RecordAudio("411171052", var_225_11)
						arg_222_1:RecordAudio("411171052", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_411171", "411171052", "story_v_out_411171.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_411171", "411171052", "story_v_out_411171.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play411171053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 411171053
		arg_226_1.duration_ = 3.43

		local var_226_0 = {
			zh = 2.966,
			ja = 3.433
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play411171054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["4010ui_story"]) and arg_226_1.var_.characterEffect4010ui_story == nil then
				arg_226_1.var_.characterEffect4010ui_story = arg_226_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["4010ui_story"]) then
				if arg_226_1.var_.characterEffect4010ui_story and not isNil(arg_226_1.actors_["4010ui_story"]) then
					arg_226_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_226_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["4010ui_story"]) and arg_226_1.var_.characterEffect4010ui_story then
				arg_226_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_226_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_229_1 = arg_226_1.actors_["1095ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1095ui_story == nil then
				arg_226_1.var_.characterEffect1095ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 and not isNil(var_229_1) then
				if arg_226_1.var_.characterEffect1095ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1095ui_story then
				arg_226_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_4 = 0
			local var_229_5 = 0.35

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(411171053)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 14 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 14)

				if (14 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 14)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171053", "story_v_out_411171.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171053", "story_v_out_411171.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_out_411171", "411171053", "story_v_out_411171.awb")

						arg_226_1:RecordAudio("411171053", var_229_11)
						arg_226_1:RecordAudio("411171053", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_411171", "411171053", "story_v_out_411171.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_411171", "411171053", "story_v_out_411171.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play411171054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 411171054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play411171055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos4010ui_story = arg_230_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["4010ui_story"].transform.position).z)
				arg_230_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["4010ui_story"].transform.localEulerAngles = arg_230_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["4010ui_story"].transform.position).z)
				arg_230_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["4010ui_story"].transform.localEulerAngles = arg_230_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["4010ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect4010ui_story == nil then
				arg_230_1.var_.characterEffect4010ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect4010ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_230_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_2)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect4010ui_story then
				arg_230_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_230_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_233_3 = arg_230_1.actors_["1095ui_story"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1095ui_story = var_233_3.localPosition
			end

			local var_233_4 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				var_233_3.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_4)
				var_233_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_3.position).x, (manager.ui.mainCamera.transform.position - var_233_3.position).y, (manager.ui.mainCamera.transform.position - var_233_3.position).z)
				var_233_3.localEulerAngles.z = 0
				var_233_3.localEulerAngles.x = 0
				var_233_3.localEulerAngles = var_233_3.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				var_233_3.localPosition = Vector3.New(0, 100, 0)
				var_233_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_3.position).x, (manager.ui.mainCamera.transform.position - var_233_3.position).y, (manager.ui.mainCamera.transform.position - var_233_3.position).z)
				var_233_3.localEulerAngles.z = 0
				var_233_3.localEulerAngles.x = 0
				var_233_3.localEulerAngles = var_233_3.localEulerAngles
			end

			local var_233_5 = arg_230_1.actors_["1095ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_5) and arg_230_1.var_.characterEffect1095ui_story == nil then
				arg_230_1.var_.characterEffect1095ui_story = var_233_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_6 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_6 and not isNil(var_233_5) then
				if arg_230_1.var_.characterEffect1095ui_story and not isNil(var_233_5) then
					arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_6)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_6 and arg_230_1.time_ < 0 + var_233_6 + arg_233_0 and not isNil(var_233_5) and arg_230_1.var_.characterEffect1095ui_story then
				arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_233_7 = 0
			local var_233_8 = 1.025

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_7 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_9 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(411171054).content)

				arg_230_1.text_.text = var_233_9

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 41 <= 0 and var_233_8 or var_233_8 * (utf8.len(var_233_9) / 41)

				if (41 <= 0 and var_233_8 or var_233_8 * (utf8.len(var_233_9) / 41)) > 0 and var_233_8 < var_233_11 then
					arg_230_1.talkMaxDuration = var_233_11

					if var_233_11 + var_233_7 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_7
					end
				end

				arg_230_1.text_.text = var_233_9
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_8, arg_230_1.talkMaxDuration)

			if var_233_7 <= arg_230_1.time_ and arg_230_1.time_ < var_233_7 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_7) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_7 + var_233_12 and arg_230_1.time_ < var_233_7 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play411171055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 411171055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play411171056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 1.125

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(411171055).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 45 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 45)

				if (45 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 45)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play411171056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 411171056
		arg_238_1.duration_ = 8.44

		local var_238_0 = {
			zh = 4.849999999999,
			ja = 8.44100000298023
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play411171057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 2.85 < arg_238_1.time_ and arg_238_1.time_ <= 2.85 + arg_241_0 then
				arg_238_1.var_.moveOldPos1095ui_story = arg_238_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 2.85 <= arg_238_1.time_ and arg_238_1.time_ < 2.85 + var_241_0 then
				arg_238_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_238_1.time_ - 2.85) / var_241_0)
				arg_238_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).z)
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles = arg_238_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 2.85 + var_241_0 and arg_238_1.time_ < 2.85 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_238_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1095ui_story"].transform.position).z)
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1095ui_story"].transform.localEulerAngles = arg_238_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["1095ui_story"]

			if 2.85 < arg_238_1.time_ and arg_238_1.time_ <= 2.85 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1095ui_story == nil then
				arg_238_1.var_.characterEffect1095ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 2.85 <= arg_238_1.time_ and arg_238_1.time_ < 2.85 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect1095ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 2.85 + var_241_2 and arg_238_1.time_ < 2.85 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1095ui_story then
				arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2.85 < arg_238_1.time_ and arg_238_1.time_ <= 2.85 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2.85 < arg_238_1.time_ and arg_238_1.time_ <= 2.85 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1.55 < arg_238_1.time_ and arg_238_1.time_ <= 1.55 + arg_241_0 then
				local var_241_4 = arg_238_1.bgs_.ST75

				arg_238_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_241_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_5 = var_241_4:GetComponent("SpriteRenderer")

				if var_241_5 and var_241_5.sprite then
					local var_241_6 = 2 * (var_241_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_241_4.transform.localScale = Vector3.New(var_241_6 / var_241_5.sprite.bounds.size.y < var_241_6 * manager.ui.mainCameraCom_.aspect / var_241_5.sprite.bounds.size.x and var_241_6 * manager.ui.mainCameraCom_.aspect / var_241_5.sprite.bounds.size.x or var_241_6 / var_241_5.sprite.bounds.size.y, var_241_6 / var_241_5.sprite.bounds.size.y < var_241_6 * manager.ui.mainCameraCom_.aspect / var_241_5.sprite.bounds.size.x and var_241_6 * manager.ui.mainCameraCom_.aspect / var_241_5.sprite.bounds.size.x or var_241_6 / var_241_5.sprite.bounds.size.y, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "ST75" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_7 = 0

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_7 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_8 = 1.55

			if var_241_7 <= arg_238_1.time_ and arg_238_1.time_ < var_241_7 + var_241_8 then
				local var_241_9 = Color.New(0, 0, 0)

				var_241_9.a = Mathf.Lerp(0, 1, (arg_238_1.time_ - var_241_7) / var_241_8)
				arg_238_1.mask_.color = var_241_9
			end

			if arg_238_1.time_ >= var_241_7 + var_241_8 and arg_238_1.time_ < var_241_7 + var_241_8 + arg_241_0 then
				local var_241_10 = Color.New(0, 0, 0)

				var_241_10.a = 1
				arg_238_1.mask_.color = var_241_10
			end

			local var_241_11 = 1.55

			if 1.55 < arg_238_1.time_ and arg_238_1.time_ <= var_241_11 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_12 = 1.45

			if var_241_11 <= arg_238_1.time_ and arg_238_1.time_ < var_241_11 + var_241_12 then
				local var_241_13 = Color.New(0, 0, 0)

				var_241_13.a = Mathf.Lerp(1, 0, (arg_238_1.time_ - var_241_11) / var_241_12)
				arg_238_1.mask_.color = var_241_13
			end

			if arg_238_1.time_ >= var_241_11 + var_241_12 and arg_238_1.time_ < var_241_11 + var_241_12 + arg_241_0 then
				local var_241_14 = Color.New(0, 0, 0)

				arg_238_1.mask_.enabled = false
				var_241_14.a = 0
				arg_238_1.mask_.color = var_241_14
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_15 = 2.97500000298023
			local var_241_16 = 0.225

			if 2.97500000298023 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_17 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_17:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(411171056)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_21 = 9 <= 0 and var_241_16 or var_241_16 * (utf8.len(var_241_19) / 9)

				if (9 <= 0 and var_241_16 or var_241_16 * (utf8.len(var_241_19) / 9)) > 0 and var_241_16 < var_241_21 then
					arg_238_1.talkMaxDuration = var_241_21
					var_241_15 = var_241_15 + 0.3

					if var_241_21 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_21 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171056", "story_v_out_411171.awb") ~= 0 then
					local var_241_22 = manager.audio:GetVoiceLength("story_v_out_411171", "411171056", "story_v_out_411171.awb") / 1000

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_out_411171", "411171056", "story_v_out_411171.awb")

						arg_238_1:RecordAudio("411171056", var_241_23)
						arg_238_1:RecordAudio("411171056", var_241_23)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_411171", "411171056", "story_v_out_411171.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_411171", "411171056", "story_v_out_411171.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_24 = var_241_15 + 0.3
			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 + 0.3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_24 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_24) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_24 + var_241_25 and arg_238_1.time_ < var_241_24 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.85,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play411171057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 411171057
		arg_244_1.duration_ = 9.77

		local var_244_0 = {
			zh = 6.066,
			ja = 9.766
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play411171058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos4010ui_story = arg_244_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["4010ui_story"].transform.position).z)
				arg_244_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["4010ui_story"].transform.localEulerAngles = arg_244_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_244_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["4010ui_story"].transform.position).z)
				arg_244_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["4010ui_story"].transform.localEulerAngles = arg_244_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["4010ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect4010ui_story == nil then
				arg_244_1.var_.characterEffect4010ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect4010ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect4010ui_story then
				arg_244_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_247_4 = arg_244_1.actors_["1095ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1095ui_story = var_247_4.localPosition
			end

			local var_247_5 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_5 then
				var_247_4.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_5)
				var_247_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_4.position).x, (manager.ui.mainCamera.transform.position - var_247_4.position).y, (manager.ui.mainCamera.transform.position - var_247_4.position).z)
				var_247_4.localEulerAngles.z = 0
				var_247_4.localEulerAngles.x = 0
				var_247_4.localEulerAngles = var_247_4.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_5 and arg_244_1.time_ < 0 + var_247_5 + arg_247_0 then
				var_247_4.localPosition = Vector3.New(0, 100, 0)
				var_247_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_4.position).x, (manager.ui.mainCamera.transform.position - var_247_4.position).y, (manager.ui.mainCamera.transform.position - var_247_4.position).z)
				var_247_4.localEulerAngles.z = 0
				var_247_4.localEulerAngles.x = 0
				var_247_4.localEulerAngles = var_247_4.localEulerAngles
			end

			local var_247_6 = arg_244_1.actors_["1095ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_6) and arg_244_1.var_.characterEffect1095ui_story == nil then
				arg_244_1.var_.characterEffect1095ui_story = var_247_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_7 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 and not isNil(var_247_6) then
				if arg_244_1.var_.characterEffect1095ui_story and not isNil(var_247_6) then
					arg_244_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_7)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 and not isNil(var_247_6) and arg_244_1.var_.characterEffect1095ui_story then
				arg_244_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_247_8 = 0
			local var_247_9 = 0.725

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_8 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_10 = arg_244_1:GetWordFromCfg(411171057)
				local var_247_11 = arg_244_1:FormatText(var_247_10.content)

				arg_244_1.text_.text = var_247_11

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_13 = 29 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 29)

				if (29 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 29)) > 0 and var_247_9 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_8
					end
				end

				arg_244_1.text_.text = var_247_11
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171057", "story_v_out_411171.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171057", "story_v_out_411171.awb") / 1000

					if var_247_14 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_8
					end

					if var_247_10.prefab_name ~= "" and arg_244_1.actors_[var_247_10.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_10.prefab_name].transform, "story_v_out_411171", "411171057", "story_v_out_411171.awb")

						arg_244_1:RecordAudio("411171057", var_247_15)
						arg_244_1:RecordAudio("411171057", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_411171", "411171057", "story_v_out_411171.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_411171", "411171057", "story_v_out_411171.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_9, arg_244_1.talkMaxDuration)

			if var_247_8 <= arg_244_1.time_ and arg_244_1.time_ < var_247_8 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_8) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_8 + var_247_16 and arg_244_1.time_ < var_247_8 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play411171058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 411171058
		arg_248_1.duration_ = 13.07

		local var_248_0 = {
			zh = 5.833,
			ja = 13.066
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
				arg_248_0:Play411171059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.7

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(411171058)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 28 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 28)

				if (28 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 28)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171058", "story_v_out_411171.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171058", "story_v_out_411171.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_411171", "411171058", "story_v_out_411171.awb")

						arg_248_1:RecordAudio("411171058", var_251_6)
						arg_248_1:RecordAudio("411171058", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_411171", "411171058", "story_v_out_411171.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_411171", "411171058", "story_v_out_411171.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play411171059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 411171059
		arg_252_1.duration_ = 9

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play411171060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				local var_255_0 = arg_252_1.bgs_.B10b

				arg_252_1.bgs_.B10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_1 = var_255_0:GetComponent("SpriteRenderer")

				if var_255_1 and var_255_1.sprite then
					local var_255_2 = 2 * (var_255_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_0.transform.localScale = Vector3.New(var_255_2 / var_255_1.sprite.bounds.size.y < var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x and var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x or var_255_2 / var_255_1.sprite.bounds.size.y, var_255_2 / var_255_1.sprite.bounds.size.y < var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x and var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x or var_255_2 / var_255_1.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "B10b" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_3 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_4 = 2

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_4 then
				local var_255_5 = Color.New(0, 0, 0)

				var_255_5.a = Mathf.Lerp(0, 1, (arg_252_1.time_ - var_255_3) / var_255_4)
				arg_252_1.mask_.color = var_255_5
			end

			if arg_252_1.time_ >= var_255_3 + var_255_4 and arg_252_1.time_ < var_255_3 + var_255_4 + arg_255_0 then
				local var_255_6 = Color.New(0, 0, 0)

				var_255_6.a = 1
				arg_252_1.mask_.color = var_255_6
			end

			local var_255_7 = 2

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_7 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_8 = 2

			if var_255_7 <= arg_252_1.time_ and arg_252_1.time_ < var_255_7 + var_255_8 then
				local var_255_9 = Color.New(0, 0, 0)

				var_255_9.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_7) / var_255_8)
				arg_252_1.mask_.color = var_255_9
			end

			if arg_252_1.time_ >= var_255_7 + var_255_8 and arg_252_1.time_ < var_255_7 + var_255_8 + arg_255_0 then
				local var_255_10 = Color.New(0, 0, 0)

				arg_252_1.mask_.enabled = false
				var_255_10.a = 0
				arg_252_1.mask_.color = var_255_10
			end

			local var_255_11 = arg_252_1.actors_["1095ui_story"].transform

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				arg_252_1.var_.moveOldPos1095ui_story = var_255_11.localPosition
			end

			local var_255_12 = 0.001

			if 2 <= arg_252_1.time_ and arg_252_1.time_ < 2 + var_255_12 then
				var_255_11.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 2) / var_255_12)
				var_255_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_11.position).x, (manager.ui.mainCamera.transform.position - var_255_11.position).y, (manager.ui.mainCamera.transform.position - var_255_11.position).z)
				var_255_11.localEulerAngles.z = 0
				var_255_11.localEulerAngles.x = 0
				var_255_11.localEulerAngles = var_255_11.localEulerAngles
			end

			if arg_252_1.time_ >= 2 + var_255_12 and arg_252_1.time_ < 2 + var_255_12 + arg_255_0 then
				var_255_11.localPosition = Vector3.New(0, 100, 0)
				var_255_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_11.position).x, (manager.ui.mainCamera.transform.position - var_255_11.position).y, (manager.ui.mainCamera.transform.position - var_255_11.position).z)
				var_255_11.localEulerAngles.z = 0
				var_255_11.localEulerAngles.x = 0
				var_255_11.localEulerAngles = var_255_11.localEulerAngles
			end

			local var_255_13 = arg_252_1.actors_["1095ui_story"]

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 and not isNil(var_255_13) and arg_252_1.var_.characterEffect1095ui_story == nil then
				arg_252_1.var_.characterEffect1095ui_story = var_255_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_14 = 0.200000002980232

			if 2 <= arg_252_1.time_ and arg_252_1.time_ < 2 + var_255_14 and not isNil(var_255_13) then
				if arg_252_1.var_.characterEffect1095ui_story and not isNil(var_255_13) then
					arg_252_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 2) / var_255_14)
				end
			end

			if arg_252_1.time_ >= 2 + var_255_14 and arg_252_1.time_ < 2 + var_255_14 + arg_255_0 and not isNil(var_255_13) and arg_252_1.var_.characterEffect1095ui_story then
				arg_252_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_255_15 = arg_252_1.actors_["4010ui_story"].transform

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				arg_252_1.var_.moveOldPos4010ui_story = var_255_15.localPosition
			end

			local var_255_16 = 0.001

			if 2 <= arg_252_1.time_ and arg_252_1.time_ < 2 + var_255_16 then
				var_255_15.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 2) / var_255_16)
				var_255_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_15.position).x, (manager.ui.mainCamera.transform.position - var_255_15.position).y, (manager.ui.mainCamera.transform.position - var_255_15.position).z)
				var_255_15.localEulerAngles.z = 0
				var_255_15.localEulerAngles.x = 0
				var_255_15.localEulerAngles = var_255_15.localEulerAngles
			end

			if arg_252_1.time_ >= 2 + var_255_16 and arg_252_1.time_ < 2 + var_255_16 + arg_255_0 then
				var_255_15.localPosition = Vector3.New(0, 100, 0)
				var_255_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_15.position).x, (manager.ui.mainCamera.transform.position - var_255_15.position).y, (manager.ui.mainCamera.transform.position - var_255_15.position).z)
				var_255_15.localEulerAngles.z = 0
				var_255_15.localEulerAngles.x = 0
				var_255_15.localEulerAngles = var_255_15.localEulerAngles
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_17 = 4
			local var_255_18 = 1.275

			if 4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_17 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_19 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_19:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_20 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(411171059).content)

				arg_252_1.text_.text = var_255_20

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_22 = 52 <= 0 and var_255_18 or var_255_18 * (utf8.len(var_255_20) / 52)

				if (52 <= 0 and var_255_18 or var_255_18 * (utf8.len(var_255_20) / 52)) > 0 and var_255_18 < var_255_22 then
					arg_252_1.talkMaxDuration = var_255_22
					var_255_17 = var_255_17 + 0.3

					if var_255_22 + var_255_17 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_22 + var_255_17
					end
				end

				arg_252_1.text_.text = var_255_20
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_23 = var_255_17 + 0.3
			local var_255_24 = math.max(var_255_18, arg_252_1.talkMaxDuration)

			if var_255_17 + 0.3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_23 + var_255_24 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_23) / var_255_24

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_23 + var_255_24 and arg_252_1.time_ < var_255_23 + var_255_24 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play411171060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 411171060
		arg_258_1.duration_ = 1.77

		local var_258_0 = {
			zh = 1.433,
			ja = 1.766
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play411171061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1024ui_story = arg_258_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1024ui_story"].transform.position).z)
				arg_258_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1024ui_story"].transform.localEulerAngles = arg_258_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_258_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1024ui_story"].transform.position).z)
				arg_258_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1024ui_story"].transform.localEulerAngles = arg_258_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1024ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1024ui_story == nil then
				arg_258_1.var_.characterEffect1024ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1024ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1024ui_story then
				arg_258_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_261_4 = 0
			local var_261_5 = 0.3

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_6 = arg_258_1:GetWordFromCfg(411171060)
				local var_261_7 = arg_258_1:FormatText(var_261_6.content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 12 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 12)

				if (12 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 12)) > 0 and var_261_5 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171060", "story_v_out_411171.awb") ~= 0 then
					local var_261_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171060", "story_v_out_411171.awb") / 1000

					if var_261_10 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_4
					end

					if var_261_6.prefab_name ~= "" and arg_258_1.actors_[var_261_6.prefab_name] ~= nil then
						local var_261_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_6.prefab_name].transform, "story_v_out_411171", "411171060", "story_v_out_411171.awb")

						arg_258_1:RecordAudio("411171060", var_261_11)
						arg_258_1:RecordAudio("411171060", var_261_11)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_411171", "411171060", "story_v_out_411171.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_411171", "411171060", "story_v_out_411171.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_12 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_12 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_12

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_12 and arg_258_1.time_ < var_261_4 + var_261_12 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play411171061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 411171061
		arg_262_1.duration_ = 4.57

		local var_262_0 = {
			zh = 2.7,
			ja = 4.566
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play411171062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1024ui_story"]) and arg_262_1.var_.characterEffect1024ui_story == nil then
				arg_262_1.var_.characterEffect1024ui_story = arg_262_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1024ui_story"]) then
				if arg_262_1.var_.characterEffect1024ui_story and not isNil(arg_262_1.actors_["1024ui_story"]) then
					arg_262_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1024ui_story"]) and arg_262_1.var_.characterEffect1024ui_story then
				arg_262_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_265_1 = 0
			local var_265_2 = 0.3

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(411171061)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_6 = 12 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_4) / 12)

				if (12 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_4) / 12)) > 0 and var_265_2 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171061", "story_v_out_411171.awb") ~= 0 then
					local var_265_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171061", "story_v_out_411171.awb") / 1000

					if var_265_7 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_1
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_out_411171", "411171061", "story_v_out_411171.awb")

						arg_262_1:RecordAudio("411171061", var_265_8)
						arg_262_1:RecordAudio("411171061", var_265_8)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_411171", "411171061", "story_v_out_411171.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_411171", "411171061", "story_v_out_411171.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_9 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_9 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_9

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_9 and arg_262_1.time_ < var_265_1 + var_265_9 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play411171062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 411171062
		arg_266_1.duration_ = 7.4

		local var_266_0 = {
			zh = 7.4,
			ja = 7.266
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play411171063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1024ui_story = arg_266_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1024ui_story"].transform.position).z)
				arg_266_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1024ui_story"].transform.localEulerAngles = arg_266_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_266_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1024ui_story"].transform.position).z)
				arg_266_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1024ui_story"].transform.localEulerAngles = arg_266_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1024ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1024ui_story == nil then
				arg_266_1.var_.characterEffect1024ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1024ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1024ui_story then
				arg_266_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_4 = 0
			local var_269_5 = 0.8

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(411171062)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 32 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 32)

				if (32 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 32)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171062", "story_v_out_411171.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171062", "story_v_out_411171.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_411171", "411171062", "story_v_out_411171.awb")

						arg_266_1:RecordAudio("411171062", var_269_11)
						arg_266_1:RecordAudio("411171062", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_411171", "411171062", "story_v_out_411171.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_411171", "411171062", "story_v_out_411171.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play411171063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 411171063
		arg_270_1.duration_ = 4.73

		local var_270_0 = {
			zh = 4.733,
			ja = 3.166
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play411171064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1024ui_story"]) and arg_270_1.var_.characterEffect1024ui_story == nil then
				arg_270_1.var_.characterEffect1024ui_story = arg_270_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1024ui_story"]) then
				if arg_270_1.var_.characterEffect1024ui_story and not isNil(arg_270_1.actors_["1024ui_story"]) then
					arg_270_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1024ui_story"]) and arg_270_1.var_.characterEffect1024ui_story then
				arg_270_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_273_1 = 0
			local var_273_2 = 0.5

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(411171063)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_6 = 20 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_4) / 20)

				if (20 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_4) / 20)) > 0 and var_273_2 < var_273_6 then
					arg_270_1.talkMaxDuration = var_273_6

					if var_273_6 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171063", "story_v_out_411171.awb") ~= 0 then
					local var_273_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171063", "story_v_out_411171.awb") / 1000

					if var_273_7 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_1
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_411171", "411171063", "story_v_out_411171.awb")

						arg_270_1:RecordAudio("411171063", var_273_8)
						arg_270_1:RecordAudio("411171063", var_273_8)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_411171", "411171063", "story_v_out_411171.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_411171", "411171063", "story_v_out_411171.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_9 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_9 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_9

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_9 and arg_270_1.time_ < var_273_1 + var_273_9 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play411171064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 411171064
		arg_274_1.duration_ = 6.77

		local var_274_0 = {
			zh = 3.933,
			ja = 6.766
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play411171065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1024ui_story"]) and arg_274_1.var_.characterEffect1024ui_story == nil then
				arg_274_1.var_.characterEffect1024ui_story = arg_274_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1024ui_story"]) then
				if arg_274_1.var_.characterEffect1024ui_story and not isNil(arg_274_1.actors_["1024ui_story"]) then
					arg_274_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1024ui_story"]) and arg_274_1.var_.characterEffect1024ui_story then
				arg_274_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_277_2 = 0
			local var_277_3 = 0.45

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(411171064)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 18 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 18)

				if (18 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 18)) > 0 and var_277_3 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171064", "story_v_out_411171.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171064", "story_v_out_411171.awb") / 1000

					if var_277_8 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_2
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_out_411171", "411171064", "story_v_out_411171.awb")

						arg_274_1:RecordAudio("411171064", var_277_9)
						arg_274_1:RecordAudio("411171064", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_411171", "411171064", "story_v_out_411171.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_411171", "411171064", "story_v_out_411171.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_10 and arg_274_1.time_ < var_277_2 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play411171065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 411171065
		arg_278_1.duration_ = 5.03

		local var_278_0 = {
			zh = 5.033,
			ja = 3.633
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play411171066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1024ui_story"]) and arg_278_1.var_.characterEffect1024ui_story == nil then
				arg_278_1.var_.characterEffect1024ui_story = arg_278_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1024ui_story"]) then
				if arg_278_1.var_.characterEffect1024ui_story and not isNil(arg_278_1.actors_["1024ui_story"]) then
					arg_278_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_0)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1024ui_story"]) and arg_278_1.var_.characterEffect1024ui_story then
				arg_278_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_281_1 = 0
			local var_281_2 = 0.5

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[716].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(411171065)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_6 = 20 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_4) / 20)

				if (20 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_4) / 20)) > 0 and var_281_2 < var_281_6 then
					arg_278_1.talkMaxDuration = var_281_6

					if var_281_6 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_1
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171065", "story_v_out_411171.awb") ~= 0 then
					local var_281_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171065", "story_v_out_411171.awb") / 1000

					if var_281_7 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_1
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_411171", "411171065", "story_v_out_411171.awb")

						arg_278_1:RecordAudio("411171065", var_281_8)
						arg_278_1:RecordAudio("411171065", var_281_8)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_411171", "411171065", "story_v_out_411171.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_411171", "411171065", "story_v_out_411171.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_9 = math.max(var_281_2, arg_278_1.talkMaxDuration)

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_9 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_1) / var_281_9

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_1 + var_281_9 and arg_278_1.time_ < var_281_1 + var_281_9 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play411171066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 411171066
		arg_282_1.duration_ = 3.13

		local var_282_0 = {
			zh = 2,
			ja = 3.133
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play411171067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1024ui_story"]) and arg_282_1.var_.characterEffect1024ui_story == nil then
				arg_282_1.var_.characterEffect1024ui_story = arg_282_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1024ui_story"]) then
				if arg_282_1.var_.characterEffect1024ui_story and not isNil(arg_282_1.actors_["1024ui_story"]) then
					arg_282_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1024ui_story"]) and arg_282_1.var_.characterEffect1024ui_story then
				arg_282_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_285_2 = 0
			local var_285_3 = 0.225

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_2 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_4 = arg_282_1:GetWordFromCfg(411171066)
				local var_285_5 = arg_282_1:FormatText(var_285_4.content)

				arg_282_1.text_.text = var_285_5

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_7 = 9 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_5) / 9)

				if (9 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_5) / 9)) > 0 and var_285_3 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_2 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_2
					end
				end

				arg_282_1.text_.text = var_285_5
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171066", "story_v_out_411171.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171066", "story_v_out_411171.awb") / 1000

					if var_285_8 + var_285_2 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_2
					end

					if var_285_4.prefab_name ~= "" and arg_282_1.actors_[var_285_4.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_4.prefab_name].transform, "story_v_out_411171", "411171066", "story_v_out_411171.awb")

						arg_282_1:RecordAudio("411171066", var_285_9)
						arg_282_1:RecordAudio("411171066", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_411171", "411171066", "story_v_out_411171.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_411171", "411171066", "story_v_out_411171.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_3, arg_282_1.talkMaxDuration)

			if var_285_2 <= arg_282_1.time_ and arg_282_1.time_ < var_285_2 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_2) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_2 + var_285_10 and arg_282_1.time_ < var_285_2 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play411171067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 411171067
		arg_286_1.duration_ = 10.13

		local var_286_0 = {
			zh = 9.533,
			ja = 10.133
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play411171068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1024ui_story"]) and arg_286_1.var_.characterEffect1024ui_story == nil then
				arg_286_1.var_.characterEffect1024ui_story = arg_286_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1024ui_story"]) then
				if arg_286_1.var_.characterEffect1024ui_story and not isNil(arg_286_1.actors_["1024ui_story"]) then
					arg_286_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_0)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1024ui_story"]) and arg_286_1.var_.characterEffect1024ui_story then
				arg_286_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_289_1 = 0
			local var_289_2 = 1.05

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[716].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(411171067)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_6 = 42 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_4) / 42)

				if (42 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_4) / 42)) > 0 and var_289_2 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171067", "story_v_out_411171.awb") ~= 0 then
					local var_289_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171067", "story_v_out_411171.awb") / 1000

					if var_289_7 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_1
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_411171", "411171067", "story_v_out_411171.awb")

						arg_286_1:RecordAudio("411171067", var_289_8)
						arg_286_1:RecordAudio("411171067", var_289_8)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_411171", "411171067", "story_v_out_411171.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_411171", "411171067", "story_v_out_411171.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_9 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_9 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_9

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_9 and arg_286_1.time_ < var_289_1 + var_289_9 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play411171068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 411171068
		arg_290_1.duration_ = 7.43

		local var_290_0 = {
			zh = 7.433,
			ja = 7.033
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play411171069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.875

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[716].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:GetWordFromCfg(411171068)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 35 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 35)

				if (35 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 35)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171068", "story_v_out_411171.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171068", "story_v_out_411171.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_411171", "411171068", "story_v_out_411171.awb")

						arg_290_1:RecordAudio("411171068", var_293_6)
						arg_290_1:RecordAudio("411171068", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_411171", "411171068", "story_v_out_411171.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_411171", "411171068", "story_v_out_411171.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play411171069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 411171069
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play411171070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.95

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(411171069).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 38 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 38)

				if (38 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 38)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play411171070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 411171070
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play411171071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1024ui_story = arg_298_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_301_0 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				arg_298_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1024ui_story"].transform.position).z)
				arg_298_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1024ui_story"].transform.localEulerAngles = arg_298_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				arg_298_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1024ui_story"].transform.position).z)
				arg_298_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1024ui_story"].transform.localEulerAngles = arg_298_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_301_1 = 0
			local var_301_2 = 0.725

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_3 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(411171070).content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 29 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 29)

				if (29 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 29)) > 0 and var_301_2 < var_301_5 then
					arg_298_1.talkMaxDuration = var_301_5

					if var_301_5 + var_301_1 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + var_301_1
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_6 = math.max(var_301_2, arg_298_1.talkMaxDuration)

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_6 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_1) / var_301_6

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_1 + var_301_6 and arg_298_1.time_ < var_301_1 + var_301_6 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play411171071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 411171071
		arg_302_1.duration_ = 6.93

		local var_302_0 = {
			zh = 6.933,
			ja = 2.3
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play411171072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1024ui_story = arg_302_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1024ui_story"].transform.position).z)
				arg_302_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1024ui_story"].transform.localEulerAngles = arg_302_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_302_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1024ui_story"].transform.position).z)
				arg_302_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1024ui_story"].transform.localEulerAngles = arg_302_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1024ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1024ui_story == nil then
				arg_302_1.var_.characterEffect1024ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1024ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1024ui_story then
				arg_302_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024actionlink/1024action462")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_305_4 = 0
			local var_305_5 = 0.925

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(411171071)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 37 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 37)

				if (37 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 37)) > 0 and var_305_5 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171071", "story_v_out_411171.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171071", "story_v_out_411171.awb") / 1000

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end

					if var_305_6.prefab_name ~= "" and arg_302_1.actors_[var_305_6.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_6.prefab_name].transform, "story_v_out_411171", "411171071", "story_v_out_411171.awb")

						arg_302_1:RecordAudio("411171071", var_305_11)
						arg_302_1:RecordAudio("411171071", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_411171", "411171071", "story_v_out_411171.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_411171", "411171071", "story_v_out_411171.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play411171072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 411171072
		arg_306_1.duration_ = 8.27

		local var_306_0 = {
			zh = 8.266,
			ja = 4
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play411171073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 1.125

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:GetWordFromCfg(411171072)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 45 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 45)

				if (45 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 45)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171072", "story_v_out_411171.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171072", "story_v_out_411171.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_411171", "411171072", "story_v_out_411171.awb")

						arg_306_1:RecordAudio("411171072", var_309_6)
						arg_306_1:RecordAudio("411171072", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_411171", "411171072", "story_v_out_411171.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_411171", "411171072", "story_v_out_411171.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play411171073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 411171073
		arg_310_1.duration_ = 4.03

		local var_310_0 = {
			zh = 4,
			ja = 4.033
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play411171074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1024ui_story"]) and arg_310_1.var_.characterEffect1024ui_story == nil then
				arg_310_1.var_.characterEffect1024ui_story = arg_310_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1024ui_story"]) then
				if arg_310_1.var_.characterEffect1024ui_story and not isNil(arg_310_1.actors_["1024ui_story"]) then
					arg_310_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_0)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1024ui_story"]) and arg_310_1.var_.characterEffect1024ui_story then
				arg_310_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_313_1 = 0
			local var_313_2 = 0.425

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(411171073)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 17 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_4) / 17)

				if (17 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_4) / 17)) > 0 and var_313_2 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_1
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171073", "story_v_out_411171.awb") ~= 0 then
					local var_313_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171073", "story_v_out_411171.awb") / 1000

					if var_313_7 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_1
					end

					if var_313_3.prefab_name ~= "" and arg_310_1.actors_[var_313_3.prefab_name] ~= nil then
						local var_313_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_3.prefab_name].transform, "story_v_out_411171", "411171073", "story_v_out_411171.awb")

						arg_310_1:RecordAudio("411171073", var_313_8)
						arg_310_1:RecordAudio("411171073", var_313_8)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_411171", "411171073", "story_v_out_411171.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_411171", "411171073", "story_v_out_411171.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_9 = math.max(var_313_2, arg_310_1.talkMaxDuration)

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_9 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_1) / var_313_9

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_1 + var_313_9 and arg_310_1.time_ < var_313_1 + var_313_9 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play411171074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 411171074
		arg_314_1.duration_ = 2.83

		local var_314_0 = {
			zh = 1.733,
			ja = 2.833
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play411171075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1024ui_story"]) and arg_314_1.var_.characterEffect1024ui_story == nil then
				arg_314_1.var_.characterEffect1024ui_story = arg_314_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1024ui_story"]) then
				if arg_314_1.var_.characterEffect1024ui_story and not isNil(arg_314_1.actors_["1024ui_story"]) then
					arg_314_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1024ui_story"]) and arg_314_1.var_.characterEffect1024ui_story then
				arg_314_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_317_2 = 0
			local var_317_3 = 0.225

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_4 = arg_314_1:GetWordFromCfg(411171074)
				local var_317_5 = arg_314_1:FormatText(var_317_4.content)

				arg_314_1.text_.text = var_317_5

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_7 = 9 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 9)

				if (9 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 9)) > 0 and var_317_3 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_5
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171074", "story_v_out_411171.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171074", "story_v_out_411171.awb") / 1000

					if var_317_8 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_2
					end

					if var_317_4.prefab_name ~= "" and arg_314_1.actors_[var_317_4.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_4.prefab_name].transform, "story_v_out_411171", "411171074", "story_v_out_411171.awb")

						arg_314_1:RecordAudio("411171074", var_317_9)
						arg_314_1:RecordAudio("411171074", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_411171", "411171074", "story_v_out_411171.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_411171", "411171074", "story_v_out_411171.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_10 and arg_314_1.time_ < var_317_2 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play411171075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 411171075
		arg_318_1.duration_ = 2.5

		local var_318_0 = {
			zh = 2.033,
			ja = 2.5
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play411171076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1024ui_story"]) and arg_318_1.var_.characterEffect1024ui_story == nil then
				arg_318_1.var_.characterEffect1024ui_story = arg_318_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1024ui_story"]) then
				if arg_318_1.var_.characterEffect1024ui_story and not isNil(arg_318_1.actors_["1024ui_story"]) then
					arg_318_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_0)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1024ui_story"]) and arg_318_1.var_.characterEffect1024ui_story then
				arg_318_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_321_1 = 0
			local var_321_2 = 0.2

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(411171075)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_6 = 8 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_4) / 8)

				if (8 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_4) / 8)) > 0 and var_321_2 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171075", "story_v_out_411171.awb") ~= 0 then
					local var_321_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171075", "story_v_out_411171.awb") / 1000

					if var_321_7 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_1
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_out_411171", "411171075", "story_v_out_411171.awb")

						arg_318_1:RecordAudio("411171075", var_321_8)
						arg_318_1:RecordAudio("411171075", var_321_8)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_411171", "411171075", "story_v_out_411171.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_411171", "411171075", "story_v_out_411171.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_9 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_9 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_9

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_9 and arg_318_1.time_ < var_321_1 + var_321_9 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play411171076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 411171076
		arg_322_1.duration_ = 2.47

		local var_322_0 = {
			zh = 2.1,
			ja = 2.466
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play411171077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1024ui_story"]) and arg_322_1.var_.characterEffect1024ui_story == nil then
				arg_322_1.var_.characterEffect1024ui_story = arg_322_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1024ui_story"]) then
				if arg_322_1.var_.characterEffect1024ui_story and not isNil(arg_322_1.actors_["1024ui_story"]) then
					arg_322_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1024ui_story"]) and arg_322_1.var_.characterEffect1024ui_story then
				arg_322_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_2")
			end

			local var_325_2 = 0
			local var_325_3 = 0.3

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_4 = arg_322_1:GetWordFromCfg(411171076)
				local var_325_5 = arg_322_1:FormatText(var_325_4.content)

				arg_322_1.text_.text = var_325_5

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 12 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_5) / 12)

				if (12 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_5) / 12)) > 0 and var_325_3 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_5
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171076", "story_v_out_411171.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171076", "story_v_out_411171.awb") / 1000

					if var_325_8 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_2
					end

					if var_325_4.prefab_name ~= "" and arg_322_1.actors_[var_325_4.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_4.prefab_name].transform, "story_v_out_411171", "411171076", "story_v_out_411171.awb")

						arg_322_1:RecordAudio("411171076", var_325_9)
						arg_322_1:RecordAudio("411171076", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_411171", "411171076", "story_v_out_411171.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_411171", "411171076", "story_v_out_411171.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_10 and arg_322_1.time_ < var_325_2 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play411171077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 411171077
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play411171078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1024ui_story = arg_326_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1024ui_story"].transform.position).z)
				arg_326_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1024ui_story"].transform.localEulerAngles = arg_326_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1024ui_story"].transform.position).z)
				arg_326_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1024ui_story"].transform.localEulerAngles = arg_326_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["1024ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1024ui_story == nil then
				arg_326_1.var_.characterEffect1024ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect1024ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_2)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1024ui_story then
				arg_326_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_329_3 = 0
			local var_329_4 = 0.9

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_3 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_5 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(411171077).content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 36 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 36)

				if (36 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 36)) > 0 and var_329_4 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_3 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_3
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_4, arg_326_1.talkMaxDuration)

			if var_329_3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_3 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_3) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_3 + var_329_8 and arg_326_1.time_ < var_329_3 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play411171078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 411171078
		arg_330_1.duration_ = 4.27

		local var_330_0 = {
			zh = 2.533,
			ja = 4.266
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play411171079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1024ui_story = arg_330_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1024ui_story"].transform.position).z)
				arg_330_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1024ui_story"].transform.localEulerAngles = arg_330_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_330_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1024ui_story"].transform.position).z)
				arg_330_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1024ui_story"].transform.localEulerAngles = arg_330_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["1024ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1024ui_story == nil then
				arg_330_1.var_.characterEffect1024ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect1024ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1024ui_story then
				arg_330_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_333_4 = 0
			local var_333_5 = 0.275

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_6 = arg_330_1:GetWordFromCfg(411171078)
				local var_333_7 = arg_330_1:FormatText(var_333_6.content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 11 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 11)

				if (11 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 11)) > 0 and var_333_5 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9

					if var_333_9 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171078", "story_v_out_411171.awb") ~= 0 then
					local var_333_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171078", "story_v_out_411171.awb") / 1000

					if var_333_10 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_4
					end

					if var_333_6.prefab_name ~= "" and arg_330_1.actors_[var_333_6.prefab_name] ~= nil then
						local var_333_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_6.prefab_name].transform, "story_v_out_411171", "411171078", "story_v_out_411171.awb")

						arg_330_1:RecordAudio("411171078", var_333_11)
						arg_330_1:RecordAudio("411171078", var_333_11)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_411171", "411171078", "story_v_out_411171.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_411171", "411171078", "story_v_out_411171.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_12 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_12 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_4) / var_333_12

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_4 + var_333_12 and arg_330_1.time_ < var_333_4 + var_333_12 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play411171079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 411171079
		arg_334_1.duration_ = 6.73

		local var_334_0 = {
			zh = 4.2,
			ja = 6.733
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play411171080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1024ui_story"]) and arg_334_1.var_.characterEffect1024ui_story == nil then
				arg_334_1.var_.characterEffect1024ui_story = arg_334_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1024ui_story"]) then
				if arg_334_1.var_.characterEffect1024ui_story and not isNil(arg_334_1.actors_["1024ui_story"]) then
					arg_334_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1024ui_story"]) and arg_334_1.var_.characterEffect1024ui_story then
				arg_334_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_337_1 = 0
			local var_337_2 = 0.5

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(411171079)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 20 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 20)

				if (20 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 20)) > 0 and var_337_2 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171079", "story_v_out_411171.awb") ~= 0 then
					local var_337_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171079", "story_v_out_411171.awb") / 1000

					if var_337_7 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_1
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_411171", "411171079", "story_v_out_411171.awb")

						arg_334_1:RecordAudio("411171079", var_337_8)
						arg_334_1:RecordAudio("411171079", var_337_8)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_411171", "411171079", "story_v_out_411171.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_411171", "411171079", "story_v_out_411171.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_9 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_9 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_9

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_9 and arg_334_1.time_ < var_337_1 + var_337_9 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play411171080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 411171080
		arg_338_1.duration_ = 1.27

		local var_338_0 = {
			zh = 1.133,
			ja = 1.266
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play411171081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1024ui_story"]) and arg_338_1.var_.characterEffect1024ui_story == nil then
				arg_338_1.var_.characterEffect1024ui_story = arg_338_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1024ui_story"]) then
				if arg_338_1.var_.characterEffect1024ui_story and not isNil(arg_338_1.actors_["1024ui_story"]) then
					arg_338_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1024ui_story"]) and arg_338_1.var_.characterEffect1024ui_story then
				arg_338_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_341_2 = 0
			local var_341_3 = 0.1

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:GetWordFromCfg(411171080)
				local var_341_5 = arg_338_1:FormatText(var_341_4.content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 4 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 4)

				if (4 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 4)) > 0 and var_341_3 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171080", "story_v_out_411171.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171080", "story_v_out_411171.awb") / 1000

					if var_341_8 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_2
					end

					if var_341_4.prefab_name ~= "" and arg_338_1.actors_[var_341_4.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_4.prefab_name].transform, "story_v_out_411171", "411171080", "story_v_out_411171.awb")

						arg_338_1:RecordAudio("411171080", var_341_9)
						arg_338_1:RecordAudio("411171080", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_411171", "411171080", "story_v_out_411171.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_411171", "411171080", "story_v_out_411171.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_10 and arg_338_1.time_ < var_341_2 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play411171081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 411171081
		arg_342_1.duration_ = 5.13

		local var_342_0 = {
			zh = 4.833,
			ja = 5.133
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
				arg_342_0:Play411171082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1024ui_story"]) and arg_342_1.var_.characterEffect1024ui_story == nil then
				arg_342_1.var_.characterEffect1024ui_story = arg_342_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1024ui_story"]) then
				if arg_342_1.var_.characterEffect1024ui_story and not isNil(arg_342_1.actors_["1024ui_story"]) then
					arg_342_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1024ui_story"]) and arg_342_1.var_.characterEffect1024ui_story then
				arg_342_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_345_1 = 0
			local var_345_2 = 0.625

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:GetWordFromCfg(411171081)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_6 = 25 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_4) / 25)

				if (25 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_4) / 25)) > 0 and var_345_2 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171081", "story_v_out_411171.awb") ~= 0 then
					local var_345_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171081", "story_v_out_411171.awb") / 1000

					if var_345_7 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_1
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_out_411171", "411171081", "story_v_out_411171.awb")

						arg_342_1:RecordAudio("411171081", var_345_8)
						arg_342_1:RecordAudio("411171081", var_345_8)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_411171", "411171081", "story_v_out_411171.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_411171", "411171081", "story_v_out_411171.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_9 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_9 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_9

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_9 and arg_342_1.time_ < var_345_1 + var_345_9 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play411171082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 411171082
		arg_346_1.duration_ = 2.77

		local var_346_0 = {
			zh = 1.999999999999,
			ja = 2.766
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
				arg_346_0:Play411171083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1024ui_story"]) and arg_346_1.var_.characterEffect1024ui_story == nil then
				arg_346_1.var_.characterEffect1024ui_story = arg_346_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1024ui_story"]) then
				if arg_346_1.var_.characterEffect1024ui_story and not isNil(arg_346_1.actors_["1024ui_story"]) then
					arg_346_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1024ui_story"]) and arg_346_1.var_.characterEffect1024ui_story then
				arg_346_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_349_2 = 0
			local var_349_3 = 0.25

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_4 = arg_346_1:GetWordFromCfg(411171082)
				local var_349_5 = arg_346_1:FormatText(var_349_4.content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 10 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 10)

				if (10 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 10)) > 0 and var_349_3 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171082", "story_v_out_411171.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171082", "story_v_out_411171.awb") / 1000

					if var_349_8 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_2
					end

					if var_349_4.prefab_name ~= "" and arg_346_1.actors_[var_349_4.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_4.prefab_name].transform, "story_v_out_411171", "411171082", "story_v_out_411171.awb")

						arg_346_1:RecordAudio("411171082", var_349_9)
						arg_346_1:RecordAudio("411171082", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_411171", "411171082", "story_v_out_411171.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_411171", "411171082", "story_v_out_411171.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_3, arg_346_1.talkMaxDuration)

			if var_349_2 <= arg_346_1.time_ and arg_346_1.time_ < var_349_2 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_2) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_2 + var_349_10 and arg_346_1.time_ < var_349_2 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play411171083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 411171083
		arg_350_1.duration_ = 7.73

		local var_350_0 = {
			zh = 7.733,
			ja = 5.7
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
				arg_350_0:Play411171084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.975

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_1 = arg_350_1:GetWordFromCfg(411171083)
				local var_353_2 = arg_350_1:FormatText(var_353_1.content)

				arg_350_1.text_.text = var_353_2

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 39 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_2) / 39)

				if (39 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_2) / 39)) > 0 and var_353_0 < var_353_4 then
					arg_350_1.talkMaxDuration = var_353_4

					if var_353_4 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_4 + 0
					end
				end

				arg_350_1.text_.text = var_353_2
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171083", "story_v_out_411171.awb") ~= 0 then
					local var_353_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171083", "story_v_out_411171.awb") / 1000

					if var_353_5 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + 0
					end

					if var_353_1.prefab_name ~= "" and arg_350_1.actors_[var_353_1.prefab_name] ~= nil then
						local var_353_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_1.prefab_name].transform, "story_v_out_411171", "411171083", "story_v_out_411171.awb")

						arg_350_1:RecordAudio("411171083", var_353_6)
						arg_350_1:RecordAudio("411171083", var_353_6)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_411171", "411171083", "story_v_out_411171.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_411171", "411171083", "story_v_out_411171.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_7 and arg_350_1.time_ < 0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play411171084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 411171084
		arg_354_1.duration_ = 4.23

		local var_354_0 = {
			zh = 3.2,
			ja = 4.233
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
				arg_354_0:Play411171085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_357_0 = 0
			local var_357_1 = 0.375

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_2 = arg_354_1:GetWordFromCfg(411171084)
				local var_357_3 = arg_354_1:FormatText(var_357_2.content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 15 <= 0 and var_357_1 or var_357_1 * (utf8.len(var_357_3) / 15)

				if (15 <= 0 and var_357_1 or var_357_1 * (utf8.len(var_357_3) / 15)) > 0 and var_357_1 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171084", "story_v_out_411171.awb") ~= 0 then
					local var_357_6 = manager.audio:GetVoiceLength("story_v_out_411171", "411171084", "story_v_out_411171.awb") / 1000

					if var_357_6 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_0
					end

					if var_357_2.prefab_name ~= "" and arg_354_1.actors_[var_357_2.prefab_name] ~= nil then
						local var_357_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_2.prefab_name].transform, "story_v_out_411171", "411171084", "story_v_out_411171.awb")

						arg_354_1:RecordAudio("411171084", var_357_7)
						arg_354_1:RecordAudio("411171084", var_357_7)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_411171", "411171084", "story_v_out_411171.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_411171", "411171084", "story_v_out_411171.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_8 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_8 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_8

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_8 and arg_354_1.time_ < var_357_0 + var_357_8 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play411171085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 411171085
		arg_358_1.duration_ = 4.7

		local var_358_0 = {
			zh = 4.7,
			ja = 4.4
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play411171086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1024ui_story"]) and arg_358_1.var_.characterEffect1024ui_story == nil then
				arg_358_1.var_.characterEffect1024ui_story = arg_358_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1024ui_story"]) then
				if arg_358_1.var_.characterEffect1024ui_story and not isNil(arg_358_1.actors_["1024ui_story"]) then
					arg_358_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_0)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1024ui_story"]) and arg_358_1.var_.characterEffect1024ui_story then
				arg_358_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_361_1 = 0
			local var_361_2 = 0.575

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(411171085)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_6 = 23 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_4) / 23)

				if (23 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_4) / 23)) > 0 and var_361_2 < var_361_6 then
					arg_358_1.talkMaxDuration = var_361_6

					if var_361_6 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_6 + var_361_1
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171085", "story_v_out_411171.awb") ~= 0 then
					local var_361_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171085", "story_v_out_411171.awb") / 1000

					if var_361_7 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_1
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_out_411171", "411171085", "story_v_out_411171.awb")

						arg_358_1:RecordAudio("411171085", var_361_8)
						arg_358_1:RecordAudio("411171085", var_361_8)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_411171", "411171085", "story_v_out_411171.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_411171", "411171085", "story_v_out_411171.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_9 = math.max(var_361_2, arg_358_1.talkMaxDuration)

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_9 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_1) / var_361_9

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_1 + var_361_9 and arg_358_1.time_ < var_361_1 + var_361_9 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play411171086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 411171086
		arg_362_1.duration_ = 3.13

		local var_362_0 = {
			zh = 3.133,
			ja = 2.066
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
				arg_362_0:Play411171087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1024ui_story"]) and arg_362_1.var_.characterEffect1024ui_story == nil then
				arg_362_1.var_.characterEffect1024ui_story = arg_362_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1024ui_story"]) then
				if arg_362_1.var_.characterEffect1024ui_story and not isNil(arg_362_1.actors_["1024ui_story"]) then
					arg_362_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1024ui_story"]) and arg_362_1.var_.characterEffect1024ui_story then
				arg_362_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_1")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_365_2 = 0
			local var_365_3 = 0.35

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_4 = arg_362_1:GetWordFromCfg(411171086)
				local var_365_5 = arg_362_1:FormatText(var_365_4.content)

				arg_362_1.text_.text = var_365_5

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_7 = 14 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 14)

				if (14 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 14)) > 0 and var_365_3 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_2
					end
				end

				arg_362_1.text_.text = var_365_5
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171086", "story_v_out_411171.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171086", "story_v_out_411171.awb") / 1000

					if var_365_8 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_2
					end

					if var_365_4.prefab_name ~= "" and arg_362_1.actors_[var_365_4.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_4.prefab_name].transform, "story_v_out_411171", "411171086", "story_v_out_411171.awb")

						arg_362_1:RecordAudio("411171086", var_365_9)
						arg_362_1:RecordAudio("411171086", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_411171", "411171086", "story_v_out_411171.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_411171", "411171086", "story_v_out_411171.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_3, arg_362_1.talkMaxDuration)

			if var_365_2 <= arg_362_1.time_ and arg_362_1.time_ < var_365_2 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_2) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_2 + var_365_10 and arg_362_1.time_ < var_365_2 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play411171087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 411171087
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play411171088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1024ui_story = arg_366_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1024ui_story"].transform.position).z)
				arg_366_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1024ui_story"].transform.localEulerAngles = arg_366_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_366_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1024ui_story"].transform.position).z)
				arg_366_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1024ui_story"].transform.localEulerAngles = arg_366_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_369_1 = arg_366_1.actors_["1024ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect1024ui_story == nil then
				arg_366_1.var_.characterEffect1024ui_story = var_369_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_2 and not isNil(var_369_1) then
				if arg_366_1.var_.characterEffect1024ui_story and not isNil(var_369_1) then
					arg_366_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_2)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_2 and arg_366_1.time_ < 0 + var_369_2 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect1024ui_story then
				arg_366_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_369_3 = 0
			local var_369_4 = 0.95

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_3 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_5 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(411171087).content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_7 = 38 <= 0 and var_369_4 or var_369_4 * (utf8.len(var_369_5) / 38)

				if (38 <= 0 and var_369_4 or var_369_4 * (utf8.len(var_369_5) / 38)) > 0 and var_369_4 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_3 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_3
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_8 = math.max(var_369_4, arg_366_1.talkMaxDuration)

			if var_369_3 <= arg_366_1.time_ and arg_366_1.time_ < var_369_3 + var_369_8 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_3) / var_369_8

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_3 + var_369_8 and arg_366_1.time_ < var_369_3 + var_369_8 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play411171088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 411171088
		arg_370_1.duration_ = 10.17

		local var_370_0 = {
			zh = 5.2,
			ja = 10.166
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
				arg_370_0:Play411171089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.625

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_1 = arg_370_1:GetWordFromCfg(411171088)
				local var_373_2 = arg_370_1:FormatText(var_373_1.content)

				arg_370_1.text_.text = var_373_2

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_4 = 25 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 25)

				if (25 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 25)) > 0 and var_373_0 < var_373_4 then
					arg_370_1.talkMaxDuration = var_373_4

					if var_373_4 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_4 + 0
					end
				end

				arg_370_1.text_.text = var_373_2
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171088", "story_v_out_411171.awb") ~= 0 then
					local var_373_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171088", "story_v_out_411171.awb") / 1000

					if var_373_5 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + 0
					end

					if var_373_1.prefab_name ~= "" and arg_370_1.actors_[var_373_1.prefab_name] ~= nil then
						local var_373_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_1.prefab_name].transform, "story_v_out_411171", "411171088", "story_v_out_411171.awb")

						arg_370_1:RecordAudio("411171088", var_373_6)
						arg_370_1:RecordAudio("411171088", var_373_6)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_411171", "411171088", "story_v_out_411171.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_411171", "411171088", "story_v_out_411171.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_7 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_7

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play411171089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 411171089
		arg_374_1.duration_ = 2.3

		local var_374_0 = {
			zh = 2.3,
			ja = 1.666
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
				arg_374_0:Play411171090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.15

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[716].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_1 = arg_374_1:GetWordFromCfg(411171089)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 6 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 6)

				if (6 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 6)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171089", "story_v_out_411171.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171089", "story_v_out_411171.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_411171", "411171089", "story_v_out_411171.awb")

						arg_374_1:RecordAudio("411171089", var_377_6)
						arg_374_1:RecordAudio("411171089", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_411171", "411171089", "story_v_out_411171.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_411171", "411171089", "story_v_out_411171.awb")
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
	Play411171090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 411171090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play411171091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.8

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(411171090).content)

				arg_378_1.text_.text = var_381_1

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_3 = 32 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_1) / 32)

				if (32 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_1) / 32)) > 0 and var_381_0 < var_381_3 then
					arg_378_1.talkMaxDuration = var_381_3

					if var_381_3 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_3 + 0
					end
				end

				arg_378_1.text_.text = var_381_1
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_4 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_4 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_4

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_4 and arg_378_1.time_ < 0 + var_381_4 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play411171091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 411171091
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play411171092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 1.15

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(411171091).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 46 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 46)

				if (46 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 46)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play411171092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 411171092
		arg_386_1.duration_ = 2.63

		local var_386_0 = {
			zh = 1.999999999999,
			ja = 2.633
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
				arg_386_0:Play411171093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1024ui_story = arg_386_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_389_0 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 then
				arg_386_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_386_1.time_ - 0) / var_389_0)
				arg_386_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1024ui_story"].transform.position).z)
				arg_386_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1024ui_story"].transform.localEulerAngles = arg_386_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 then
				arg_386_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_386_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1024ui_story"].transform.position).z)
				arg_386_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1024ui_story"].transform.localEulerAngles = arg_386_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_389_1 = arg_386_1.actors_["1024ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1024ui_story == nil then
				arg_386_1.var_.characterEffect1024ui_story = var_389_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_2 and not isNil(var_389_1) then
				if arg_386_1.var_.characterEffect1024ui_story and not isNil(var_389_1) then
					arg_386_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_2 and arg_386_1.time_ < 0 + var_389_2 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1024ui_story then
				arg_386_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_2")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_389_4 = 0
			local var_389_5 = 0.25

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_6 = arg_386_1:GetWordFromCfg(411171092)
				local var_389_7 = arg_386_1:FormatText(var_389_6.content)

				arg_386_1.text_.text = var_389_7

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_9 = 10 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 10)

				if (10 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 10)) > 0 and var_389_5 < var_389_9 then
					arg_386_1.talkMaxDuration = var_389_9

					if var_389_9 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_9 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_7
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171092", "story_v_out_411171.awb") ~= 0 then
					local var_389_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171092", "story_v_out_411171.awb") / 1000

					if var_389_10 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_4
					end

					if var_389_6.prefab_name ~= "" and arg_386_1.actors_[var_389_6.prefab_name] ~= nil then
						local var_389_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_6.prefab_name].transform, "story_v_out_411171", "411171092", "story_v_out_411171.awb")

						arg_386_1:RecordAudio("411171092", var_389_11)
						arg_386_1:RecordAudio("411171092", var_389_11)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_411171", "411171092", "story_v_out_411171.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_411171", "411171092", "story_v_out_411171.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_12 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_12 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_12

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_12 and arg_386_1.time_ < var_389_4 + var_389_12 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play411171093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 411171093
		arg_390_1.duration_ = 11.03

		local var_390_0 = {
			zh = 7.233,
			ja = 11.033
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play411171094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1024ui_story"]) and arg_390_1.var_.characterEffect1024ui_story == nil then
				arg_390_1.var_.characterEffect1024ui_story = arg_390_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1024ui_story"]) then
				if arg_390_1.var_.characterEffect1024ui_story and not isNil(arg_390_1.actors_["1024ui_story"]) then
					arg_390_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_0)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1024ui_story"]) and arg_390_1.var_.characterEffect1024ui_story then
				arg_390_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_393_1 = 0
			local var_393_2 = 0.925

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_3 = arg_390_1:GetWordFromCfg(411171093)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_6 = 37 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_4) / 37)

				if (37 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_4) / 37)) > 0 and var_393_2 < var_393_6 then
					arg_390_1.talkMaxDuration = var_393_6

					if var_393_6 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_1
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171093", "story_v_out_411171.awb") ~= 0 then
					local var_393_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171093", "story_v_out_411171.awb") / 1000

					if var_393_7 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_1
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_out_411171", "411171093", "story_v_out_411171.awb")

						arg_390_1:RecordAudio("411171093", var_393_8)
						arg_390_1:RecordAudio("411171093", var_393_8)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_411171", "411171093", "story_v_out_411171.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_411171", "411171093", "story_v_out_411171.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_9 = math.max(var_393_2, arg_390_1.talkMaxDuration)

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_9 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_1) / var_393_9

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_1 + var_393_9 and arg_390_1.time_ < var_393_1 + var_393_9 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play411171094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 411171094
		arg_394_1.duration_ = 3.87

		local var_394_0 = {
			zh = 2.566,
			ja = 3.866
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
				arg_394_0:Play411171095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.375

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_1 = arg_394_1:GetWordFromCfg(411171094)
				local var_397_2 = arg_394_1:FormatText(var_397_1.content)

				arg_394_1.text_.text = var_397_2

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 15 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 15)

				if (15 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 15)) > 0 and var_397_0 < var_397_4 then
					arg_394_1.talkMaxDuration = var_397_4

					if var_397_4 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_4 + 0
					end
				end

				arg_394_1.text_.text = var_397_2
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171094", "story_v_out_411171.awb") ~= 0 then
					local var_397_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171094", "story_v_out_411171.awb") / 1000

					if var_397_5 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + 0
					end

					if var_397_1.prefab_name ~= "" and arg_394_1.actors_[var_397_1.prefab_name] ~= nil then
						local var_397_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_1.prefab_name].transform, "story_v_out_411171", "411171094", "story_v_out_411171.awb")

						arg_394_1:RecordAudio("411171094", var_397_6)
						arg_394_1:RecordAudio("411171094", var_397_6)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_411171", "411171094", "story_v_out_411171.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_411171", "411171094", "story_v_out_411171.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play411171095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 411171095
		arg_398_1.duration_ = 3.87

		local var_398_0 = {
			zh = 3.3,
			ja = 3.866
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play411171096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1024ui_story = arg_398_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1024ui_story"].transform.position).z)
				arg_398_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1024ui_story"].transform.localEulerAngles = arg_398_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_398_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1024ui_story"].transform.position).z)
				arg_398_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1024ui_story"].transform.localEulerAngles = arg_398_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_401_1 = arg_398_1.actors_["1024ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1024ui_story == nil then
				arg_398_1.var_.characterEffect1024ui_story = var_401_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 and not isNil(var_401_1) then
				if arg_398_1.var_.characterEffect1024ui_story and not isNil(var_401_1) then
					arg_398_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1024ui_story then
				arg_398_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_401_4 = 0
			local var_401_5 = 0.4

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_6 = arg_398_1:GetWordFromCfg(411171095)
				local var_401_7 = arg_398_1:FormatText(var_401_6.content)

				arg_398_1.text_.text = var_401_7

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 16 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 16)

				if (16 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 16)) > 0 and var_401_5 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_7
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171095", "story_v_out_411171.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171095", "story_v_out_411171.awb") / 1000

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end

					if var_401_6.prefab_name ~= "" and arg_398_1.actors_[var_401_6.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_6.prefab_name].transform, "story_v_out_411171", "411171095", "story_v_out_411171.awb")

						arg_398_1:RecordAudio("411171095", var_401_11)
						arg_398_1:RecordAudio("411171095", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_411171", "411171095", "story_v_out_411171.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_411171", "411171095", "story_v_out_411171.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 <= arg_398_1.time_ and arg_398_1.time_ < var_401_4 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_4) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_4 + var_401_12 and arg_398_1.time_ < var_401_4 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play411171096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 411171096
		arg_402_1.duration_ = 7.9

		local var_402_0 = {
			zh = 7.9,
			ja = 7.233
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
				arg_402_0:Play411171097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_1")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_405_0 = 0
			local var_405_1 = 1.05

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_2 = arg_402_1:GetWordFromCfg(411171096)
				local var_405_3 = arg_402_1:FormatText(var_405_2.content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 42 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_3) / 42)

				if (42 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_3) / 42)) > 0 and var_405_1 < var_405_5 then
					arg_402_1.talkMaxDuration = var_405_5

					if var_405_5 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171096", "story_v_out_411171.awb") ~= 0 then
					local var_405_6 = manager.audio:GetVoiceLength("story_v_out_411171", "411171096", "story_v_out_411171.awb") / 1000

					if var_405_6 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_0
					end

					if var_405_2.prefab_name ~= "" and arg_402_1.actors_[var_405_2.prefab_name] ~= nil then
						local var_405_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_2.prefab_name].transform, "story_v_out_411171", "411171096", "story_v_out_411171.awb")

						arg_402_1:RecordAudio("411171096", var_405_7)
						arg_402_1:RecordAudio("411171096", var_405_7)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_411171", "411171096", "story_v_out_411171.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_411171", "411171096", "story_v_out_411171.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_8 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_8 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_8

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_8 and arg_402_1.time_ < var_405_0 + var_405_8 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play411171097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 411171097
		arg_406_1.duration_ = 4.63

		local var_406_0 = {
			zh = 1.533,
			ja = 4.633
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play411171098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1024ui_story"]) and arg_406_1.var_.characterEffect1024ui_story == nil then
				arg_406_1.var_.characterEffect1024ui_story = arg_406_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1024ui_story"]) then
				if arg_406_1.var_.characterEffect1024ui_story and not isNil(arg_406_1.actors_["1024ui_story"]) then
					arg_406_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_0)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1024ui_story"]) and arg_406_1.var_.characterEffect1024ui_story then
				arg_406_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_409_1 = 0
			local var_409_2 = 0.15

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:GetWordFromCfg(411171097)
				local var_409_4 = arg_406_1:FormatText(var_409_3.content)

				arg_406_1.text_.text = var_409_4

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_6 = 6 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_4) / 6)

				if (6 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_4) / 6)) > 0 and var_409_2 < var_409_6 then
					arg_406_1.talkMaxDuration = var_409_6

					if var_409_6 + var_409_1 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_6 + var_409_1
					end
				end

				arg_406_1.text_.text = var_409_4
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171097", "story_v_out_411171.awb") ~= 0 then
					local var_409_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171097", "story_v_out_411171.awb") / 1000

					if var_409_7 + var_409_1 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_1
					end

					if var_409_3.prefab_name ~= "" and arg_406_1.actors_[var_409_3.prefab_name] ~= nil then
						local var_409_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_3.prefab_name].transform, "story_v_out_411171", "411171097", "story_v_out_411171.awb")

						arg_406_1:RecordAudio("411171097", var_409_8)
						arg_406_1:RecordAudio("411171097", var_409_8)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_411171", "411171097", "story_v_out_411171.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_411171", "411171097", "story_v_out_411171.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_9 = math.max(var_409_2, arg_406_1.talkMaxDuration)

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_9 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_1) / var_409_9

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_1 + var_409_9 and arg_406_1.time_ < var_409_1 + var_409_9 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play411171098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 411171098
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play411171099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1024ui_story = arg_410_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_413_0 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 then
				arg_410_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_410_1.time_ - 0) / var_413_0)
				arg_410_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1024ui_story"].transform.position).z)
				arg_410_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1024ui_story"].transform.localEulerAngles = arg_410_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 then
				arg_410_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_410_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1024ui_story"].transform.position).z)
				arg_410_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1024ui_story"].transform.localEulerAngles = arg_410_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_413_1 = 0
			local var_413_2 = 1.025

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(411171098).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 41 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 41)

				if (41 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 41)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play411171099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 411171099
		arg_414_1.duration_ = 5.5

		local var_414_0 = {
			zh = 5.2,
			ja = 5.5
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
				arg_414_0:Play411171100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.4

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:GetWordFromCfg(411171099)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 16 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 16)

				if (16 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 16)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171099", "story_v_out_411171.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171099", "story_v_out_411171.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_411171", "411171099", "story_v_out_411171.awb")

						arg_414_1:RecordAudio("411171099", var_417_6)
						arg_414_1:RecordAudio("411171099", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_411171", "411171099", "story_v_out_411171.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_411171", "411171099", "story_v_out_411171.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play411171100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 411171100
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play411171101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.7

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(411171100).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 28 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 28)

				if (28 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 28)) > 0 and var_421_0 < var_421_3 then
					arg_418_1.talkMaxDuration = var_421_3

					if var_421_3 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_3 + 0
					end
				end

				arg_418_1.text_.text = var_421_1
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_4 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_4

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play411171101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 411171101
		arg_422_1.duration_ = 2

		local var_422_0 = {
			zh = 1.4,
			ja = 2
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play411171102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.1

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_1 = arg_422_1:GetWordFromCfg(411171101)
				local var_425_2 = arg_422_1:FormatText(var_425_1.content)

				arg_422_1.text_.text = var_425_2

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 4 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 4)

				if (4 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 4)) > 0 and var_425_0 < var_425_4 then
					arg_422_1.talkMaxDuration = var_425_4

					if var_425_4 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_4 + 0
					end
				end

				arg_422_1.text_.text = var_425_2
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171101", "story_v_out_411171.awb") ~= 0 then
					local var_425_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171101", "story_v_out_411171.awb") / 1000

					if var_425_5 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + 0
					end

					if var_425_1.prefab_name ~= "" and arg_422_1.actors_[var_425_1.prefab_name] ~= nil then
						local var_425_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_1.prefab_name].transform, "story_v_out_411171", "411171101", "story_v_out_411171.awb")

						arg_422_1:RecordAudio("411171101", var_425_6)
						arg_422_1:RecordAudio("411171101", var_425_6)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_411171", "411171101", "story_v_out_411171.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_411171", "411171101", "story_v_out_411171.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_7 and arg_422_1.time_ < 0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play411171102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 411171102
		arg_426_1.duration_ = 8.9

		local var_426_0 = {
			zh = 4,
			ja = 8.9
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play411171103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.375

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_1 = arg_426_1:GetWordFromCfg(411171102)
				local var_429_2 = arg_426_1:FormatText(var_429_1.content)

				arg_426_1.text_.text = var_429_2

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 15 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 15)

				if (15 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 15)) > 0 and var_429_0 < var_429_4 then
					arg_426_1.talkMaxDuration = var_429_4

					if var_429_4 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_4 + 0
					end
				end

				arg_426_1.text_.text = var_429_2
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171102", "story_v_out_411171.awb") ~= 0 then
					local var_429_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171102", "story_v_out_411171.awb") / 1000

					if var_429_5 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + 0
					end

					if var_429_1.prefab_name ~= "" and arg_426_1.actors_[var_429_1.prefab_name] ~= nil then
						local var_429_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_1.prefab_name].transform, "story_v_out_411171", "411171102", "story_v_out_411171.awb")

						arg_426_1:RecordAudio("411171102", var_429_6)
						arg_426_1:RecordAudio("411171102", var_429_6)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_411171", "411171102", "story_v_out_411171.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_411171", "411171102", "story_v_out_411171.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play411171103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 411171103
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play411171104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 1

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(411171103).content)

				arg_430_1.text_.text = var_433_1

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_3 = 40 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 40)

				if (40 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 40)) > 0 and var_433_0 < var_433_3 then
					arg_430_1.talkMaxDuration = var_433_3

					if var_433_3 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_3 + 0
					end
				end

				arg_430_1.text_.text = var_433_1
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_4 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_4

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play411171104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 411171104
		arg_434_1.duration_ = 13.27

		local var_434_0 = {
			zh = 6.2,
			ja = 13.266
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play411171105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.675

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:GetWordFromCfg(411171104)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 27 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 27)

				if (27 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 27)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171104", "story_v_out_411171.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171104", "story_v_out_411171.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_out_411171", "411171104", "story_v_out_411171.awb")

						arg_434_1:RecordAudio("411171104", var_437_6)
						arg_434_1:RecordAudio("411171104", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_411171", "411171104", "story_v_out_411171.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_411171", "411171104", "story_v_out_411171.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play411171105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 411171105
		arg_438_1.duration_ = 4.1

		local var_438_0 = {
			zh = 3.066,
			ja = 4.1
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
				arg_438_0:Play411171106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.4

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[715].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:GetWordFromCfg(411171105)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 16 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 16)

				if (16 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 16)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171105", "story_v_out_411171.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171105", "story_v_out_411171.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_out_411171", "411171105", "story_v_out_411171.awb")

						arg_438_1:RecordAudio("411171105", var_441_6)
						arg_438_1:RecordAudio("411171105", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_411171", "411171105", "story_v_out_411171.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_411171", "411171105", "story_v_out_411171.awb")
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
	Play411171106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 411171106
		arg_442_1.duration_ = 2.17

		local var_442_0 = {
			zh = 0.999999999999,
			ja = 2.166
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play411171107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.075

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_1 = arg_442_1:GetWordFromCfg(411171106)
				local var_445_2 = arg_442_1:FormatText(var_445_1.content)

				arg_442_1.text_.text = var_445_2

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 3 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 3)

				if (3 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 3)) > 0 and var_445_0 < var_445_4 then
					arg_442_1.talkMaxDuration = var_445_4

					if var_445_4 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_4 + 0
					end
				end

				arg_442_1.text_.text = var_445_2
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171106", "story_v_out_411171.awb") ~= 0 then
					local var_445_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171106", "story_v_out_411171.awb") / 1000

					if var_445_5 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + 0
					end

					if var_445_1.prefab_name ~= "" and arg_442_1.actors_[var_445_1.prefab_name] ~= nil then
						local var_445_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_1.prefab_name].transform, "story_v_out_411171", "411171106", "story_v_out_411171.awb")

						arg_442_1:RecordAudio("411171106", var_445_6)
						arg_442_1:RecordAudio("411171106", var_445_6)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_411171", "411171106", "story_v_out_411171.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_411171", "411171106", "story_v_out_411171.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play411171107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 411171107
		arg_446_1.duration_ = 10.27

		local var_446_0 = {
			zh = 8.533,
			ja = 10.266
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play411171108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.9

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_1 = arg_446_1:GetWordFromCfg(411171107)
				local var_449_2 = arg_446_1:FormatText(var_449_1.content)

				arg_446_1.text_.text = var_449_2

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 36 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 36)

				if (36 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 36)) > 0 and var_449_0 < var_449_4 then
					arg_446_1.talkMaxDuration = var_449_4

					if var_449_4 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_4 + 0
					end
				end

				arg_446_1.text_.text = var_449_2
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171107", "story_v_out_411171.awb") ~= 0 then
					local var_449_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171107", "story_v_out_411171.awb") / 1000

					if var_449_5 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + 0
					end

					if var_449_1.prefab_name ~= "" and arg_446_1.actors_[var_449_1.prefab_name] ~= nil then
						local var_449_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_1.prefab_name].transform, "story_v_out_411171", "411171107", "story_v_out_411171.awb")

						arg_446_1:RecordAudio("411171107", var_449_6)
						arg_446_1:RecordAudio("411171107", var_449_6)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_411171", "411171107", "story_v_out_411171.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_411171", "411171107", "story_v_out_411171.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play411171108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 411171108
		arg_450_1.duration_ = 2.6

		local var_450_0 = {
			zh = 2.6,
			ja = 1.966
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
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play411171109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos1024ui_story = arg_450_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_453_0 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 then
				arg_450_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_450_1.time_ - 0) / var_453_0)
				arg_450_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1024ui_story"].transform.position).z)
				arg_450_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["1024ui_story"].transform.localEulerAngles = arg_450_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 then
				arg_450_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_450_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1024ui_story"].transform.position).z)
				arg_450_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["1024ui_story"].transform.localEulerAngles = arg_450_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_453_1 = arg_450_1.actors_["1024ui_story"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_1) and arg_450_1.var_.characterEffect1024ui_story == nil then
				arg_450_1.var_.characterEffect1024ui_story = var_453_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_2 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_2 and not isNil(var_453_1) then
				if arg_450_1.var_.characterEffect1024ui_story and not isNil(var_453_1) then
					arg_450_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= 0 + var_453_2 and arg_450_1.time_ < 0 + var_453_2 + arg_453_0 and not isNil(var_453_1) and arg_450_1.var_.characterEffect1024ui_story then
				arg_450_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_453_4 = 0
			local var_453_5 = 0.325

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_4 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_6 = arg_450_1:GetWordFromCfg(411171108)
				local var_453_7 = arg_450_1:FormatText(var_453_6.content)

				arg_450_1.text_.text = var_453_7

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_9 = 13 <= 0 and var_453_5 or var_453_5 * (utf8.len(var_453_7) / 13)

				if (13 <= 0 and var_453_5 or var_453_5 * (utf8.len(var_453_7) / 13)) > 0 and var_453_5 < var_453_9 then
					arg_450_1.talkMaxDuration = var_453_9

					if var_453_9 + var_453_4 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_9 + var_453_4
					end
				end

				arg_450_1.text_.text = var_453_7
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171108", "story_v_out_411171.awb") ~= 0 then
					local var_453_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171108", "story_v_out_411171.awb") / 1000

					if var_453_10 + var_453_4 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_10 + var_453_4
					end

					if var_453_6.prefab_name ~= "" and arg_450_1.actors_[var_453_6.prefab_name] ~= nil then
						local var_453_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_6.prefab_name].transform, "story_v_out_411171", "411171108", "story_v_out_411171.awb")

						arg_450_1:RecordAudio("411171108", var_453_11)
						arg_450_1:RecordAudio("411171108", var_453_11)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_411171", "411171108", "story_v_out_411171.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_411171", "411171108", "story_v_out_411171.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_12 = math.max(var_453_5, arg_450_1.talkMaxDuration)

			if var_453_4 <= arg_450_1.time_ and arg_450_1.time_ < var_453_4 + var_453_12 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_4) / var_453_12

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_4 + var_453_12 and arg_450_1.time_ < var_453_4 + var_453_12 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play411171109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 411171109
		arg_454_1.duration_ = 9.5

		local var_454_0 = {
			zh = 4.3,
			ja = 9.5
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play411171110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1024ui_story"]) and arg_454_1.var_.characterEffect1024ui_story == nil then
				arg_454_1.var_.characterEffect1024ui_story = arg_454_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1024ui_story"]) then
				if arg_454_1.var_.characterEffect1024ui_story and not isNil(arg_454_1.actors_["1024ui_story"]) then
					arg_454_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_454_1.time_ - 0) / var_457_0)
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1024ui_story"]) and arg_454_1.var_.characterEffect1024ui_story then
				arg_454_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_457_1 = 0
			local var_457_2 = 0.575

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:GetWordFromCfg(411171109)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_6 = 23 <= 0 and var_457_2 or var_457_2 * (utf8.len(var_457_4) / 23)

				if (23 <= 0 and var_457_2 or var_457_2 * (utf8.len(var_457_4) / 23)) > 0 and var_457_2 < var_457_6 then
					arg_454_1.talkMaxDuration = var_457_6

					if var_457_6 + var_457_1 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_6 + var_457_1
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171109", "story_v_out_411171.awb") ~= 0 then
					local var_457_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171109", "story_v_out_411171.awb") / 1000

					if var_457_7 + var_457_1 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_1
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_out_411171", "411171109", "story_v_out_411171.awb")

						arg_454_1:RecordAudio("411171109", var_457_8)
						arg_454_1:RecordAudio("411171109", var_457_8)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_411171", "411171109", "story_v_out_411171.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_411171", "411171109", "story_v_out_411171.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_9 = math.max(var_457_2, arg_454_1.talkMaxDuration)

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_9 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_1) / var_457_9

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_1 + var_457_9 and arg_454_1.time_ < var_457_1 + var_457_9 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play411171110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 411171110
		arg_458_1.duration_ = 6.83

		local var_458_0 = {
			zh = 6.833,
			ja = 3.433
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play411171111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1024ui_story"]) and arg_458_1.var_.characterEffect1024ui_story == nil then
				arg_458_1.var_.characterEffect1024ui_story = arg_458_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1024ui_story"]) then
				if arg_458_1.var_.characterEffect1024ui_story and not isNil(arg_458_1.actors_["1024ui_story"]) then
					arg_458_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1024ui_story"]) and arg_458_1.var_.characterEffect1024ui_story then
				arg_458_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_2")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_461_2 = 0
			local var_461_3 = 0.95

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_4 = arg_458_1:GetWordFromCfg(411171110)
				local var_461_5 = arg_458_1:FormatText(var_461_4.content)

				arg_458_1.text_.text = var_461_5

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_7 = 38 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 38)

				if (38 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 38)) > 0 and var_461_3 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_5
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171110", "story_v_out_411171.awb") ~= 0 then
					local var_461_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171110", "story_v_out_411171.awb") / 1000

					if var_461_8 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_2
					end

					if var_461_4.prefab_name ~= "" and arg_458_1.actors_[var_461_4.prefab_name] ~= nil then
						local var_461_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_4.prefab_name].transform, "story_v_out_411171", "411171110", "story_v_out_411171.awb")

						arg_458_1:RecordAudio("411171110", var_461_9)
						arg_458_1:RecordAudio("411171110", var_461_9)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_411171", "411171110", "story_v_out_411171.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_411171", "411171110", "story_v_out_411171.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_10 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_10 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_10

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_10 and arg_458_1.time_ < var_461_2 + var_461_10 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play411171111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 411171111
		arg_462_1.duration_ = 2.2

		local var_462_0 = {
			zh = 0.999999999999,
			ja = 2.2
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play411171112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1024ui_story"]) and arg_462_1.var_.characterEffect1024ui_story == nil then
				arg_462_1.var_.characterEffect1024ui_story = arg_462_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1024ui_story"]) then
				if arg_462_1.var_.characterEffect1024ui_story and not isNil(arg_462_1.actors_["1024ui_story"]) then
					arg_462_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_462_1.time_ - 0) / var_465_0)
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1024ui_story"]) and arg_462_1.var_.characterEffect1024ui_story then
				arg_462_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_465_1 = 0
			local var_465_2 = 0.075

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_3 = arg_462_1:GetWordFromCfg(411171111)
				local var_465_4 = arg_462_1:FormatText(var_465_3.content)

				arg_462_1.text_.text = var_465_4

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_6 = 3 <= 0 and var_465_2 or var_465_2 * (utf8.len(var_465_4) / 3)

				if (3 <= 0 and var_465_2 or var_465_2 * (utf8.len(var_465_4) / 3)) > 0 and var_465_2 < var_465_6 then
					arg_462_1.talkMaxDuration = var_465_6

					if var_465_6 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_1
					end
				end

				arg_462_1.text_.text = var_465_4
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171111", "story_v_out_411171.awb") ~= 0 then
					local var_465_7 = manager.audio:GetVoiceLength("story_v_out_411171", "411171111", "story_v_out_411171.awb") / 1000

					if var_465_7 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_1
					end

					if var_465_3.prefab_name ~= "" and arg_462_1.actors_[var_465_3.prefab_name] ~= nil then
						local var_465_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_3.prefab_name].transform, "story_v_out_411171", "411171111", "story_v_out_411171.awb")

						arg_462_1:RecordAudio("411171111", var_465_8)
						arg_462_1:RecordAudio("411171111", var_465_8)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_411171", "411171111", "story_v_out_411171.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_411171", "411171111", "story_v_out_411171.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_9 = math.max(var_465_2, arg_462_1.talkMaxDuration)

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_9 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_1) / var_465_9

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_1 + var_465_9 and arg_462_1.time_ < var_465_1 + var_465_9 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play411171112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 411171112
		arg_466_1.duration_ = 5.6

		local var_466_0 = {
			zh = 3.8,
			ja = 5.6
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play411171113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.525

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_1 = arg_466_1:GetWordFromCfg(411171112)
				local var_469_2 = arg_466_1:FormatText(var_469_1.content)

				arg_466_1.text_.text = var_469_2

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 21 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 21)

				if (21 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 21)) > 0 and var_469_0 < var_469_4 then
					arg_466_1.talkMaxDuration = var_469_4

					if var_469_4 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_4 + 0
					end
				end

				arg_466_1.text_.text = var_469_2
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171112", "story_v_out_411171.awb") ~= 0 then
					local var_469_5 = manager.audio:GetVoiceLength("story_v_out_411171", "411171112", "story_v_out_411171.awb") / 1000

					if var_469_5 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + 0
					end

					if var_469_1.prefab_name ~= "" and arg_466_1.actors_[var_469_1.prefab_name] ~= nil then
						local var_469_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_1.prefab_name].transform, "story_v_out_411171", "411171112", "story_v_out_411171.awb")

						arg_466_1:RecordAudio("411171112", var_469_6)
						arg_466_1:RecordAudio("411171112", var_469_6)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_411171", "411171112", "story_v_out_411171.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_411171", "411171112", "story_v_out_411171.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_7 and arg_466_1.time_ < 0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play411171113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 411171113
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
			arg_470_1.auto_ = false
		end

		function arg_470_1.playNext_(arg_472_0)
			arg_470_1.onStoryFinished_()
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1024ui_story = arg_470_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1024ui_story"].transform.position).z)
				arg_470_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1024ui_story"].transform.localEulerAngles = arg_470_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1024ui_story"].transform.position).z)
				arg_470_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1024ui_story"].transform.localEulerAngles = arg_470_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["1024ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1024ui_story == nil then
				arg_470_1.var_.characterEffect1024ui_story = var_473_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 and not isNil(var_473_1) then
				if arg_470_1.var_.characterEffect1024ui_story and not isNil(var_473_1) then
					arg_470_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 0) / var_473_2)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1024ui_story then
				arg_470_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				if arg_470_1.var_.effect工厂雨 then
					Object.Destroy(arg_470_1.var_.effect工厂雨)

					arg_470_1.var_.effect工厂雨 = nil
				end
			end

			local var_473_4 = 0
			local var_473_5 = 1.05

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_4 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_6 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(411171113).content)

				arg_470_1.text_.text = var_473_6

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_8 = 42 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_6) / 42)

				if (42 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_6) / 42)) > 0 and var_473_5 < var_473_8 then
					arg_470_1.talkMaxDuration = var_473_8

					if var_473_8 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_4
					end
				end

				arg_470_1.text_.text = var_473_6
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_9 = math.max(var_473_5, arg_470_1.talkMaxDuration)

			if var_473_4 <= arg_470_1.time_ and arg_470_1.time_ < var_473_4 + var_473_9 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_4) / var_473_9

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_4 + var_473_9 and arg_470_1.time_ < var_473_4 + var_473_9 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10b",
		"TextureConfig/Background/ST75"
	},
	voices = {
		"story_v_out_411171.awb"
	}
}
