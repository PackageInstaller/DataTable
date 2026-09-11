return {
	Play320202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320202001
		arg_1_1.duration_ = 8.9

		local var_1_0 = {
			zh = 8.9,
			ja = 8.7
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
				arg_1_0:Play320202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L05f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L05f")
				var_4_0.name = "L05f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L05f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L05f

				arg_1_1.bgs_.L05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L05f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.925

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(320202001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 37 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 37)

				if (37 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 37)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202001", "story_v_out_320202.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_320202", "320202001", "story_v_out_320202.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_320202", "320202001", "story_v_out_320202.awb")

						arg_1_1:RecordAudio("320202001", var_4_23)
						arg_1_1:RecordAudio("320202001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320202", "320202001", "story_v_out_320202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320202", "320202001", "story_v_out_320202.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320202002
		arg_9_1.duration_ = 7.1

		local var_9_0 = {
			zh = 4.2,
			ja = 7.1
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
				arg_9_0:Play320202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1011ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1011ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1011ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1011ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1011ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1011ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.71, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1011ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1011ui_story == nil then
				arg_9_1.var_.characterEffect1011ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1011ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1011ui_story then
				arg_9_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.5

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(320202002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 20 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 20)

				if (20 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 20)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202002", "story_v_out_320202.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_320202", "320202002", "story_v_out_320202.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_320202", "320202002", "story_v_out_320202.awb")

						arg_9_1:RecordAudio("320202002", var_12_15)
						arg_9_1:RecordAudio("320202002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320202", "320202002", "story_v_out_320202.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320202", "320202002", "story_v_out_320202.awb")
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
				actorName = "1011ui_story",
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
	Play320202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320202003
		arg_13_1.duration_ = 9

		local var_13_0 = {
			zh = 7.2,
			ja = 9
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
				arg_13_0:Play320202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1011ui_story"]) and arg_13_1.var_.characterEffect1011ui_story == nil then
				arg_13_1.var_.characterEffect1011ui_story = arg_13_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1011ui_story"]) then
				if arg_13_1.var_.characterEffect1011ui_story and not isNil(arg_13_1.actors_["1011ui_story"]) then
					arg_13_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1011ui_story"]) and arg_13_1.var_.characterEffect1011ui_story then
				arg_13_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.975

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(320202003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 39 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 39)

				if (39 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 39)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202003", "story_v_out_320202.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202003", "story_v_out_320202.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_320202", "320202003", "story_v_out_320202.awb")

						arg_13_1:RecordAudio("320202003", var_16_8)
						arg_13_1:RecordAudio("320202003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320202", "320202003", "story_v_out_320202.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320202", "320202003", "story_v_out_320202.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play320202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320202004
		arg_17_1.duration_ = 3

		local var_17_0 = {
			zh = 2.066,
			ja = 3
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1011ui_story = arg_17_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).z)
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles = arg_17_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_17_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).z)
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles = arg_17_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1011ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1011ui_story == nil then
				arg_17_1.var_.characterEffect1011ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1011ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1011ui_story then
				arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(320202004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)

				if (10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202004", "story_v_out_320202.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_320202", "320202004", "story_v_out_320202.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_320202", "320202004", "story_v_out_320202.awb")

						arg_17_1:RecordAudio("320202004", var_20_11)
						arg_17_1:RecordAudio("320202004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320202", "320202004", "story_v_out_320202.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320202", "320202004", "story_v_out_320202.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play320202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320202005
		arg_21_1.duration_ = 11.13

		local var_21_0 = {
			zh = 9,
			ja = 11.133
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
				arg_21_0:Play320202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) and arg_21_1.var_.characterEffect1011ui_story == nil then
				arg_21_1.var_.characterEffect1011ui_story = arg_21_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) then
				if arg_21_1.var_.characterEffect1011ui_story and not isNil(arg_21_1.actors_["1011ui_story"]) then
					arg_21_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) and arg_21_1.var_.characterEffect1011ui_story then
				arg_21_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(320202005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 45 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 45)

				if (45 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 45)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202005", "story_v_out_320202.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202005", "story_v_out_320202.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_320202", "320202005", "story_v_out_320202.awb")

						arg_21_1:RecordAudio("320202005", var_24_8)
						arg_21_1:RecordAudio("320202005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320202", "320202005", "story_v_out_320202.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320202", "320202005", "story_v_out_320202.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320202006
		arg_25_1.duration_ = 6.47

		local var_25_0 = {
			zh = 4.033,
			ja = 6.466
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
				arg_25_0:Play320202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(320202006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 22 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 22)

				if (22 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 22)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202006", "story_v_out_320202.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202006", "story_v_out_320202.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_320202", "320202006", "story_v_out_320202.awb")

						arg_25_1:RecordAudio("320202006", var_28_6)
						arg_25_1:RecordAudio("320202006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320202", "320202006", "story_v_out_320202.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320202", "320202006", "story_v_out_320202.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320202007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320202007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play320202008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1011ui_story = arg_29_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1011ui_story"].transform.position).z)
				arg_29_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1011ui_story"].transform.localEulerAngles = arg_29_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1011ui_story"].transform.position).z)
				arg_29_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1011ui_story"].transform.localEulerAngles = arg_29_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1011ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1011ui_story == nil then
				arg_29_1.var_.characterEffect1011ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1011ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_2)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1011ui_story then
				arg_29_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_32_3 = 0
			local var_32_4 = 1.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(320202007).content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 55 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 55)

				if (55 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 55)) > 0 and var_32_4 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_8 and arg_29_1.time_ < var_32_3 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play320202008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320202008
		arg_33_1.duration_ = 6.23

		local var_33_0 = {
			zh = 4.5,
			ja = 6.233
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
				arg_33_0:Play320202009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(320202008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 19 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 19)

				if (19 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 19)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202008", "story_v_out_320202.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202008", "story_v_out_320202.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_320202", "320202008", "story_v_out_320202.awb")

						arg_33_1:RecordAudio("320202008", var_36_6)
						arg_33_1:RecordAudio("320202008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320202", "320202008", "story_v_out_320202.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320202", "320202008", "story_v_out_320202.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320202009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320202009
		arg_37_1.duration_ = 6.47

		local var_37_0 = {
			zh = 5.7,
			ja = 6.466
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
				arg_37_0:Play320202010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["10101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10101ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "10101ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "10101ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10101ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["10101ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["10101ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["10101ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["10101ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10101ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, -1.16, -6.01)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["10101ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10101ui_story == nil then
				arg_37_1.var_.characterEffect10101ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect10101ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10101ui_story then
				arg_37_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_8 = 0
			local var_40_9 = 0.625

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(320202009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 25 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 25)

				if (25 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 25)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202009", "story_v_out_320202.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_320202", "320202009", "story_v_out_320202.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_320202", "320202009", "story_v_out_320202.awb")

						arg_37_1:RecordAudio("320202009", var_40_15)
						arg_37_1:RecordAudio("320202009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320202", "320202009", "story_v_out_320202.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320202", "320202009", "story_v_out_320202.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play320202010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320202010
		arg_41_1.duration_ = 7.67

		local var_41_0 = {
			zh = 6.566,
			ja = 7.666
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
				arg_41_0:Play320202011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10101ui_story"]) and arg_41_1.var_.characterEffect10101ui_story == nil then
				arg_41_1.var_.characterEffect10101ui_story = arg_41_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10101ui_story"]) then
				if arg_41_1.var_.characterEffect10101ui_story and not isNil(arg_41_1.actors_["10101ui_story"]) then
					arg_41_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10101ui_story"]) and arg_41_1.var_.characterEffect10101ui_story then
				arg_41_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(320202010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 27 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 27)

				if (27 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 27)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202010", "story_v_out_320202.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202010", "story_v_out_320202.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_320202", "320202010", "story_v_out_320202.awb")

						arg_41_1:RecordAudio("320202010", var_44_8)
						arg_41_1:RecordAudio("320202010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320202", "320202010", "story_v_out_320202.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320202", "320202010", "story_v_out_320202.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_9 and arg_41_1.time_ < var_44_1 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play320202011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320202011
		arg_45_1.duration_ = 5

		local var_45_0 = {
			zh = 3.533,
			ja = 5
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
				arg_45_0:Play320202012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.45

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(320202011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 18 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 18)

				if (18 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 18)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202011", "story_v_out_320202.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202011", "story_v_out_320202.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_320202", "320202011", "story_v_out_320202.awb")

						arg_45_1:RecordAudio("320202011", var_48_6)
						arg_45_1:RecordAudio("320202011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320202", "320202011", "story_v_out_320202.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320202", "320202011", "story_v_out_320202.awb")
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
	Play320202012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320202012
		arg_49_1.duration_ = 2.43

		local var_49_0 = {
			zh = 1.999999999999,
			ja = 2.433
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
				arg_49_0:Play320202013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10101ui_story"]) and arg_49_1.var_.characterEffect10101ui_story == nil then
				arg_49_1.var_.characterEffect10101ui_story = arg_49_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10101ui_story"]) then
				if arg_49_1.var_.characterEffect10101ui_story and not isNil(arg_49_1.actors_["10101ui_story"]) then
					arg_49_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10101ui_story"]) and arg_49_1.var_.characterEffect10101ui_story then
				arg_49_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_52_2 = 0
			local var_52_3 = 0.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(320202012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 7 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 7)

				if (7 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 7)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202012", "story_v_out_320202.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202012", "story_v_out_320202.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_320202", "320202012", "story_v_out_320202.awb")

						arg_49_1:RecordAudio("320202012", var_52_9)
						arg_49_1:RecordAudio("320202012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320202", "320202012", "story_v_out_320202.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320202", "320202012", "story_v_out_320202.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320202013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320202013
		arg_53_1.duration_ = 14.17

		local var_53_0 = {
			zh = 13.5,
			ja = 14.166
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320202014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10101ui_story"]) and arg_53_1.var_.characterEffect10101ui_story == nil then
				arg_53_1.var_.characterEffect10101ui_story = arg_53_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10101ui_story"]) then
				if arg_53_1.var_.characterEffect10101ui_story and not isNil(arg_53_1.actors_["10101ui_story"]) then
					arg_53_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10101ui_story"]) and arg_53_1.var_.characterEffect10101ui_story then
				arg_53_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 1.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(320202013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 55 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 55)

				if (55 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 55)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202013", "story_v_out_320202.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202013", "story_v_out_320202.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_320202", "320202013", "story_v_out_320202.awb")

						arg_53_1:RecordAudio("320202013", var_56_8)
						arg_53_1:RecordAudio("320202013", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320202", "320202013", "story_v_out_320202.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320202", "320202013", "story_v_out_320202.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320202014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320202014
		arg_57_1.duration_ = 3.9

		local var_57_0 = {
			zh = 3.9,
			ja = 1.999999999999
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
				arg_57_0:Play320202015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10101ui_story"]) and arg_57_1.var_.characterEffect10101ui_story == nil then
				arg_57_1.var_.characterEffect10101ui_story = arg_57_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10101ui_story"]) then
				if arg_57_1.var_.characterEffect10101ui_story and not isNil(arg_57_1.actors_["10101ui_story"]) then
					arg_57_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10101ui_story"]) and arg_57_1.var_.characterEffect10101ui_story then
				arg_57_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			local var_60_2 = 0
			local var_60_3 = 0.45

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(320202014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 18 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 18)

				if (18 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 18)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202014", "story_v_out_320202.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202014", "story_v_out_320202.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_320202", "320202014", "story_v_out_320202.awb")

						arg_57_1:RecordAudio("320202014", var_60_9)
						arg_57_1:RecordAudio("320202014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320202", "320202014", "story_v_out_320202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320202", "320202014", "story_v_out_320202.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320202015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320202015
		arg_61_1.duration_ = 5.4

		local var_61_0 = {
			zh = 5.333,
			ja = 5.4
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
				arg_61_0:Play320202016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10101ui_story"]) and arg_61_1.var_.characterEffect10101ui_story == nil then
				arg_61_1.var_.characterEffect10101ui_story = arg_61_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10101ui_story"]) then
				if arg_61_1.var_.characterEffect10101ui_story and not isNil(arg_61_1.actors_["10101ui_story"]) then
					arg_61_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10101ui_story"]) and arg_61_1.var_.characterEffect10101ui_story then
				arg_61_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.65

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(320202015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 26 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 26)

				if (26 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 26)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202015", "story_v_out_320202.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202015", "story_v_out_320202.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_320202", "320202015", "story_v_out_320202.awb")

						arg_61_1:RecordAudio("320202015", var_64_8)
						arg_61_1:RecordAudio("320202015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320202", "320202015", "story_v_out_320202.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320202", "320202015", "story_v_out_320202.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320202016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320202016
		arg_65_1.duration_ = 6.43

		local var_65_0 = {
			zh = 6.433,
			ja = 5.9
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play320202017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.775

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(320202016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 31 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 31)

				if (31 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 31)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202016", "story_v_out_320202.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202016", "story_v_out_320202.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_320202", "320202016", "story_v_out_320202.awb")

						arg_65_1:RecordAudio("320202016", var_68_6)
						arg_65_1:RecordAudio("320202016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320202", "320202016", "story_v_out_320202.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320202", "320202016", "story_v_out_320202.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play320202017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320202017
		arg_69_1.duration_ = 9.3

		local var_69_0 = {
			zh = 5.666,
			ja = 9.3
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
				arg_69_0:Play320202018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10101ui_story"]) and arg_69_1.var_.characterEffect10101ui_story == nil then
				arg_69_1.var_.characterEffect10101ui_story = arg_69_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10101ui_story"]) then
				if arg_69_1.var_.characterEffect10101ui_story and not isNil(arg_69_1.actors_["10101ui_story"]) then
					arg_69_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10101ui_story"]) and arg_69_1.var_.characterEffect10101ui_story then
				arg_69_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_72_2 = 0
			local var_72_3 = 0.725

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(320202017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 29 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 29)

				if (29 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 29)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202017", "story_v_out_320202.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202017", "story_v_out_320202.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_320202", "320202017", "story_v_out_320202.awb")

						arg_69_1:RecordAudio("320202017", var_72_9)
						arg_69_1:RecordAudio("320202017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_320202", "320202017", "story_v_out_320202.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_320202", "320202017", "story_v_out_320202.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320202018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320202018
		arg_73_1.duration_ = 2.23

		local var_73_0 = {
			zh = 1.2,
			ja = 2.233
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
				arg_73_0:Play320202019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10101ui_story"]) and arg_73_1.var_.characterEffect10101ui_story == nil then
				arg_73_1.var_.characterEffect10101ui_story = arg_73_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10101ui_story"]) then
				if arg_73_1.var_.characterEffect10101ui_story and not isNil(arg_73_1.actors_["10101ui_story"]) then
					arg_73_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10101ui_story"]) and arg_73_1.var_.characterEffect10101ui_story then
				arg_73_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(320202018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 4 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 4)

				if (4 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 4)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202018", "story_v_out_320202.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202018", "story_v_out_320202.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_320202", "320202018", "story_v_out_320202.awb")

						arg_73_1:RecordAudio("320202018", var_76_8)
						arg_73_1:RecordAudio("320202018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320202", "320202018", "story_v_out_320202.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320202", "320202018", "story_v_out_320202.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play320202019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320202019
		arg_77_1.duration_ = 5.7

		local var_77_0 = {
			zh = 3.8,
			ja = 5.7
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play320202020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10101ui_story"]) and arg_77_1.var_.characterEffect10101ui_story == nil then
				arg_77_1.var_.characterEffect10101ui_story = arg_77_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10101ui_story"]) then
				if arg_77_1.var_.characterEffect10101ui_story and not isNil(arg_77_1.actors_["10101ui_story"]) then
					arg_77_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10101ui_story"]) and arg_77_1.var_.characterEffect10101ui_story then
				arg_77_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_80_2 = 0
			local var_80_3 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(320202019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 17 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 17)

				if (17 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 17)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202019", "story_v_out_320202.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202019", "story_v_out_320202.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_320202", "320202019", "story_v_out_320202.awb")

						arg_77_1:RecordAudio("320202019", var_80_9)
						arg_77_1:RecordAudio("320202019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320202", "320202019", "story_v_out_320202.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320202", "320202019", "story_v_out_320202.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320202020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320202020
		arg_81_1.duration_ = 6.77

		local var_81_0 = {
			zh = 5,
			ja = 6.766
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
				arg_81_0:Play320202021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.675

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(320202020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 27 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 27)

				if (27 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 27)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202020", "story_v_out_320202.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202020", "story_v_out_320202.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_320202", "320202020", "story_v_out_320202.awb")

						arg_81_1:RecordAudio("320202020", var_84_6)
						arg_81_1:RecordAudio("320202020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_320202", "320202020", "story_v_out_320202.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_320202", "320202020", "story_v_out_320202.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320202021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320202021
		arg_85_1.duration_ = 1.57

		local var_85_0 = {
			zh = 1.2,
			ja = 1.566
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
				arg_85_0:Play320202022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10101ui_story"]) and arg_85_1.var_.characterEffect10101ui_story == nil then
				arg_85_1.var_.characterEffect10101ui_story = arg_85_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10101ui_story"]) then
				if arg_85_1.var_.characterEffect10101ui_story and not isNil(arg_85_1.actors_["10101ui_story"]) then
					arg_85_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10101ui_story"]) and arg_85_1.var_.characterEffect10101ui_story then
				arg_85_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.45

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(320202021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 18 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 18)

				if (18 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 18)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202021", "story_v_out_320202.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202021", "story_v_out_320202.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_320202", "320202021", "story_v_out_320202.awb")

						arg_85_1:RecordAudio("320202021", var_88_8)
						arg_85_1:RecordAudio("320202021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320202", "320202021", "story_v_out_320202.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320202", "320202021", "story_v_out_320202.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play320202022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320202022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play320202023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.775

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(320202022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 31 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 31)

				if (31 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 31)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play320202023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320202023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play320202024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10101ui_story = arg_93_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10101ui_story"].transform.position).z)
				arg_93_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10101ui_story"].transform.localEulerAngles = arg_93_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10101ui_story"].transform.position).z)
				arg_93_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10101ui_story"].transform.localEulerAngles = arg_93_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10101ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10101ui_story == nil then
				arg_93_1.var_.characterEffect10101ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10101ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_2)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10101ui_story then
				arg_93_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_96_3 = 0
			local var_96_4 = 1.125

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(320202023).content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 45 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 45)

				if (45 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 45)) > 0 and var_96_4 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_8 and arg_93_1.time_ < var_96_3 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play320202024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320202024
		arg_97_1.duration_ = 2.57

		local var_97_0 = {
			zh = 2.533,
			ja = 2.566
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
				arg_97_0:Play320202025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10101ui_story = arg_97_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10101ui_story"].transform.position).z)
				arg_97_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10101ui_story"].transform.localEulerAngles = arg_97_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.01)
				arg_97_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10101ui_story"].transform.position).z)
				arg_97_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10101ui_story"].transform.localEulerAngles = arg_97_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10101ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10101ui_story == nil then
				arg_97_1.var_.characterEffect10101ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10101ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10101ui_story then
				arg_97_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_100_4 = 0
			local var_100_5 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(320202024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 13 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 13)

				if (13 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 13)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202024", "story_v_out_320202.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_320202", "320202024", "story_v_out_320202.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_320202", "320202024", "story_v_out_320202.awb")

						arg_97_1:RecordAudio("320202024", var_100_11)
						arg_97_1:RecordAudio("320202024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320202", "320202024", "story_v_out_320202.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320202", "320202024", "story_v_out_320202.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play320202025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320202025
		arg_101_1.duration_ = 8.67

		local var_101_0 = {
			zh = 8.233,
			ja = 8.666
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play320202026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10101ui_story"]) and arg_101_1.var_.characterEffect10101ui_story == nil then
				arg_101_1.var_.characterEffect10101ui_story = arg_101_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10101ui_story"]) then
				if arg_101_1.var_.characterEffect10101ui_story and not isNil(arg_101_1.actors_["10101ui_story"]) then
					arg_101_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10101ui_story"]) and arg_101_1.var_.characterEffect10101ui_story then
				arg_101_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.925

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(320202025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 37 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 37)

				if (37 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 37)) > 0 and var_104_2 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202025", "story_v_out_320202.awb") ~= 0 then
					local var_104_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202025", "story_v_out_320202.awb") / 1000

					if var_104_7 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_1
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_320202", "320202025", "story_v_out_320202.awb")

						arg_101_1:RecordAudio("320202025", var_104_8)
						arg_101_1:RecordAudio("320202025", var_104_8)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320202", "320202025", "story_v_out_320202.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320202", "320202025", "story_v_out_320202.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_9 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_9 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_9

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_9 and arg_101_1.time_ < var_104_1 + var_104_9 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320202026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320202026
		arg_105_1.duration_ = 8.7

		local var_105_0 = {
			zh = 8.7,
			ja = 8.6
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
				arg_105_0:Play320202027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10101ui_story"]) and arg_105_1.var_.characterEffect10101ui_story == nil then
				arg_105_1.var_.characterEffect10101ui_story = arg_105_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10101ui_story"]) then
				if arg_105_1.var_.characterEffect10101ui_story and not isNil(arg_105_1.actors_["10101ui_story"]) then
					arg_105_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10101ui_story"]) and arg_105_1.var_.characterEffect10101ui_story then
				arg_105_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_108_2 = 0
			local var_108_3 = 0.95

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(320202026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 38 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 38)

				if (38 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 38)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202026", "story_v_out_320202.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202026", "story_v_out_320202.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_320202", "320202026", "story_v_out_320202.awb")

						arg_105_1:RecordAudio("320202026", var_108_9)
						arg_105_1:RecordAudio("320202026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320202", "320202026", "story_v_out_320202.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320202", "320202026", "story_v_out_320202.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320202027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320202027
		arg_109_1.duration_ = 5.1

		local var_109_0 = {
			zh = 3.766,
			ja = 5.1
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play320202028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10101ui_story"]) and arg_109_1.var_.characterEffect10101ui_story == nil then
				arg_109_1.var_.characterEffect10101ui_story = arg_109_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10101ui_story"]) then
				if arg_109_1.var_.characterEffect10101ui_story and not isNil(arg_109_1.actors_["10101ui_story"]) then
					arg_109_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10101ui_story"]) and arg_109_1.var_.characterEffect10101ui_story then
				arg_109_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.475

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(320202027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 19 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 19)

				if (19 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 19)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202027", "story_v_out_320202.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202027", "story_v_out_320202.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_320202", "320202027", "story_v_out_320202.awb")

						arg_109_1:RecordAudio("320202027", var_112_8)
						arg_109_1:RecordAudio("320202027", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320202", "320202027", "story_v_out_320202.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320202", "320202027", "story_v_out_320202.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320202028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320202028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play320202029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_116_0 = 0
			local var_116_1 = 1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(320202028).content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 40 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_2) / 40)

				if (40 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_2) / 40)) > 0 and var_116_1 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_5 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_5 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_5

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_5 and arg_113_1.time_ < var_116_0 + var_116_5 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play320202029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320202029
		arg_117_1.duration_ = 6.8

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play320202030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if arg_117_1.bgs_.STblack == nil then
				local var_120_0 = Object.Instantiate(arg_117_1.paintGo_)

				var_120_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_120_0.name = "STblack"
				var_120_0.transform.parent = arg_117_1.stage_.transform
				var_120_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.bgs_.STblack = var_120_0
			end

			if 1.025 < arg_117_1.time_ and arg_117_1.time_ <= 1.025 + arg_120_0 then
				local var_120_1 = arg_117_1.bgs_.STblack

				arg_117_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_2 = var_120_1:GetComponent("SpriteRenderer")

				if var_120_2 and var_120_2.sprite then
					local var_120_3 = 2 * (var_120_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_1.transform.localScale = Vector3.New(var_120_3 / var_120_2.sprite.bounds.size.y < var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x and var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x or var_120_3 / var_120_2.sprite.bounds.size.y, var_120_3 / var_120_2.sprite.bounds.size.y < var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x and var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x or var_120_3 / var_120_2.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "STblack" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_4 = 1.025

			if 1.025 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_4 + 0.3 and arg_117_1.time_ < var_120_4 + 0.3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_5 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_6 = 1.05900000184774

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_6 then
				local var_120_7 = Color.New(0, 0, 0)

				var_120_7.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_5) / var_120_6)
				arg_117_1.mask_.color = var_120_7
			end

			if arg_117_1.time_ >= var_120_5 + var_120_6 and arg_117_1.time_ < var_120_5 + var_120_6 + arg_120_0 then
				local var_120_8 = Color.New(0, 0, 0)

				var_120_8.a = 1
				arg_117_1.mask_.color = var_120_8
			end

			local var_120_9 = 1.05900000184774

			if 1.05900000184774 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_10 = 0.640999998152256

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 then
				local var_120_11 = Color.New(0, 0, 0)

				var_120_11.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_9) / var_120_10)
				arg_117_1.mask_.color = var_120_11
			end

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 then
				local var_120_12 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_12.a = 0
				arg_117_1.mask_.color = var_120_12
			end

			local var_120_13 = arg_117_1.actors_["10101ui_story"].transform

			if 1.025 < arg_117_1.time_ and arg_117_1.time_ <= 1.025 + arg_120_0 then
				arg_117_1.var_.moveOldPos10101ui_story = var_120_13.localPosition
			end

			local var_120_14 = 0.001

			if 1.025 <= arg_117_1.time_ and arg_117_1.time_ < 1.025 + var_120_14 then
				var_120_13.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 1.025) / var_120_14)
				var_120_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_13.position).x, (manager.ui.mainCamera.transform.position - var_120_13.position).y, (manager.ui.mainCamera.transform.position - var_120_13.position).z)
				var_120_13.localEulerAngles.z = 0
				var_120_13.localEulerAngles.x = 0
				var_120_13.localEulerAngles = var_120_13.localEulerAngles
			end

			if arg_117_1.time_ >= 1.025 + var_120_14 and arg_117_1.time_ < 1.025 + var_120_14 + arg_120_0 then
				var_120_13.localPosition = Vector3.New(0, 100, 0)
				var_120_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_13.position).x, (manager.ui.mainCamera.transform.position - var_120_13.position).y, (manager.ui.mainCamera.transform.position - var_120_13.position).z)
				var_120_13.localEulerAngles.z = 0
				var_120_13.localEulerAngles.x = 0
				var_120_13.localEulerAngles = var_120_13.localEulerAngles
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_15 = 1.8
			local var_120_16 = 1.025

			if 1.8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_17 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_17:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(320202029).content)

				arg_117_1.text_.text = var_120_18

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 41 <= 0 and var_120_16 or var_120_16 * (utf8.len(var_120_18) / 41)

				if (41 <= 0 and var_120_16 or var_120_16 * (utf8.len(var_120_18) / 41)) > 0 and var_120_16 < var_120_20 then
					arg_117_1.talkMaxDuration = var_120_20
					var_120_15 = var_120_15 + 0.3

					if var_120_20 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_20 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_18
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_21 = var_120_15 + 0.3
			local var_120_22 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_21 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_21) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_21 + var_120_22 and arg_117_1.time_ < var_120_21 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.025,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play320202030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 320202030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play320202031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.875

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(320202030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 35 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 35)

				if (35 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 35)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play320202031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 320202031
		arg_127_1.duration_ = 9.37

		local var_127_0 = {
			zh = 9.1,
			ja = 9.366
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play320202032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.L05i == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L05i")
				var_130_0.name = "L05i"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.L05i = var_130_0
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.L05i

				arg_127_1.bgs_.L05i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "L05i" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			if arg_127_1.time_ >= var_130_4 + 0.3 and arg_127_1.time_ < var_130_4 + 0.3 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_5 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_6 = 2

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = Color.New(0, 0, 0)

				var_130_7.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_5) / var_130_6)
				arg_127_1.mask_.color = var_130_7
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				local var_130_8 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_8.a = 0
				arg_127_1.mask_.color = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["10101ui_story"].transform

			if 1.83333333333333 < arg_127_1.time_ and arg_127_1.time_ <= 1.83333333333333 + arg_130_0 then
				arg_127_1.var_.moveOldPos10101ui_story = var_130_9.localPosition
			end

			local var_130_10 = 0.001

			if 1.83333333333333 <= arg_127_1.time_ and arg_127_1.time_ < 1.83333333333333 + var_130_10 then
				var_130_9.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_127_1.time_ - 1.83333333333333) / var_130_10)
				var_130_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_9.position).x, (manager.ui.mainCamera.transform.position - var_130_9.position).y, (manager.ui.mainCamera.transform.position - var_130_9.position).z)
				var_130_9.localEulerAngles.z = 0
				var_130_9.localEulerAngles.x = 0
				var_130_9.localEulerAngles = var_130_9.localEulerAngles
			end

			if arg_127_1.time_ >= 1.83333333333333 + var_130_10 and arg_127_1.time_ < 1.83333333333333 + var_130_10 + arg_130_0 then
				var_130_9.localPosition = Vector3.New(0, -1.16, -6.01)
				var_130_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_9.position).x, (manager.ui.mainCamera.transform.position - var_130_9.position).y, (manager.ui.mainCamera.transform.position - var_130_9.position).z)
				var_130_9.localEulerAngles.z = 0
				var_130_9.localEulerAngles.x = 0
				var_130_9.localEulerAngles = var_130_9.localEulerAngles
			end

			local var_130_11 = arg_127_1.actors_["10101ui_story"]

			if 1.83333333333333 < arg_127_1.time_ and arg_127_1.time_ <= 1.83333333333333 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.characterEffect10101ui_story == nil then
				arg_127_1.var_.characterEffect10101ui_story = var_130_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_12 = 0.200000002980232

			if 1.83333333333333 <= arg_127_1.time_ and arg_127_1.time_ < 1.83333333333333 + var_130_12 and not isNil(var_130_11) then
				if arg_127_1.var_.characterEffect10101ui_story and not isNil(var_130_11) then
					arg_127_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 1.83333333333333 + var_130_12 and arg_127_1.time_ < 1.83333333333333 + var_130_12 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.characterEffect10101ui_story then
				arg_127_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 1.83333333333333 < arg_127_1.time_ and arg_127_1.time_ <= 1.83333333333333 + arg_130_0 then
				arg_127_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			if 1.833333333332 < arg_127_1.time_ and arg_127_1.time_ <= 1.833333333332 + arg_130_0 then
				arg_127_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_14 = 2
			local var_130_15 = 0.9

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_16 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_16:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_17 = arg_127_1:GetWordFromCfg(320202031)
				local var_130_18 = arg_127_1:FormatText(var_130_17.content)

				arg_127_1.text_.text = var_130_18

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 36 <= 0 and var_130_15 or var_130_15 * (utf8.len(var_130_18) / 36)

				if (36 <= 0 and var_130_15 or var_130_15 * (utf8.len(var_130_18) / 36)) > 0 and var_130_15 < var_130_20 then
					arg_127_1.talkMaxDuration = var_130_20
					var_130_14 = var_130_14 + 0.3

					if var_130_20 + var_130_14 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_14
					end
				end

				arg_127_1.text_.text = var_130_18
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202031", "story_v_out_320202.awb") ~= 0 then
					local var_130_21 = manager.audio:GetVoiceLength("story_v_out_320202", "320202031", "story_v_out_320202.awb") / 1000

					if var_130_21 + var_130_14 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_21 + var_130_14
					end

					if var_130_17.prefab_name ~= "" and arg_127_1.actors_[var_130_17.prefab_name] ~= nil then
						local var_130_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_17.prefab_name].transform, "story_v_out_320202", "320202031", "story_v_out_320202.awb")

						arg_127_1:RecordAudio("320202031", var_130_22)
						arg_127_1:RecordAudio("320202031", var_130_22)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_320202", "320202031", "story_v_out_320202.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_320202", "320202031", "story_v_out_320202.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_23 = var_130_14 + 0.3
			local var_130_24 = math.max(var_130_15, arg_127_1.talkMaxDuration)

			if var_130_14 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_23) / var_130_24

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play320202032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320202032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play320202033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10101ui_story"]) and arg_133_1.var_.characterEffect10101ui_story == nil then
				arg_133_1.var_.characterEffect10101ui_story = arg_133_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10101ui_story"]) then
				if arg_133_1.var_.characterEffect10101ui_story and not isNil(arg_133_1.actors_["10101ui_story"]) then
					arg_133_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10101ui_story"]) and arg_133_1.var_.characterEffect10101ui_story then
				arg_133_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 1.075

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(320202032).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 43 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 43)

				if (43 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 43)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play320202033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320202033
		arg_137_1.duration_ = 6.53

		local var_137_0 = {
			zh = 5.7,
			ja = 6.533
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play320202034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10101ui_story"]) and arg_137_1.var_.characterEffect10101ui_story == nil then
				arg_137_1.var_.characterEffect10101ui_story = arg_137_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10101ui_story"]) then
				if arg_137_1.var_.characterEffect10101ui_story and not isNil(arg_137_1.actors_["10101ui_story"]) then
					arg_137_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10101ui_story"]) and arg_137_1.var_.characterEffect10101ui_story then
				arg_137_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_140_2 = 0
			local var_140_3 = 0.675

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(320202033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 27 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 27)

				if (27 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 27)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202033", "story_v_out_320202.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202033", "story_v_out_320202.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_320202", "320202033", "story_v_out_320202.awb")

						arg_137_1:RecordAudio("320202033", var_140_9)
						arg_137_1:RecordAudio("320202033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320202", "320202033", "story_v_out_320202.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320202", "320202033", "story_v_out_320202.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320202034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320202034
		arg_141_1.duration_ = 9.2

		local var_141_0 = {
			zh = 9.2,
			ja = 9.066
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
				arg_141_0:Play320202035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_2")
			end

			local var_144_0 = 0
			local var_144_1 = 1.2

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(320202034)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 48 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 48)

				if (48 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 48)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202034", "story_v_out_320202.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_out_320202", "320202034", "story_v_out_320202.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_out_320202", "320202034", "story_v_out_320202.awb")

						arg_141_1:RecordAudio("320202034", var_144_7)
						arg_141_1:RecordAudio("320202034", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320202", "320202034", "story_v_out_320202.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320202", "320202034", "story_v_out_320202.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320202035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320202035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play320202036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10101ui_story = arg_145_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10101ui_story"].transform.position).z)
				arg_145_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10101ui_story"].transform.localEulerAngles = arg_145_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10101ui_story"].transform.position).z)
				arg_145_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10101ui_story"].transform.localEulerAngles = arg_145_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10101ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10101ui_story == nil then
				arg_145_1.var_.characterEffect10101ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10101ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_2)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10101ui_story then
				arg_145_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_148_3 = 0
			local var_148_4 = 1.45

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(320202035).content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 58 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 58)

				if (58 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 58)) > 0 and var_148_4 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_3 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_3
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_4, arg_145_1.talkMaxDuration)

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_3) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_3 + var_148_8 and arg_145_1.time_ < var_148_3 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play320202036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320202036
		arg_149_1.duration_ = 7.73

		local var_149_0 = {
			zh = 7.733,
			ja = 6.8
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
				arg_149_0:Play320202037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1011ui_story = arg_149_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).z)
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles = arg_149_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_149_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).z)
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles = arg_149_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1011ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1011ui_story == nil then
				arg_149_1.var_.characterEffect1011ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1011ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1011ui_story then
				arg_149_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_152_4 = 0
			local var_152_5 = 0.875

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(320202036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 35 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 35)

				if (35 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 35)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202036", "story_v_out_320202.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_320202", "320202036", "story_v_out_320202.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_320202", "320202036", "story_v_out_320202.awb")

						arg_149_1:RecordAudio("320202036", var_152_11)
						arg_149_1:RecordAudio("320202036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320202", "320202036", "story_v_out_320202.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320202", "320202036", "story_v_out_320202.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play320202037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320202037
		arg_153_1.duration_ = 6.1

		local var_153_0 = {
			zh = 6.033,
			ja = 6.1
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
				arg_153_0:Play320202038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = arg_153_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1011ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_2)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_156_3 = arg_153_1.actors_["10101ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10101ui_story = var_156_3.localPosition
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_3.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_153_1.time_ - 0) / var_156_4)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_3.localPosition = Vector3.New(0, -1.16, -6.01)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			local var_156_5 = arg_153_1.actors_["10101ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect10101ui_story == nil then
				arg_153_1.var_.characterEffect10101ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.characterEffect10101ui_story and not isNil(var_156_5) then
					arg_153_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect10101ui_story then
				arg_153_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_156_8 = 0
			local var_156_9 = 0.6

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:GetWordFromCfg(320202037)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 24 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 24)

				if (24 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 24)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202037", "story_v_out_320202.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_320202", "320202037", "story_v_out_320202.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_320202", "320202037", "story_v_out_320202.awb")

						arg_153_1:RecordAudio("320202037", var_156_15)
						arg_153_1:RecordAudio("320202037", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320202", "320202037", "story_v_out_320202.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320202", "320202037", "story_v_out_320202.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_153_1:InitPlayNodeList()
	end,
	Play320202038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320202038
		arg_157_1.duration_ = 16.13

		local var_157_0 = {
			zh = 16.133,
			ja = 15.666
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320202039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			local var_160_0 = 0
			local var_160_1 = 1.6

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(320202038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 64 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 64)

				if (64 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 64)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202038", "story_v_out_320202.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_out_320202", "320202038", "story_v_out_320202.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_out_320202", "320202038", "story_v_out_320202.awb")

						arg_157_1:RecordAudio("320202038", var_160_7)
						arg_157_1:RecordAudio("320202038", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_320202", "320202038", "story_v_out_320202.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_320202", "320202038", "story_v_out_320202.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320202039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320202039
		arg_161_1.duration_ = 10.4

		local var_161_0 = {
			zh = 9.033,
			ja = 10.4
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play320202040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.975

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(320202039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 39 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 39)

				if (39 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 39)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202039", "story_v_out_320202.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202039", "story_v_out_320202.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_320202", "320202039", "story_v_out_320202.awb")

						arg_161_1:RecordAudio("320202039", var_164_6)
						arg_161_1:RecordAudio("320202039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320202", "320202039", "story_v_out_320202.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320202", "320202039", "story_v_out_320202.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play320202040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320202040
		arg_165_1.duration_ = 5.03

		local var_165_0 = {
			zh = 4.666,
			ja = 5.033
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play320202041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = arg_165_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1011ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action423")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_168_4 = arg_165_1.actors_["10101ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10101ui_story = var_168_4.localPosition
			end

			local var_168_5 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				var_168_4.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_5)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				var_168_4.localPosition = Vector3.New(0, 100, 0)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			local var_168_6 = arg_165_1.actors_["10101ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect10101ui_story == nil then
				arg_165_1.var_.characterEffect10101ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_7 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 and not isNil(var_168_6) then
				if arg_165_1.var_.characterEffect10101ui_story and not isNil(var_168_6) then
					arg_165_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_7)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect10101ui_story then
				arg_165_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_168_8 = 0
			local var_168_9 = 0.4

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(320202040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 16 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 16)

				if (16 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 16)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202040", "story_v_out_320202.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_out_320202", "320202040", "story_v_out_320202.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_320202", "320202040", "story_v_out_320202.awb")

						arg_165_1:RecordAudio("320202040", var_168_15)
						arg_165_1:RecordAudio("320202040", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320202", "320202040", "story_v_out_320202.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320202", "320202040", "story_v_out_320202.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_165_1:InitPlayNodeList()
	end,
	Play320202041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320202041
		arg_169_1.duration_ = 6.87

		local var_169_0 = {
			zh = 5.2,
			ja = 6.866
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
				arg_169_0:Play320202042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10101ui_story = arg_169_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10101ui_story"].transform.position).z)
				arg_169_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10101ui_story"].transform.localEulerAngles = arg_169_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.01)
				arg_169_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10101ui_story"].transform.position).z)
				arg_169_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10101ui_story"].transform.localEulerAngles = arg_169_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["10101ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10101ui_story == nil then
				arg_169_1.var_.characterEffect10101ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect10101ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10101ui_story then
				arg_169_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_172_4 = arg_169_1.actors_["1011ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1011ui_story = var_172_4.localPosition
			end

			local var_172_5 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 then
				var_172_4.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_5)
				var_172_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_4.position).x, (manager.ui.mainCamera.transform.position - var_172_4.position).y, (manager.ui.mainCamera.transform.position - var_172_4.position).z)
				var_172_4.localEulerAngles.z = 0
				var_172_4.localEulerAngles.x = 0
				var_172_4.localEulerAngles = var_172_4.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 then
				var_172_4.localPosition = Vector3.New(0, 100, 0)
				var_172_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_4.position).x, (manager.ui.mainCamera.transform.position - var_172_4.position).y, (manager.ui.mainCamera.transform.position - var_172_4.position).z)
				var_172_4.localEulerAngles.z = 0
				var_172_4.localEulerAngles.x = 0
				var_172_4.localEulerAngles = var_172_4.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_172_6 = 0
			local var_172_7 = 0.55

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(320202041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 22 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 22)

				if (22 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 22)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202041", "story_v_out_320202.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_320202", "320202041", "story_v_out_320202.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_320202", "320202041", "story_v_out_320202.awb")

						arg_169_1:RecordAudio("320202041", var_172_13)
						arg_169_1:RecordAudio("320202041", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320202", "320202041", "story_v_out_320202.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320202", "320202041", "story_v_out_320202.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play320202042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320202042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320202043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10101ui_story"]) and arg_173_1.var_.characterEffect10101ui_story == nil then
				arg_173_1.var_.characterEffect10101ui_story = arg_173_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10101ui_story"]) then
				if arg_173_1.var_.characterEffect10101ui_story and not isNil(arg_173_1.actors_["10101ui_story"]) then
					arg_173_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10101ui_story"]) and arg_173_1.var_.characterEffect10101ui_story then
				arg_173_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 1.2

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(320202042).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 48 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 48)

				if (48 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 48)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320202043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320202043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play320202044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.075

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(320202043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 43 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 43)

				if (43 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 43)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320202044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320202044
		arg_181_1.duration_ = 8.77

		local var_181_0 = {
			zh = 7.666,
			ja = 8.766
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
				arg_181_0:Play320202045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10101ui_story"]) and arg_181_1.var_.characterEffect10101ui_story == nil then
				arg_181_1.var_.characterEffect10101ui_story = arg_181_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10101ui_story"]) then
				if arg_181_1.var_.characterEffect10101ui_story and not isNil(arg_181_1.actors_["10101ui_story"]) then
					arg_181_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10101ui_story"]) and arg_181_1.var_.characterEffect10101ui_story then
				arg_181_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_184_2 = 0
			local var_184_3 = 0.925

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(320202044)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 37 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 37)

				if (37 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 37)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202044", "story_v_out_320202.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202044", "story_v_out_320202.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_out_320202", "320202044", "story_v_out_320202.awb")

						arg_181_1:RecordAudio("320202044", var_184_9)
						arg_181_1:RecordAudio("320202044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320202", "320202044", "story_v_out_320202.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320202", "320202044", "story_v_out_320202.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play320202045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320202045
		arg_185_1.duration_ = 7.3

		local var_185_0 = {
			zh = 7.3,
			ja = 6.633
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play320202046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_188_0 = 0
			local var_188_1 = 0.625

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(320202045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 25 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 25)

				if (25 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 25)) > 0 and var_188_1 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202045", "story_v_out_320202.awb") ~= 0 then
					local var_188_6 = manager.audio:GetVoiceLength("story_v_out_320202", "320202045", "story_v_out_320202.awb") / 1000

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end

					if var_188_2.prefab_name ~= "" and arg_185_1.actors_[var_188_2.prefab_name] ~= nil then
						local var_188_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_2.prefab_name].transform, "story_v_out_320202", "320202045", "story_v_out_320202.awb")

						arg_185_1:RecordAudio("320202045", var_188_7)
						arg_185_1:RecordAudio("320202045", var_188_7)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320202", "320202045", "story_v_out_320202.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320202", "320202045", "story_v_out_320202.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play320202046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320202046
		arg_189_1.duration_ = 15.03

		local var_189_0 = {
			zh = 15.033,
			ja = 12.8
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
				arg_189_0:Play320202047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.425

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(320202046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 57 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 57)

				if (57 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 57)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202046", "story_v_out_320202.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202046", "story_v_out_320202.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_320202", "320202046", "story_v_out_320202.awb")

						arg_189_1:RecordAudio("320202046", var_192_6)
						arg_189_1:RecordAudio("320202046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320202", "320202046", "story_v_out_320202.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320202", "320202046", "story_v_out_320202.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play320202047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320202047
		arg_193_1.duration_ = 15.47

		local var_193_0 = {
			zh = 13.3993333333333,
			ja = 15.4663333333333
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play320202048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if arg_193_1.bgs_.ST0502 == nil then
				local var_196_0 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0502")
				var_196_0.name = "ST0502"
				var_196_0.transform.parent = arg_193_1.stage_.transform
				var_196_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_.ST0502 = var_196_0
			end

			if 1.999999999999 < arg_193_1.time_ and arg_193_1.time_ <= 1.999999999999 + arg_196_0 then
				local var_196_1 = arg_193_1.bgs_.ST0502

				arg_193_1.bgs_.ST0502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_2 = var_196_1:GetComponent("SpriteRenderer")

				if var_196_2 and var_196_2.sprite then
					local var_196_3 = 2 * (var_196_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_1.transform.localScale = Vector3.New(var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "ST0502" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_4 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_4 + 0.3 and arg_193_1.time_ < var_196_4 + 0.3 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_5 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_6 = 2

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_6 then
				local var_196_7 = Color.New(0, 0, 0)

				var_196_7.a = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_5) / var_196_6)
				arg_193_1.mask_.color = var_196_7
			end

			if arg_193_1.time_ >= var_196_5 + var_196_6 and arg_193_1.time_ < var_196_5 + var_196_6 + arg_196_0 then
				local var_196_8 = Color.New(0, 0, 0)

				var_196_8.a = 1
				arg_193_1.mask_.color = var_196_8
			end

			local var_196_9 = 2

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_10 = 2

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 then
				local var_196_11 = Color.New(0, 0, 0)

				var_196_11.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_9) / var_196_10)
				arg_193_1.mask_.color = var_196_11
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 then
				local var_196_12 = Color.New(0, 0, 0)

				arg_193_1.mask_.enabled = false
				var_196_12.a = 0
				arg_193_1.mask_.color = var_196_12
			end

			local var_196_13 = arg_193_1.actors_["10101ui_story"].transform

			if 3.73333333333333 < arg_193_1.time_ and arg_193_1.time_ <= 3.73333333333333 + arg_196_0 then
				arg_193_1.var_.moveOldPos10101ui_story = var_196_13.localPosition
			end

			local var_196_14 = 0.001

			if 3.73333333333333 <= arg_193_1.time_ and arg_193_1.time_ < 3.73333333333333 + var_196_14 then
				var_196_13.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_193_1.time_ - 3.73333333333333) / var_196_14)
				var_196_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_13.position).x, (manager.ui.mainCamera.transform.position - var_196_13.position).y, (manager.ui.mainCamera.transform.position - var_196_13.position).z)
				var_196_13.localEulerAngles.z = 0
				var_196_13.localEulerAngles.x = 0
				var_196_13.localEulerAngles = var_196_13.localEulerAngles
			end

			if arg_193_1.time_ >= 3.73333333333333 + var_196_14 and arg_193_1.time_ < 3.73333333333333 + var_196_14 + arg_196_0 then
				var_196_13.localPosition = Vector3.New(0, -1.16, -6.01)
				var_196_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_13.position).x, (manager.ui.mainCamera.transform.position - var_196_13.position).y, (manager.ui.mainCamera.transform.position - var_196_13.position).z)
				var_196_13.localEulerAngles.z = 0
				var_196_13.localEulerAngles.x = 0
				var_196_13.localEulerAngles = var_196_13.localEulerAngles
			end

			local var_196_15 = arg_193_1.actors_["10101ui_story"]

			if 3.73333333333333 < arg_193_1.time_ and arg_193_1.time_ <= 3.73333333333333 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.characterEffect10101ui_story == nil then
				arg_193_1.var_.characterEffect10101ui_story = var_196_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_16 = 0.200000002980232

			if 3.73333333333333 <= arg_193_1.time_ and arg_193_1.time_ < 3.73333333333333 + var_196_16 and not isNil(var_196_15) then
				if arg_193_1.var_.characterEffect10101ui_story and not isNil(var_196_15) then
					arg_193_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 3.73333333333333 + var_196_16 and arg_193_1.time_ < 3.73333333333333 + var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.characterEffect10101ui_story then
				arg_193_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 3.73333333333333 < arg_193_1.time_ and arg_193_1.time_ <= 3.73333333333333 + arg_196_0 then
				arg_193_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_2")
			end

			local var_196_18 = arg_193_1.actors_["10101ui_story"].transform

			if 1.98333333333233 < arg_193_1.time_ and arg_193_1.time_ <= 1.98333333333233 + arg_196_0 then
				arg_193_1.var_.moveOldPos10101ui_story = var_196_18.localPosition
			end

			local var_196_19 = 0.001

			if 1.98333333333233 <= arg_193_1.time_ and arg_193_1.time_ < 1.98333333333233 + var_196_19 then
				var_196_18.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 1.98333333333233) / var_196_19)
				var_196_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_18.position).x, (manager.ui.mainCamera.transform.position - var_196_18.position).y, (manager.ui.mainCamera.transform.position - var_196_18.position).z)
				var_196_18.localEulerAngles.z = 0
				var_196_18.localEulerAngles.x = 0
				var_196_18.localEulerAngles = var_196_18.localEulerAngles
			end

			if arg_193_1.time_ >= 1.98333333333233 + var_196_19 and arg_193_1.time_ < 1.98333333333233 + var_196_19 + arg_196_0 then
				var_196_18.localPosition = Vector3.New(0, 100, 0)
				var_196_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_18.position).x, (manager.ui.mainCamera.transform.position - var_196_18.position).y, (manager.ui.mainCamera.transform.position - var_196_18.position).z)
				var_196_18.localEulerAngles.z = 0
				var_196_18.localEulerAngles.x = 0
				var_196_18.localEulerAngles = var_196_18.localEulerAngles
			end

			local var_196_20 = arg_193_1.actors_["10101ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_20) and arg_193_1.var_.characterEffect10101ui_story == nil then
				arg_193_1.var_.characterEffect10101ui_story = var_196_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_21 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_21 and not isNil(var_196_20) then
				if arg_193_1.var_.characterEffect10101ui_story and not isNil(var_196_20) then
					arg_193_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_21 and arg_193_1.time_ < 0 + var_196_21 + arg_196_0 and not isNil(var_196_20) and arg_193_1.var_.characterEffect10101ui_story then
				arg_193_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_23 = 3.73333333333333
			local var_196_24 = 1.125

			if 3.73333333333333 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_25 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_25:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_26 = arg_193_1:GetWordFromCfg(320202047)
				local var_196_27 = arg_193_1:FormatText(var_196_26.content)

				arg_193_1.text_.text = var_196_27

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_29 = 45 <= 0 and var_196_24 or var_196_24 * (utf8.len(var_196_27) / 45)

				if (45 <= 0 and var_196_24 or var_196_24 * (utf8.len(var_196_27) / 45)) > 0 and var_196_24 < var_196_29 then
					arg_193_1.talkMaxDuration = var_196_29
					var_196_23 = var_196_23 + 0.3

					if var_196_29 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_29 + var_196_23
					end
				end

				arg_193_1.text_.text = var_196_27
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202047", "story_v_out_320202.awb") ~= 0 then
					local var_196_30 = manager.audio:GetVoiceLength("story_v_out_320202", "320202047", "story_v_out_320202.awb") / 1000

					if var_196_30 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_30 + var_196_23
					end

					if var_196_26.prefab_name ~= "" and arg_193_1.actors_[var_196_26.prefab_name] ~= nil then
						local var_196_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_26.prefab_name].transform, "story_v_out_320202", "320202047", "story_v_out_320202.awb")

						arg_193_1:RecordAudio("320202047", var_196_31)
						arg_193_1:RecordAudio("320202047", var_196_31)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_320202", "320202047", "story_v_out_320202.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_320202", "320202047", "story_v_out_320202.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_32 = var_196_23 + 0.3
			local var_196_33 = math.max(var_196_24, arg_193_1.talkMaxDuration)

			if var_196_23 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_32 + var_196_33 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_32) / var_196_33

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_32 + var_196_33 and arg_193_1.time_ < var_196_32 + var_196_33 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333233,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play320202048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 320202048
		arg_199_1.duration_ = 6.63

		local var_199_0 = {
			zh = 5.1,
			ja = 6.633
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
				arg_199_0:Play320202049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10101ui_story"]) and arg_199_1.var_.characterEffect10101ui_story == nil then
				arg_199_1.var_.characterEffect10101ui_story = arg_199_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10101ui_story"]) then
				if arg_199_1.var_.characterEffect10101ui_story and not isNil(arg_199_1.actors_["10101ui_story"]) then
					arg_199_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10101ui_story"]) and arg_199_1.var_.characterEffect10101ui_story then
				arg_199_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.55

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(320202048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 22 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 22)

				if (22 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 22)) > 0 and var_202_2 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202048", "story_v_out_320202.awb") ~= 0 then
					local var_202_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202048", "story_v_out_320202.awb") / 1000

					if var_202_7 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_1
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_320202", "320202048", "story_v_out_320202.awb")

						arg_199_1:RecordAudio("320202048", var_202_8)
						arg_199_1:RecordAudio("320202048", var_202_8)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_320202", "320202048", "story_v_out_320202.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_320202", "320202048", "story_v_out_320202.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_9 and arg_199_1.time_ < var_202_1 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play320202049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 320202049
		arg_203_1.duration_ = 8.3

		local var_203_0 = {
			zh = 8.3,
			ja = 7.633
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play320202050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10101ui_story"]) and arg_203_1.var_.characterEffect10101ui_story == nil then
				arg_203_1.var_.characterEffect10101ui_story = arg_203_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10101ui_story"]) then
				if arg_203_1.var_.characterEffect10101ui_story and not isNil(arg_203_1.actors_["10101ui_story"]) then
					arg_203_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10101ui_story"]) and arg_203_1.var_.characterEffect10101ui_story then
				arg_203_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_206_2 = 0
			local var_206_3 = 0.975

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(320202049)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 39 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 39)

				if (39 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 39)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202049", "story_v_out_320202.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202049", "story_v_out_320202.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_out_320202", "320202049", "story_v_out_320202.awb")

						arg_203_1:RecordAudio("320202049", var_206_9)
						arg_203_1:RecordAudio("320202049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_320202", "320202049", "story_v_out_320202.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_320202", "320202049", "story_v_out_320202.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play320202050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 320202050
		arg_207_1.duration_ = 12

		local var_207_0 = {
			zh = 9.7,
			ja = 12
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play320202051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			local var_210_0 = 0
			local var_210_1 = 1.125

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(320202050)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 45 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 45)

				if (45 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 45)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202050", "story_v_out_320202.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_out_320202", "320202050", "story_v_out_320202.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_out_320202", "320202050", "story_v_out_320202.awb")

						arg_207_1:RecordAudio("320202050", var_210_7)
						arg_207_1:RecordAudio("320202050", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_320202", "320202050", "story_v_out_320202.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_320202", "320202050", "story_v_out_320202.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play320202051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 320202051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play320202052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10101ui_story = arg_211_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10101ui_story"].transform.position).z)
				arg_211_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10101ui_story"].transform.localEulerAngles = arg_211_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10101ui_story"].transform.position).z)
				arg_211_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10101ui_story"].transform.localEulerAngles = arg_211_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["10101ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect10101ui_story == nil then
				arg_211_1.var_.characterEffect10101ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect10101ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect10101ui_story then
				arg_211_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_214_3 = 0
			local var_214_4 = 0.4

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(320202051).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 16 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 16)

				if (16 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 16)) > 0 and var_214_4 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_8 and arg_211_1.time_ < var_214_3 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play320202052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 320202052
		arg_215_1.duration_ = 4.7

		local var_215_0 = {
			zh = 4.7,
			ja = 4.133
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
				arg_215_0:Play320202053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.475

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(320202052)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 19 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 19)

				if (19 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 19)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202052", "story_v_out_320202.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202052", "story_v_out_320202.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_320202", "320202052", "story_v_out_320202.awb")

						arg_215_1:RecordAudio("320202052", var_218_6)
						arg_215_1:RecordAudio("320202052", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_320202", "320202052", "story_v_out_320202.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_320202", "320202052", "story_v_out_320202.awb")
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
	Play320202053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 320202053
		arg_219_1.duration_ = 4.17

		local var_219_0 = {
			zh = 1.999999999999,
			ja = 4.166
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play320202054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10101ui_story = arg_219_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10101ui_story"].transform.position).z)
				arg_219_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10101ui_story"].transform.localEulerAngles = arg_219_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.01)
				arg_219_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10101ui_story"].transform.position).z)
				arg_219_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10101ui_story"].transform.localEulerAngles = arg_219_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["10101ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10101ui_story == nil then
				arg_219_1.var_.characterEffect10101ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect10101ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10101ui_story then
				arg_219_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_222_4 = 0
			local var_222_5 = 0.175

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(320202053)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 7 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 7)

				if (7 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 7)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202053", "story_v_out_320202.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_320202", "320202053", "story_v_out_320202.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_320202", "320202053", "story_v_out_320202.awb")

						arg_219_1:RecordAudio("320202053", var_222_11)
						arg_219_1:RecordAudio("320202053", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_320202", "320202053", "story_v_out_320202.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_320202", "320202053", "story_v_out_320202.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play320202054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 320202054
		arg_223_1.duration_ = 8.13

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play320202055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if arg_223_1.bgs_.L06g == nil then
				local var_226_0 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L06g")
				var_226_0.name = "L06g"
				var_226_0.transform.parent = arg_223_1.stage_.transform
				var_226_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_.L06g = var_226_0
			end

			if 1.63333333333333 < arg_223_1.time_ and arg_223_1.time_ <= 1.63333333333333 + arg_226_0 then
				local var_226_1 = arg_223_1.bgs_.L06g

				arg_223_1.bgs_.L06g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_2 = var_226_1:GetComponent("SpriteRenderer")

				if var_226_2 and var_226_2.sprite then
					local var_226_3 = 2 * (var_226_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_1.transform.localScale = Vector3.New(var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "L06g" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_4 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_4 + 0.3 and arg_223_1.time_ < var_226_4 + 0.3 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_5 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_6 = 1.63333333333333

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_6 then
				local var_226_7 = Color.New(0, 0, 0)

				var_226_7.a = Mathf.Lerp(0, 1, (arg_223_1.time_ - var_226_5) / var_226_6)
				arg_223_1.mask_.color = var_226_7
			end

			if arg_223_1.time_ >= var_226_5 + var_226_6 and arg_223_1.time_ < var_226_5 + var_226_6 + arg_226_0 then
				local var_226_8 = Color.New(0, 0, 0)

				var_226_8.a = 1
				arg_223_1.mask_.color = var_226_8
			end

			local var_226_9 = 1.63333333333333

			if 1.63333333333333 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_10 = 1.73333333333333

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_10 then
				local var_226_11 = Color.New(0, 0, 0)

				var_226_11.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_9) / var_226_10)
				arg_223_1.mask_.color = var_226_11
			end

			if arg_223_1.time_ >= var_226_9 + var_226_10 and arg_223_1.time_ < var_226_9 + var_226_10 + arg_226_0 then
				local var_226_12 = Color.New(0, 0, 0)

				arg_223_1.mask_.enabled = false
				var_226_12.a = 0
				arg_223_1.mask_.color = var_226_12
			end

			local var_226_13 = arg_223_1.actors_["10101ui_story"].transform

			if 1.59933333148559 < arg_223_1.time_ and arg_223_1.time_ <= 1.59933333148559 + arg_226_0 then
				arg_223_1.var_.moveOldPos10101ui_story = var_226_13.localPosition
			end

			local var_226_14 = 0.001

			if 1.59933333148559 <= arg_223_1.time_ and arg_223_1.time_ < 1.59933333148559 + var_226_14 then
				var_226_13.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 1.59933333148559) / var_226_14)
				var_226_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_13.position).x, (manager.ui.mainCamera.transform.position - var_226_13.position).y, (manager.ui.mainCamera.transform.position - var_226_13.position).z)
				var_226_13.localEulerAngles.z = 0
				var_226_13.localEulerAngles.x = 0
				var_226_13.localEulerAngles = var_226_13.localEulerAngles
			end

			if arg_223_1.time_ >= 1.59933333148559 + var_226_14 and arg_223_1.time_ < 1.59933333148559 + var_226_14 + arg_226_0 then
				var_226_13.localPosition = Vector3.New(0, 100, 0)
				var_226_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_13.position).x, (manager.ui.mainCamera.transform.position - var_226_13.position).y, (manager.ui.mainCamera.transform.position - var_226_13.position).z)
				var_226_13.localEulerAngles.z = 0
				var_226_13.localEulerAngles.x = 0
				var_226_13.localEulerAngles = var_226_13.localEulerAngles
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_226_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_17 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_17

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_17
						arg_223_1.bgmTxt2_.text = var_226_17
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.03333333333333 < arg_223_1.time_ and arg_223_1.time_ <= 1.03333333333333 + arg_226_0 then
				arg_223_1:AudioAction("play", "music", "bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area.awb")

				local var_226_20 = manager.audio:GetAudioName("bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area")

				if "" ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_20 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_20

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_20
						arg_223_1.bgmTxt2_.text = var_226_20
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.3 < arg_223_1.time_ and arg_223_1.time_ <= 1.3 + arg_226_0 then
				arg_223_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_street_loop", "")
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_22 = 3.13333333333333
			local var_226_23 = 1.425

			if 3.13333333333333 < arg_223_1.time_ and arg_223_1.time_ <= var_226_22 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_24 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_24:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_223_1.dialogCg_.alpha = arg_229_0
				end))
				var_226_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_25 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(320202054).content)

				arg_223_1.text_.text = var_226_25

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_27 = 57 <= 0 and var_226_23 or var_226_23 * (utf8.len(var_226_25) / 57)

				if (57 <= 0 and var_226_23 or var_226_23 * (utf8.len(var_226_25) / 57)) > 0 and var_226_23 < var_226_27 then
					arg_223_1.talkMaxDuration = var_226_27
					var_226_22 = var_226_22 + 0.3

					if var_226_27 + var_226_22 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_27 + var_226_22
					end
				end

				arg_223_1.text_.text = var_226_25
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_28 = var_226_22 + 0.3
			local var_226_29 = math.max(var_226_23, arg_223_1.talkMaxDuration)

			if var_226_22 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_28 + var_226_29 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_28) / var_226_29

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_28 + var_226_29 and arg_223_1.time_ < var_226_28 + var_226_29 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.59933333148559,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play320202055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 320202055
		arg_231_1.duration_ = 6.17

		local var_231_0 = {
			zh = 5,
			ja = 6.166
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play320202056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_234_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_231_1.stage_.transform)

				var_234_0.name = "10102ui_story"
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["10102ui_story"] = var_234_0

				local var_234_1 = var_234_0:GetComponentInChildren(typeof(CharacterEffect))

				var_234_1.enabled = true

				local var_234_2 = GameObjectTools.GetOrAddComponent(var_234_0, typeof(DynamicBoneHelper))

				if var_234_2 then
					var_234_2:EnableDynamicBone(false)
				end

				arg_231_1:ShowWeapon(var_234_1.transform, false)

				arg_231_1.var_["10102ui_story" .. "Animator"] = var_234_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_231_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_231_1.var_["10102ui_story" .. "LipSync"] = var_234_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_234_3 = arg_231_1.actors_["10102ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10102ui_story = var_234_3.localPosition
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_3.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_231_1.time_ - 0) / var_234_4)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			local var_234_5 = arg_231_1.actors_["10102ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect10102ui_story == nil then
				arg_231_1.var_.characterEffect10102ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_6 and not isNil(var_234_5) then
				if arg_231_1.var_.characterEffect10102ui_story and not isNil(var_234_5) then
					arg_231_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_6 and arg_231_1.time_ < 0 + var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect10102ui_story then
				arg_231_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_234_8 = 0
			local var_234_9 = 0.675

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(320202055)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 27 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 27)

				if (27 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 27)) > 0 and var_234_9 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202055", "story_v_out_320202.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_320202", "320202055", "story_v_out_320202.awb") / 1000

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_320202", "320202055", "story_v_out_320202.awb")

						arg_231_1:RecordAudio("320202055", var_234_15)
						arg_231_1:RecordAudio("320202055", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_320202", "320202055", "story_v_out_320202.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_320202", "320202055", "story_v_out_320202.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_16 and arg_231_1.time_ < var_234_8 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play320202056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 320202056
		arg_235_1.duration_ = 7.2

		local var_235_0 = {
			zh = 5.033,
			ja = 7.2
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
				arg_235_0:Play320202057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.65

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(320202056)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 26 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 26)

				if (26 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 26)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202056", "story_v_out_320202.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202056", "story_v_out_320202.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_320202", "320202056", "story_v_out_320202.awb")

						arg_235_1:RecordAudio("320202056", var_238_6)
						arg_235_1:RecordAudio("320202056", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_320202", "320202056", "story_v_out_320202.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_320202", "320202056", "story_v_out_320202.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play320202057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 320202057
		arg_239_1.duration_ = 8.43

		local var_239_0 = {
			zh = 6.7,
			ja = 8.433
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
				arg_239_0:Play320202058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10102ui_story"]) and arg_239_1.var_.characterEffect10102ui_story == nil then
				arg_239_1.var_.characterEffect10102ui_story = arg_239_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10102ui_story"]) then
				if arg_239_1.var_.characterEffect10102ui_story and not isNil(arg_239_1.actors_["10102ui_story"]) then
					arg_239_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10102ui_story"]) and arg_239_1.var_.characterEffect10102ui_story then
				arg_239_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.85

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(320202057)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 34 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_4) / 34)

				if (34 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_4) / 34)) > 0 and var_242_2 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202057", "story_v_out_320202.awb") ~= 0 then
					local var_242_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202057", "story_v_out_320202.awb") / 1000

					if var_242_7 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_1
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_320202", "320202057", "story_v_out_320202.awb")

						arg_239_1:RecordAudio("320202057", var_242_8)
						arg_239_1:RecordAudio("320202057", var_242_8)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_320202", "320202057", "story_v_out_320202.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_320202", "320202057", "story_v_out_320202.awb")
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
	Play320202058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 320202058
		arg_243_1.duration_ = 7.4

		local var_243_0 = {
			zh = 5.966,
			ja = 7.4
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play320202059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.85

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:GetWordFromCfg(320202058)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 34 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 34)

				if (34 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 34)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202058", "story_v_out_320202.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202058", "story_v_out_320202.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_320202", "320202058", "story_v_out_320202.awb")

						arg_243_1:RecordAudio("320202058", var_246_6)
						arg_243_1:RecordAudio("320202058", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_320202", "320202058", "story_v_out_320202.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_320202", "320202058", "story_v_out_320202.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play320202059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 320202059
		arg_247_1.duration_ = 4.4

		local var_247_0 = {
			zh = 4.4,
			ja = 3.5
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
				arg_247_0:Play320202060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10102ui_story"]) and arg_247_1.var_.characterEffect10102ui_story == nil then
				arg_247_1.var_.characterEffect10102ui_story = arg_247_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10102ui_story"]) then
				if arg_247_1.var_.characterEffect10102ui_story and not isNil(arg_247_1.actors_["10102ui_story"]) then
					arg_247_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10102ui_story"]) and arg_247_1.var_.characterEffect10102ui_story then
				arg_247_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action476")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_250_2 = 0
			local var_250_3 = 0.55

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(320202059)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 22 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 22)

				if (22 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 22)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202059", "story_v_out_320202.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202059", "story_v_out_320202.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_320202", "320202059", "story_v_out_320202.awb")

						arg_247_1:RecordAudio("320202059", var_250_9)
						arg_247_1:RecordAudio("320202059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_320202", "320202059", "story_v_out_320202.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_320202", "320202059", "story_v_out_320202.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play320202060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 320202060
		arg_251_1.duration_ = 6.5

		local var_251_0 = {
			zh = 6.5,
			ja = 4.833
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play320202061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10102ui_story"]) and arg_251_1.var_.characterEffect10102ui_story == nil then
				arg_251_1.var_.characterEffect10102ui_story = arg_251_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10102ui_story"]) then
				if arg_251_1.var_.characterEffect10102ui_story and not isNil(arg_251_1.actors_["10102ui_story"]) then
					arg_251_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10102ui_story"]) and arg_251_1.var_.characterEffect10102ui_story then
				arg_251_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.75

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(320202060)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 30 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_4) / 30)

				if (30 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_4) / 30)) > 0 and var_254_2 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202060", "story_v_out_320202.awb") ~= 0 then
					local var_254_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202060", "story_v_out_320202.awb") / 1000

					if var_254_7 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_1
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_320202", "320202060", "story_v_out_320202.awb")

						arg_251_1:RecordAudio("320202060", var_254_8)
						arg_251_1:RecordAudio("320202060", var_254_8)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_320202", "320202060", "story_v_out_320202.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_320202", "320202060", "story_v_out_320202.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_9 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_9 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_9

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_9 and arg_251_1.time_ < var_254_1 + var_254_9 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play320202061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 320202061
		arg_255_1.duration_ = 11.83

		local var_255_0 = {
			zh = 9.533,
			ja = 11.833
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play320202062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1.2

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(320202061)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 48 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 48)

				if (48 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 48)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202061", "story_v_out_320202.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202061", "story_v_out_320202.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_320202", "320202061", "story_v_out_320202.awb")

						arg_255_1:RecordAudio("320202061", var_258_6)
						arg_255_1:RecordAudio("320202061", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_320202", "320202061", "story_v_out_320202.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_320202", "320202061", "story_v_out_320202.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play320202062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 320202062
		arg_259_1.duration_ = 3.37

		local var_259_0 = {
			zh = 3.333,
			ja = 3.366
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play320202063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10102ui_story = arg_259_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10102ui_story"].transform.position).z)
				arg_259_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10102ui_story"].transform.localEulerAngles = arg_259_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10102ui_story"].transform.position).z)
				arg_259_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10102ui_story"].transform.localEulerAngles = arg_259_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["10102ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10102ui_story == nil then
				arg_259_1.var_.characterEffect10102ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect10102ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_2)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10102ui_story then
				arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_262_3 = arg_259_1.actors_["1011ui_story"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1011ui_story = var_262_3.localPosition
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_3.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_259_1.time_ - 0) / var_262_4)
				var_262_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_3.position).x, (manager.ui.mainCamera.transform.position - var_262_3.position).y, (manager.ui.mainCamera.transform.position - var_262_3.position).z)
				var_262_3.localEulerAngles.z = 0
				var_262_3.localEulerAngles.x = 0
				var_262_3.localEulerAngles = var_262_3.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_3.localPosition = Vector3.New(0, -0.71, -6)
				var_262_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_3.position).x, (manager.ui.mainCamera.transform.position - var_262_3.position).y, (manager.ui.mainCamera.transform.position - var_262_3.position).z)
				var_262_3.localEulerAngles.z = 0
				var_262_3.localEulerAngles.x = 0
				var_262_3.localEulerAngles = var_262_3.localEulerAngles
			end

			local var_262_5 = arg_259_1.actors_["1011ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.characterEffect1011ui_story == nil then
				arg_259_1.var_.characterEffect1011ui_story = var_262_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_6 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_6 and not isNil(var_262_5) then
				if arg_259_1.var_.characterEffect1011ui_story and not isNil(var_262_5) then
					arg_259_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_6 and arg_259_1.time_ < 0 + var_262_6 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.characterEffect1011ui_story then
				arg_259_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_8 = 0
			local var_262_9 = 0.275

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_10 = arg_259_1:GetWordFromCfg(320202062)
				local var_262_11 = arg_259_1:FormatText(var_262_10.content)

				arg_259_1.text_.text = var_262_11

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_13 = 11 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 11)

				if (11 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 11)) > 0 and var_262_9 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_11
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202062", "story_v_out_320202.awb") ~= 0 then
					local var_262_14 = manager.audio:GetVoiceLength("story_v_out_320202", "320202062", "story_v_out_320202.awb") / 1000

					if var_262_14 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_8
					end

					if var_262_10.prefab_name ~= "" and arg_259_1.actors_[var_262_10.prefab_name] ~= nil then
						local var_262_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_10.prefab_name].transform, "story_v_out_320202", "320202062", "story_v_out_320202.awb")

						arg_259_1:RecordAudio("320202062", var_262_15)
						arg_259_1:RecordAudio("320202062", var_262_15)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_320202", "320202062", "story_v_out_320202.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_320202", "320202062", "story_v_out_320202.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_16 and arg_259_1.time_ < var_262_8 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play320202063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 320202063
		arg_263_1.duration_ = 4.03

		local var_263_0 = {
			zh = 4.033,
			ja = 3.6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play320202064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1011ui_story"]) and arg_263_1.var_.characterEffect1011ui_story == nil then
				arg_263_1.var_.characterEffect1011ui_story = arg_263_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1011ui_story"]) then
				if arg_263_1.var_.characterEffect1011ui_story and not isNil(arg_263_1.actors_["1011ui_story"]) then
					arg_263_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1011ui_story"]) and arg_263_1.var_.characterEffect1011ui_story then
				arg_263_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.55

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:GetWordFromCfg(320202063)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 22 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 22)

				if (22 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 22)) > 0 and var_266_2 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202063", "story_v_out_320202.awb") ~= 0 then
					local var_266_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202063", "story_v_out_320202.awb") / 1000

					if var_266_7 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_1
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_320202", "320202063", "story_v_out_320202.awb")

						arg_263_1:RecordAudio("320202063", var_266_8)
						arg_263_1:RecordAudio("320202063", var_266_8)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_320202", "320202063", "story_v_out_320202.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_320202", "320202063", "story_v_out_320202.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_9 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_9 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_9

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_9 and arg_263_1.time_ < var_266_1 + var_266_9 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play320202064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 320202064
		arg_267_1.duration_ = 11.57

		local var_267_0 = {
			zh = 11.2,
			ja = 11.566
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
				arg_267_0:Play320202065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.35

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:GetWordFromCfg(320202064)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 54 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 54)

				if (54 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 54)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202064", "story_v_out_320202.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202064", "story_v_out_320202.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_320202", "320202064", "story_v_out_320202.awb")

						arg_267_1:RecordAudio("320202064", var_270_6)
						arg_267_1:RecordAudio("320202064", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_320202", "320202064", "story_v_out_320202.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_320202", "320202064", "story_v_out_320202.awb")
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
	Play320202065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 320202065
		arg_271_1.duration_ = 13.63

		local var_271_0 = {
			zh = 11,
			ja = 13.633
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
				arg_271_0:Play320202066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.325

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:GetWordFromCfg(320202065)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 53 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 53)

				if (53 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 53)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202065", "story_v_out_320202.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202065", "story_v_out_320202.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_320202", "320202065", "story_v_out_320202.awb")

						arg_271_1:RecordAudio("320202065", var_274_6)
						arg_271_1:RecordAudio("320202065", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_320202", "320202065", "story_v_out_320202.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_320202", "320202065", "story_v_out_320202.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play320202066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 320202066
		arg_275_1.duration_ = 16.37

		local var_275_0 = {
			zh = 7.4,
			ja = 16.366
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play320202067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1011ui_story"]) and arg_275_1.var_.characterEffect1011ui_story == nil then
				arg_275_1.var_.characterEffect1011ui_story = arg_275_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1011ui_story"]) then
				if arg_275_1.var_.characterEffect1011ui_story and not isNil(arg_275_1.actors_["1011ui_story"]) then
					arg_275_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1011ui_story"]) and arg_275_1.var_.characterEffect1011ui_story then
				arg_275_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_278_2 = 0
			local var_278_3 = 0.8

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:GetWordFromCfg(320202066)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 32 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 32)

				if (32 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 32)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202066", "story_v_out_320202.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_320202", "320202066", "story_v_out_320202.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_out_320202", "320202066", "story_v_out_320202.awb")

						arg_275_1:RecordAudio("320202066", var_278_9)
						arg_275_1:RecordAudio("320202066", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_320202", "320202066", "story_v_out_320202.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_320202", "320202066", "story_v_out_320202.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play320202067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 320202067
		arg_279_1.duration_ = 11.67

		local var_279_0 = {
			zh = 5,
			ja = 11.666
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play320202068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1011ui_story"]) and arg_279_1.var_.characterEffect1011ui_story == nil then
				arg_279_1.var_.characterEffect1011ui_story = arg_279_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1011ui_story"]) then
				if arg_279_1.var_.characterEffect1011ui_story and not isNil(arg_279_1.actors_["1011ui_story"]) then
					arg_279_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1011ui_story"]) and arg_279_1.var_.characterEffect1011ui_story then
				arg_279_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.45

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:GetWordFromCfg(320202067)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_6 = 18 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_4) / 18)

				if (18 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_4) / 18)) > 0 and var_282_2 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202067", "story_v_out_320202.awb") ~= 0 then
					local var_282_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202067", "story_v_out_320202.awb") / 1000

					if var_282_7 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_1
					end

					if var_282_3.prefab_name ~= "" and arg_279_1.actors_[var_282_3.prefab_name] ~= nil then
						local var_282_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_3.prefab_name].transform, "story_v_out_320202", "320202067", "story_v_out_320202.awb")

						arg_279_1:RecordAudio("320202067", var_282_8)
						arg_279_1:RecordAudio("320202067", var_282_8)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_320202", "320202067", "story_v_out_320202.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_320202", "320202067", "story_v_out_320202.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_9 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_9 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_9

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_9 and arg_279_1.time_ < var_282_1 + var_282_9 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play320202068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 320202068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play320202069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1011ui_story = arg_283_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1011ui_story"].transform.position).z)
				arg_283_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1011ui_story"].transform.localEulerAngles = arg_283_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1011ui_story"].transform.position).z)
				arg_283_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1011ui_story"].transform.localEulerAngles = arg_283_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_286_1 = 0
			local var_286_2 = 0.575

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(320202068).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 23 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 23)

				if (23 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 23)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play320202069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 320202069
		arg_287_1.duration_ = 13.93

		local var_287_0 = {
			zh = 13.633,
			ja = 13.933
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
				arg_287_0:Play320202070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.55

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(320202069)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 62 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 62)

				if (62 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 62)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202069", "story_v_out_320202.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202069", "story_v_out_320202.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_320202", "320202069", "story_v_out_320202.awb")

						arg_287_1:RecordAudio("320202069", var_290_6)
						arg_287_1:RecordAudio("320202069", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_320202", "320202069", "story_v_out_320202.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_320202", "320202069", "story_v_out_320202.awb")
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
	Play320202070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 320202070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play320202071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.425

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(320202070).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 17 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 17)

				if (17 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 17)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play320202071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 320202071
		arg_295_1.duration_ = 2.77

		local var_295_0 = {
			zh = 1.2,
			ja = 2.766
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
				arg_295_0:Play320202072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.1

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(320202071)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 4 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 4)

				if (4 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 4)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202071", "story_v_out_320202.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202071", "story_v_out_320202.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_320202", "320202071", "story_v_out_320202.awb")

						arg_295_1:RecordAudio("320202071", var_298_6)
						arg_295_1:RecordAudio("320202071", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_320202", "320202071", "story_v_out_320202.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_320202", "320202071", "story_v_out_320202.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play320202072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 320202072
		arg_299_1.duration_ = 10.53

		local var_299_0 = {
			zh = 8,
			ja = 10.533
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play320202073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.95

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:GetWordFromCfg(320202072)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 38 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 38)

				if (38 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 38)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202072", "story_v_out_320202.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202072", "story_v_out_320202.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_320202", "320202072", "story_v_out_320202.awb")

						arg_299_1:RecordAudio("320202072", var_302_6)
						arg_299_1:RecordAudio("320202072", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_320202", "320202072", "story_v_out_320202.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_320202", "320202072", "story_v_out_320202.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play320202073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 320202073
		arg_303_1.duration_ = 10.2

		local var_303_0 = {
			zh = 10.2,
			ja = 9.433
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play320202074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10102ui_story = arg_303_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10102ui_story"].transform.position).z)
				arg_303_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["10102ui_story"].transform.localEulerAngles = arg_303_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_303_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10102ui_story"].transform.position).z)
				arg_303_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["10102ui_story"].transform.localEulerAngles = arg_303_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["10102ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect10102ui_story == nil then
				arg_303_1.var_.characterEffect10102ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect10102ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect10102ui_story then
				arg_303_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_306_4 = 0
			local var_306_5 = 1.2

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(320202073)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 48 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 48)

				if (48 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 48)) > 0 and var_306_5 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202073", "story_v_out_320202.awb") ~= 0 then
					local var_306_10 = manager.audio:GetVoiceLength("story_v_out_320202", "320202073", "story_v_out_320202.awb") / 1000

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end

					if var_306_6.prefab_name ~= "" and arg_303_1.actors_[var_306_6.prefab_name] ~= nil then
						local var_306_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_6.prefab_name].transform, "story_v_out_320202", "320202073", "story_v_out_320202.awb")

						arg_303_1:RecordAudio("320202073", var_306_11)
						arg_303_1:RecordAudio("320202073", var_306_11)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_320202", "320202073", "story_v_out_320202.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_320202", "320202073", "story_v_out_320202.awb")
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
				actorName = "10102ui_story",
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
	Play320202074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 320202074
		arg_307_1.duration_ = 6.33

		local var_307_0 = {
			zh = 6.233,
			ja = 6.333
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play320202075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10102ui_story"]) and arg_307_1.var_.characterEffect10102ui_story == nil then
				arg_307_1.var_.characterEffect10102ui_story = arg_307_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10102ui_story"]) then
				if arg_307_1.var_.characterEffect10102ui_story and not isNil(arg_307_1.actors_["10102ui_story"]) then
					arg_307_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10102ui_story"]) and arg_307_1.var_.characterEffect10102ui_story then
				arg_307_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.8

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:GetWordFromCfg(320202074)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_6 = 32 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_4) / 32)

				if (32 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_4) / 32)) > 0 and var_310_2 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202074", "story_v_out_320202.awb") ~= 0 then
					local var_310_7 = manager.audio:GetVoiceLength("story_v_out_320202", "320202074", "story_v_out_320202.awb") / 1000

					if var_310_7 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_1
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_320202", "320202074", "story_v_out_320202.awb")

						arg_307_1:RecordAudio("320202074", var_310_8)
						arg_307_1:RecordAudio("320202074", var_310_8)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_320202", "320202074", "story_v_out_320202.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_320202", "320202074", "story_v_out_320202.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_9 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_9 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_9

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_9 and arg_307_1.time_ < var_310_1 + var_310_9 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play320202075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 320202075
		arg_311_1.duration_ = 10.2

		local var_311_0 = {
			zh = 9.133,
			ja = 10.2
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play320202076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 1

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:GetWordFromCfg(320202075)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 40 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 40)

				if (40 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 40)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202075", "story_v_out_320202.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202075", "story_v_out_320202.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_320202", "320202075", "story_v_out_320202.awb")

						arg_311_1:RecordAudio("320202075", var_314_6)
						arg_311_1:RecordAudio("320202075", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_320202", "320202075", "story_v_out_320202.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_320202", "320202075", "story_v_out_320202.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play320202076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 320202076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play320202077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10102ui_story = arg_315_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10102ui_story"].transform.position).z)
				arg_315_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["10102ui_story"].transform.localEulerAngles = arg_315_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_315_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["10102ui_story"].transform.position).z)
				arg_315_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["10102ui_story"].transform.localEulerAngles = arg_315_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["10102ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect10102ui_story == nil then
				arg_315_1.var_.characterEffect10102ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect10102ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_2)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect10102ui_story then
				arg_315_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_318_3 = 0
			local var_318_4 = 1.05

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_5 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(320202076).content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 42 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 42)

				if (42 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 42)) > 0 and var_318_4 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_3
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_8 = math.max(var_318_4, arg_315_1.talkMaxDuration)

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_8 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_3) / var_318_8

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_3 + var_318_8 and arg_315_1.time_ < var_318_3 + var_318_8 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play320202077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 320202077
		arg_319_1.duration_ = 5.5

		local var_319_0 = {
			zh = 4.4,
			ja = 5.5
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
			arg_319_1.auto_ = false
		end

		function arg_319_1.playNext_(arg_321_0)
			arg_319_1.onStoryFinished_()
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.45

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:GetWordFromCfg(320202077)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 18 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 18)

				if (18 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 18)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320202", "320202077", "story_v_out_320202.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_320202", "320202077", "story_v_out_320202.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_320202", "320202077", "story_v_out_320202.awb")

						arg_319_1:RecordAudio("320202077", var_322_6)
						arg_319_1:RecordAudio("320202077", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_320202", "320202077", "story_v_out_320202.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_320202", "320202077", "story_v_out_320202.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L05f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L05i",
		"TextureConfig/Background/ST0502",
		"TextureConfig/Background/L06g"
	},
	voices = {
		"story_v_out_320202.awb"
	}
}
