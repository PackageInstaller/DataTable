return {
	Play420051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420051001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0505 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0505")
				var_4_0.name = "ST0505"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0505 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0505

				arg_1_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0505" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.100000000001 and arg_1_1.time_ < var_4_4 + 0.100000000001 + arg_4_0 then
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

			local var_4_9 = "404001ui_story"

			if arg_1_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["404001ui_story"].transform

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos404001ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.46666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.46666666666667 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_1_1.time_ - 1.46666666666667) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.46666666666667 + var_4_14 and arg_1_1.time_ < 1.46666666666667 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.55, -5.5)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["404001ui_story"]

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect404001ui_story == nil then
				arg_1_1.var_.characterEffect404001ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.46666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.46666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect404001ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.46666666666667 + var_4_16 and arg_1_1.time_ < 1.46666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect404001ui_story then
				arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.6 < arg_1_1.time_ and arg_1_1.time_ <= 1.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			local var_4_25 = 1.999999999999
			local var_4_26 = 0.25

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(420051001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)

				if (10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051001", "story_v_out_420051.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_420051", "420051001", "story_v_out_420051.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_420051", "420051001", "story_v_out_420051.awb")

						arg_1_1:RecordAudio("420051001", var_4_33)
						arg_1_1:RecordAudio("420051001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_420051", "420051001", "story_v_out_420051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_420051", "420051001", "story_v_out_420051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play420051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420051002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos404001ui_story = arg_9_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).z)
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles = arg_9_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).z)
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles = arg_9_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_12_1 = 0
			local var_12_2 = 1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(420051002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)

				if (40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420051003
		arg_13_1.duration_ = 7.57

		local var_13_0 = {
			zh = 5.3,
			ja = 7.566
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
				arg_13_0:Play420051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos404001ui_story = arg_13_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).z)
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles = arg_13_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_13_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).z)
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles = arg_13_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["404001ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect404001ui_story then
				arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_4 = 0
			local var_16_5 = 0.55

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(420051003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 22 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 22)

				if (22 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 22)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051003", "story_v_out_420051.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051003", "story_v_out_420051.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_420051", "420051003", "story_v_out_420051.awb")

						arg_13_1:RecordAudio("420051003", var_16_11)
						arg_13_1:RecordAudio("420051003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_420051", "420051003", "story_v_out_420051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_420051", "420051003", "story_v_out_420051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420051004
		arg_17_1.duration_ = 4.6

		local var_17_0 = {
			zh = 3.5,
			ja = 4.6
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
				arg_17_0:Play420051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos404001ui_story = arg_17_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_20_1 = "1085ui_story"

			if arg_17_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_17_1.stage_.transform)

				var_20_2.name = var_20_1
				var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_1] = var_20_2

				local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

				var_20_3.enabled = true

				local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

				if var_20_4 then
					var_20_4:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_3.transform, false)

				arg_17_1.var_[var_20_1 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_1 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_1 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_5 = arg_17_1.actors_["1085ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1085ui_story = var_20_5.localPosition
			end

			local var_20_6 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_17_1.time_ - 0) / var_20_6)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			local var_20_7 = arg_17_1.actors_["1085ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1085ui_story == nil then
				arg_17_1.var_.characterEffect1085ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect1085ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1085ui_story then
				arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_20_10 = arg_17_1.actors_["404001ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_17_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect404001ui_story then
				arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_17_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_12 = 0
			local var_20_13 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(420051004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 9 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 9)

				if (9 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 9)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051004", "story_v_out_420051.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051004", "story_v_out_420051.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_420051", "420051004", "story_v_out_420051.awb")

						arg_17_1:RecordAudio("420051004", var_20_19)
						arg_17_1:RecordAudio("420051004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_420051", "420051004", "story_v_out_420051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_420051", "420051004", "story_v_out_420051.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_17_1:InitPlayNodeList()
	end,
	Play420051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420051005
		arg_21_1.duration_ = 5.7

		local var_21_0 = {
			zh = 3.666,
			ja = 5.7
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
				arg_21_0:Play420051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["404001ui_story"]) and arg_21_1.var_.characterEffect404001ui_story == nil then
				arg_21_1.var_.characterEffect404001ui_story = arg_21_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["404001ui_story"]) then
				if arg_21_1.var_.characterEffect404001ui_story and not isNil(arg_21_1.actors_["404001ui_story"]) then
					arg_21_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["404001ui_story"]) and arg_21_1.var_.characterEffect404001ui_story then
				arg_21_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_24_2 = arg_21_1.actors_["1085ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1085ui_story == nil then
				arg_21_1.var_.characterEffect1085ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1085ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1085ui_story then
				arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.575

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(420051005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 23 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 23)

				if (23 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 23)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051005", "story_v_out_420051.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051005", "story_v_out_420051.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_420051", "420051005", "story_v_out_420051.awb")

						arg_21_1:RecordAudio("420051005", var_24_11)
						arg_21_1:RecordAudio("420051005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_420051", "420051005", "story_v_out_420051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_420051", "420051005", "story_v_out_420051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play420051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420051006
		arg_25_1.duration_ = 5.4

		local var_25_0 = {
			zh = 4.1,
			ja = 5.4
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
				arg_25_0:Play420051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_0 = 0
			local var_28_1 = 0.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(420051006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 23 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 23)

				if (23 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 23)) > 0 and var_28_1 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051006", "story_v_out_420051.awb") ~= 0 then
					local var_28_6 = manager.audio:GetVoiceLength("story_v_out_420051", "420051006", "story_v_out_420051.awb") / 1000

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end

					if var_28_2.prefab_name ~= "" and arg_25_1.actors_[var_28_2.prefab_name] ~= nil then
						local var_28_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_2.prefab_name].transform, "story_v_out_420051", "420051006", "story_v_out_420051.awb")

						arg_25_1:RecordAudio("420051006", var_28_7)
						arg_25_1:RecordAudio("420051006", var_28_7)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_420051", "420051006", "story_v_out_420051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_420051", "420051006", "story_v_out_420051.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420051007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1085ui_story"]) and arg_29_1.var_.characterEffect1085ui_story == nil then
				arg_29_1.var_.characterEffect1085ui_story = arg_29_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1085ui_story"]) then
				if arg_29_1.var_.characterEffect1085ui_story and not isNil(arg_29_1.actors_["1085ui_story"]) then
					arg_29_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1085ui_story"]) and arg_29_1.var_.characterEffect1085ui_story then
				arg_29_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["404001ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect404001ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_29_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect404001ui_story then
				arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_29_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_32_4 = 0
			local var_32_5 = 0.05

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(420051007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 2 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 2)

				if (2 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 2)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051007", "story_v_out_420051.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051007", "story_v_out_420051.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_420051", "420051007", "story_v_out_420051.awb")

						arg_29_1:RecordAudio("420051007", var_32_11)
						arg_29_1:RecordAudio("420051007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420051", "420051007", "story_v_out_420051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420051", "420051007", "story_v_out_420051.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play420051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420051008
		arg_33_1.duration_ = 2.3

		local var_33_0 = {
			zh = 2.3,
			ja = 2.066
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
				arg_33_0:Play420051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["404001ui_story"]) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = arg_33_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["404001ui_story"]) then
				if arg_33_1.var_.characterEffect404001ui_story and not isNil(arg_33_1.actors_["404001ui_story"]) then
					arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["404001ui_story"]) and arg_33_1.var_.characterEffect404001ui_story then
				arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_36_2 = arg_33_1.actors_["1085ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1085ui_story == nil then
				arg_33_1.var_.characterEffect1085ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect1085ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1085ui_story then
				arg_33_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_36_4 = 0
			local var_36_5 = 0.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(420051008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 8 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 8)

				if (8 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 8)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051008", "story_v_out_420051.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051008", "story_v_out_420051.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_420051", "420051008", "story_v_out_420051.awb")

						arg_33_1:RecordAudio("420051008", var_36_11)
						arg_33_1:RecordAudio("420051008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_420051", "420051008", "story_v_out_420051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_420051", "420051008", "story_v_out_420051.awb")
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

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play420051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420051009
		arg_37_1.duration_ = 2.2

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_37_0:Play420051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1085ui_story"]) and arg_37_1.var_.characterEffect1085ui_story == nil then
				arg_37_1.var_.characterEffect1085ui_story = arg_37_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1085ui_story"]) then
				if arg_37_1.var_.characterEffect1085ui_story and not isNil(arg_37_1.actors_["1085ui_story"]) then
					arg_37_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1085ui_story"]) and arg_37_1.var_.characterEffect1085ui_story then
				arg_37_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_40_2 = arg_37_1.actors_["404001ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_37_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect404001ui_story then
				arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_37_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_40_4 = 0
			local var_40_5 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(420051009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 7 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 7)

				if (7 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 7)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051009", "story_v_out_420051.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051009", "story_v_out_420051.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_420051", "420051009", "story_v_out_420051.awb")

						arg_37_1:RecordAudio("420051009", var_40_11)
						arg_37_1:RecordAudio("420051009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_420051", "420051009", "story_v_out_420051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_420051", "420051009", "story_v_out_420051.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play420051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420051010
		arg_41_1.duration_ = 5.4

		local var_41_0 = {
			zh = 5.366,
			ja = 5.4
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
				arg_41_0:Play420051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["404001ui_story"]) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = arg_41_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["404001ui_story"]) then
				if arg_41_1.var_.characterEffect404001ui_story and not isNil(arg_41_1.actors_["404001ui_story"]) then
					arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["404001ui_story"]) and arg_41_1.var_.characterEffect404001ui_story then
				arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1085ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1085ui_story == nil then
				arg_41_1.var_.characterEffect1085ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1085ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1085ui_story then
				arg_41_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 0.6

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(420051010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 24 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 24)

				if (24 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 24)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051010", "story_v_out_420051.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051010", "story_v_out_420051.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_420051", "420051010", "story_v_out_420051.awb")

						arg_41_1:RecordAudio("420051010", var_44_11)
						arg_41_1:RecordAudio("420051010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_420051", "420051010", "story_v_out_420051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_420051", "420051010", "story_v_out_420051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play420051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420051011
		arg_45_1.duration_ = 2.77

		local var_45_0 = {
			zh = 2.4,
			ja = 2.766
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
				arg_45_0:Play420051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1085ui_story"]) and arg_45_1.var_.characterEffect1085ui_story == nil then
				arg_45_1.var_.characterEffect1085ui_story = arg_45_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1085ui_story"]) then
				if arg_45_1.var_.characterEffect1085ui_story and not isNil(arg_45_1.actors_["1085ui_story"]) then
					arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1085ui_story"]) and arg_45_1.var_.characterEffect1085ui_story then
				arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_48_2 = arg_45_1.actors_["404001ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_45_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect404001ui_story then
				arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_45_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_48_4 = 0
			local var_48_5 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(420051011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 8 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 8)

				if (8 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 8)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051011", "story_v_out_420051.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051011", "story_v_out_420051.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_420051", "420051011", "story_v_out_420051.awb")

						arg_45_1:RecordAudio("420051011", var_48_11)
						arg_45_1:RecordAudio("420051011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_420051", "420051011", "story_v_out_420051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_420051", "420051011", "story_v_out_420051.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play420051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420051012
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			zh = 5.233,
			ja = 5.9
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
				arg_49_0:Play420051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["404001ui_story"]) and arg_49_1.var_.characterEffect404001ui_story == nil then
				arg_49_1.var_.characterEffect404001ui_story = arg_49_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["404001ui_story"]) then
				if arg_49_1.var_.characterEffect404001ui_story and not isNil(arg_49_1.actors_["404001ui_story"]) then
					arg_49_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["404001ui_story"]) and arg_49_1.var_.characterEffect404001ui_story then
				arg_49_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1085ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1085ui_story == nil then
				arg_49_1.var_.characterEffect1085ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1085ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1085ui_story then
				arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_52_4 = 0
			local var_52_5 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(420051012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 24 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 24)

				if (24 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 24)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051012", "story_v_out_420051.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051012", "story_v_out_420051.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_420051", "420051012", "story_v_out_420051.awb")

						arg_49_1:RecordAudio("420051012", var_52_11)
						arg_49_1:RecordAudio("420051012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_420051", "420051012", "story_v_out_420051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_420051", "420051012", "story_v_out_420051.awb")
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
	Play420051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420051013
		arg_53_1.duration_ = 6.43

		local var_53_0 = {
			zh = 3.566,
			ja = 6.433
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
				arg_53_0:Play420051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(420051013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)

				if (18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051013", "story_v_out_420051.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051013", "story_v_out_420051.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_420051", "420051013", "story_v_out_420051.awb")

						arg_53_1:RecordAudio("420051013", var_56_6)
						arg_53_1:RecordAudio("420051013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_420051", "420051013", "story_v_out_420051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_420051", "420051013", "story_v_out_420051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play420051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420051014
		arg_57_1.duration_ = 3.6

		local var_57_0 = {
			zh = 3.066,
			ja = 3.6
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
				arg_57_0:Play420051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1085ui_story"]) and arg_57_1.var_.characterEffect1085ui_story == nil then
				arg_57_1.var_.characterEffect1085ui_story = arg_57_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1085ui_story"]) then
				if arg_57_1.var_.characterEffect1085ui_story and not isNil(arg_57_1.actors_["1085ui_story"]) then
					arg_57_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1085ui_story"]) and arg_57_1.var_.characterEffect1085ui_story then
				arg_57_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["404001ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect404001ui_story == nil then
				arg_57_1.var_.characterEffect404001ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect404001ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_57_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect404001ui_story then
				arg_57_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_57_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_60_4 = 0
			local var_60_5 = 0.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(420051014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 10 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 10)

				if (10 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 10)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051014", "story_v_out_420051.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051014", "story_v_out_420051.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_420051", "420051014", "story_v_out_420051.awb")

						arg_57_1:RecordAudio("420051014", var_60_11)
						arg_57_1:RecordAudio("420051014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_420051", "420051014", "story_v_out_420051.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_420051", "420051014", "story_v_out_420051.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play420051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 420051015
		arg_61_1.duration_ = 2.9

		local var_61_0 = {
			zh = 2.133,
			ja = 2.9
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
				arg_61_0:Play420051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["404001ui_story"]) and arg_61_1.var_.characterEffect404001ui_story == nil then
				arg_61_1.var_.characterEffect404001ui_story = arg_61_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["404001ui_story"]) then
				if arg_61_1.var_.characterEffect404001ui_story and not isNil(arg_61_1.actors_["404001ui_story"]) then
					arg_61_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["404001ui_story"]) and arg_61_1.var_.characterEffect404001ui_story then
				arg_61_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1085ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1085ui_story == nil then
				arg_61_1.var_.characterEffect1085ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1085ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1085ui_story then
				arg_61_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_64_4 = 0
			local var_64_5 = 0.125

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(420051015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 5)

				if (5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 5)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051015", "story_v_out_420051.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051015", "story_v_out_420051.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_420051", "420051015", "story_v_out_420051.awb")

						arg_61_1:RecordAudio("420051015", var_64_11)
						arg_61_1:RecordAudio("420051015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_420051", "420051015", "story_v_out_420051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_420051", "420051015", "story_v_out_420051.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play420051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 420051016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play420051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos404001ui_story = arg_65_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["404001ui_story"].transform.position).z)
				arg_65_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["404001ui_story"].transform.localEulerAngles = arg_65_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["404001ui_story"].transform.position).z)
				arg_65_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["404001ui_story"].transform.localEulerAngles = arg_65_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1085ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1085ui_story = var_68_1.localPosition
			end

			local var_68_2 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 then
				var_68_1.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_2)
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
			local var_68_4 = 0.7

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

				local var_68_5 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(420051016).content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 28 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 28)

				if (28 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 28)) > 0 and var_68_4 < var_68_7 then
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
				actorName = "404001ui_story",
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

		arg_65_1:InitPlayNodeList()
	end,
	Play420051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 420051017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play420051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.7

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(420051017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 28 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 28)

				if (28 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 28)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play420051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 420051018
		arg_73_1.duration_ = 9.43

		local var_73_0 = {
			zh = 8.6,
			ja = 9.433
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
				arg_73_0:Play420051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos404001ui_story = arg_73_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["404001ui_story"].transform.position).z)
				arg_73_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["404001ui_story"].transform.localEulerAngles = arg_73_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_73_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["404001ui_story"].transform.position).z)
				arg_73_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["404001ui_story"].transform.localEulerAngles = arg_73_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["404001ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect404001ui_story == nil then
				arg_73_1.var_.characterEffect404001ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect404001ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect404001ui_story then
				arg_73_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_76_4 = 0
			local var_76_5 = 0.925

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(420051018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 37 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 37)

				if (37 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 37)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051018", "story_v_out_420051.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051018", "story_v_out_420051.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_420051", "420051018", "story_v_out_420051.awb")

						arg_73_1:RecordAudio("420051018", var_76_11)
						arg_73_1:RecordAudio("420051018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_420051", "420051018", "story_v_out_420051.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_420051", "420051018", "story_v_out_420051.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 420051019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play420051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos404001ui_story = arg_77_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["404001ui_story"].transform.position).z)
				arg_77_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["404001ui_story"].transform.localEulerAngles = arg_77_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["404001ui_story"].transform.position).z)
				arg_77_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["404001ui_story"].transform.localEulerAngles = arg_77_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.8 < arg_77_1.time_ and arg_77_1.time_ <= 0.8 + arg_80_0 then
				arg_77_1:AudioAction("play", "effect", "se_story_side_1042", "se_story_1042_doorbell", "")
			end

			local var_80_2 = 0
			local var_80_3 = 0.975

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(420051019).content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 39 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 39)

				if (39 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 39)) > 0 and var_80_3 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_7 and arg_77_1.time_ < var_80_2 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 420051020
		arg_81_1.duration_ = 16.2

		local var_81_0 = {
			zh = 14.1,
			ja = 16.2
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
				arg_81_0:Play420051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.bgs_.L01f == nil then
				local var_84_0 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_84_0.name = "L01f"
				var_84_0.transform.parent = arg_81_1.stage_.transform
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_.L01f = var_84_0
			end

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= 2 + arg_84_0 then
				local var_84_1 = arg_81_1.bgs_.L01f

				arg_81_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_2 = var_84_1:GetComponent("SpriteRenderer")

				if var_84_2 and var_84_2.sprite then
					local var_84_3 = 2 * (var_84_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_1.transform.localScale = Vector3.New(var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "L01f" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_4 = 4

			if 4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			if arg_81_1.time_ >= var_84_4 + 0.3 and arg_81_1.time_ < var_84_4 + 0.3 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_5 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_6 = 2

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 then
				local var_84_7 = Color.New(0, 0, 0)

				var_84_7.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_5) / var_84_6)
				arg_81_1.mask_.color = var_84_7
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 then
				local var_84_8 = Color.New(0, 0, 0)

				var_84_8.a = 1
				arg_81_1.mask_.color = var_84_8
			end

			local var_84_9 = 2

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_10 = 2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 then
				local var_84_11 = Color.New(0, 0, 0)

				var_84_11.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_9) / var_84_10)
				arg_81_1.mask_.color = var_84_11
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 then
				local var_84_12 = Color.New(0, 0, 0)

				arg_81_1.mask_.enabled = false
				var_84_12.a = 0
				arg_81_1.mask_.color = var_84_12
			end

			if 3.8 < arg_81_1.time_ and arg_81_1.time_ <= 3.8 + arg_84_0 then
				arg_81_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 3.8 < arg_81_1.time_ and arg_81_1.time_ <= 3.8 + arg_84_0 then
				arg_81_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_13 = arg_81_1.actors_["404001ui_story"].transform

			if 3.8 < arg_81_1.time_ and arg_81_1.time_ <= 3.8 + arg_84_0 then
				arg_81_1.var_.moveOldPos404001ui_story = var_84_13.localPosition
			end

			local var_84_14 = 0.001

			if 3.8 <= arg_81_1.time_ and arg_81_1.time_ < 3.8 + var_84_14 then
				var_84_13.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_81_1.time_ - 3.8) / var_84_14)
				var_84_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_13.position).x, (manager.ui.mainCamera.transform.position - var_84_13.position).y, (manager.ui.mainCamera.transform.position - var_84_13.position).z)
				var_84_13.localEulerAngles.z = 0
				var_84_13.localEulerAngles.x = 0
				var_84_13.localEulerAngles = var_84_13.localEulerAngles
			end

			if arg_81_1.time_ >= 3.8 + var_84_14 and arg_81_1.time_ < 3.8 + var_84_14 + arg_84_0 then
				var_84_13.localPosition = Vector3.New(0, -1.55, -5.5)
				var_84_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_13.position).x, (manager.ui.mainCamera.transform.position - var_84_13.position).y, (manager.ui.mainCamera.transform.position - var_84_13.position).z)
				var_84_13.localEulerAngles.z = 0
				var_84_13.localEulerAngles.x = 0
				var_84_13.localEulerAngles = var_84_13.localEulerAngles
			end

			local var_84_15 = arg_81_1.actors_["404001ui_story"]

			if 3.8 < arg_81_1.time_ and arg_81_1.time_ <= 3.8 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect404001ui_story == nil then
				arg_81_1.var_.characterEffect404001ui_story = var_84_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_16 = 0.200000002980232

			if 3.8 <= arg_81_1.time_ and arg_81_1.time_ < 3.8 + var_84_16 and not isNil(var_84_15) then
				if arg_81_1.var_.characterEffect404001ui_story and not isNil(var_84_15) then
					arg_81_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 3.8 + var_84_16 and arg_81_1.time_ < 3.8 + var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect404001ui_story then
				arg_81_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_18 = 4
			local var_84_19 = 1.125

			if 4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_20 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_20:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_21 = arg_81_1:GetWordFromCfg(420051020)
				local var_84_22 = arg_81_1:FormatText(var_84_21.content)

				arg_81_1.text_.text = var_84_22

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_24 = 45 <= 0 and var_84_19 or var_84_19 * (utf8.len(var_84_22) / 45)

				if (45 <= 0 and var_84_19 or var_84_19 * (utf8.len(var_84_22) / 45)) > 0 and var_84_19 < var_84_24 then
					arg_81_1.talkMaxDuration = var_84_24
					var_84_18 = var_84_18 + 0.3

					if var_84_24 + var_84_18 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_24 + var_84_18
					end
				end

				arg_81_1.text_.text = var_84_22
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051020", "story_v_out_420051.awb") ~= 0 then
					local var_84_25 = manager.audio:GetVoiceLength("story_v_out_420051", "420051020", "story_v_out_420051.awb") / 1000

					if var_84_25 + var_84_18 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_25 + var_84_18
					end

					if var_84_21.prefab_name ~= "" and arg_81_1.actors_[var_84_21.prefab_name] ~= nil then
						local var_84_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_21.prefab_name].transform, "story_v_out_420051", "420051020", "story_v_out_420051.awb")

						arg_81_1:RecordAudio("420051020", var_84_26)
						arg_81_1:RecordAudio("420051020", var_84_26)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_420051", "420051020", "story_v_out_420051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_420051", "420051020", "story_v_out_420051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_27 = var_84_18 + 0.3
			local var_84_28 = math.max(var_84_19, arg_81_1.talkMaxDuration)

			if var_84_18 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_27 + var_84_28 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_27) / var_84_28

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_27 + var_84_28 and arg_81_1.time_ < var_84_27 + var_84_28 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play420051021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 420051021
		arg_87_1.duration_ = 3.8

		local var_87_0 = {
			zh = 2.8,
			ja = 3.8
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
				arg_87_0:Play420051022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.3

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(420051021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 12 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 12)

				if (12 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 12)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051021", "story_v_out_420051.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051021", "story_v_out_420051.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_420051", "420051021", "story_v_out_420051.awb")

						arg_87_1:RecordAudio("420051021", var_90_6)
						arg_87_1:RecordAudio("420051021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_420051", "420051021", "story_v_out_420051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_420051", "420051021", "story_v_out_420051.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play420051022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 420051022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play420051023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos404001ui_story = arg_91_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["404001ui_story"].transform.position).z)
				arg_91_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["404001ui_story"].transform.localEulerAngles = arg_91_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["404001ui_story"].transform.position).z)
				arg_91_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["404001ui_story"].transform.localEulerAngles = arg_91_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.05 < arg_91_1.time_ and arg_91_1.time_ <= 0.05 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car04", "")
			end

			local var_94_2 = 0
			local var_94_3 = 1.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(420051022).content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 52 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 52)

				if (52 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 52)) > 0 and var_94_3 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_7 and arg_91_1.time_ < var_94_2 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play420051023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 420051023
		arg_95_1.duration_ = 3.57

		local var_95_0 = {
			zh = 3.566,
			ja = 3.4
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play420051024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1085ui_story = arg_95_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1085ui_story"].transform.position).z)
				arg_95_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1085ui_story"].transform.localEulerAngles = arg_95_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_95_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1085ui_story"].transform.position).z)
				arg_95_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1085ui_story"].transform.localEulerAngles = arg_95_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1085ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1085ui_story == nil then
				arg_95_1.var_.characterEffect1085ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1085ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1085ui_story then
				arg_95_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_98_4 = 0
			local var_98_5 = 0.35

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(420051023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 14 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 14)

				if (14 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 14)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051023", "story_v_out_420051.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051023", "story_v_out_420051.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_420051", "420051023", "story_v_out_420051.awb")

						arg_95_1:RecordAudio("420051023", var_98_11)
						arg_95_1:RecordAudio("420051023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_420051", "420051023", "story_v_out_420051.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_420051", "420051023", "story_v_out_420051.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play420051024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 420051024
		arg_99_1.duration_ = 3.3

		local var_99_0 = {
			zh = 2.7,
			ja = 3.3
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play420051025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos404001ui_story = arg_99_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["404001ui_story"].transform.position).z)
				arg_99_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["404001ui_story"].transform.localEulerAngles = arg_99_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_99_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["404001ui_story"].transform.position).z)
				arg_99_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["404001ui_story"].transform.localEulerAngles = arg_99_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["404001ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect404001ui_story == nil then
				arg_99_1.var_.characterEffect404001ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect404001ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect404001ui_story then
				arg_99_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_102_4 = arg_99_1.actors_["1085ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1085ui_story == nil then
				arg_99_1.var_.characterEffect1085ui_story = var_102_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_5 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 and not isNil(var_102_4) then
				if arg_99_1.var_.characterEffect1085ui_story and not isNil(var_102_4) then
					arg_99_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_5)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1085ui_story then
				arg_99_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_102_6 = arg_99_1.actors_["1085ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1085ui_story = var_102_6.localPosition
			end

			local var_102_7 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				var_102_6.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_7)
				var_102_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_6.position).x, (manager.ui.mainCamera.transform.position - var_102_6.position).y, (manager.ui.mainCamera.transform.position - var_102_6.position).z)
				var_102_6.localEulerAngles.z = 0
				var_102_6.localEulerAngles.x = 0
				var_102_6.localEulerAngles = var_102_6.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				var_102_6.localPosition = Vector3.New(0, 100, 0)
				var_102_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_6.position).x, (manager.ui.mainCamera.transform.position - var_102_6.position).y, (manager.ui.mainCamera.transform.position - var_102_6.position).z)
				var_102_6.localEulerAngles.z = 0
				var_102_6.localEulerAngles.x = 0
				var_102_6.localEulerAngles = var_102_6.localEulerAngles
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_102_8 = 0
			local var_102_9 = 0.25

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_10 = arg_99_1:GetWordFromCfg(420051024)
				local var_102_11 = arg_99_1:FormatText(var_102_10.content)

				arg_99_1.text_.text = var_102_11

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 10 <= 0 and var_102_9 or var_102_9 * (utf8.len(var_102_11) / 10)

				if (10 <= 0 and var_102_9 or var_102_9 * (utf8.len(var_102_11) / 10)) > 0 and var_102_9 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_8
					end
				end

				arg_99_1.text_.text = var_102_11
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051024", "story_v_out_420051.awb") ~= 0 then
					local var_102_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051024", "story_v_out_420051.awb") / 1000

					if var_102_14 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_8
					end

					if var_102_10.prefab_name ~= "" and arg_99_1.actors_[var_102_10.prefab_name] ~= nil then
						local var_102_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_10.prefab_name].transform, "story_v_out_420051", "420051024", "story_v_out_420051.awb")

						arg_99_1:RecordAudio("420051024", var_102_15)
						arg_99_1:RecordAudio("420051024", var_102_15)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_420051", "420051024", "story_v_out_420051.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_420051", "420051024", "story_v_out_420051.awb")
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
				actorName = "404001ui_story",
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

		arg_99_1:InitPlayNodeList()
	end,
	Play420051025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 420051025
		arg_103_1.duration_ = 5.87

		local var_103_0 = {
			zh = 4.7,
			ja = 5.866
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
				arg_103_0:Play420051026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos404001ui_story = arg_103_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["404001ui_story"].transform.position).z)
				arg_103_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["404001ui_story"].transform.localEulerAngles = arg_103_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_103_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["404001ui_story"].transform.position).z)
				arg_103_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["404001ui_story"].transform.localEulerAngles = arg_103_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1085ui_story"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1085ui_story = var_106_1.localPosition
			end

			local var_106_2 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 then
				var_106_1.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_103_1.time_ - 0) / var_106_2)
				var_106_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_1.position).x, (manager.ui.mainCamera.transform.position - var_106_1.position).y, (manager.ui.mainCamera.transform.position - var_106_1.position).z)
				var_106_1.localEulerAngles.z = 0
				var_106_1.localEulerAngles.x = 0
				var_106_1.localEulerAngles = var_106_1.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 then
				var_106_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_106_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_1.position).x, (manager.ui.mainCamera.transform.position - var_106_1.position).y, (manager.ui.mainCamera.transform.position - var_106_1.position).z)
				var_106_1.localEulerAngles.z = 0
				var_106_1.localEulerAngles.x = 0
				var_106_1.localEulerAngles = var_106_1.localEulerAngles
			end

			local var_106_3 = arg_103_1.actors_["1085ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect1085ui_story == nil then
				arg_103_1.var_.characterEffect1085ui_story = var_106_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_4 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 and not isNil(var_106_3) then
				if arg_103_1.var_.characterEffect1085ui_story and not isNil(var_106_3) then
					arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect1085ui_story then
				arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_106_6 = arg_103_1.actors_["404001ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect404001ui_story == nil then
				arg_103_1.var_.characterEffect404001ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 and not isNil(var_106_6) then
				if arg_103_1.var_.characterEffect404001ui_story and not isNil(var_106_6) then
					arg_103_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_103_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_7)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect404001ui_story then
				arg_103_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_103_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_106_8 = 0
			local var_106_9 = 0.625

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(420051025)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 25 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 25)

				if (25 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 25)) > 0 and var_106_9 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051025", "story_v_out_420051.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051025", "story_v_out_420051.awb") / 1000

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_420051", "420051025", "story_v_out_420051.awb")

						arg_103_1:RecordAudio("420051025", var_106_15)
						arg_103_1:RecordAudio("420051025", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_420051", "420051025", "story_v_out_420051.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_420051", "420051025", "story_v_out_420051.awb")
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
				actorName = "404001ui_story",
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

		arg_103_1:InitPlayNodeList()
	end,
	Play420051026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 420051026
		arg_107_1.duration_ = 6.47

		local var_107_0 = {
			zh = 4.833,
			ja = 6.466
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
				arg_107_0:Play420051027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["404001ui_story"]) and arg_107_1.var_.characterEffect404001ui_story == nil then
				arg_107_1.var_.characterEffect404001ui_story = arg_107_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["404001ui_story"]) then
				if arg_107_1.var_.characterEffect404001ui_story and not isNil(arg_107_1.actors_["404001ui_story"]) then
					arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["404001ui_story"]) and arg_107_1.var_.characterEffect404001ui_story then
				arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_110_2 = arg_107_1.actors_["1085ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect1085ui_story == nil then
				arg_107_1.var_.characterEffect1085ui_story = var_110_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_3 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.characterEffect1085ui_story and not isNil(var_110_2) then
					arg_107_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_3)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect1085ui_story then
				arg_107_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_110_4 = 0
			local var_110_5 = 0.525

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(420051026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 21 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 21)

				if (21 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 21)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051026", "story_v_out_420051.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051026", "story_v_out_420051.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_420051", "420051026", "story_v_out_420051.awb")

						arg_107_1:RecordAudio("420051026", var_110_11)
						arg_107_1:RecordAudio("420051026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_420051", "420051026", "story_v_out_420051.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_420051", "420051026", "story_v_out_420051.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play420051027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 420051027
		arg_111_1.duration_ = 2

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play420051028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1085ui_story"]) and arg_111_1.var_.characterEffect1085ui_story == nil then
				arg_111_1.var_.characterEffect1085ui_story = arg_111_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1085ui_story"]) then
				if arg_111_1.var_.characterEffect1085ui_story and not isNil(arg_111_1.actors_["1085ui_story"]) then
					arg_111_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1085ui_story"]) and arg_111_1.var_.characterEffect1085ui_story then
				arg_111_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_114_2 = arg_111_1.actors_["404001ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect404001ui_story == nil then
				arg_111_1.var_.characterEffect404001ui_story = var_114_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_3 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.characterEffect404001ui_story and not isNil(var_114_2) then
					arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_111_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_3)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect404001ui_story then
				arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_111_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_114_4 = 0
			local var_114_5 = 0.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(420051027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 6 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 6)

				if (6 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 6)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051027", "story_v_out_420051.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051027", "story_v_out_420051.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_out_420051", "420051027", "story_v_out_420051.awb")

						arg_111_1:RecordAudio("420051027", var_114_11)
						arg_111_1:RecordAudio("420051027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_420051", "420051027", "story_v_out_420051.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_420051", "420051027", "story_v_out_420051.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play420051028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 420051028
		arg_115_1.duration_ = 9

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play420051029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.bgs_.ST0503 == nil then
				local var_118_0 = Object.Instantiate(arg_115_1.paintGo_)

				var_118_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0503")
				var_118_0.name = "ST0503"
				var_118_0.transform.parent = arg_115_1.stage_.transform
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.bgs_.ST0503 = var_118_0
			end

			if 1.999999999999 < arg_115_1.time_ and arg_115_1.time_ <= 1.999999999999 + arg_118_0 then
				local var_118_1 = arg_115_1.bgs_.ST0503

				arg_115_1.bgs_.ST0503.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_2 = var_118_1:GetComponent("SpriteRenderer")

				if var_118_2 and var_118_2.sprite then
					local var_118_3 = 2 * (var_118_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_1.transform.localScale = Vector3.New(var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST0503" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_4 = 3.999999999999

			if 3.999999999999 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			if arg_115_1.time_ >= var_118_4 + 0.400000000001 and arg_115_1.time_ < var_118_4 + 0.400000000001 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			local var_118_5 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_6 = 2

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_6 then
				local var_118_7 = Color.New(0, 0, 0)

				var_118_7.a = Mathf.Lerp(0, 1, (arg_115_1.time_ - var_118_5) / var_118_6)
				arg_115_1.mask_.color = var_118_7
			end

			if arg_115_1.time_ >= var_118_5 + var_118_6 and arg_115_1.time_ < var_118_5 + var_118_6 + arg_118_0 then
				local var_118_8 = Color.New(0, 0, 0)

				var_118_8.a = 1
				arg_115_1.mask_.color = var_118_8
			end

			local var_118_9 = 2

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_10 = 2

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_10 then
				local var_118_11 = Color.New(0, 0, 0)

				var_118_11.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - var_118_9) / var_118_10)
				arg_115_1.mask_.color = var_118_11
			end

			if arg_115_1.time_ >= var_118_9 + var_118_10 and arg_115_1.time_ < var_118_9 + var_118_10 + arg_118_0 then
				local var_118_12 = Color.New(0, 0, 0)

				arg_115_1.mask_.enabled = false
				var_118_12.a = 0
				arg_115_1.mask_.color = var_118_12
			end

			local var_118_13 = arg_115_1.actors_["404001ui_story"].transform

			if 1.999999999999 < arg_115_1.time_ and arg_115_1.time_ <= 1.999999999999 + arg_118_0 then
				arg_115_1.var_.moveOldPos404001ui_story = var_118_13.localPosition
			end

			local var_118_14 = 0.001

			if 1.999999999999 <= arg_115_1.time_ and arg_115_1.time_ < 1.999999999999 + var_118_14 then
				var_118_13.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 1.999999999999) / var_118_14)
				var_118_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_13.position).x, (manager.ui.mainCamera.transform.position - var_118_13.position).y, (manager.ui.mainCamera.transform.position - var_118_13.position).z)
				var_118_13.localEulerAngles.z = 0
				var_118_13.localEulerAngles.x = 0
				var_118_13.localEulerAngles = var_118_13.localEulerAngles
			end

			if arg_115_1.time_ >= 1.999999999999 + var_118_14 and arg_115_1.time_ < 1.999999999999 + var_118_14 + arg_118_0 then
				var_118_13.localPosition = Vector3.New(0, 100, 0)
				var_118_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_13.position).x, (manager.ui.mainCamera.transform.position - var_118_13.position).y, (manager.ui.mainCamera.transform.position - var_118_13.position).z)
				var_118_13.localEulerAngles.z = 0
				var_118_13.localEulerAngles.x = 0
				var_118_13.localEulerAngles = var_118_13.localEulerAngles
			end

			local var_118_15 = arg_115_1.actors_["1085ui_story"].transform

			if 1.999999999999 < arg_115_1.time_ and arg_115_1.time_ <= 1.999999999999 + arg_118_0 then
				arg_115_1.var_.moveOldPos1085ui_story = var_118_15.localPosition
			end

			local var_118_16 = 0.001

			if 1.999999999999 <= arg_115_1.time_ and arg_115_1.time_ < 1.999999999999 + var_118_16 then
				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 1.999999999999) / var_118_16)
				var_118_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_15.position).x, (manager.ui.mainCamera.transform.position - var_118_15.position).y, (manager.ui.mainCamera.transform.position - var_118_15.position).z)
				var_118_15.localEulerAngles.z = 0
				var_118_15.localEulerAngles.x = 0
				var_118_15.localEulerAngles = var_118_15.localEulerAngles
			end

			if arg_115_1.time_ >= 1.999999999999 + var_118_16 and arg_115_1.time_ < 1.999999999999 + var_118_16 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(0, 100, 0)
				var_118_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_15.position).x, (manager.ui.mainCamera.transform.position - var_118_15.position).y, (manager.ui.mainCamera.transform.position - var_118_15.position).z)
				var_118_15.localEulerAngles.z = 0
				var_118_15.localEulerAngles.x = 0
				var_118_15.localEulerAngles = var_118_15.localEulerAngles
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_17 = 4
			local var_118_18 = 0.8

			if 4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_19 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_19:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_20 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(420051028).content)

				arg_115_1.text_.text = var_118_20

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_22 = 32 <= 0 and var_118_18 or var_118_18 * (utf8.len(var_118_20) / 32)

				if (32 <= 0 and var_118_18 or var_118_18 * (utf8.len(var_118_20) / 32)) > 0 and var_118_18 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22
					var_118_17 = var_118_17 + 0.3

					if var_118_22 + var_118_17 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_17
					end
				end

				arg_115_1.text_.text = var_118_20
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_23 = var_118_17 + 0.3
			local var_118_24 = math.max(var_118_18, arg_115_1.talkMaxDuration)

			if var_118_17 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_24 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_23) / var_118_24

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_23 + var_118_24 and arg_115_1.time_ < var_118_23 + var_118_24 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play420051029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 420051029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play420051030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.725

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(420051029).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 69 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 69)

				if (69 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 69)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play420051030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 420051030
		arg_125_1.duration_ = 3.2

		local var_125_0 = {
			zh = 3.2,
			ja = 2.733
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
				arg_125_0:Play420051031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1085ui_story = arg_125_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1085ui_story"].transform.position).z)
				arg_125_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1085ui_story"].transform.localEulerAngles = arg_125_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_125_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1085ui_story"].transform.position).z)
				arg_125_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1085ui_story"].transform.localEulerAngles = arg_125_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1085ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1085ui_story == nil then
				arg_125_1.var_.characterEffect1085ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1085ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1085ui_story then
				arg_125_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_4 = 0
			local var_128_5 = 0.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(420051030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 10 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 10)

				if (10 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 10)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051030", "story_v_out_420051.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051030", "story_v_out_420051.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_420051", "420051030", "story_v_out_420051.awb")

						arg_125_1:RecordAudio("420051030", var_128_11)
						arg_125_1:RecordAudio("420051030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_420051", "420051030", "story_v_out_420051.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_420051", "420051030", "story_v_out_420051.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play420051031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 420051031
		arg_129_1.duration_ = 5.6

		local var_129_0 = {
			zh = 3.5,
			ja = 5.6
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play420051032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1085ui_story = arg_129_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1085ui_story"].transform.position).z)
				arg_129_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1085ui_story"].transform.localEulerAngles = arg_129_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1085ui_story"].transform.position).z)
				arg_129_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1085ui_story"].transform.localEulerAngles = arg_129_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_132_1 = 0
			local var_132_2 = 0.375

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1157].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(420051031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 15 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 15)

				if (15 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 15)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051031", "story_v_out_420051.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_420051", "420051031", "story_v_out_420051.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_420051", "420051031", "story_v_out_420051.awb")

						arg_129_1:RecordAudio("420051031", var_132_8)
						arg_129_1:RecordAudio("420051031", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_420051", "420051031", "story_v_out_420051.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_420051", "420051031", "story_v_out_420051.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_9 and arg_129_1.time_ < var_132_1 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play420051032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 420051032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play420051033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0.05 < arg_133_1.time_ and arg_133_1.time_ <= 0.05 + arg_136_0 then
				arg_133_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_cash02", "")
			end

			local var_136_1 = 0
			local var_136_2 = 0.725

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(420051032).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 29 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 29)

				if (29 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 29)) > 0 and var_136_2 < var_136_5 then
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
	Play420051033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 420051033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play420051034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.025

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(420051033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 41 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 41)

				if (41 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 41)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play420051034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 420051034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play420051035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.75

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(420051034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 30 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 30)

				if (30 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 30)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play420051035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 420051035
		arg_145_1.duration_ = 6.4

		local var_145_0 = {
			zh = 3.8,
			ja = 6.4
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
				arg_145_0:Play420051036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos404001ui_story = arg_145_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["404001ui_story"].transform.position).z)
				arg_145_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["404001ui_story"].transform.localEulerAngles = arg_145_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_145_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["404001ui_story"].transform.position).z)
				arg_145_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["404001ui_story"].transform.localEulerAngles = arg_145_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["404001ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect404001ui_story == nil then
				arg_145_1.var_.characterEffect404001ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect404001ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect404001ui_story then
				arg_145_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_148_4 = 0
			local var_148_5 = 0.5

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(420051035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 20 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 20)

				if (20 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 20)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051035", "story_v_out_420051.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051035", "story_v_out_420051.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_420051", "420051035", "story_v_out_420051.awb")

						arg_145_1:RecordAudio("420051035", var_148_11)
						arg_145_1:RecordAudio("420051035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_420051", "420051035", "story_v_out_420051.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_420051", "420051035", "story_v_out_420051.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420051036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 420051036
		arg_149_1.duration_ = 2.3

		local var_149_0 = {
			zh = 1.833,
			ja = 2.3
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
				arg_149_0:Play420051037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos404001ui_story = arg_149_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["404001ui_story"].transform.position).z)
				arg_149_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["404001ui_story"].transform.localEulerAngles = arg_149_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_149_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["404001ui_story"].transform.position).z)
				arg_149_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["404001ui_story"].transform.localEulerAngles = arg_149_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1085ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1085ui_story = var_152_1.localPosition
			end

			local var_152_2 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 then
				var_152_1.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_149_1.time_ - 0) / var_152_2)
				var_152_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_1.position).x, (manager.ui.mainCamera.transform.position - var_152_1.position).y, (manager.ui.mainCamera.transform.position - var_152_1.position).z)
				var_152_1.localEulerAngles.z = 0
				var_152_1.localEulerAngles.x = 0
				var_152_1.localEulerAngles = var_152_1.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 then
				var_152_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_152_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_1.position).x, (manager.ui.mainCamera.transform.position - var_152_1.position).y, (manager.ui.mainCamera.transform.position - var_152_1.position).z)
				var_152_1.localEulerAngles.z = 0
				var_152_1.localEulerAngles.x = 0
				var_152_1.localEulerAngles = var_152_1.localEulerAngles
			end

			local var_152_3 = arg_149_1.actors_["1085ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect1085ui_story == nil then
				arg_149_1.var_.characterEffect1085ui_story = var_152_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_4 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 and not isNil(var_152_3) then
				if arg_149_1.var_.characterEffect1085ui_story and not isNil(var_152_3) then
					arg_149_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect1085ui_story then
				arg_149_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_152_6 = arg_149_1.actors_["404001ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect404001ui_story == nil then
				arg_149_1.var_.characterEffect404001ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_7 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 and not isNil(var_152_6) then
				if arg_149_1.var_.characterEffect404001ui_story and not isNil(var_152_6) then
					arg_149_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_149_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_7)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect404001ui_story then
				arg_149_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_149_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_152_8 = 0
			local var_152_9 = 0.4

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(420051036)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 16 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 16)

				if (16 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 16)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051036", "story_v_out_420051.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051036", "story_v_out_420051.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_420051", "420051036", "story_v_out_420051.awb")

						arg_149_1:RecordAudio("420051036", var_152_15)
						arg_149_1:RecordAudio("420051036", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_420051", "420051036", "story_v_out_420051.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_420051", "420051036", "story_v_out_420051.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_149_1:InitPlayNodeList()
	end,
	Play420051037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 420051037
		arg_153_1.duration_ = 4.97

		local var_153_0 = {
			zh = 3.533,
			ja = 4.966
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
				arg_153_0:Play420051038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["404001ui_story"]) and arg_153_1.var_.characterEffect404001ui_story == nil then
				arg_153_1.var_.characterEffect404001ui_story = arg_153_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["404001ui_story"]) then
				if arg_153_1.var_.characterEffect404001ui_story and not isNil(arg_153_1.actors_["404001ui_story"]) then
					arg_153_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["404001ui_story"]) and arg_153_1.var_.characterEffect404001ui_story then
				arg_153_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["1085ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1085ui_story == nil then
				arg_153_1.var_.characterEffect1085ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1085ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1085ui_story then
				arg_153_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_156_4 = 0
			local var_156_5 = 0.425

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(420051037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 17 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 17)

				if (17 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 17)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051037", "story_v_out_420051.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051037", "story_v_out_420051.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_420051", "420051037", "story_v_out_420051.awb")

						arg_153_1:RecordAudio("420051037", var_156_11)
						arg_153_1:RecordAudio("420051037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_420051", "420051037", "story_v_out_420051.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_420051", "420051037", "story_v_out_420051.awb")
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

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play420051038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 420051038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play420051039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos404001ui_story = arg_157_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).z)
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles = arg_157_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).z)
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles = arg_157_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1085ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1085ui_story = var_160_1.localPosition
			end

			local var_160_2 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 then
				var_160_1.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 then
				var_160_1.localPosition = Vector3.New(0, 100, 0)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if 0.200000002980232 < arg_157_1.time_ and arg_157_1.time_ <= 0.200000002980232 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			local var_160_4 = 0
			local var_160_5 = 0.625

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(420051038).content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 25 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 25)

				if (25 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 25)) > 0 and var_160_5 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_9 and arg_157_1.time_ < var_160_4 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_157_1:InitPlayNodeList()
	end,
	Play420051039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 420051039
		arg_161_1.duration_ = 9

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play420051040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if arg_161_1.bgs_.ST61 == nil then
				local var_164_0 = Object.Instantiate(arg_161_1.paintGo_)

				var_164_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_164_0.name = "ST61"
				var_164_0.transform.parent = arg_161_1.stage_.transform
				var_164_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.bgs_.ST61 = var_164_0
			end

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= 2 + arg_164_0 then
				local var_164_1 = arg_161_1.bgs_.ST61

				arg_161_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_164_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_164_2 = var_164_1:GetComponent("SpriteRenderer")

				if var_164_2 and var_164_2.sprite then
					local var_164_3 = 2 * (var_164_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_164_1.transform.localScale = Vector3.New(var_164_3 / var_164_2.sprite.bounds.size.y < var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x and var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x or var_164_3 / var_164_2.sprite.bounds.size.y, var_164_3 / var_164_2.sprite.bounds.size.y < var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x and var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x or var_164_3 / var_164_2.sprite.bounds.size.y, 0)
				end

				for iter_164_0, iter_164_1 in pairs(arg_161_1.bgs_) do
					if iter_164_0 ~= "ST61" then
						iter_164_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_164_4 = 3.999999999999

			if 3.999999999999 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			if arg_161_1.time_ >= var_164_4 + 0.3 and arg_161_1.time_ < var_164_4 + 0.3 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			local var_164_5 = 0

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_6 = 2

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 then
				local var_164_7 = Color.New(0, 0, 0)

				var_164_7.a = Mathf.Lerp(0, 1, (arg_161_1.time_ - var_164_5) / var_164_6)
				arg_161_1.mask_.color = var_164_7
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 then
				local var_164_8 = Color.New(0, 0, 0)

				var_164_8.a = 1
				arg_161_1.mask_.color = var_164_8
			end

			local var_164_9 = 2

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_10 = 2

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_10 then
				local var_164_11 = Color.New(0, 0, 0)

				var_164_11.a = Mathf.Lerp(1, 0, (arg_161_1.time_ - var_164_9) / var_164_10)
				arg_161_1.mask_.color = var_164_11
			end

			if arg_161_1.time_ >= var_164_9 + var_164_10 and arg_161_1.time_ < var_164_9 + var_164_10 + arg_164_0 then
				local var_164_12 = Color.New(0, 0, 0)

				arg_161_1.mask_.enabled = false
				var_164_12.a = 0
				arg_161_1.mask_.color = var_164_12
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_13 = 3.999999999999
			local var_164_14 = 0.8

			if 3.999999999999 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_15 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_15:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_16 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(420051039).content)

				arg_161_1.text_.text = var_164_16

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_18 = 32 <= 0 and var_164_14 or var_164_14 * (utf8.len(var_164_16) / 32)

				if (32 <= 0 and var_164_14 or var_164_14 * (utf8.len(var_164_16) / 32)) > 0 and var_164_14 < var_164_18 then
					arg_161_1.talkMaxDuration = var_164_18
					var_164_13 = var_164_13 + 0.3

					if var_164_18 + var_164_13 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_13
					end
				end

				arg_161_1.text_.text = var_164_16
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_19 = var_164_13 + 0.3
			local var_164_20 = math.max(var_164_14, arg_161_1.talkMaxDuration)

			if var_164_13 + 0.3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_19 + var_164_20 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_19) / var_164_20

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_19 + var_164_20 and arg_161_1.time_ < var_164_19 + var_164_20 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play420051040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 420051040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play420051041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0.3 < arg_167_1.time_ and arg_167_1.time_ <= 0.3 + arg_170_0 then
				arg_167_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_bag02", "")
			end

			local var_170_1 = 0
			local var_170_2 = 1.025

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(420051040).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 41 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 41)

				if (41 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 41)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play420051041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 420051041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play420051042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.35

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(420051041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 14 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 14)

				if (14 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 14)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play420051042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 420051042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play420051043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.575

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(420051042).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 23)

				if (23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 23)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play420051043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 420051043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play420051044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.65

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(420051043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 26 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 26)

				if (26 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 26)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play420051044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 420051044
		arg_183_1.duration_ = 4.1

		local var_183_0 = {
			zh = 1.999999999999,
			ja = 4.1
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play420051045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1085ui_story = arg_183_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).z)
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles = arg_183_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_183_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).z)
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles = arg_183_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1085ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1085ui_story == nil then
				arg_183_1.var_.characterEffect1085ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1085ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1085ui_story then
				arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_4 = 0
			local var_186_5 = 0.125

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(420051044)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 5 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 5)

				if (5 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 5)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051044", "story_v_out_420051.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051044", "story_v_out_420051.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_420051", "420051044", "story_v_out_420051.awb")

						arg_183_1:RecordAudio("420051044", var_186_11)
						arg_183_1:RecordAudio("420051044", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_420051", "420051044", "story_v_out_420051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_420051", "420051044", "story_v_out_420051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play420051045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 420051045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play420051046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1085ui_story"]) and arg_187_1.var_.characterEffect1085ui_story == nil then
				arg_187_1.var_.characterEffect1085ui_story = arg_187_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1085ui_story"]) then
				if arg_187_1.var_.characterEffect1085ui_story and not isNil(arg_187_1.actors_["1085ui_story"]) then
					arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1085ui_story"]) and arg_187_1.var_.characterEffect1085ui_story then
				arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.575

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(420051045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 23 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 23)

				if (23 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 23)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play420051046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 420051046
		arg_191_1.duration_ = 10

		local var_191_0 = {
			zh = 9.833,
			ja = 10
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
				arg_191_0:Play420051047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1085ui_story"]) and arg_191_1.var_.characterEffect1085ui_story == nil then
				arg_191_1.var_.characterEffect1085ui_story = arg_191_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1085ui_story"]) then
				if arg_191_1.var_.characterEffect1085ui_story and not isNil(arg_191_1.actors_["1085ui_story"]) then
					arg_191_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1085ui_story"]) and arg_191_1.var_.characterEffect1085ui_story then
				arg_191_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_194_2 = 0
			local var_194_3 = 0.775

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(420051046)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 31 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 31)

				if (31 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 31)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051046", "story_v_out_420051.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051046", "story_v_out_420051.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_420051", "420051046", "story_v_out_420051.awb")

						arg_191_1:RecordAudio("420051046", var_194_9)
						arg_191_1:RecordAudio("420051046", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_420051", "420051046", "story_v_out_420051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_420051", "420051046", "story_v_out_420051.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play420051047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 420051047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play420051048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1085ui_story = arg_195_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).z)
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles = arg_195_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).z)
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles = arg_195_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_198_1 = 0
			local var_198_2 = 0.075

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(420051047).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 3 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 3)

				if (3 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 3)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play420051048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 420051048
		arg_199_1.duration_ = 5.73

		local var_199_0 = {
			zh = 5.666,
			ja = 5.733
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
				arg_199_0:Play420051049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos404001ui_story = arg_199_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).z)
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles = arg_199_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_199_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).z)
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles = arg_199_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["404001ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect404001ui_story == nil then
				arg_199_1.var_.characterEffect404001ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect404001ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect404001ui_story then
				arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_202_4 = 0
			local var_202_5 = 0.525

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(420051048)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 21 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 21)

				if (21 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 21)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051048", "story_v_out_420051.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051048", "story_v_out_420051.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_420051", "420051048", "story_v_out_420051.awb")

						arg_199_1:RecordAudio("420051048", var_202_11)
						arg_199_1:RecordAudio("420051048", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_420051", "420051048", "story_v_out_420051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_420051", "420051048", "story_v_out_420051.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play420051049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 420051049
		arg_203_1.duration_ = 4.13

		local var_203_0 = {
			zh = 4.133,
			ja = 3.9
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
				arg_203_0:Play420051050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos404001ui_story = arg_203_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).z)
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles = arg_203_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_203_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).z)
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles = arg_203_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1085ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1085ui_story = var_206_1.localPosition
			end

			local var_206_2 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 then
				var_206_1.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_203_1.time_ - 0) / var_206_2)
				var_206_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_1.position).x, (manager.ui.mainCamera.transform.position - var_206_1.position).y, (manager.ui.mainCamera.transform.position - var_206_1.position).z)
				var_206_1.localEulerAngles.z = 0
				var_206_1.localEulerAngles.x = 0
				var_206_1.localEulerAngles = var_206_1.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 then
				var_206_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_206_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_1.position).x, (manager.ui.mainCamera.transform.position - var_206_1.position).y, (manager.ui.mainCamera.transform.position - var_206_1.position).z)
				var_206_1.localEulerAngles.z = 0
				var_206_1.localEulerAngles.x = 0
				var_206_1.localEulerAngles = var_206_1.localEulerAngles
			end

			local var_206_3 = arg_203_1.actors_["1085ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1085ui_story == nil then
				arg_203_1.var_.characterEffect1085ui_story = var_206_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_4 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 and not isNil(var_206_3) then
				if arg_203_1.var_.characterEffect1085ui_story and not isNil(var_206_3) then
					arg_203_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1085ui_story then
				arg_203_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_206_6 = arg_203_1.actors_["404001ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect404001ui_story == nil then
				arg_203_1.var_.characterEffect404001ui_story = var_206_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_7 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 and not isNil(var_206_6) then
				if arg_203_1.var_.characterEffect404001ui_story and not isNil(var_206_6) then
					arg_203_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_203_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_7)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect404001ui_story then
				arg_203_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_203_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action447")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_206_8 = 0
			local var_206_9 = 0.25

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:GetWordFromCfg(420051049)
				local var_206_11 = arg_203_1:FormatText(var_206_10.content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 10 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 10)

				if (10 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 10)) > 0 and var_206_9 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051049", "story_v_out_420051.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051049", "story_v_out_420051.awb") / 1000

					if var_206_14 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_8
					end

					if var_206_10.prefab_name ~= "" and arg_203_1.actors_[var_206_10.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_10.prefab_name].transform, "story_v_out_420051", "420051049", "story_v_out_420051.awb")

						arg_203_1:RecordAudio("420051049", var_206_15)
						arg_203_1:RecordAudio("420051049", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_420051", "420051049", "story_v_out_420051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_420051", "420051049", "story_v_out_420051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_16 and arg_203_1.time_ < var_206_8 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_203_1:InitPlayNodeList()
	end,
	Play420051050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 420051050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play420051051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos404001ui_story = arg_207_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["404001ui_story"].transform.position).z)
				arg_207_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["404001ui_story"].transform.localEulerAngles = arg_207_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["404001ui_story"].transform.position).z)
				arg_207_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["404001ui_story"].transform.localEulerAngles = arg_207_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1085ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1085ui_story = var_210_1.localPosition
			end

			local var_210_2 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 then
				var_210_1.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_2)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 then
				var_210_1.localPosition = Vector3.New(0, 100, 0)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			if 0.05 < arg_207_1.time_ and arg_207_1.time_ <= 0.05 + arg_210_0 then
				arg_207_1:AudioAction("play", "effect", "se_story_140", "se_story_140_camera03", "")
			end

			local var_210_4 = 0
			local var_210_5 = 0.9

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(420051050).content)

				arg_207_1.text_.text = var_210_6

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_8 = 36 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_6) / 36)

				if (36 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_6) / 36)) > 0 and var_210_5 < var_210_8 then
					arg_207_1.talkMaxDuration = var_210_8

					if var_210_8 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_6
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_9 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_9 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_9

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_9 and arg_207_1.time_ < var_210_4 + var_210_9 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_207_1:InitPlayNodeList()
	end,
	Play420051051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 420051051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play420051052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.3

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

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(420051051).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 52 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 52)

				if (52 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 52)) > 0 and var_214_0 < var_214_3 then
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
	Play420051052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 420051052
		arg_215_1.duration_ = 4.97

		local var_215_0 = {
			zh = 4.266,
			ja = 4.966
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
				arg_215_0:Play420051053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1085ui_story = arg_215_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1085ui_story"].transform.position).z)
				arg_215_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1085ui_story"].transform.localEulerAngles = arg_215_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_215_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1085ui_story"].transform.position).z)
				arg_215_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1085ui_story"].transform.localEulerAngles = arg_215_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1085ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1085ui_story == nil then
				arg_215_1.var_.characterEffect1085ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1085ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1085ui_story then
				arg_215_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_218_4 = 0
			local var_218_5 = 0.35

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(420051052)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 14 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 14)

				if (14 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 14)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051052", "story_v_out_420051.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051052", "story_v_out_420051.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_420051", "420051052", "story_v_out_420051.awb")

						arg_215_1:RecordAudio("420051052", var_218_11)
						arg_215_1:RecordAudio("420051052", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_420051", "420051052", "story_v_out_420051.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_420051", "420051052", "story_v_out_420051.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play420051053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 420051053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play420051054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if arg_219_1.bgs_.STblack == nil then
				local var_222_0 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_222_0.name = "STblack"
				var_222_0.transform.parent = arg_219_1.stage_.transform
				var_222_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_.STblack = var_222_0
			end

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				local var_222_1 = arg_219_1.bgs_.STblack

				arg_219_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_2 = var_222_1:GetComponent("SpriteRenderer")

				if var_222_2 and var_222_2.sprite then
					local var_222_3 = 2 * (var_222_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_1.transform.localScale = Vector3.New(var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "STblack" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_4 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_5 = 2

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_5 then
				local var_222_6 = Color.New(0, 0, 0)

				var_222_6.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_4) / var_222_5)
				arg_219_1.mask_.color = var_222_6
			end

			if arg_219_1.time_ >= var_222_4 + var_222_5 and arg_219_1.time_ < var_222_4 + var_222_5 + arg_222_0 then
				local var_222_7 = Color.New(0, 0, 0)

				var_222_7.a = 1
				arg_219_1.mask_.color = var_222_7
			end

			local var_222_8 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_9 = 2

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_9 then
				local var_222_10 = Color.New(0, 0, 0)

				var_222_10.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_8) / var_222_9)
				arg_219_1.mask_.color = var_222_10
			end

			if arg_219_1.time_ >= var_222_8 + var_222_9 and arg_219_1.time_ < var_222_8 + var_222_9 + arg_222_0 then
				local var_222_11 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_11.a = 0
				arg_219_1.mask_.color = var_222_11
			end

			local var_222_12 = arg_219_1.actors_["1085ui_story"].transform

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				arg_219_1.var_.moveOldPos1085ui_story = var_222_12.localPosition
			end

			local var_222_13 = 0.001

			if 2 <= arg_219_1.time_ and arg_219_1.time_ < 2 + var_222_13 then
				var_222_12.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 2) / var_222_13)
				var_222_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_12.position).x, (manager.ui.mainCamera.transform.position - var_222_12.position).y, (manager.ui.mainCamera.transform.position - var_222_12.position).z)
				var_222_12.localEulerAngles.z = 0
				var_222_12.localEulerAngles.x = 0
				var_222_12.localEulerAngles = var_222_12.localEulerAngles
			end

			if arg_219_1.time_ >= 2 + var_222_13 and arg_219_1.time_ < 2 + var_222_13 + arg_222_0 then
				var_222_12.localPosition = Vector3.New(0, 100, 0)
				var_222_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_12.position).x, (manager.ui.mainCamera.transform.position - var_222_12.position).y, (manager.ui.mainCamera.transform.position - var_222_12.position).z)
				var_222_12.localEulerAngles.z = 0
				var_222_12.localEulerAngles.x = 0
				var_222_12.localEulerAngles = var_222_12.localEulerAngles
			end

			if 4 < arg_219_1.time_ and arg_219_1.time_ <= 4 + arg_222_0 then
				arg_219_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_hit", "")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_222_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_219_1.bgmTxt_.text ~= var_222_17 and arg_219_1.bgmTxt_.text ~= "" then
						if arg_219_1.bgmTxt2_.text ~= "" then
							arg_219_1.bgmTxt_.text = arg_219_1.bgmTxt2_.text
						end

						arg_219_1.bgmTxt2_.text = var_222_17

						arg_219_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_219_1.bgmTxt_.text = var_222_17
						arg_219_1.bgmTxt2_.text = var_222_17
					end

					if arg_219_1.bgmTimer then
						arg_219_1.bgmTimer:Stop()

						arg_219_1.bgmTimer = nil
					end

					if arg_219_1.settingData.show_music_name == 1 then
						arg_219_1.musicController:SetSelectedState("show")
						arg_219_1.musicAnimator_:Play("open", 0, 0)

						if arg_219_1.settingData.music_time ~= 0 then
							arg_219_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_219_1.settingData.music_time), function()
								if arg_219_1 == nil or isNil(arg_219_1.bgmTxt_) then
									return
								end

								arg_219_1.musicController:SetSelectedState("hide")
								arg_219_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_219_1.time_ and arg_219_1.time_ <= 0.466666666666667 + arg_222_0 then
				arg_219_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_222_20 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_219_1.bgmTxt_.text ~= var_222_20 and arg_219_1.bgmTxt_.text ~= "" then
						if arg_219_1.bgmTxt2_.text ~= "" then
							arg_219_1.bgmTxt_.text = arg_219_1.bgmTxt2_.text
						end

						arg_219_1.bgmTxt2_.text = var_222_20

						arg_219_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_219_1.bgmTxt_.text = var_222_20
						arg_219_1.bgmTxt2_.text = var_222_20
					end

					if arg_219_1.bgmTimer then
						arg_219_1.bgmTimer:Stop()

						arg_219_1.bgmTimer = nil
					end

					if arg_219_1.settingData.show_music_name == 1 then
						arg_219_1.musicController:SetSelectedState("show")
						arg_219_1.musicAnimator_:Play("open", 0, 0)

						if arg_219_1.settingData.music_time ~= 0 then
							arg_219_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_219_1.settingData.music_time), function()
								if arg_219_1 == nil or isNil(arg_219_1.bgmTxt_) then
									return
								end

								arg_219_1.musicController:SetSelectedState("hide")
								arg_219_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0
				arg_219_1.fswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(420051053).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_21 = 2.73333333333333

			if 2.73333333333333 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_22 = 10
			local var_222_23 = 0.666666666666667
			local var_222_24, var_222_25 = arg_219_1:GetPercentByPara(arg_219_1:FormatText(arg_219_1:GetWordFromCfg(420051053).content), 1)

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_26 = var_222_22 <= 0 and var_222_23 or var_222_23 * ((var_222_25 - arg_219_1.typewritterCharCountI18N) / var_222_22)

				if (var_222_22 <= 0 and var_222_23 or var_222_23 * ((var_222_25 - arg_219_1.typewritterCharCountI18N) / var_222_22)) > 0 and var_222_23 < var_222_26 then
					arg_219_1.talkMaxDuration = var_222_26

					if var_222_26 + var_222_21 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_26 + var_222_21
					end
				end
			end

			local var_222_27 = math.max(0.666666666666667, arg_219_1.talkMaxDuration)

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_27 then
				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_24, (arg_219_1.time_ - var_222_21) / var_222_27)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_21 + var_222_27 and arg_219_1.time_ < var_222_21 + var_222_27 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_24

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_25
			end

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				local var_222_28 = arg_219_1.fswbg_.transform:Find("textbox/adapt/content") or arg_219_1.fswbg_.transform:Find("textbox/content")
				local var_222_29 = arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_222_30 = var_222_28:GetComponent("RectTransform")

				var_222_28:GetComponent("Text").alignment = UnityEngine.TextAnchor.UpperLeft
				var_222_30.offsetMin = Vector2.New(0, 0)
				var_222_30.offsetMax = Vector2.New(0, -150)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play420051054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 420051054
		arg_225_1.duration_ = 1.47

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play420051055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.oldValueTypewriter = arg_225_1.fswtw_.percent

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_0 = 22
			local var_228_1 = 1.46666666666667
			local var_228_2, var_228_3 = arg_225_1:GetPercentByPara(arg_225_1:FormatText(arg_225_1:GetWordFromCfg(420051053).content), 2)

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				local var_228_4 = var_228_0 <= 0 and var_228_1 or var_228_1 * ((var_228_3 - arg_225_1.typewritterCharCountI18N) / var_228_0)

				if (var_228_0 <= 0 and var_228_1 or var_228_1 * ((var_228_3 - arg_225_1.typewritterCharCountI18N) / var_228_0)) > 0 and var_228_1 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end
			end

			local var_228_5 = math.max(1.46666666666667, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_5 then
				arg_225_1.fswtw_.percent = Mathf.Lerp(arg_225_1.var_.oldValueTypewriter, var_228_2, (arg_225_1.time_ - 0) / var_228_5)
				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_225_1.fswtw_:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_5 and arg_225_1.time_ < 0 + var_228_5 + arg_228_0 then
				arg_225_1.fswtw_.percent = var_228_2

				arg_225_1.fswtw_:SetDirty()
				arg_225_1:ShowNextGo(true)

				arg_225_1.typewritterCharCountI18N = var_228_3
			end

			if 0.05 < arg_225_1.time_ and arg_225_1.time_ <= 0.05 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car01", "")
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play420051055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 420051055
		arg_229_1.duration_ = 1.2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play420051056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.oldValueTypewriter = arg_229_1.fswtw_.percent

				SetActive(arg_229_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_229_1:ShowNextGo(false)
			end

			local var_232_0 = 18
			local var_232_1 = 1.2
			local var_232_2, var_232_3 = arg_229_1:GetPercentByPara(arg_229_1:FormatText(arg_229_1:GetWordFromCfg(420051053).content), 3)

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				local var_232_4 = var_232_0 <= 0 and var_232_1 or var_232_1 * ((var_232_3 - arg_229_1.typewritterCharCountI18N) / var_232_0)

				if (var_232_0 <= 0 and var_232_1 or var_232_1 * ((var_232_3 - arg_229_1.typewritterCharCountI18N) / var_232_0)) > 0 and var_232_1 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end
			end

			local var_232_5 = math.max(1.2, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_5 then
				arg_229_1.fswtw_.percent = Mathf.Lerp(arg_229_1.var_.oldValueTypewriter, var_232_2, (arg_229_1.time_ - 0) / var_232_5)
				arg_229_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_229_1.fswtw_:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_5 and arg_229_1.time_ < 0 + var_232_5 + arg_232_0 then
				arg_229_1.fswtw_.percent = var_232_2

				arg_229_1.fswtw_:SetDirty()
				arg_229_1:ShowNextGo(true)

				arg_229_1.typewritterCharCountI18N = var_232_3
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play420051056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 420051056
		arg_233_1.duration_ = 1.05

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play420051057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.oldValueTypewriter = arg_233_1.fswtw_.percent

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_0 = 10
			local var_236_1 = 0.666666666666667
			local var_236_2, var_236_3 = arg_233_1:GetPercentByPara(arg_233_1:FormatText(arg_233_1:GetWordFromCfg(420051053).content), 4)

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				local var_236_4 = var_236_0 <= 0 and var_236_1 or var_236_1 * ((var_236_3 - arg_233_1.typewritterCharCountI18N) / var_236_0)

				if (var_236_0 <= 0 and var_236_1 or var_236_1 * ((var_236_3 - arg_233_1.typewritterCharCountI18N) / var_236_0)) > 0 and var_236_1 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end
			end

			local var_236_5 = math.max(0.666666666666667, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_5 then
				arg_233_1.fswtw_.percent = Mathf.Lerp(arg_233_1.var_.oldValueTypewriter, var_236_2, (arg_233_1.time_ - 0) / var_236_5)
				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.fswtw_:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_5 and arg_233_1.time_ < 0 + var_236_5 + arg_236_0 then
				arg_233_1.fswtw_.percent = var_236_2

				arg_233_1.fswtw_:SetDirty()
				arg_233_1:ShowNextGo(true)

				arg_233_1.typewritterCharCountI18N = var_236_3
			end

			if 0.05 < arg_233_1.time_ and arg_233_1.time_ <= 0.05 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck06", "")
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play420051057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 420051057
		arg_237_1.duration_ = 7

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play420051058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.fswbg_:SetActive(false)
				arg_237_1.dialog_:SetActive(false)
				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_0 = "L16f"

			if arg_237_1.bgs_.L16f == nil then
				local var_240_1 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_240_0)
				var_240_1.name = var_240_0
				var_240_1.transform.parent = arg_237_1.stage_.transform
				var_240_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_[var_240_0] = var_240_1
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				local var_240_2 = arg_237_1.bgs_.L16f

				arg_237_1.bgs_.L16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_240_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_3 = var_240_2:GetComponent("SpriteRenderer")

				if var_240_3 and var_240_3.sprite then
					local var_240_4 = 2 * (var_240_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_240_2.transform.localScale = Vector3.New(var_240_4 / var_240_3.sprite.bounds.size.y < var_240_4 * manager.ui.mainCameraCom_.aspect / var_240_3.sprite.bounds.size.x and var_240_4 * manager.ui.mainCameraCom_.aspect / var_240_3.sprite.bounds.size.x or var_240_4 / var_240_3.sprite.bounds.size.y, var_240_4 / var_240_3.sprite.bounds.size.y < var_240_4 * manager.ui.mainCameraCom_.aspect / var_240_3.sprite.bounds.size.x and var_240_4 * manager.ui.mainCameraCom_.aspect / var_240_3.sprite.bounds.size.x or var_240_4 / var_240_3.sprite.bounds.size.y, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "L16f" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_5 = 0

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = false

				arg_237_1:SetGaussion(false)
			end

			local var_240_6 = 2

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_6 then
				local var_240_7 = Color.New(0, 0, 0)

				var_240_7.a = Mathf.Lerp(1, 0, (arg_237_1.time_ - var_240_5) / var_240_6)
				arg_237_1.mask_.color = var_240_7
			end

			if arg_237_1.time_ >= var_240_5 + var_240_6 and arg_237_1.time_ < var_240_5 + var_240_6 + arg_240_0 then
				local var_240_8 = Color.New(0, 0, 0)

				arg_237_1.mask_.enabled = false
				var_240_8.a = 0
				arg_237_1.mask_.color = var_240_8
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_9 = 2
			local var_240_10 = 0.125

			if 2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_11 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_11:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_12 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(420051057).content)

				arg_237_1.text_.text = var_240_12

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_14 = 5 <= 0 and var_240_10 or var_240_10 * (utf8.len(var_240_12) / 5)

				if (5 <= 0 and var_240_10 or var_240_10 * (utf8.len(var_240_12) / 5)) > 0 and var_240_10 < var_240_14 then
					arg_237_1.talkMaxDuration = var_240_14
					var_240_9 = var_240_9 + 0.3

					if var_240_14 + var_240_9 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_9
					end
				end

				arg_237_1.text_.text = var_240_12
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_15 = var_240_9 + 0.3
			local var_240_16 = math.max(var_240_10, arg_237_1.talkMaxDuration)

			if var_240_9 + 0.3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_16 and arg_237_1.time_ < var_240_15 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play420051058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 420051058
		arg_243_1.duration_ = 4.13

		local var_243_0 = {
			zh = 4.133,
			ja = 4.066
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
				arg_243_0:Play420051059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1085ui_story = arg_243_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1085ui_story"].transform.position).z)
				arg_243_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1085ui_story"].transform.localEulerAngles = arg_243_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_243_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1085ui_story"].transform.position).z)
				arg_243_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1085ui_story"].transform.localEulerAngles = arg_243_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1085ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1085ui_story == nil then
				arg_243_1.var_.characterEffect1085ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1085ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1085ui_story then
				arg_243_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_4 = 0
			local var_246_5 = 0.35

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(420051058)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 14 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 14)

				if (14 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 14)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051058", "story_v_out_420051.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051058", "story_v_out_420051.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_420051", "420051058", "story_v_out_420051.awb")

						arg_243_1:RecordAudio("420051058", var_246_11)
						arg_243_1:RecordAudio("420051058", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_420051", "420051058", "story_v_out_420051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_420051", "420051058", "story_v_out_420051.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play420051059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 420051059
		arg_247_1.duration_ = 1

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"

			SetActive(arg_247_1.choicesGo_, true)

			for iter_248_0, iter_248_1 in ipairs(arg_247_1.choices_) do
				SetActive(iter_248_1.go, iter_248_0 <= 1)
			end

			arg_247_1.choices_[1].txt.text = arg_247_1:FormatText(StoryChoiceCfg[1229].name)
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play420051060(arg_247_1)
			end

			arg_247_1:RecordChoiceLog(420051059, 1229)
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1085ui_story"]) and arg_247_1.var_.characterEffect1085ui_story == nil then
				arg_247_1.var_.characterEffect1085ui_story = arg_247_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1085ui_story"]) then
				if arg_247_1.var_.characterEffect1085ui_story and not isNil(arg_247_1.actors_["1085ui_story"]) then
					arg_247_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1085ui_story"]) and arg_247_1.var_.characterEffect1085ui_story then
				arg_247_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play420051060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 420051060
		arg_251_1.duration_ = 4.37

		local var_251_0 = {
			zh = 4.366,
			ja = 4.3
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
				arg_251_0:Play420051061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.3

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(420051060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 12 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 12)

				if (12 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 12)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051060", "story_v_out_420051.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051060", "story_v_out_420051.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_420051", "420051060", "story_v_out_420051.awb")

						arg_251_1:RecordAudio("420051060", var_254_6)
						arg_251_1:RecordAudio("420051060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_420051", "420051060", "story_v_out_420051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_420051", "420051060", "story_v_out_420051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play420051061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 420051061
		arg_255_1.duration_ = 4.9

		local var_255_0 = {
			zh = 4.9,
			ja = 4.5
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
				arg_255_0:Play420051062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1085ui_story"]) and arg_255_1.var_.characterEffect1085ui_story == nil then
				arg_255_1.var_.characterEffect1085ui_story = arg_255_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1085ui_story"]) then
				if arg_255_1.var_.characterEffect1085ui_story and not isNil(arg_255_1.actors_["1085ui_story"]) then
					arg_255_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1085ui_story"]) and arg_255_1.var_.characterEffect1085ui_story then
				arg_255_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_258_2 = 0
			local var_258_3 = 0.35

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(420051061)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 14 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 14)

				if (14 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 14)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051061", "story_v_out_420051.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051061", "story_v_out_420051.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_out_420051", "420051061", "story_v_out_420051.awb")

						arg_255_1:RecordAudio("420051061", var_258_9)
						arg_255_1:RecordAudio("420051061", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_420051", "420051061", "story_v_out_420051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_420051", "420051061", "story_v_out_420051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play420051062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 420051062
		arg_259_1.duration_ = 5.5

		local var_259_0 = {
			zh = 5.5,
			ja = 4.3
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
				arg_259_0:Play420051063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.4

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(420051062)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 16 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 16)

				if (16 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 16)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051062", "story_v_out_420051.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051062", "story_v_out_420051.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_420051", "420051062", "story_v_out_420051.awb")

						arg_259_1:RecordAudio("420051062", var_262_6)
						arg_259_1:RecordAudio("420051062", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_420051", "420051062", "story_v_out_420051.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_420051", "420051062", "story_v_out_420051.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play420051063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 420051063
		arg_263_1.duration_ = 7.43

		local var_263_0 = {
			zh = 5.633,
			ja = 7.433
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
				arg_263_0:Play420051064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1085ui_story = arg_263_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1085ui_story"].transform.position).z)
				arg_263_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1085ui_story"].transform.localEulerAngles = arg_263_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1085ui_story"].transform.position).z)
				arg_263_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1085ui_story"].transform.localEulerAngles = arg_263_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_266_1 = 0
			local var_266_2 = 0.65

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:GetWordFromCfg(420051063)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 26 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 26)

				if (26 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 26)) > 0 and var_266_2 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051063", "story_v_out_420051.awb") ~= 0 then
					local var_266_7 = manager.audio:GetVoiceLength("story_v_out_420051", "420051063", "story_v_out_420051.awb") / 1000

					if var_266_7 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_1
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_420051", "420051063", "story_v_out_420051.awb")

						arg_263_1:RecordAudio("420051063", var_266_8)
						arg_263_1:RecordAudio("420051063", var_266_8)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_420051", "420051063", "story_v_out_420051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_420051", "420051063", "story_v_out_420051.awb")
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

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play420051064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 420051064
		arg_267_1.duration_ = 8.47

		local var_267_0 = {
			zh = 7.565999999999,
			ja = 8.465999999999
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
				arg_267_0:Play420051065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if arg_267_1.bgs_.L16i == nil then
				local var_270_0 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L16i")
				var_270_0.name = "L16i"
				var_270_0.transform.parent = arg_267_1.stage_.transform
				var_270_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_.L16i = var_270_0
			end

			if 1.999999999999 < arg_267_1.time_ and arg_267_1.time_ <= 1.999999999999 + arg_270_0 then
				local var_270_1 = arg_267_1.bgs_.L16i

				arg_267_1.bgs_.L16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_2 = var_270_1:GetComponent("SpriteRenderer")

				if var_270_2 and var_270_2.sprite then
					local var_270_3 = 2 * (var_270_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_1.transform.localScale = Vector3.New(var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "L16i" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_4 = 3.999999999999

			if 3.999999999999 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= var_270_4 + 0.3 and arg_267_1.time_ < var_270_4 + 0.3 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_5 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_6 = 2

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 then
				local var_270_7 = Color.New(0, 0, 0)

				var_270_7.a = Mathf.Lerp(0, 1, (arg_267_1.time_ - var_270_5) / var_270_6)
				arg_267_1.mask_.color = var_270_7
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 then
				local var_270_8 = Color.New(0, 0, 0)

				var_270_8.a = 1
				arg_267_1.mask_.color = var_270_8
			end

			local var_270_9 = 2

			if 2 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_10 = 2

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 then
				local var_270_11 = Color.New(0, 0, 0)

				var_270_11.a = Mathf.Lerp(1, 0, (arg_267_1.time_ - var_270_9) / var_270_10)
				arg_267_1.mask_.color = var_270_11
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 then
				local var_270_12 = Color.New(0, 0, 0)

				arg_267_1.mask_.enabled = false
				var_270_12.a = 0
				arg_267_1.mask_.color = var_270_12
			end

			if 1.6 < arg_267_1.time_ and arg_267_1.time_ <= 1.6 + arg_270_0 then
				arg_267_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 3.56666666666667 < arg_267_1.time_ and arg_267_1.time_ <= 3.56666666666667 + arg_270_0 then
				arg_267_1:AudioAction("play", "effect", "se_story_140", "se_story_140_electric02", "")
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_15 = 3.999999999999
			local var_270_16 = 0.4

			if 3.999999999999 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_17 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_17:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056_split_2")

				arg_267_1.callingController_:SetSelectedState("calling")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_18 = arg_267_1:GetWordFromCfg(420051064)
				local var_270_19 = arg_267_1:FormatText(var_270_18.content)

				arg_267_1.text_.text = var_270_19

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_21 = 16 <= 0 and var_270_16 or var_270_16 * (utf8.len(var_270_19) / 16)

				if (16 <= 0 and var_270_16 or var_270_16 * (utf8.len(var_270_19) / 16)) > 0 and var_270_16 < var_270_21 then
					arg_267_1.talkMaxDuration = var_270_21
					var_270_15 = var_270_15 + 0.3

					if var_270_21 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_21 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_19
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051064", "story_v_out_420051.awb") ~= 0 then
					local var_270_22 = manager.audio:GetVoiceLength("story_v_out_420051", "420051064", "story_v_out_420051.awb") / 1000

					if var_270_22 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_22 + var_270_15
					end

					if var_270_18.prefab_name ~= "" and arg_267_1.actors_[var_270_18.prefab_name] ~= nil then
						local var_270_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_18.prefab_name].transform, "story_v_out_420051", "420051064", "story_v_out_420051.awb")

						arg_267_1:RecordAudio("420051064", var_270_23)
						arg_267_1:RecordAudio("420051064", var_270_23)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_420051", "420051064", "story_v_out_420051.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_420051", "420051064", "story_v_out_420051.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_24 = var_270_15 + 0.3
			local var_270_25 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_24 + var_270_25 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_24) / var_270_25

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_24 + var_270_25 and arg_267_1.time_ < var_270_24 + var_270_25 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play420051065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 420051065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play420051066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if arg_273_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_276_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_273_1.stage_.transform)

				var_276_0.name = "1056ui_story"
				var_276_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1056ui_story"] = var_276_0

				local var_276_1 = var_276_0:GetComponentInChildren(typeof(CharacterEffect))

				var_276_1.enabled = true

				local var_276_2 = GameObjectTools.GetOrAddComponent(var_276_0, typeof(DynamicBoneHelper))

				if var_276_2 then
					var_276_2:EnableDynamicBone(false)
				end

				arg_273_1:ShowWeapon(var_276_1.transform, false)

				arg_273_1.var_["1056ui_story" .. "Animator"] = var_276_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_273_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_273_1.var_["1056ui_story" .. "LipSync"] = var_276_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_276_3 = arg_273_1.actors_["1056ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1056ui_story = var_276_3.localPosition
			end

			local var_276_4 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				var_276_3.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_4)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				var_276_3.localPosition = Vector3.New(0, 100, 0)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			local var_276_5 = 0
			local var_276_6 = 1.05

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(420051065).content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 42 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_7) / 42)

				if (42 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_7) / 42)) > 0 and var_276_6 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_10 and arg_273_1.time_ < var_276_5 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play420051066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 420051066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play420051067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.275

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(420051066).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 51 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 51)

				if (51 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 51)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play420051067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 420051067
		arg_281_1.duration_ = 2.3

		local var_281_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play420051068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1085ui_story = arg_281_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1085ui_story"].transform.position).z)
				arg_281_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1085ui_story"].transform.localEulerAngles = arg_281_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_281_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1085ui_story"].transform.position).z)
				arg_281_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1085ui_story"].transform.localEulerAngles = arg_281_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1085ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1085ui_story == nil then
				arg_281_1.var_.characterEffect1085ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1085ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1085ui_story then
				arg_281_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_284_4 = 0
			local var_284_5 = 0.125

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(420051067)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 5 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 5)

				if (5 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 5)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051067", "story_v_out_420051.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051067", "story_v_out_420051.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_420051", "420051067", "story_v_out_420051.awb")

						arg_281_1:RecordAudio("420051067", var_284_11)
						arg_281_1:RecordAudio("420051067", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_420051", "420051067", "story_v_out_420051.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_420051", "420051067", "story_v_out_420051.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play420051068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 420051068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play420051069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1085ui_story"]) and arg_285_1.var_.characterEffect1085ui_story == nil then
				arg_285_1.var_.characterEffect1085ui_story = arg_285_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1085ui_story"]) then
				if arg_285_1.var_.characterEffect1085ui_story and not isNil(arg_285_1.actors_["1085ui_story"]) then
					arg_285_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1085ui_story"]) and arg_285_1.var_.characterEffect1085ui_story then
				arg_285_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.45

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(420051068).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 18 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 18)

				if (18 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 18)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play420051069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 420051069
		arg_289_1.duration_ = 3.37

		local var_289_0 = {
			zh = 3.066,
			ja = 3.366
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play420051070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1085ui_story"]) and arg_289_1.var_.characterEffect1085ui_story == nil then
				arg_289_1.var_.characterEffect1085ui_story = arg_289_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1085ui_story"]) then
				if arg_289_1.var_.characterEffect1085ui_story and not isNil(arg_289_1.actors_["1085ui_story"]) then
					arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1085ui_story"]) and arg_289_1.var_.characterEffect1085ui_story then
				arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_2")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_292_2 = 0
			local var_292_3 = 0.25

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(420051069)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 10 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 10)

				if (10 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 10)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051069", "story_v_out_420051.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051069", "story_v_out_420051.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_420051", "420051069", "story_v_out_420051.awb")

						arg_289_1:RecordAudio("420051069", var_292_9)
						arg_289_1:RecordAudio("420051069", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_420051", "420051069", "story_v_out_420051.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_420051", "420051069", "story_v_out_420051.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play420051070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 420051070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play420051071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1085ui_story = arg_293_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).z)
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles = arg_293_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).z)
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles = arg_293_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_296_1 = 0
			local var_296_2 = 0.55

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(420051070).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 22 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 22)

				if (22 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 22)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play420051071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 420051071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play420051072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.05

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(420051071).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 42 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 42)

				if (42 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 42)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play420051072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 420051072
		arg_301_1.duration_ = 5.77

		local var_301_0 = {
			zh = 5.766,
			ja = 4.2
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play420051073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1085ui_story = arg_301_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).z)
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles = arg_301_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_301_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).z)
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles = arg_301_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1085ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1085ui_story == nil then
				arg_301_1.var_.characterEffect1085ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1085ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1085ui_story then
				arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_4 = 0
			local var_304_5 = 0.375

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(420051072)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 15 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 15)

				if (15 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 15)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051072", "story_v_out_420051.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051072", "story_v_out_420051.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_420051", "420051072", "story_v_out_420051.awb")

						arg_301_1:RecordAudio("420051072", var_304_11)
						arg_301_1:RecordAudio("420051072", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_420051", "420051072", "story_v_out_420051.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_420051", "420051072", "story_v_out_420051.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play420051073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 420051073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play420051074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1085ui_story"]) and arg_305_1.var_.characterEffect1085ui_story == nil then
				arg_305_1.var_.characterEffect1085ui_story = arg_305_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1085ui_story"]) then
				if arg_305_1.var_.characterEffect1085ui_story and not isNil(arg_305_1.actors_["1085ui_story"]) then
					arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1085ui_story"]) and arg_305_1.var_.characterEffect1085ui_story then
				arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.075

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(420051073).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 3 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 3)

				if (3 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 3)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play420051074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 420051074
		arg_309_1.duration_ = 12.6

		local var_309_0 = {
			zh = 12.6,
			ja = 11.9
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play420051075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1085ui_story"]) and arg_309_1.var_.characterEffect1085ui_story == nil then
				arg_309_1.var_.characterEffect1085ui_story = arg_309_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1085ui_story"]) then
				if arg_309_1.var_.characterEffect1085ui_story and not isNil(arg_309_1.actors_["1085ui_story"]) then
					arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1085ui_story"]) and arg_309_1.var_.characterEffect1085ui_story then
				arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_312_2 = 0
			local var_312_3 = 0.85

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(420051074)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 34 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 34)

				if (34 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 34)) > 0 and var_312_3 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051074", "story_v_out_420051.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051074", "story_v_out_420051.awb") / 1000

					if var_312_8 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_2
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_out_420051", "420051074", "story_v_out_420051.awb")

						arg_309_1:RecordAudio("420051074", var_312_9)
						arg_309_1:RecordAudio("420051074", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_420051", "420051074", "story_v_out_420051.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_420051", "420051074", "story_v_out_420051.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_10 and arg_309_1.time_ < var_312_2 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play420051075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 420051075
		arg_313_1.duration_ = 8.83

		local var_313_0 = {
			zh = 6.766,
			ja = 8.833
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play420051076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.6

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(420051075)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 24 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 24)

				if (24 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 24)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051075", "story_v_out_420051.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051075", "story_v_out_420051.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_420051", "420051075", "story_v_out_420051.awb")

						arg_313_1:RecordAudio("420051075", var_316_6)
						arg_313_1:RecordAudio("420051075", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_420051", "420051075", "story_v_out_420051.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_420051", "420051075", "story_v_out_420051.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play420051076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 420051076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play420051077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1085ui_story = arg_317_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).z)
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles = arg_317_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).z)
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles = arg_317_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_320_1 = 0
			local var_320_2 = 0.9

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(420051076).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 36 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 36)

				if (36 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 36)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play420051077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 420051077
		arg_321_1.duration_ = 10.1

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play420051078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if arg_321_1.bgs_.STwhite == nil then
				local var_324_0 = Object.Instantiate(arg_321_1.paintGo_)

				var_324_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_324_0.name = "STwhite"
				var_324_0.transform.parent = arg_321_1.stage_.transform
				var_324_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.bgs_.STwhite = var_324_0
			end

			if 1.06666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 1.06666666666667 + arg_324_0 then
				local var_324_1 = arg_321_1.bgs_.STwhite

				arg_321_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_324_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_324_2 = var_324_1:GetComponent("SpriteRenderer")

				if var_324_2 and var_324_2.sprite then
					local var_324_3 = 2 * (var_324_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_324_1.transform.localScale = Vector3.New(var_324_3 / var_324_2.sprite.bounds.size.y < var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x and var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x or var_324_3 / var_324_2.sprite.bounds.size.y, var_324_3 / var_324_2.sprite.bounds.size.y < var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x and var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x or var_324_3 / var_324_2.sprite.bounds.size.y, 0)
				end

				for iter_324_0, iter_324_1 in pairs(arg_321_1.bgs_) do
					if iter_324_0 ~= "STwhite" then
						iter_324_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_324_4 = 3.06666666666667

			if 3.06666666666667 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			if arg_321_1.time_ >= var_324_4 + 0.9 and arg_321_1.time_ < var_324_4 + 0.9 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			local var_324_5 = 0

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_6 = 1.06666666666667

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_6 then
				local var_324_7 = Color.New(0, 0, 0)

				var_324_7.a = Mathf.Lerp(0, 1, (arg_321_1.time_ - var_324_5) / var_324_6)
				arg_321_1.mask_.color = var_324_7
			end

			if arg_321_1.time_ >= var_324_5 + var_324_6 and arg_321_1.time_ < var_324_5 + var_324_6 + arg_324_0 then
				local var_324_8 = Color.New(0, 0, 0)

				var_324_8.a = 1
				arg_321_1.mask_.color = var_324_8
			end

			local var_324_9 = 1.06666666666667

			if 1.06666666666667 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_10 = 2

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_10 then
				local var_324_11 = Color.New(0, 0, 0)

				var_324_11.a = Mathf.Lerp(1, 0, (arg_321_1.time_ - var_324_9) / var_324_10)
				arg_321_1.mask_.color = var_324_11
			end

			if arg_321_1.time_ >= var_324_9 + var_324_10 and arg_321_1.time_ < var_324_9 + var_324_10 + arg_324_0 then
				local var_324_12 = Color.New(0, 0, 0)

				arg_321_1.mask_.enabled = false
				var_324_12.a = 0
				arg_321_1.mask_.color = var_324_12
			end

			if 1.06666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 1.06666666666667 + arg_324_0 then
				arg_321_1.cswbg_:SetActive(true)

				local var_324_13 = arg_321_1.cswt_:GetComponent("RectTransform")

				arg_321_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_324_13.offsetMin = Vector2.New(0, 0)
				var_324_13.offsetMax = Vector2.New(0, 130)
				arg_321_1.cswt_.text = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(419144).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.cswt_)

				arg_321_1.cswt_.fontSize = 120
				arg_321_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_321_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_321_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.06666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 1.06666666666667 + arg_324_0 then
				arg_321_1.fswbg_:SetActive(true)
				arg_321_1.dialog_:SetActive(false)

				arg_321_1.fswtw_.percent = 0
				arg_321_1.fswt_.text = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(420051077).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.fswt_)

				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_321_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_321_1.fswtw_:SetDirty()

				arg_321_1.typewritterCharCountI18N = 0

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_14 = 3.06666666666667

			if 3.06666666666667 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1.var_.oldValueTypewriter = arg_321_1.fswtw_.percent

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_15 = 26
			local var_324_16 = 1.73333333333333
			local var_324_17, var_324_18 = arg_321_1:GetPercentByPara(arg_321_1:FormatText(arg_321_1:GetWordFromCfg(420051077).content), 1)

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				local var_324_19 = var_324_15 <= 0 and var_324_16 or var_324_16 * ((var_324_18 - arg_321_1.typewritterCharCountI18N) / var_324_15)

				if (var_324_15 <= 0 and var_324_16 or var_324_16 * ((var_324_18 - arg_321_1.typewritterCharCountI18N) / var_324_15)) > 0 and var_324_16 < var_324_19 then
					arg_321_1.talkMaxDuration = var_324_19

					if var_324_19 + var_324_14 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_19 + var_324_14
					end
				end
			end

			local var_324_20 = math.max(1.73333333333333, arg_321_1.talkMaxDuration)

			if var_324_14 <= arg_321_1.time_ and arg_321_1.time_ < var_324_14 + var_324_20 then
				arg_321_1.fswtw_.percent = Mathf.Lerp(arg_321_1.var_.oldValueTypewriter, var_324_17, (arg_321_1.time_ - var_324_14) / var_324_20)
				arg_321_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_321_1.fswtw_:SetDirty()
			end

			if arg_321_1.time_ >= var_324_14 + var_324_20 and arg_321_1.time_ < var_324_14 + var_324_20 + arg_324_0 then
				arg_321_1.fswtw_.percent = var_324_17

				arg_321_1.fswtw_:SetDirty()
				arg_321_1:ShowNextGo(true)

				arg_321_1.typewritterCharCountI18N = var_324_18
			end

			local var_324_21 = 1.06666666666667
			local var_324_22 = manager.audio:GetVoiceLength("story_v_out_420051", "420051077", "story_v_out_420051.awb") / 1000

			if var_324_22 > 0 and 9.033 < var_324_22 and var_324_22 + var_324_21 > arg_321_1.duration_ then
				arg_321_1.duration_ = var_324_22 + var_324_21
			end

			if var_324_21 < arg_321_1.time_ and arg_321_1.time_ <= var_324_21 + arg_324_0 then
				arg_321_1:AudioAction("play", "voice", "story_v_out_420051", "420051077", "story_v_out_420051.awb")
			end

			if 1.06666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 1.06666666666667 + arg_324_0 then
				local var_324_24 = arg_321_1.fswbg_.transform:Find("textbox/adapt/content") or arg_321_1.fswbg_.transform:Find("textbox/content")
				local var_324_25 = arg_321_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_324_26 = var_324_24:GetComponent("RectTransform")

				var_324_24:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_324_26.offsetMin = Vector2.New(0, -70)
				var_324_26.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_324_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_321_1.bgmTxt_.text ~= var_324_29 and arg_321_1.bgmTxt_.text ~= "" then
						if arg_321_1.bgmTxt2_.text ~= "" then
							arg_321_1.bgmTxt_.text = arg_321_1.bgmTxt2_.text
						end

						arg_321_1.bgmTxt2_.text = var_324_29

						arg_321_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_321_1.bgmTxt_.text = var_324_29
						arg_321_1.bgmTxt2_.text = var_324_29
					end

					if arg_321_1.bgmTimer then
						arg_321_1.bgmTimer:Stop()

						arg_321_1.bgmTimer = nil
					end

					if arg_321_1.settingData.show_music_name == 1 then
						arg_321_1.musicController:SetSelectedState("show")
						arg_321_1.musicAnimator_:Play("open", 0, 0)

						if arg_321_1.settingData.music_time ~= 0 then
							arg_321_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_321_1.settingData.music_time), function()
								if arg_321_1 == nil or isNil(arg_321_1.bgmTxt_) then
									return
								end

								arg_321_1.musicController:SetSelectedState("hide")
								arg_321_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play420051078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 420051078
		arg_326_1.duration_ = 8.97

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play420051079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.fswbg_:SetActive(true)
				arg_326_1.dialog_:SetActive(false)

				arg_326_1.fswtw_.percent = 0
				arg_326_1.fswt_.text = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(420051078).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.fswt_)

				arg_326_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_326_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_326_1.fswtw_:SetDirty()

				arg_326_1.typewritterCharCountI18N = 0

				SetActive(arg_326_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_326_1:ShowNextGo(false)
			end

			local var_329_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.var_.oldValueTypewriter = arg_326_1.fswtw_.percent

				SetActive(arg_326_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_326_1:ShowNextGo(false)
			end

			local var_329_1 = 21
			local var_329_2 = 1.73333333333333
			local var_329_3, var_329_4 = arg_326_1:GetPercentByPara(arg_326_1:FormatText(arg_326_1:GetWordFromCfg(420051078).content), 1)

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				local var_329_5 = var_329_1 <= 0 and var_329_2 or var_329_2 * ((var_329_4 - arg_326_1.typewritterCharCountI18N) / var_329_1)

				if (var_329_1 <= 0 and var_329_2 or var_329_2 * ((var_329_4 - arg_326_1.typewritterCharCountI18N) / var_329_1)) > 0 and var_329_2 < var_329_5 then
					arg_326_1.talkMaxDuration = var_329_5

					if var_329_5 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + var_329_0
					end
				end
			end

			local var_329_6 = math.max(1.73333333333333, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_6 then
				arg_326_1.fswtw_.percent = Mathf.Lerp(arg_326_1.var_.oldValueTypewriter, var_329_3, (arg_326_1.time_ - var_329_0) / var_329_6)
				arg_326_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_326_1.fswtw_:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_6 and arg_326_1.time_ < var_329_0 + var_329_6 + arg_329_0 then
				arg_326_1.fswtw_.percent = var_329_3

				arg_326_1.fswtw_:SetDirty()
				arg_326_1:ShowNextGo(true)

				arg_326_1.typewritterCharCountI18N = var_329_4
			end

			local var_329_7 = 0
			local var_329_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051078", "story_v_out_420051.awb") / 1000

			if var_329_8 > 0 and 8.966 < var_329_8 and var_329_8 + var_329_7 > arg_326_1.duration_ then
				arg_326_1.duration_ = var_329_8 + var_329_7
			end

			if var_329_7 < arg_326_1.time_ and arg_326_1.time_ <= var_329_7 + arg_329_0 then
				arg_326_1:AudioAction("play", "voice", "story_v_out_420051", "420051078", "story_v_out_420051.awb")
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play420051079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 420051079
		arg_330_1.duration_ = 8.33

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play420051080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.fswbg_:SetActive(true)
				arg_330_1.dialog_:SetActive(false)

				arg_330_1.fswtw_.percent = 0
				arg_330_1.fswt_.text = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(420051079).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.fswt_)

				arg_330_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_330_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_330_1.fswtw_:SetDirty()

				arg_330_1.typewritterCharCountI18N = 0

				SetActive(arg_330_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_330_1:ShowNextGo(false)
			end

			local var_333_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.var_.oldValueTypewriter = arg_330_1.fswtw_.percent

				SetActive(arg_330_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_330_1:ShowNextGo(false)
			end

			local var_333_1 = 22
			local var_333_2 = 1.73333333333333
			local var_333_3, var_333_4 = arg_330_1:GetPercentByPara(arg_330_1:FormatText(arg_330_1:GetWordFromCfg(420051079).content), 1)

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				local var_333_5 = var_333_1 <= 0 and var_333_2 or var_333_2 * ((var_333_4 - arg_330_1.typewritterCharCountI18N) / var_333_1)

				if (var_333_1 <= 0 and var_333_2 or var_333_2 * ((var_333_4 - arg_330_1.typewritterCharCountI18N) / var_333_1)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_0
					end
				end
			end

			local var_333_6 = math.max(1.73333333333333, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_6 then
				arg_330_1.fswtw_.percent = Mathf.Lerp(arg_330_1.var_.oldValueTypewriter, var_333_3, (arg_330_1.time_ - var_333_0) / var_333_6)
				arg_330_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_330_1.fswtw_:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_6 and arg_330_1.time_ < var_333_0 + var_333_6 + arg_333_0 then
				arg_330_1.fswtw_.percent = var_333_3

				arg_330_1.fswtw_:SetDirty()
				arg_330_1:ShowNextGo(true)

				arg_330_1.typewritterCharCountI18N = var_333_4
			end

			local var_333_7 = 0
			local var_333_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051079", "story_v_out_420051.awb") / 1000

			if var_333_8 > 0 and 8.066 < var_333_8 and var_333_8 + var_333_7 > arg_330_1.duration_ then
				arg_330_1.duration_ = var_333_8 + var_333_7
			end

			if var_333_7 < arg_330_1.time_ and arg_330_1.time_ <= var_333_7 + arg_333_0 then
				arg_330_1:AudioAction("play", "voice", "story_v_out_420051", "420051079", "story_v_out_420051.awb")
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play420051080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 420051080
		arg_334_1.duration_ = 5.97

		local var_334_0 = {
			zh = 5.799999997019,
			ja = 5.966
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
				arg_334_0:Play420051081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if arg_334_1.bgs_.ST67 == nil then
				local var_337_0 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_337_0.name = "ST67"
				var_337_0.transform.parent = arg_334_1.stage_.transform
				var_337_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_.ST67 = var_337_0
			end

			if 2 < arg_334_1.time_ and arg_334_1.time_ <= 2 + arg_337_0 then
				local var_337_1 = arg_334_1.bgs_.ST67

				arg_334_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_337_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_2 = var_337_1:GetComponent("SpriteRenderer")

				if var_337_2 and var_337_2.sprite then
					local var_337_3 = 2 * (var_337_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_337_1.transform.localScale = Vector3.New(var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "ST67" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_4 = 4

			if 4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			if arg_334_1.time_ >= var_337_4 + 0.0666666666666669 and arg_334_1.time_ < var_337_4 + 0.0666666666666669 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_5 = 0

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_6 = 2

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_6 then
				local var_337_7 = Color.New(0, 0, 0)

				var_337_7.a = Mathf.Lerp(0, 1, (arg_334_1.time_ - var_337_5) / var_337_6)
				arg_334_1.mask_.color = var_337_7
			end

			if arg_334_1.time_ >= var_337_5 + var_337_6 and arg_334_1.time_ < var_337_5 + var_337_6 + arg_337_0 then
				local var_337_8 = Color.New(0, 0, 0)

				var_337_8.a = 1
				arg_334_1.mask_.color = var_337_8
			end

			local var_337_9 = 2

			if 2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_9 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_10 = 2

			if var_337_9 <= arg_334_1.time_ and arg_334_1.time_ < var_337_9 + var_337_10 then
				local var_337_11 = Color.New(0, 0, 0)

				var_337_11.a = Mathf.Lerp(1, 0, (arg_334_1.time_ - var_337_9) / var_337_10)
				arg_334_1.mask_.color = var_337_11
			end

			if arg_334_1.time_ >= var_337_9 + var_337_10 and arg_334_1.time_ < var_337_9 + var_337_10 + arg_337_0 then
				local var_337_12 = Color.New(0, 0, 0)

				arg_334_1.mask_.enabled = false
				var_337_12.a = 0
				arg_334_1.mask_.color = var_337_12
			end

			local var_337_13 = "1061ui_story"

			if arg_334_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_337_14 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_334_1.stage_.transform)

				var_337_14.name = var_337_13
				var_337_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.actors_[var_337_13] = var_337_14

				local var_337_15 = var_337_14:GetComponentInChildren(typeof(CharacterEffect))

				var_337_15.enabled = true

				local var_337_16 = GameObjectTools.GetOrAddComponent(var_337_14, typeof(DynamicBoneHelper))

				if var_337_16 then
					var_337_16:EnableDynamicBone(false)
				end

				arg_334_1:ShowWeapon(var_337_15.transform, false)

				arg_334_1.var_[var_337_13 .. "Animator"] = var_337_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_334_1.var_[var_337_13 .. "Animator"].applyRootMotion = true
				arg_334_1.var_[var_337_13 .. "LipSync"] = var_337_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_337_17 = arg_334_1.actors_["1061ui_story"].transform

			if 3.79999999701977 < arg_334_1.time_ and arg_334_1.time_ <= 3.79999999701977 + arg_337_0 then
				arg_334_1.var_.moveOldPos1061ui_story = var_337_17.localPosition
			end

			local var_337_18 = 0.001

			if 3.79999999701977 <= arg_334_1.time_ and arg_334_1.time_ < 3.79999999701977 + var_337_18 then
				var_337_17.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_334_1.time_ - 3.79999999701977) / var_337_18)
				var_337_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_17.position).x, (manager.ui.mainCamera.transform.position - var_337_17.position).y, (manager.ui.mainCamera.transform.position - var_337_17.position).z)
				var_337_17.localEulerAngles.z = 0
				var_337_17.localEulerAngles.x = 0
				var_337_17.localEulerAngles = var_337_17.localEulerAngles
			end

			if arg_334_1.time_ >= 3.79999999701977 + var_337_18 and arg_334_1.time_ < 3.79999999701977 + var_337_18 + arg_337_0 then
				var_337_17.localPosition = Vector3.New(0, -1.18, -6.15)
				var_337_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_17.position).x, (manager.ui.mainCamera.transform.position - var_337_17.position).y, (manager.ui.mainCamera.transform.position - var_337_17.position).z)
				var_337_17.localEulerAngles.z = 0
				var_337_17.localEulerAngles.x = 0
				var_337_17.localEulerAngles = var_337_17.localEulerAngles
			end

			local var_337_19 = arg_334_1.actors_["1061ui_story"]

			if 3.79999999701977 < arg_334_1.time_ and arg_334_1.time_ <= 3.79999999701977 + arg_337_0 and not isNil(var_337_19) and arg_334_1.var_.characterEffect1061ui_story == nil then
				arg_334_1.var_.characterEffect1061ui_story = var_337_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_20 = 0.200000002980232

			if 3.79999999701977 <= arg_334_1.time_ and arg_334_1.time_ < 3.79999999701977 + var_337_20 and not isNil(var_337_19) then
				if arg_334_1.var_.characterEffect1061ui_story and not isNil(var_337_19) then
					arg_334_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 3.79999999701977 + var_337_20 and arg_334_1.time_ < 3.79999999701977 + var_337_20 + arg_337_0 and not isNil(var_337_19) and arg_334_1.var_.characterEffect1061ui_story then
				arg_334_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 3.79999999701977 < arg_334_1.time_ and arg_334_1.time_ <= 3.79999999701977 + arg_337_0 then
				arg_334_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 3.79999999701977 < arg_334_1.time_ and arg_334_1.time_ <= 3.79999999701977 + arg_337_0 then
				arg_334_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.93333333333333 < arg_334_1.time_ and arg_334_1.time_ <= 1.93333333333333 + arg_337_0 then
				arg_334_1.cswbg_:SetActive(false)
			end

			if 2 < arg_334_1.time_ and arg_334_1.time_ <= 2 + arg_337_0 then
				arg_334_1.fswbg_:SetActive(false)
				arg_334_1.dialog_:SetActive(false)
				SetActive(arg_334_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_334_1:ShowNextGo(false)
			end

			if 1.56666666666667 < arg_334_1.time_ and arg_334_1.time_ <= 1.56666666666667 + arg_337_0 then
				arg_334_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_337_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_334_1.bgmTxt_.text ~= var_337_25 and arg_334_1.bgmTxt_.text ~= "" then
						if arg_334_1.bgmTxt2_.text ~= "" then
							arg_334_1.bgmTxt_.text = arg_334_1.bgmTxt2_.text
						end

						arg_334_1.bgmTxt2_.text = var_337_25

						arg_334_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_334_1.bgmTxt_.text = var_337_25
						arg_334_1.bgmTxt2_.text = var_337_25
					end

					if arg_334_1.bgmTimer then
						arg_334_1.bgmTimer:Stop()

						arg_334_1.bgmTimer = nil
					end

					if arg_334_1.settingData.show_music_name == 1 then
						arg_334_1.musicController:SetSelectedState("show")
						arg_334_1.musicAnimator_:Play("open", 0, 0)

						if arg_334_1.settingData.music_time ~= 0 then
							arg_334_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_334_1.settingData.music_time), function()
								if arg_334_1 == nil or isNil(arg_334_1.bgmTxt_) then
									return
								end

								arg_334_1.musicController:SetSelectedState("hide")
								arg_334_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.56666666666667 < arg_334_1.time_ and arg_334_1.time_ <= 1.56666666666667 + arg_337_0 then
				arg_334_1:AudioAction("play", "music", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab.awb")

				local var_337_28 = manager.audio:GetAudioName("bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab")

				if "" ~= "" then
					if arg_334_1.bgmTxt_.text ~= var_337_28 and arg_334_1.bgmTxt_.text ~= "" then
						if arg_334_1.bgmTxt2_.text ~= "" then
							arg_334_1.bgmTxt_.text = arg_334_1.bgmTxt2_.text
						end

						arg_334_1.bgmTxt2_.text = var_337_28

						arg_334_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_334_1.bgmTxt_.text = var_337_28
						arg_334_1.bgmTxt2_.text = var_337_28
					end

					if arg_334_1.bgmTimer then
						arg_334_1.bgmTimer:Stop()

						arg_334_1.bgmTimer = nil
					end

					if arg_334_1.settingData.show_music_name == 1 then
						arg_334_1.musicController:SetSelectedState("show")
						arg_334_1.musicAnimator_:Play("open", 0, 0)

						if arg_334_1.settingData.music_time ~= 0 then
							arg_334_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_334_1.settingData.music_time), function()
								if arg_334_1 == nil or isNil(arg_334_1.bgmTxt_) then
									return
								end

								arg_334_1.musicController:SetSelectedState("hide")
								arg_334_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_29 = 4
			local var_337_30 = 0.125

			if 4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_29 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_31 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_31:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_334_1.dialogCg_.alpha = arg_340_0
				end))
				var_337_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_32 = arg_334_1:GetWordFromCfg(420051080)
				local var_337_33 = arg_334_1:FormatText(var_337_32.content)

				arg_334_1.text_.text = var_337_33

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_35 = 5 <= 0 and var_337_30 or var_337_30 * (utf8.len(var_337_33) / 5)

				if (5 <= 0 and var_337_30 or var_337_30 * (utf8.len(var_337_33) / 5)) > 0 and var_337_30 < var_337_35 then
					arg_334_1.talkMaxDuration = var_337_35
					var_337_29 = var_337_29 + 0.3

					if var_337_35 + var_337_29 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_35 + var_337_29
					end
				end

				arg_334_1.text_.text = var_337_33
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051080", "story_v_out_420051.awb") ~= 0 then
					local var_337_36 = manager.audio:GetVoiceLength("story_v_out_420051", "420051080", "story_v_out_420051.awb") / 1000

					if var_337_36 + var_337_29 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_36 + var_337_29
					end

					if var_337_32.prefab_name ~= "" and arg_334_1.actors_[var_337_32.prefab_name] ~= nil then
						local var_337_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_32.prefab_name].transform, "story_v_out_420051", "420051080", "story_v_out_420051.awb")

						arg_334_1:RecordAudio("420051080", var_337_37)
						arg_334_1:RecordAudio("420051080", var_337_37)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_420051", "420051080", "story_v_out_420051.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_420051", "420051080", "story_v_out_420051.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_38 = var_337_29 + 0.3
			local var_337_39 = math.max(var_337_30, arg_334_1.talkMaxDuration)

			if var_337_29 + 0.3 <= arg_334_1.time_ and arg_334_1.time_ < var_337_38 + var_337_39 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_38) / var_337_39

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_38 + var_337_39 and arg_334_1.time_ < var_337_38 + var_337_39 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play420051081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 420051081
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play420051082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1061ui_story"]) and arg_342_1.var_.characterEffect1061ui_story == nil then
				arg_342_1.var_.characterEffect1061ui_story = arg_342_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1061ui_story"]) then
				if arg_342_1.var_.characterEffect1061ui_story and not isNil(arg_342_1.actors_["1061ui_story"]) then
					arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1061ui_story"]) and arg_342_1.var_.characterEffect1061ui_story then
				arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_342_1.time_ and arg_342_1.time_ <= 0.05 + arg_345_0 then
				arg_342_1:AudioAction("play", "effect", "se_story_140", "se_story_140_xuanji", "")
			end

			local var_345_2 = 0
			local var_345_3 = 0.575

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_4 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(420051081).content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_6 = 23 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_4) / 23)

				if (23 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_4) / 23)) > 0 and var_345_3 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_7 and arg_342_1.time_ < var_345_2 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play420051082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 420051082
		arg_346_1.duration_ = 7.2

		local var_346_0 = {
			zh = 4.566,
			ja = 7.2
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
				arg_346_0:Play420051083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) and arg_346_1.var_.characterEffect1061ui_story == nil then
				arg_346_1.var_.characterEffect1061ui_story = arg_346_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) then
				if arg_346_1.var_.characterEffect1061ui_story and not isNil(arg_346_1.actors_["1061ui_story"]) then
					arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) and arg_346_1.var_.characterEffect1061ui_story then
				arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_349_2 = 0
			local var_349_3 = 0.525

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_4 = arg_346_1:GetWordFromCfg(420051082)
				local var_349_5 = arg_346_1:FormatText(var_349_4.content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 21 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 21)

				if (21 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 21)) > 0 and var_349_3 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051082", "story_v_out_420051.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051082", "story_v_out_420051.awb") / 1000

					if var_349_8 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_2
					end

					if var_349_4.prefab_name ~= "" and arg_346_1.actors_[var_349_4.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_4.prefab_name].transform, "story_v_out_420051", "420051082", "story_v_out_420051.awb")

						arg_346_1:RecordAudio("420051082", var_349_9)
						arg_346_1:RecordAudio("420051082", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_420051", "420051082", "story_v_out_420051.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_420051", "420051082", "story_v_out_420051.awb")
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
	Play420051083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 420051083
		arg_350_1.duration_ = 14.13

		local var_350_0 = {
			zh = 10.466,
			ja = 14.133
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
				arg_350_0:Play420051084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_353_0 = 0
			local var_353_1 = 1.2

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_2 = arg_350_1:GetWordFromCfg(420051083)
				local var_353_3 = arg_350_1:FormatText(var_353_2.content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 48 <= 0 and var_353_1 or var_353_1 * (utf8.len(var_353_3) / 48)

				if (48 <= 0 and var_353_1 or var_353_1 * (utf8.len(var_353_3) / 48)) > 0 and var_353_1 < var_353_5 then
					arg_350_1.talkMaxDuration = var_353_5

					if var_353_5 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051083", "story_v_out_420051.awb") ~= 0 then
					local var_353_6 = manager.audio:GetVoiceLength("story_v_out_420051", "420051083", "story_v_out_420051.awb") / 1000

					if var_353_6 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_6 + var_353_0
					end

					if var_353_2.prefab_name ~= "" and arg_350_1.actors_[var_353_2.prefab_name] ~= nil then
						local var_353_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_2.prefab_name].transform, "story_v_out_420051", "420051083", "story_v_out_420051.awb")

						arg_350_1:RecordAudio("420051083", var_353_7)
						arg_350_1:RecordAudio("420051083", var_353_7)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_420051", "420051083", "story_v_out_420051.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_420051", "420051083", "story_v_out_420051.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_8 and arg_350_1.time_ < var_353_0 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play420051084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 420051084
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play420051085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1061ui_story"]) and arg_354_1.var_.characterEffect1061ui_story == nil then
				arg_354_1.var_.characterEffect1061ui_story = arg_354_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1061ui_story"]) then
				if arg_354_1.var_.characterEffect1061ui_story and not isNil(arg_354_1.actors_["1061ui_story"]) then
					arg_354_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_0)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1061ui_story"]) and arg_354_1.var_.characterEffect1061ui_story then
				arg_354_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_357_1 = 0
			local var_357_2 = 0.775

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_3 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(420051084).content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 31 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 31)

				if (31 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 31)) > 0 and var_357_2 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_6 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_6 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_6

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_6 and arg_354_1.time_ < var_357_1 + var_357_6 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play420051085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 420051085
		arg_358_1.duration_ = 11.53

		local var_358_0 = {
			zh = 6.8,
			ja = 11.533
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
				arg_358_0:Play420051086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1061ui_story"]) and arg_358_1.var_.characterEffect1061ui_story == nil then
				arg_358_1.var_.characterEffect1061ui_story = arg_358_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1061ui_story"]) then
				if arg_358_1.var_.characterEffect1061ui_story and not isNil(arg_358_1.actors_["1061ui_story"]) then
					arg_358_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1061ui_story"]) and arg_358_1.var_.characterEffect1061ui_story then
				arg_358_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva", "EmotionTimelineAnimator")
			end

			local var_361_2 = 0
			local var_361_3 = 0.8

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_2 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_4 = arg_358_1:GetWordFromCfg(420051085)
				local var_361_5 = arg_358_1:FormatText(var_361_4.content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 32 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 32)

				if (32 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 32)) > 0 and var_361_3 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_2
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051085", "story_v_out_420051.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051085", "story_v_out_420051.awb") / 1000

					if var_361_8 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_2
					end

					if var_361_4.prefab_name ~= "" and arg_358_1.actors_[var_361_4.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_4.prefab_name].transform, "story_v_out_420051", "420051085", "story_v_out_420051.awb")

						arg_358_1:RecordAudio("420051085", var_361_9)
						arg_358_1:RecordAudio("420051085", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_420051", "420051085", "story_v_out_420051.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_420051", "420051085", "story_v_out_420051.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_3, arg_358_1.talkMaxDuration)

			if var_361_2 <= arg_358_1.time_ and arg_358_1.time_ < var_361_2 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_2) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_2 + var_361_10 and arg_358_1.time_ < var_361_2 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play420051086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 420051086
		arg_362_1.duration_ = 8.3

		local var_362_0 = {
			zh = 2.5,
			ja = 8.3
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
				arg_362_0:Play420051087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.3

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(420051086)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 12 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 12)

				if (12 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 12)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051086", "story_v_out_420051.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051086", "story_v_out_420051.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_out_420051", "420051086", "story_v_out_420051.awb")

						arg_362_1:RecordAudio("420051086", var_365_6)
						arg_362_1:RecordAudio("420051086", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_420051", "420051086", "story_v_out_420051.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_420051", "420051086", "story_v_out_420051.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play420051087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 420051087
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play420051088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1061ui_story = arg_366_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1061ui_story"].transform.position).z)
				arg_366_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1061ui_story"].transform.localEulerAngles = arg_366_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_366_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1061ui_story"].transform.position).z)
				arg_366_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1061ui_story"].transform.localEulerAngles = arg_366_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_369_1 = 0
			local var_369_2 = 0.075

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_3 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(420051087).content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 3 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 3)

				if (3 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 3)) > 0 and var_369_2 < var_369_5 then
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
				actorName = "1061ui_story",
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
	Play420051088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 420051088
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play420051089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0.533333333333333 < arg_370_1.time_ and arg_370_1.time_ <= 0.533333333333333 + arg_373_0 then
				arg_370_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_373_1 = 0
			local var_373_2 = 1.05

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(420051088).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 42 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 42)

				if (42 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 42)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play420051089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 420051089
		arg_374_1.duration_ = 3.17

		local var_374_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_374_0:Play420051090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1085ui_story = arg_374_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_377_0 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 then
				arg_374_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_374_1.time_ - 0) / var_377_0)
				arg_374_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1085ui_story"].transform.position).z)
				arg_374_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1085ui_story"].transform.localEulerAngles = arg_374_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 then
				arg_374_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_374_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1085ui_story"].transform.position).z)
				arg_374_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1085ui_story"].transform.localEulerAngles = arg_374_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_377_1 = arg_374_1.actors_["1085ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1085ui_story == nil then
				arg_374_1.var_.characterEffect1085ui_story = var_377_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_2 and not isNil(var_377_1) then
				if arg_374_1.var_.characterEffect1085ui_story and not isNil(var_377_1) then
					arg_374_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_2 and arg_374_1.time_ < 0 + var_377_2 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1085ui_story then
				arg_374_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_377_4 = 0
			local var_377_5 = 0.275

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_6 = arg_374_1:GetWordFromCfg(420051089)
				local var_377_7 = arg_374_1:FormatText(var_377_6.content)

				arg_374_1.text_.text = var_377_7

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 11 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 11)

				if (11 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 11)) > 0 and var_377_5 < var_377_9 then
					arg_374_1.talkMaxDuration = var_377_9

					if var_377_9 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_7
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051089", "story_v_out_420051.awb") ~= 0 then
					local var_377_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051089", "story_v_out_420051.awb") / 1000

					if var_377_10 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_4
					end

					if var_377_6.prefab_name ~= "" and arg_374_1.actors_[var_377_6.prefab_name] ~= nil then
						local var_377_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_6.prefab_name].transform, "story_v_out_420051", "420051089", "story_v_out_420051.awb")

						arg_374_1:RecordAudio("420051089", var_377_11)
						arg_374_1:RecordAudio("420051089", var_377_11)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_420051", "420051089", "story_v_out_420051.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_420051", "420051089", "story_v_out_420051.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_12 and arg_374_1.time_ < var_377_4 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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

		arg_374_1:InitPlayNodeList()
	end,
	Play420051090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 420051090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play420051091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1085ui_story"]) and arg_378_1.var_.characterEffect1085ui_story == nil then
				arg_378_1.var_.characterEffect1085ui_story = arg_378_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1085ui_story"]) then
				if arg_378_1.var_.characterEffect1085ui_story and not isNil(arg_378_1.actors_["1085ui_story"]) then
					arg_378_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1085ui_story"]) and arg_378_1.var_.characterEffect1085ui_story then
				arg_378_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_381_1 = 0
			local var_381_2 = 0.4

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(420051090).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 16 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 16)

				if (16 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 16)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play420051091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 420051091
		arg_382_1.duration_ = 15.3

		local var_382_0 = {
			zh = 9.7,
			ja = 15.3
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
				arg_382_0:Play420051092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1085ui_story"]) and arg_382_1.var_.characterEffect1085ui_story == nil then
				arg_382_1.var_.characterEffect1085ui_story = arg_382_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1085ui_story"]) then
				if arg_382_1.var_.characterEffect1085ui_story and not isNil(arg_382_1.actors_["1085ui_story"]) then
					arg_382_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1085ui_story"]) and arg_382_1.var_.characterEffect1085ui_story then
				arg_382_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_385_2 = 0
			local var_385_3 = 0.725

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_2 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_4 = arg_382_1:GetWordFromCfg(420051091)
				local var_385_5 = arg_382_1:FormatText(var_385_4.content)

				arg_382_1.text_.text = var_385_5

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_7 = 29 <= 0 and var_385_3 or var_385_3 * (utf8.len(var_385_5) / 29)

				if (29 <= 0 and var_385_3 or var_385_3 * (utf8.len(var_385_5) / 29)) > 0 and var_385_3 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_2 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_2
					end
				end

				arg_382_1.text_.text = var_385_5
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051091", "story_v_out_420051.awb") ~= 0 then
					local var_385_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051091", "story_v_out_420051.awb") / 1000

					if var_385_8 + var_385_2 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_8 + var_385_2
					end

					if var_385_4.prefab_name ~= "" and arg_382_1.actors_[var_385_4.prefab_name] ~= nil then
						local var_385_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_4.prefab_name].transform, "story_v_out_420051", "420051091", "story_v_out_420051.awb")

						arg_382_1:RecordAudio("420051091", var_385_9)
						arg_382_1:RecordAudio("420051091", var_385_9)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_420051", "420051091", "story_v_out_420051.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_420051", "420051091", "story_v_out_420051.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_10 = math.max(var_385_3, arg_382_1.talkMaxDuration)

			if var_385_2 <= arg_382_1.time_ and arg_382_1.time_ < var_385_2 + var_385_10 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_2) / var_385_10

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_2 + var_385_10 and arg_382_1.time_ < var_385_2 + var_385_10 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play420051092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 420051092
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play420051093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1085ui_story"]) and arg_386_1.var_.characterEffect1085ui_story == nil then
				arg_386_1.var_.characterEffect1085ui_story = arg_386_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1085ui_story"]) then
				if arg_386_1.var_.characterEffect1085ui_story and not isNil(arg_386_1.actors_["1085ui_story"]) then
					arg_386_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_0)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1085ui_story"]) and arg_386_1.var_.characterEffect1085ui_story then
				arg_386_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_389_1 = 0
			local var_389_2 = 0.475

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(420051092).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 19 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 19)

				if (19 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 19)) > 0 and var_389_2 < var_389_5 then
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
	Play420051093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 420051093
		arg_390_1.duration_ = 1.43

		local var_390_0 = {
			zh = 1.1,
			ja = 1.433
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
				arg_390_0:Play420051094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1085ui_story"]) and arg_390_1.var_.characterEffect1085ui_story == nil then
				arg_390_1.var_.characterEffect1085ui_story = arg_390_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1085ui_story"]) then
				if arg_390_1.var_.characterEffect1085ui_story and not isNil(arg_390_1.actors_["1085ui_story"]) then
					arg_390_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1085ui_story"]) and arg_390_1.var_.characterEffect1085ui_story then
				arg_390_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_393_2 = 0
			local var_393_3 = 0.05

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_4 = arg_390_1:GetWordFromCfg(420051093)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_7 = 2 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 2)

				if (2 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 2)) > 0 and var_393_3 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_2
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051093", "story_v_out_420051.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051093", "story_v_out_420051.awb") / 1000

					if var_393_8 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_2
					end

					if var_393_4.prefab_name ~= "" and arg_390_1.actors_[var_393_4.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_4.prefab_name].transform, "story_v_out_420051", "420051093", "story_v_out_420051.awb")

						arg_390_1:RecordAudio("420051093", var_393_9)
						arg_390_1:RecordAudio("420051093", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_420051", "420051093", "story_v_out_420051.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_420051", "420051093", "story_v_out_420051.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_3, arg_390_1.talkMaxDuration)

			if var_393_2 <= arg_390_1.time_ and arg_390_1.time_ < var_393_2 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_2) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_2 + var_393_10 and arg_390_1.time_ < var_393_2 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play420051094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 420051094
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play420051095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1085ui_story = arg_394_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_397_0 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 then
				arg_394_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_394_1.time_ - 0) / var_397_0)
				arg_394_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1085ui_story"].transform.position).z)
				arg_394_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["1085ui_story"].transform.localEulerAngles = arg_394_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 then
				arg_394_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_394_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1085ui_story"].transform.position).z)
				arg_394_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["1085ui_story"].transform.localEulerAngles = arg_394_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_397_1 = 0
			local var_397_2 = 1.1

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_3 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(420051094).content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 44 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 44)

				if (44 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 44)) > 0 and var_397_2 < var_397_5 then
					arg_394_1.talkMaxDuration = var_397_5

					if var_397_5 + var_397_1 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + var_397_1
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_6 = math.max(var_397_2, arg_394_1.talkMaxDuration)

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_6 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_1) / var_397_6

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_1 + var_397_6 and arg_394_1.time_ < var_397_1 + var_397_6 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
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

		arg_394_1:InitPlayNodeList()
	end,
	Play420051095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 420051095
		arg_398_1.duration_ = 3.23

		local var_398_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_398_0:Play420051096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1061ui_story = arg_398_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1061ui_story"].transform.position).z)
				arg_398_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1061ui_story"].transform.localEulerAngles = arg_398_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_398_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1061ui_story"].transform.position).z)
				arg_398_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1061ui_story"].transform.localEulerAngles = arg_398_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_401_1 = arg_398_1.actors_["1061ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1061ui_story == nil then
				arg_398_1.var_.characterEffect1061ui_story = var_401_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 and not isNil(var_401_1) then
				if arg_398_1.var_.characterEffect1061ui_story and not isNil(var_401_1) then
					arg_398_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1061ui_story then
				arg_398_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_4 = 0
			local var_401_5 = 0.275

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_6 = arg_398_1:GetWordFromCfg(420051095)
				local var_401_7 = arg_398_1:FormatText(var_401_6.content)

				arg_398_1.text_.text = var_401_7

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 11 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 11)

				if (11 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 11)) > 0 and var_401_5 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_7
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051095", "story_v_out_420051.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051095", "story_v_out_420051.awb") / 1000

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end

					if var_401_6.prefab_name ~= "" and arg_398_1.actors_[var_401_6.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_6.prefab_name].transform, "story_v_out_420051", "420051095", "story_v_out_420051.awb")

						arg_398_1:RecordAudio("420051095", var_401_11)
						arg_398_1:RecordAudio("420051095", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_420051", "420051095", "story_v_out_420051.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_420051", "420051095", "story_v_out_420051.awb")
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
				actorName = "1061ui_story",
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
	Play420051096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 420051096
		arg_402_1.duration_ = 3.57

		local var_402_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_402_0:Play420051097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos1061ui_story = arg_402_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_405_0 = 0.001

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 then
				arg_402_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_402_1.time_ - 0) / var_405_0)
				arg_402_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1061ui_story"].transform.position).z)
				arg_402_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["1061ui_story"].transform.localEulerAngles = arg_402_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 then
				arg_402_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_402_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1061ui_story"].transform.position).z)
				arg_402_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["1061ui_story"].transform.localEulerAngles = arg_402_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_405_1 = arg_402_1.actors_["1085ui_story"].transform

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos1085ui_story = var_405_1.localPosition
			end

			local var_405_2 = 0.001

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_2 then
				var_405_1.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_402_1.time_ - 0) / var_405_2)
				var_405_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_405_1.position).x, (manager.ui.mainCamera.transform.position - var_405_1.position).y, (manager.ui.mainCamera.transform.position - var_405_1.position).z)
				var_405_1.localEulerAngles.z = 0
				var_405_1.localEulerAngles.x = 0
				var_405_1.localEulerAngles = var_405_1.localEulerAngles
			end

			if arg_402_1.time_ >= 0 + var_405_2 and arg_402_1.time_ < 0 + var_405_2 + arg_405_0 then
				var_405_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_405_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_405_1.position).x, (manager.ui.mainCamera.transform.position - var_405_1.position).y, (manager.ui.mainCamera.transform.position - var_405_1.position).z)
				var_405_1.localEulerAngles.z = 0
				var_405_1.localEulerAngles.x = 0
				var_405_1.localEulerAngles = var_405_1.localEulerAngles
			end

			local var_405_3 = arg_402_1.actors_["1085ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_3) and arg_402_1.var_.characterEffect1085ui_story == nil then
				arg_402_1.var_.characterEffect1085ui_story = var_405_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_4 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 and not isNil(var_405_3) then
				if arg_402_1.var_.characterEffect1085ui_story and not isNil(var_405_3) then
					arg_402_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 and not isNil(var_405_3) and arg_402_1.var_.characterEffect1085ui_story then
				arg_402_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_405_6 = arg_402_1.actors_["1061ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_6) and arg_402_1.var_.characterEffect1061ui_story == nil then
				arg_402_1.var_.characterEffect1061ui_story = var_405_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_7 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 and not isNil(var_405_6) then
				if arg_402_1.var_.characterEffect1061ui_story and not isNil(var_405_6) then
					arg_402_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_7)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 and not isNil(var_405_6) and arg_402_1.var_.characterEffect1061ui_story then
				arg_402_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_405_8 = 0
			local var_405_9 = 0.15

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_8 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_10 = arg_402_1:GetWordFromCfg(420051096)
				local var_405_11 = arg_402_1:FormatText(var_405_10.content)

				arg_402_1.text_.text = var_405_11

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_13 = 6 <= 0 and var_405_9 or var_405_9 * (utf8.len(var_405_11) / 6)

				if (6 <= 0 and var_405_9 or var_405_9 * (utf8.len(var_405_11) / 6)) > 0 and var_405_9 < var_405_13 then
					arg_402_1.talkMaxDuration = var_405_13

					if var_405_13 + var_405_8 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_13 + var_405_8
					end
				end

				arg_402_1.text_.text = var_405_11
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051096", "story_v_out_420051.awb") ~= 0 then
					local var_405_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051096", "story_v_out_420051.awb") / 1000

					if var_405_14 + var_405_8 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_14 + var_405_8
					end

					if var_405_10.prefab_name ~= "" and arg_402_1.actors_[var_405_10.prefab_name] ~= nil then
						local var_405_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_10.prefab_name].transform, "story_v_out_420051", "420051096", "story_v_out_420051.awb")

						arg_402_1:RecordAudio("420051096", var_405_15)
						arg_402_1:RecordAudio("420051096", var_405_15)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_420051", "420051096", "story_v_out_420051.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_420051", "420051096", "story_v_out_420051.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_16 = math.max(var_405_9, arg_402_1.talkMaxDuration)

			if var_405_8 <= arg_402_1.time_ and arg_402_1.time_ < var_405_8 + var_405_16 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_8) / var_405_16

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_8 + var_405_16 and arg_402_1.time_ < var_405_8 + var_405_16 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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

		arg_402_1:InitPlayNodeList()
	end,
	Play420051097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 420051097
		arg_406_1.duration_ = 14.9

		local var_406_0 = {
			zh = 9.066,
			ja = 14.9
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
				arg_406_0:Play420051098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1061ui_story"]) and arg_406_1.var_.characterEffect1061ui_story == nil then
				arg_406_1.var_.characterEffect1061ui_story = arg_406_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1061ui_story"]) then
				if arg_406_1.var_.characterEffect1061ui_story and not isNil(arg_406_1.actors_["1061ui_story"]) then
					arg_406_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1061ui_story"]) and arg_406_1.var_.characterEffect1061ui_story then
				arg_406_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_409_2 = arg_406_1.actors_["1085ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.characterEffect1085ui_story == nil then
				arg_406_1.var_.characterEffect1085ui_story = var_409_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_3 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_3 and not isNil(var_409_2) then
				if arg_406_1.var_.characterEffect1085ui_story and not isNil(var_409_2) then
					arg_406_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_3)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_3 and arg_406_1.time_ < 0 + var_409_3 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.characterEffect1085ui_story then
				arg_406_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_409_4 = 0
			local var_409_5 = 0.85

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_6 = arg_406_1:GetWordFromCfg(420051097)
				local var_409_7 = arg_406_1:FormatText(var_409_6.content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 34 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 34)

				if (34 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 34)) > 0 and var_409_5 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051097", "story_v_out_420051.awb") ~= 0 then
					local var_409_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051097", "story_v_out_420051.awb") / 1000

					if var_409_10 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_4
					end

					if var_409_6.prefab_name ~= "" and arg_406_1.actors_[var_409_6.prefab_name] ~= nil then
						local var_409_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_6.prefab_name].transform, "story_v_out_420051", "420051097", "story_v_out_420051.awb")

						arg_406_1:RecordAudio("420051097", var_409_11)
						arg_406_1:RecordAudio("420051097", var_409_11)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_420051", "420051097", "story_v_out_420051.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_420051", "420051097", "story_v_out_420051.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_12 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_12 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_12

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_12 and arg_406_1.time_ < var_409_4 + var_409_12 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play420051098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 420051098
		arg_410_1.duration_ = 12.2

		local var_410_0 = {
			zh = 8,
			ja = 12.2
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
				arg_410_0:Play420051099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 1.025

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_1 = arg_410_1:GetWordFromCfg(420051098)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 41 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 41)

				if (41 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 41)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051098", "story_v_out_420051.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051098", "story_v_out_420051.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_out_420051", "420051098", "story_v_out_420051.awb")

						arg_410_1:RecordAudio("420051098", var_413_6)
						arg_410_1:RecordAudio("420051098", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_420051", "420051098", "story_v_out_420051.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_420051", "420051098", "story_v_out_420051.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play420051099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 420051099
		arg_414_1.duration_ = 4.73

		local var_414_0 = {
			zh = 3.9,
			ja = 4.733
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
				arg_414_0:Play420051100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.5

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:GetWordFromCfg(420051099)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 20 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 20)

				if (20 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 20)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051099", "story_v_out_420051.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051099", "story_v_out_420051.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_420051", "420051099", "story_v_out_420051.awb")

						arg_414_1:RecordAudio("420051099", var_417_6)
						arg_414_1:RecordAudio("420051099", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_420051", "420051099", "story_v_out_420051.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_420051", "420051099", "story_v_out_420051.awb")
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
	Play420051100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 420051100
		arg_418_1.duration_ = 10.17

		local var_418_0 = {
			zh = 7.9,
			ja = 10.166
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
				arg_418_0:Play420051101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if arg_418_1.bgs_.ST0504a == nil then
				local var_421_0 = Object.Instantiate(arg_418_1.paintGo_)

				var_421_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0504a")
				var_421_0.name = "ST0504a"
				var_421_0.transform.parent = arg_418_1.stage_.transform
				var_421_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_418_1.bgs_.ST0504a = var_421_0
			end

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= 2 + arg_421_0 then
				local var_421_1 = arg_418_1.bgs_.ST0504a

				arg_418_1.bgs_.ST0504a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_421_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_421_2 = var_421_1:GetComponent("SpriteRenderer")

				if var_421_2 and var_421_2.sprite then
					local var_421_3 = 2 * (var_421_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_421_1.transform.localScale = Vector3.New(var_421_3 / var_421_2.sprite.bounds.size.y < var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x and var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x or var_421_3 / var_421_2.sprite.bounds.size.y, var_421_3 / var_421_2.sprite.bounds.size.y < var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x and var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x or var_421_3 / var_421_2.sprite.bounds.size.y, 0)
				end

				for iter_421_0, iter_421_1 in pairs(arg_418_1.bgs_) do
					if iter_421_0 ~= "ST0504a" then
						iter_421_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_421_4 = 4

			if 4 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1.allBtn_.enabled = false
			end

			if arg_418_1.time_ >= var_421_4 + 0.3 and arg_418_1.time_ < var_421_4 + 0.3 + arg_421_0 then
				arg_418_1.allBtn_.enabled = true
			end

			local var_421_5 = 0

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_5 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_6 = 2

			if var_421_5 <= arg_418_1.time_ and arg_418_1.time_ < var_421_5 + var_421_6 then
				local var_421_7 = Color.New(0, 0, 0)

				var_421_7.a = Mathf.Lerp(0, 1, (arg_418_1.time_ - var_421_5) / var_421_6)
				arg_418_1.mask_.color = var_421_7
			end

			if arg_418_1.time_ >= var_421_5 + var_421_6 and arg_418_1.time_ < var_421_5 + var_421_6 + arg_421_0 then
				local var_421_8 = Color.New(0, 0, 0)

				var_421_8.a = 1
				arg_418_1.mask_.color = var_421_8
			end

			local var_421_9 = 2

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= var_421_9 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_10 = 2

			if var_421_9 <= arg_418_1.time_ and arg_418_1.time_ < var_421_9 + var_421_10 then
				local var_421_11 = Color.New(0, 0, 0)

				var_421_11.a = Mathf.Lerp(1, 0, (arg_418_1.time_ - var_421_9) / var_421_10)
				arg_418_1.mask_.color = var_421_11
			end

			if arg_418_1.time_ >= var_421_9 + var_421_10 and arg_418_1.time_ < var_421_9 + var_421_10 + arg_421_0 then
				local var_421_12 = Color.New(0, 0, 0)

				arg_418_1.mask_.enabled = false
				var_421_12.a = 0
				arg_418_1.mask_.color = var_421_12
			end

			local var_421_13 = arg_418_1.actors_["1061ui_story"].transform

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= 2 + arg_421_0 then
				arg_418_1.var_.moveOldPos1061ui_story = var_421_13.localPosition
			end

			local var_421_14 = 0.001

			if 2 <= arg_418_1.time_ and arg_418_1.time_ < 2 + var_421_14 then
				var_421_13.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_418_1.time_ - 2) / var_421_14)
				var_421_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_13.position).x, (manager.ui.mainCamera.transform.position - var_421_13.position).y, (manager.ui.mainCamera.transform.position - var_421_13.position).z)
				var_421_13.localEulerAngles.z = 0
				var_421_13.localEulerAngles.x = 0
				var_421_13.localEulerAngles = var_421_13.localEulerAngles
			end

			if arg_418_1.time_ >= 2 + var_421_14 and arg_418_1.time_ < 2 + var_421_14 + arg_421_0 then
				var_421_13.localPosition = Vector3.New(0, 100, 0)
				var_421_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_13.position).x, (manager.ui.mainCamera.transform.position - var_421_13.position).y, (manager.ui.mainCamera.transform.position - var_421_13.position).z)
				var_421_13.localEulerAngles.z = 0
				var_421_13.localEulerAngles.x = 0
				var_421_13.localEulerAngles = var_421_13.localEulerAngles
			end

			local var_421_15 = arg_418_1.actors_["1085ui_story"].transform

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= 2 + arg_421_0 then
				arg_418_1.var_.moveOldPos1085ui_story = var_421_15.localPosition
			end

			local var_421_16 = 0.001

			if 2 <= arg_418_1.time_ and arg_418_1.time_ < 2 + var_421_16 then
				var_421_15.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_418_1.time_ - 2) / var_421_16)
				var_421_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_15.position).x, (manager.ui.mainCamera.transform.position - var_421_15.position).y, (manager.ui.mainCamera.transform.position - var_421_15.position).z)
				var_421_15.localEulerAngles.z = 0
				var_421_15.localEulerAngles.x = 0
				var_421_15.localEulerAngles = var_421_15.localEulerAngles
			end

			if arg_418_1.time_ >= 2 + var_421_16 and arg_418_1.time_ < 2 + var_421_16 + arg_421_0 then
				var_421_15.localPosition = Vector3.New(0, 100, 0)
				var_421_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_15.position).x, (manager.ui.mainCamera.transform.position - var_421_15.position).y, (manager.ui.mainCamera.transform.position - var_421_15.position).z)
				var_421_15.localEulerAngles.z = 0
				var_421_15.localEulerAngles.x = 0
				var_421_15.localEulerAngles = var_421_15.localEulerAngles
			end

			local var_421_17 = arg_418_1.actors_["404001ui_story"].transform

			if 3.79999999701977 < arg_418_1.time_ and arg_418_1.time_ <= 3.79999999701977 + arg_421_0 then
				arg_418_1.var_.moveOldPos404001ui_story = var_421_17.localPosition
			end

			local var_421_18 = 0.001

			if 3.79999999701977 <= arg_418_1.time_ and arg_418_1.time_ < 3.79999999701977 + var_421_18 then
				var_421_17.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_418_1.time_ - 3.79999999701977) / var_421_18)
				var_421_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_17.position).x, (manager.ui.mainCamera.transform.position - var_421_17.position).y, (manager.ui.mainCamera.transform.position - var_421_17.position).z)
				var_421_17.localEulerAngles.z = 0
				var_421_17.localEulerAngles.x = 0
				var_421_17.localEulerAngles = var_421_17.localEulerAngles
			end

			if arg_418_1.time_ >= 3.79999999701977 + var_421_18 and arg_418_1.time_ < 3.79999999701977 + var_421_18 + arg_421_0 then
				var_421_17.localPosition = Vector3.New(0, -1.55, -5.5)
				var_421_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_17.position).x, (manager.ui.mainCamera.transform.position - var_421_17.position).y, (manager.ui.mainCamera.transform.position - var_421_17.position).z)
				var_421_17.localEulerAngles.z = 0
				var_421_17.localEulerAngles.x = 0
				var_421_17.localEulerAngles = var_421_17.localEulerAngles
			end

			local var_421_19 = arg_418_1.actors_["404001ui_story"]

			if 3.79999999701977 < arg_418_1.time_ and arg_418_1.time_ <= 3.79999999701977 + arg_421_0 and not isNil(var_421_19) and arg_418_1.var_.characterEffect404001ui_story == nil then
				arg_418_1.var_.characterEffect404001ui_story = var_421_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_20 = 0.200000002980232

			if 3.79999999701977 <= arg_418_1.time_ and arg_418_1.time_ < 3.79999999701977 + var_421_20 and not isNil(var_421_19) then
				if arg_418_1.var_.characterEffect404001ui_story and not isNil(var_421_19) then
					arg_418_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 3.79999999701977 + var_421_20 and arg_418_1.time_ < 3.79999999701977 + var_421_20 + arg_421_0 and not isNil(var_421_19) and arg_418_1.var_.characterEffect404001ui_story then
				arg_418_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 3.79999999701977 < arg_418_1.time_ and arg_418_1.time_ <= 3.79999999701977 + arg_421_0 then
				arg_418_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 3.79999999701977 < arg_418_1.time_ and arg_418_1.time_ <= 3.79999999701977 + arg_421_0 then
				arg_418_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0.366666666666667 < arg_418_1.time_ and arg_418_1.time_ <= 0.366666666666667 + arg_421_0 then
				arg_418_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_421_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_25 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_25

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_25
						arg_418_1.bgmTxt2_.text = var_421_25
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= 2 + arg_421_0 then
				arg_418_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_421_28 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_28 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_28

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_28
						arg_418_1.bgmTxt2_.text = var_421_28
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_418_1.frameCnt_ <= 1 then
				arg_418_1.dialog_:SetActive(false)
			end

			local var_421_29 = 4
			local var_421_30 = 0.45

			if 4 < arg_418_1.time_ and arg_418_1.time_ <= var_421_29 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0

				arg_418_1.dialog_:SetActive(true)

				arg_418_1.dialogCg_.alpha = 0

				local var_421_31 = LeanTween.value(arg_418_1.dialog_, 0, 1, 0.3)

				var_421_31:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_418_1.dialogCg_.alpha = arg_424_0
				end))
				var_421_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_418_1.dialog_)
					var_421_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_418_1.duration_ = arg_418_1.duration_ + 0.3

				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_32 = arg_418_1:GetWordFromCfg(420051100)
				local var_421_33 = arg_418_1:FormatText(var_421_32.content)

				arg_418_1.text_.text = var_421_33

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_35 = 18 <= 0 and var_421_30 or var_421_30 * (utf8.len(var_421_33) / 18)

				if (18 <= 0 and var_421_30 or var_421_30 * (utf8.len(var_421_33) / 18)) > 0 and var_421_30 < var_421_35 then
					arg_418_1.talkMaxDuration = var_421_35
					var_421_29 = var_421_29 + 0.3

					if var_421_35 + var_421_29 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_35 + var_421_29
					end
				end

				arg_418_1.text_.text = var_421_33
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051100", "story_v_out_420051.awb") ~= 0 then
					local var_421_36 = manager.audio:GetVoiceLength("story_v_out_420051", "420051100", "story_v_out_420051.awb") / 1000

					if var_421_36 + var_421_29 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_36 + var_421_29
					end

					if var_421_32.prefab_name ~= "" and arg_418_1.actors_[var_421_32.prefab_name] ~= nil then
						local var_421_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_32.prefab_name].transform, "story_v_out_420051", "420051100", "story_v_out_420051.awb")

						arg_418_1:RecordAudio("420051100", var_421_37)
						arg_418_1:RecordAudio("420051100", var_421_37)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_420051", "420051100", "story_v_out_420051.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_420051", "420051100", "story_v_out_420051.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_38 = var_421_29 + 0.3
			local var_421_39 = math.max(var_421_30, arg_418_1.talkMaxDuration)

			if var_421_29 + 0.3 <= arg_418_1.time_ and arg_418_1.time_ < var_421_38 + var_421_39 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_38) / var_421_39

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_38 + var_421_39 and arg_418_1.time_ < var_421_38 + var_421_39 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play420051101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 420051101
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play420051102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos404001ui_story = arg_426_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_429_0 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				arg_426_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_426_1.time_ - 0) / var_429_0)
				arg_426_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["404001ui_story"].transform.position).z)
				arg_426_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["404001ui_story"].transform.localEulerAngles = arg_426_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				arg_426_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_426_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["404001ui_story"].transform.position).z)
				arg_426_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["404001ui_story"].transform.localEulerAngles = arg_426_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_429_1 = 0
			local var_429_2 = 1.175

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_3 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(420051101).content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 47 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 47)

				if (47 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 47)) > 0 and var_429_2 < var_429_5 then
					arg_426_1.talkMaxDuration = var_429_5

					if var_429_5 + var_429_1 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + var_429_1
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_6 = math.max(var_429_2, arg_426_1.talkMaxDuration)

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_6 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_1) / var_429_6

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_1 + var_429_6 and arg_426_1.time_ < var_429_1 + var_429_6 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play420051102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 420051102
		arg_430_1.duration_ = 14.93

		local var_430_0 = {
			zh = 9.7,
			ja = 14.933
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
				arg_430_0:Play420051103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos404001ui_story = arg_430_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["404001ui_story"].transform.position).z)
				arg_430_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["404001ui_story"].transform.localEulerAngles = arg_430_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_430_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["404001ui_story"].transform.position).z)
				arg_430_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["404001ui_story"].transform.localEulerAngles = arg_430_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["404001ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect404001ui_story == nil then
				arg_430_1.var_.characterEffect404001ui_story = var_433_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 and not isNil(var_433_1) then
				if arg_430_1.var_.characterEffect404001ui_story and not isNil(var_433_1) then
					arg_430_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect404001ui_story then
				arg_430_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_433_4 = 0
			local var_433_5 = 1.2

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_6 = arg_430_1:GetWordFromCfg(420051102)
				local var_433_7 = arg_430_1:FormatText(var_433_6.content)

				arg_430_1.text_.text = var_433_7

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_9 = 48 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 48)

				if (48 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 48)) > 0 and var_433_5 < var_433_9 then
					arg_430_1.talkMaxDuration = var_433_9

					if var_433_9 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_9 + var_433_4
					end
				end

				arg_430_1.text_.text = var_433_7
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051102", "story_v_out_420051.awb") ~= 0 then
					local var_433_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051102", "story_v_out_420051.awb") / 1000

					if var_433_10 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_4
					end

					if var_433_6.prefab_name ~= "" and arg_430_1.actors_[var_433_6.prefab_name] ~= nil then
						local var_433_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_6.prefab_name].transform, "story_v_out_420051", "420051102", "story_v_out_420051.awb")

						arg_430_1:RecordAudio("420051102", var_433_11)
						arg_430_1:RecordAudio("420051102", var_433_11)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_420051", "420051102", "story_v_out_420051.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_420051", "420051102", "story_v_out_420051.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_12 = math.max(var_433_5, arg_430_1.talkMaxDuration)

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_12 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_4) / var_433_12

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_4 + var_433_12 and arg_430_1.time_ < var_433_4 + var_433_12 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play420051103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 420051103
		arg_434_1.duration_ = 2

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play420051104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos404001ui_story = arg_434_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_437_0 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 then
				arg_434_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_434_1.time_ - 0) / var_437_0)
				arg_434_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["404001ui_story"].transform.position).z)
				arg_434_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["404001ui_story"].transform.localEulerAngles = arg_434_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 then
				arg_434_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_434_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["404001ui_story"].transform.position).z)
				arg_434_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["404001ui_story"].transform.localEulerAngles = arg_434_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_437_1 = arg_434_1.actors_["1085ui_story"].transform

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1085ui_story = var_437_1.localPosition
			end

			local var_437_2 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_2 then
				var_437_1.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_434_1.time_ - 0) / var_437_2)
				var_437_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_1.position).x, (manager.ui.mainCamera.transform.position - var_437_1.position).y, (manager.ui.mainCamera.transform.position - var_437_1.position).z)
				var_437_1.localEulerAngles.z = 0
				var_437_1.localEulerAngles.x = 0
				var_437_1.localEulerAngles = var_437_1.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_2 and arg_434_1.time_ < 0 + var_437_2 + arg_437_0 then
				var_437_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_437_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_1.position).x, (manager.ui.mainCamera.transform.position - var_437_1.position).y, (manager.ui.mainCamera.transform.position - var_437_1.position).z)
				var_437_1.localEulerAngles.z = 0
				var_437_1.localEulerAngles.x = 0
				var_437_1.localEulerAngles = var_437_1.localEulerAngles
			end

			local var_437_3 = arg_434_1.actors_["1085ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_3) and arg_434_1.var_.characterEffect1085ui_story == nil then
				arg_434_1.var_.characterEffect1085ui_story = var_437_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_4 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 and not isNil(var_437_3) then
				if arg_434_1.var_.characterEffect1085ui_story and not isNil(var_437_3) then
					arg_434_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 and not isNil(var_437_3) and arg_434_1.var_.characterEffect1085ui_story then
				arg_434_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_437_6 = arg_434_1.actors_["404001ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_6) and arg_434_1.var_.characterEffect404001ui_story == nil then
				arg_434_1.var_.characterEffect404001ui_story = var_437_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_7 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 and not isNil(var_437_6) then
				if arg_434_1.var_.characterEffect404001ui_story and not isNil(var_437_6) then
					arg_434_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_434_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_7)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 and not isNil(var_437_6) and arg_434_1.var_.characterEffect404001ui_story then
				arg_434_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_434_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_437_8 = 0
			local var_437_9 = 0.175

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_8 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_10 = arg_434_1:GetWordFromCfg(420051103)
				local var_437_11 = arg_434_1:FormatText(var_437_10.content)

				arg_434_1.text_.text = var_437_11

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_13 = 7 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 7)

				if (7 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 7)) > 0 and var_437_9 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_8
					end
				end

				arg_434_1.text_.text = var_437_11
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051103", "story_v_out_420051.awb") ~= 0 then
					local var_437_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051103", "story_v_out_420051.awb") / 1000

					if var_437_14 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_14 + var_437_8
					end

					if var_437_10.prefab_name ~= "" and arg_434_1.actors_[var_437_10.prefab_name] ~= nil then
						local var_437_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_10.prefab_name].transform, "story_v_out_420051", "420051103", "story_v_out_420051.awb")

						arg_434_1:RecordAudio("420051103", var_437_15)
						arg_434_1:RecordAudio("420051103", var_437_15)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_420051", "420051103", "story_v_out_420051.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_420051", "420051103", "story_v_out_420051.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_9, arg_434_1.talkMaxDuration)

			if var_437_8 <= arg_434_1.time_ and arg_434_1.time_ < var_437_8 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_8) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_8 + var_437_16 and arg_434_1.time_ < var_437_8 + var_437_16 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_434_1:InitPlayNodeList()
	end,
	Play420051104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 420051104
		arg_438_1.duration_ = 5.8

		local var_438_0 = {
			zh = 5.366,
			ja = 5.8
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
				arg_438_0:Play420051105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["404001ui_story"]) and arg_438_1.var_.characterEffect404001ui_story == nil then
				arg_438_1.var_.characterEffect404001ui_story = arg_438_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["404001ui_story"]) then
				if arg_438_1.var_.characterEffect404001ui_story and not isNil(arg_438_1.actors_["404001ui_story"]) then
					arg_438_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["404001ui_story"]) and arg_438_1.var_.characterEffect404001ui_story then
				arg_438_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_441_2 = arg_438_1.actors_["1085ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.characterEffect1085ui_story == nil then
				arg_438_1.var_.characterEffect1085ui_story = var_441_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_3 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_3 and not isNil(var_441_2) then
				if arg_438_1.var_.characterEffect1085ui_story and not isNil(var_441_2) then
					arg_438_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_438_1.time_ - 0) / var_441_3)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_3 and arg_438_1.time_ < 0 + var_441_3 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.characterEffect1085ui_story then
				arg_438_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_441_4 = 0
			local var_441_5 = 0.6

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_6 = arg_438_1:GetWordFromCfg(420051104)
				local var_441_7 = arg_438_1:FormatText(var_441_6.content)

				arg_438_1.text_.text = var_441_7

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 24 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 24)

				if (24 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 24)) > 0 and var_441_5 < var_441_9 then
					arg_438_1.talkMaxDuration = var_441_9

					if var_441_9 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_9 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_7
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051104", "story_v_out_420051.awb") ~= 0 then
					local var_441_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051104", "story_v_out_420051.awb") / 1000

					if var_441_10 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_4
					end

					if var_441_6.prefab_name ~= "" and arg_438_1.actors_[var_441_6.prefab_name] ~= nil then
						local var_441_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_6.prefab_name].transform, "story_v_out_420051", "420051104", "story_v_out_420051.awb")

						arg_438_1:RecordAudio("420051104", var_441_11)
						arg_438_1:RecordAudio("420051104", var_441_11)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_420051", "420051104", "story_v_out_420051.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_420051", "420051104", "story_v_out_420051.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_12 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_12 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_12

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_12 and arg_438_1.time_ < var_441_4 + var_441_12 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play420051105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 420051105
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play420051106(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos404001ui_story = arg_442_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_445_0 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 then
				arg_442_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_442_1.time_ - 0) / var_445_0)
				arg_442_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["404001ui_story"].transform.position).z)
				arg_442_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["404001ui_story"].transform.localEulerAngles = arg_442_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 then
				arg_442_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_442_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["404001ui_story"].transform.position).z)
				arg_442_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["404001ui_story"].transform.localEulerAngles = arg_442_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_445_1 = arg_442_1.actors_["1085ui_story"].transform

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1085ui_story = var_445_1.localPosition
			end

			local var_445_2 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_2 then
				var_445_1.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_442_1.time_ - 0) / var_445_2)
				var_445_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_1.position).x, (manager.ui.mainCamera.transform.position - var_445_1.position).y, (manager.ui.mainCamera.transform.position - var_445_1.position).z)
				var_445_1.localEulerAngles.z = 0
				var_445_1.localEulerAngles.x = 0
				var_445_1.localEulerAngles = var_445_1.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_2 and arg_442_1.time_ < 0 + var_445_2 + arg_445_0 then
				var_445_1.localPosition = Vector3.New(0, 100, 0)
				var_445_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_1.position).x, (manager.ui.mainCamera.transform.position - var_445_1.position).y, (manager.ui.mainCamera.transform.position - var_445_1.position).z)
				var_445_1.localEulerAngles.z = 0
				var_445_1.localEulerAngles.x = 0
				var_445_1.localEulerAngles = var_445_1.localEulerAngles
			end

			if 0.034000001847744 < arg_442_1.time_ and arg_442_1.time_ <= 0.034000001847744 + arg_445_0 then
				arg_442_1:AudioAction("play", "effect", "se_story_140", "se_story_140_curtain02", "")
			end

			local var_445_4 = 0
			local var_445_5 = 0.825

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_6 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(420051105).content)

				arg_442_1.text_.text = var_445_6

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_8 = 33 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_6) / 33)

				if (33 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_6) / 33)) > 0 and var_445_5 < var_445_8 then
					arg_442_1.talkMaxDuration = var_445_8

					if var_445_8 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_4
					end
				end

				arg_442_1.text_.text = var_445_6
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_9 = math.max(var_445_5, arg_442_1.talkMaxDuration)

			if var_445_4 <= arg_442_1.time_ and arg_442_1.time_ < var_445_4 + var_445_9 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_4) / var_445_9

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_4 + var_445_9 and arg_442_1.time_ < var_445_4 + var_445_9 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_442_1:InitPlayNodeList()
	end,
	Play420051106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 420051106
		arg_446_1.duration_ = 2.87

		local var_446_0 = {
			zh = 2.3,
			ja = 2.866
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
				arg_446_0:Play420051107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.var_.moveOldPos1085ui_story = arg_446_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_449_0 = 0.001

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 then
				arg_446_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_446_1.time_ - 0) / var_449_0)
				arg_446_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1085ui_story"].transform.position).z)
				arg_446_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["1085ui_story"].transform.localEulerAngles = arg_446_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 then
				arg_446_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_446_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1085ui_story"].transform.position).z)
				arg_446_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["1085ui_story"].transform.localEulerAngles = arg_446_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_449_1 = arg_446_1.actors_["1085ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1085ui_story == nil then
				arg_446_1.var_.characterEffect1085ui_story = var_449_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_2 and not isNil(var_449_1) then
				if arg_446_1.var_.characterEffect1085ui_story and not isNil(var_449_1) then
					arg_446_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= 0 + var_449_2 and arg_446_1.time_ < 0 + var_449_2 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1085ui_story then
				arg_446_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_449_4 = 0
			local var_449_5 = 0.2

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_6 = arg_446_1:GetWordFromCfg(420051106)
				local var_449_7 = arg_446_1:FormatText(var_449_6.content)

				arg_446_1.text_.text = var_449_7

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_9 = 8 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 8)

				if (8 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 8)) > 0 and var_449_5 < var_449_9 then
					arg_446_1.talkMaxDuration = var_449_9

					if var_449_9 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_9 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_7
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051106", "story_v_out_420051.awb") ~= 0 then
					local var_449_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051106", "story_v_out_420051.awb") / 1000

					if var_449_10 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_4
					end

					if var_449_6.prefab_name ~= "" and arg_446_1.actors_[var_449_6.prefab_name] ~= nil then
						local var_449_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_6.prefab_name].transform, "story_v_out_420051", "420051106", "story_v_out_420051.awb")

						arg_446_1:RecordAudio("420051106", var_449_11)
						arg_446_1:RecordAudio("420051106", var_449_11)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_420051", "420051106", "story_v_out_420051.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_420051", "420051106", "story_v_out_420051.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_12 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_12 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_12

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_12 and arg_446_1.time_ < var_449_4 + var_449_12 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
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

		arg_446_1:InitPlayNodeList()
	end,
	Play420051107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 420051107
		arg_450_1.duration_ = 4.2

		local var_450_0 = {
			zh = 2.4,
			ja = 4.2
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
				arg_450_0:Play420051108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos404001ui_story = arg_450_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_453_0 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 then
				arg_450_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_450_1.time_ - 0) / var_453_0)
				arg_450_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["404001ui_story"].transform.position).z)
				arg_450_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["404001ui_story"].transform.localEulerAngles = arg_450_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 then
				arg_450_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_450_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["404001ui_story"].transform.position).z)
				arg_450_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["404001ui_story"].transform.localEulerAngles = arg_450_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_453_1 = arg_450_1.actors_["1085ui_story"].transform

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos1085ui_story = var_453_1.localPosition
			end

			local var_453_2 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_2 then
				var_453_1.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_450_1.time_ - 0) / var_453_2)
				var_453_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_453_1.position).x, (manager.ui.mainCamera.transform.position - var_453_1.position).y, (manager.ui.mainCamera.transform.position - var_453_1.position).z)
				var_453_1.localEulerAngles.z = 0
				var_453_1.localEulerAngles.x = 0
				var_453_1.localEulerAngles = var_453_1.localEulerAngles
			end

			if arg_450_1.time_ >= 0 + var_453_2 and arg_450_1.time_ < 0 + var_453_2 + arg_453_0 then
				var_453_1.localPosition = Vector3.New(0, 100, 0)
				var_453_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_453_1.position).x, (manager.ui.mainCamera.transform.position - var_453_1.position).y, (manager.ui.mainCamera.transform.position - var_453_1.position).z)
				var_453_1.localEulerAngles.z = 0
				var_453_1.localEulerAngles.x = 0
				var_453_1.localEulerAngles = var_453_1.localEulerAngles
			end

			local var_453_3 = arg_450_1.actors_["404001ui_story"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_3) and arg_450_1.var_.characterEffect404001ui_story == nil then
				arg_450_1.var_.characterEffect404001ui_story = var_453_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_4 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_4 and not isNil(var_453_3) then
				if arg_450_1.var_.characterEffect404001ui_story and not isNil(var_453_3) then
					arg_450_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= 0 + var_453_4 and arg_450_1.time_ < 0 + var_453_4 + arg_453_0 and not isNil(var_453_3) and arg_450_1.var_.characterEffect404001ui_story then
				arg_450_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_453_6 = arg_450_1.actors_["1085ui_story"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_6) and arg_450_1.var_.characterEffect1085ui_story == nil then
				arg_450_1.var_.characterEffect1085ui_story = var_453_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_7 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 and not isNil(var_453_6) then
				if arg_450_1.var_.characterEffect1085ui_story and not isNil(var_453_6) then
					arg_450_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_7)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 and not isNil(var_453_6) and arg_450_1.var_.characterEffect1085ui_story then
				arg_450_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_453_8 = 0
			local var_453_9 = 0.25

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_10 = arg_450_1:GetWordFromCfg(420051107)
				local var_453_11 = arg_450_1:FormatText(var_453_10.content)

				arg_450_1.text_.text = var_453_11

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 10 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 10)

				if (10 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 10)) > 0 and var_453_9 < var_453_13 then
					arg_450_1.talkMaxDuration = var_453_13

					if var_453_13 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_13 + var_453_8
					end
				end

				arg_450_1.text_.text = var_453_11
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051107", "story_v_out_420051.awb") ~= 0 then
					local var_453_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051107", "story_v_out_420051.awb") / 1000

					if var_453_14 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_14 + var_453_8
					end

					if var_453_10.prefab_name ~= "" and arg_450_1.actors_[var_453_10.prefab_name] ~= nil then
						local var_453_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_10.prefab_name].transform, "story_v_out_420051", "420051107", "story_v_out_420051.awb")

						arg_450_1:RecordAudio("420051107", var_453_15)
						arg_450_1:RecordAudio("420051107", var_453_15)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_420051", "420051107", "story_v_out_420051.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_420051", "420051107", "story_v_out_420051.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_16 = math.max(var_453_9, arg_450_1.talkMaxDuration)

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_16 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_8) / var_453_16

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_8 + var_453_16 and arg_450_1.time_ < var_453_8 + var_453_16 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_450_1:InitPlayNodeList()
	end,
	Play420051108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 420051108
		arg_454_1.duration_ = 9.9

		local var_454_0 = {
			zh = 4.7,
			ja = 9.9
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
				arg_454_0:Play420051109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.875

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_1 = arg_454_1:GetWordFromCfg(420051108)
				local var_457_2 = arg_454_1:FormatText(var_457_1.content)

				arg_454_1.text_.text = var_457_2

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 35 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 35)

				if (35 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 35)) > 0 and var_457_0 < var_457_4 then
					arg_454_1.talkMaxDuration = var_457_4

					if var_457_4 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_4 + 0
					end
				end

				arg_454_1.text_.text = var_457_2
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051108", "story_v_out_420051.awb") ~= 0 then
					local var_457_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051108", "story_v_out_420051.awb") / 1000

					if var_457_5 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + 0
					end

					if var_457_1.prefab_name ~= "" and arg_454_1.actors_[var_457_1.prefab_name] ~= nil then
						local var_457_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_1.prefab_name].transform, "story_v_out_420051", "420051108", "story_v_out_420051.awb")

						arg_454_1:RecordAudio("420051108", var_457_6)
						arg_454_1:RecordAudio("420051108", var_457_6)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_420051", "420051108", "story_v_out_420051.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_420051", "420051108", "story_v_out_420051.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_7 and arg_454_1.time_ < 0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play420051109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 420051109
		arg_458_1.duration_ = 10.83

		local var_458_0 = {
			zh = 9.033,
			ja = 10.833
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
				arg_458_0:Play420051110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos404001ui_story = arg_458_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_461_0 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 then
				arg_458_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_458_1.time_ - 0) / var_461_0)
				arg_458_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["404001ui_story"].transform.position).z)
				arg_458_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["404001ui_story"].transform.localEulerAngles = arg_458_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 then
				arg_458_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_458_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["404001ui_story"].transform.position).z)
				arg_458_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["404001ui_story"].transform.localEulerAngles = arg_458_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_461_1 = arg_458_1.actors_["1085ui_story"].transform

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos1085ui_story = var_461_1.localPosition
			end

			local var_461_2 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_2 then
				var_461_1.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_458_1.time_ - 0) / var_461_2)
				var_461_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_461_1.position).x, (manager.ui.mainCamera.transform.position - var_461_1.position).y, (manager.ui.mainCamera.transform.position - var_461_1.position).z)
				var_461_1.localEulerAngles.z = 0
				var_461_1.localEulerAngles.x = 0
				var_461_1.localEulerAngles = var_461_1.localEulerAngles
			end

			if arg_458_1.time_ >= 0 + var_461_2 and arg_458_1.time_ < 0 + var_461_2 + arg_461_0 then
				var_461_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_461_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_461_1.position).x, (manager.ui.mainCamera.transform.position - var_461_1.position).y, (manager.ui.mainCamera.transform.position - var_461_1.position).z)
				var_461_1.localEulerAngles.z = 0
				var_461_1.localEulerAngles.x = 0
				var_461_1.localEulerAngles = var_461_1.localEulerAngles
			end

			local var_461_3 = arg_458_1.actors_["1085ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_3) and arg_458_1.var_.characterEffect1085ui_story == nil then
				arg_458_1.var_.characterEffect1085ui_story = var_461_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_4 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 and not isNil(var_461_3) then
				if arg_458_1.var_.characterEffect1085ui_story and not isNil(var_461_3) then
					arg_458_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 and not isNil(var_461_3) and arg_458_1.var_.characterEffect1085ui_story then
				arg_458_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_461_6 = arg_458_1.actors_["404001ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_6) and arg_458_1.var_.characterEffect404001ui_story == nil then
				arg_458_1.var_.characterEffect404001ui_story = var_461_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_7 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_7 and not isNil(var_461_6) then
				if arg_458_1.var_.characterEffect404001ui_story and not isNil(var_461_6) then
					arg_458_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_458_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_7)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_7 and arg_458_1.time_ < 0 + var_461_7 + arg_461_0 and not isNil(var_461_6) and arg_458_1.var_.characterEffect404001ui_story then
				arg_458_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_458_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_461_8 = 0
			local var_461_9 = 0.8

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_8 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_10 = arg_458_1:GetWordFromCfg(420051109)
				local var_461_11 = arg_458_1:FormatText(var_461_10.content)

				arg_458_1.text_.text = var_461_11

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_13 = 32 <= 0 and var_461_9 or var_461_9 * (utf8.len(var_461_11) / 32)

				if (32 <= 0 and var_461_9 or var_461_9 * (utf8.len(var_461_11) / 32)) > 0 and var_461_9 < var_461_13 then
					arg_458_1.talkMaxDuration = var_461_13

					if var_461_13 + var_461_8 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_13 + var_461_8
					end
				end

				arg_458_1.text_.text = var_461_11
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051109", "story_v_out_420051.awb") ~= 0 then
					local var_461_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051109", "story_v_out_420051.awb") / 1000

					if var_461_14 + var_461_8 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_14 + var_461_8
					end

					if var_461_10.prefab_name ~= "" and arg_458_1.actors_[var_461_10.prefab_name] ~= nil then
						local var_461_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_10.prefab_name].transform, "story_v_out_420051", "420051109", "story_v_out_420051.awb")

						arg_458_1:RecordAudio("420051109", var_461_15)
						arg_458_1:RecordAudio("420051109", var_461_15)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_420051", "420051109", "story_v_out_420051.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_420051", "420051109", "story_v_out_420051.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_16 = math.max(var_461_9, arg_458_1.talkMaxDuration)

			if var_461_8 <= arg_458_1.time_ and arg_458_1.time_ < var_461_8 + var_461_16 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_8) / var_461_16

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_8 + var_461_16 and arg_458_1.time_ < var_461_8 + var_461_16 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_458_1:InitPlayNodeList()
	end,
	Play420051110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 420051110
		arg_462_1.duration_ = 6.53

		local var_462_0 = {
			zh = 3.1,
			ja = 6.533
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
				arg_462_0:Play420051111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_465_0 = 0
			local var_465_1 = 0.325

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_2 = arg_462_1:GetWordFromCfg(420051110)
				local var_465_3 = arg_462_1:FormatText(var_465_2.content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 13 <= 0 and var_465_1 or var_465_1 * (utf8.len(var_465_3) / 13)

				if (13 <= 0 and var_465_1 or var_465_1 * (utf8.len(var_465_3) / 13)) > 0 and var_465_1 < var_465_5 then
					arg_462_1.talkMaxDuration = var_465_5

					if var_465_5 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_5 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051110", "story_v_out_420051.awb") ~= 0 then
					local var_465_6 = manager.audio:GetVoiceLength("story_v_out_420051", "420051110", "story_v_out_420051.awb") / 1000

					if var_465_6 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_0
					end

					if var_465_2.prefab_name ~= "" and arg_462_1.actors_[var_465_2.prefab_name] ~= nil then
						local var_465_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_2.prefab_name].transform, "story_v_out_420051", "420051110", "story_v_out_420051.awb")

						arg_462_1:RecordAudio("420051110", var_465_7)
						arg_462_1:RecordAudio("420051110", var_465_7)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_420051", "420051110", "story_v_out_420051.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_420051", "420051110", "story_v_out_420051.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_8 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_8 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_8

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_8 and arg_462_1.time_ < var_465_0 + var_465_8 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play420051111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 420051111
		arg_466_1.duration_ = 12.03

		local var_466_0 = {
			zh = 8.7,
			ja = 12.033
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
				arg_466_0:Play420051112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["404001ui_story"]) and arg_466_1.var_.characterEffect404001ui_story == nil then
				arg_466_1.var_.characterEffect404001ui_story = arg_466_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["404001ui_story"]) then
				if arg_466_1.var_.characterEffect404001ui_story and not isNil(arg_466_1.actors_["404001ui_story"]) then
					arg_466_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["404001ui_story"]) and arg_466_1.var_.characterEffect404001ui_story then
				arg_466_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_469_2 = arg_466_1.actors_["1085ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_2) and arg_466_1.var_.characterEffect1085ui_story == nil then
				arg_466_1.var_.characterEffect1085ui_story = var_469_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_3 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_3 and not isNil(var_469_2) then
				if arg_466_1.var_.characterEffect1085ui_story and not isNil(var_469_2) then
					arg_466_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_3)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_3 and arg_466_1.time_ < 0 + var_469_3 + arg_469_0 and not isNil(var_469_2) and arg_466_1.var_.characterEffect1085ui_story then
				arg_466_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_469_4 = 0
			local var_469_5 = 1.05

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_4 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_6 = arg_466_1:GetWordFromCfg(420051111)
				local var_469_7 = arg_466_1:FormatText(var_469_6.content)

				arg_466_1.text_.text = var_469_7

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_9 = 42 <= 0 and var_469_5 or var_469_5 * (utf8.len(var_469_7) / 42)

				if (42 <= 0 and var_469_5 or var_469_5 * (utf8.len(var_469_7) / 42)) > 0 and var_469_5 < var_469_9 then
					arg_466_1.talkMaxDuration = var_469_9

					if var_469_9 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_9 + var_469_4
					end
				end

				arg_466_1.text_.text = var_469_7
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051111", "story_v_out_420051.awb") ~= 0 then
					local var_469_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051111", "story_v_out_420051.awb") / 1000

					if var_469_10 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_10 + var_469_4
					end

					if var_469_6.prefab_name ~= "" and arg_466_1.actors_[var_469_6.prefab_name] ~= nil then
						local var_469_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_6.prefab_name].transform, "story_v_out_420051", "420051111", "story_v_out_420051.awb")

						arg_466_1:RecordAudio("420051111", var_469_11)
						arg_466_1:RecordAudio("420051111", var_469_11)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_420051", "420051111", "story_v_out_420051.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_420051", "420051111", "story_v_out_420051.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_12 = math.max(var_469_5, arg_466_1.talkMaxDuration)

			if var_469_4 <= arg_466_1.time_ and arg_466_1.time_ < var_469_4 + var_469_12 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_4) / var_469_12

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_4 + var_469_12 and arg_466_1.time_ < var_469_4 + var_469_12 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play420051112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 420051112
		arg_470_1.duration_ = 4.97

		local var_470_0 = {
			zh = 3.266,
			ja = 4.966
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play420051113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.35

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_1 = arg_470_1:GetWordFromCfg(420051112)
				local var_473_2 = arg_470_1:FormatText(var_473_1.content)

				arg_470_1.text_.text = var_473_2

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 14 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 14)

				if (14 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 14)) > 0 and var_473_0 < var_473_4 then
					arg_470_1.talkMaxDuration = var_473_4

					if var_473_4 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_4 + 0
					end
				end

				arg_470_1.text_.text = var_473_2
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051112", "story_v_out_420051.awb") ~= 0 then
					local var_473_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051112", "story_v_out_420051.awb") / 1000

					if var_473_5 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + 0
					end

					if var_473_1.prefab_name ~= "" and arg_470_1.actors_[var_473_1.prefab_name] ~= nil then
						local var_473_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_1.prefab_name].transform, "story_v_out_420051", "420051112", "story_v_out_420051.awb")

						arg_470_1:RecordAudio("420051112", var_473_6)
						arg_470_1:RecordAudio("420051112", var_473_6)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_420051", "420051112", "story_v_out_420051.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_420051", "420051112", "story_v_out_420051.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_7 and arg_470_1.time_ < 0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play420051113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 420051113
		arg_474_1.duration_ = 4.4

		local var_474_0 = {
			zh = 4.4,
			ja = 3.9
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play420051114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(arg_474_1.actors_["1085ui_story"]) and arg_474_1.var_.characterEffect1085ui_story == nil then
				arg_474_1.var_.characterEffect1085ui_story = arg_474_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_0 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 and not isNil(arg_474_1.actors_["1085ui_story"]) then
				if arg_474_1.var_.characterEffect1085ui_story and not isNil(arg_474_1.actors_["1085ui_story"]) then
					arg_474_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 and not isNil(arg_474_1.actors_["1085ui_story"]) and arg_474_1.var_.characterEffect1085ui_story then
				arg_474_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_477_2 = arg_474_1.actors_["404001ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_2) and arg_474_1.var_.characterEffect404001ui_story == nil then
				arg_474_1.var_.characterEffect404001ui_story = var_477_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_3 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_3 and not isNil(var_477_2) then
				if arg_474_1.var_.characterEffect404001ui_story and not isNil(var_477_2) then
					arg_474_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_474_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 0) / var_477_3)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_3 and arg_474_1.time_ < 0 + var_477_3 + arg_477_0 and not isNil(var_477_2) and arg_474_1.var_.characterEffect404001ui_story then
				arg_474_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_474_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_477_4 = 0
			local var_477_5 = 0.3

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_6 = arg_474_1:GetWordFromCfg(420051113)
				local var_477_7 = arg_474_1:FormatText(var_477_6.content)

				arg_474_1.text_.text = var_477_7

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_9 = 12 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 12)

				if (12 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 12)) > 0 and var_477_5 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_4
					end
				end

				arg_474_1.text_.text = var_477_7
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051113", "story_v_out_420051.awb") ~= 0 then
					local var_477_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051113", "story_v_out_420051.awb") / 1000

					if var_477_10 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_10 + var_477_4
					end

					if var_477_6.prefab_name ~= "" and arg_474_1.actors_[var_477_6.prefab_name] ~= nil then
						local var_477_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_6.prefab_name].transform, "story_v_out_420051", "420051113", "story_v_out_420051.awb")

						arg_474_1:RecordAudio("420051113", var_477_11)
						arg_474_1:RecordAudio("420051113", var_477_11)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_420051", "420051113", "story_v_out_420051.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_420051", "420051113", "story_v_out_420051.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_12 = math.max(var_477_5, arg_474_1.talkMaxDuration)

			if var_477_4 <= arg_474_1.time_ and arg_474_1.time_ < var_477_4 + var_477_12 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_4) / var_477_12

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_4 + var_477_12 and arg_474_1.time_ < var_477_4 + var_477_12 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play420051114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 420051114
		arg_478_1.duration_ = 8.73

		local var_478_0 = {
			zh = 7.9,
			ja = 8.733
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play420051115(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["404001ui_story"]) and arg_478_1.var_.characterEffect404001ui_story == nil then
				arg_478_1.var_.characterEffect404001ui_story = arg_478_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_0 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["404001ui_story"]) then
				if arg_478_1.var_.characterEffect404001ui_story and not isNil(arg_478_1.actors_["404001ui_story"]) then
					arg_478_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["404001ui_story"]) and arg_478_1.var_.characterEffect404001ui_story then
				arg_478_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_481_2 = arg_478_1.actors_["1085ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.characterEffect1085ui_story == nil then
				arg_478_1.var_.characterEffect1085ui_story = var_481_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_3 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_3 and not isNil(var_481_2) then
				if arg_478_1.var_.characterEffect1085ui_story and not isNil(var_481_2) then
					arg_478_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_3)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_3 and arg_478_1.time_ < 0 + var_481_3 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.characterEffect1085ui_story then
				arg_478_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_481_4 = 0
			local var_481_5 = 0.925

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_4 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_6 = arg_478_1:GetWordFromCfg(420051114)
				local var_481_7 = arg_478_1:FormatText(var_481_6.content)

				arg_478_1.text_.text = var_481_7

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_9 = 37 <= 0 and var_481_5 or var_481_5 * (utf8.len(var_481_7) / 37)

				if (37 <= 0 and var_481_5 or var_481_5 * (utf8.len(var_481_7) / 37)) > 0 and var_481_5 < var_481_9 then
					arg_478_1.talkMaxDuration = var_481_9

					if var_481_9 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_9 + var_481_4
					end
				end

				arg_478_1.text_.text = var_481_7
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051114", "story_v_out_420051.awb") ~= 0 then
					local var_481_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051114", "story_v_out_420051.awb") / 1000

					if var_481_10 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_10 + var_481_4
					end

					if var_481_6.prefab_name ~= "" and arg_478_1.actors_[var_481_6.prefab_name] ~= nil then
						local var_481_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_6.prefab_name].transform, "story_v_out_420051", "420051114", "story_v_out_420051.awb")

						arg_478_1:RecordAudio("420051114", var_481_11)
						arg_478_1:RecordAudio("420051114", var_481_11)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_420051", "420051114", "story_v_out_420051.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_420051", "420051114", "story_v_out_420051.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_12 = math.max(var_481_5, arg_478_1.talkMaxDuration)

			if var_481_4 <= arg_478_1.time_ and arg_478_1.time_ < var_481_4 + var_481_12 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_4) / var_481_12

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_4 + var_481_12 and arg_478_1.time_ < var_481_4 + var_481_12 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play420051115 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 420051115
		arg_482_1.duration_ = 5.67

		local var_482_0 = {
			zh = 4.933,
			ja = 5.666
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play420051116(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.55

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_1 = arg_482_1:GetWordFromCfg(420051115)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 22 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 22)

				if (22 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 22)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051115", "story_v_out_420051.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051115", "story_v_out_420051.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_out_420051", "420051115", "story_v_out_420051.awb")

						arg_482_1:RecordAudio("420051115", var_485_6)
						arg_482_1:RecordAudio("420051115", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_420051", "420051115", "story_v_out_420051.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_420051", "420051115", "story_v_out_420051.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play420051116 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 420051116
		arg_486_1.duration_ = 15.7

		local var_486_0 = {
			zh = 10.3,
			ja = 15.7
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play420051117(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 1.225

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_1 = arg_486_1:GetWordFromCfg(420051116)
				local var_489_2 = arg_486_1:FormatText(var_489_1.content)

				arg_486_1.text_.text = var_489_2

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 49 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 49)

				if (49 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 49)) > 0 and var_489_0 < var_489_4 then
					arg_486_1.talkMaxDuration = var_489_4

					if var_489_4 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_4 + 0
					end
				end

				arg_486_1.text_.text = var_489_2
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051116", "story_v_out_420051.awb") ~= 0 then
					local var_489_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051116", "story_v_out_420051.awb") / 1000

					if var_489_5 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + 0
					end

					if var_489_1.prefab_name ~= "" and arg_486_1.actors_[var_489_1.prefab_name] ~= nil then
						local var_489_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_1.prefab_name].transform, "story_v_out_420051", "420051116", "story_v_out_420051.awb")

						arg_486_1:RecordAudio("420051116", var_489_6)
						arg_486_1:RecordAudio("420051116", var_489_6)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_420051", "420051116", "story_v_out_420051.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_420051", "420051116", "story_v_out_420051.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_7 and arg_486_1.time_ < 0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play420051117 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 420051117
		arg_490_1.duration_ = 4.4

		local var_490_0 = {
			zh = 3.533,
			ja = 4.4
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play420051118(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_493_0 = 0
			local var_493_1 = 0.4

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_2 = arg_490_1:GetWordFromCfg(420051117)
				local var_493_3 = arg_490_1:FormatText(var_493_2.content)

				arg_490_1.text_.text = var_493_3

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 16 <= 0 and var_493_1 or var_493_1 * (utf8.len(var_493_3) / 16)

				if (16 <= 0 and var_493_1 or var_493_1 * (utf8.len(var_493_3) / 16)) > 0 and var_493_1 < var_493_5 then
					arg_490_1.talkMaxDuration = var_493_5

					if var_493_5 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_3
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051117", "story_v_out_420051.awb") ~= 0 then
					local var_493_6 = manager.audio:GetVoiceLength("story_v_out_420051", "420051117", "story_v_out_420051.awb") / 1000

					if var_493_6 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_6 + var_493_0
					end

					if var_493_2.prefab_name ~= "" and arg_490_1.actors_[var_493_2.prefab_name] ~= nil then
						local var_493_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_2.prefab_name].transform, "story_v_out_420051", "420051117", "story_v_out_420051.awb")

						arg_490_1:RecordAudio("420051117", var_493_7)
						arg_490_1:RecordAudio("420051117", var_493_7)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_420051", "420051117", "story_v_out_420051.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_420051", "420051117", "story_v_out_420051.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_8 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_8 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_8

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_8 and arg_490_1.time_ < var_493_0 + var_493_8 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play420051118 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 420051118
		arg_494_1.duration_ = 7

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play420051119(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 2 < arg_494_1.time_ and arg_494_1.time_ <= 2 + arg_497_0 then
				local var_497_0 = arg_494_1.bgs_.ST0505

				arg_494_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_497_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_497_1 = var_497_0:GetComponent("SpriteRenderer")

				if var_497_1 and var_497_1.sprite then
					local var_497_2 = 2 * (var_497_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_497_0.transform.localScale = Vector3.New(var_497_2 / var_497_1.sprite.bounds.size.y < var_497_2 * manager.ui.mainCameraCom_.aspect / var_497_1.sprite.bounds.size.x and var_497_2 * manager.ui.mainCameraCom_.aspect / var_497_1.sprite.bounds.size.x or var_497_2 / var_497_1.sprite.bounds.size.y, var_497_2 / var_497_1.sprite.bounds.size.y < var_497_2 * manager.ui.mainCameraCom_.aspect / var_497_1.sprite.bounds.size.x and var_497_2 * manager.ui.mainCameraCom_.aspect / var_497_1.sprite.bounds.size.x or var_497_2 / var_497_1.sprite.bounds.size.y, 0)
				end

				for iter_497_0, iter_497_1 in pairs(arg_494_1.bgs_) do
					if iter_497_0 ~= "ST0505" then
						iter_497_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_497_3 = 4

			if 4 < arg_494_1.time_ and arg_494_1.time_ <= var_497_3 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			if arg_494_1.time_ >= var_497_3 + 0.3 and arg_494_1.time_ < var_497_3 + 0.3 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			local var_497_4 = 0

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_5 = 2

			if var_497_4 <= arg_494_1.time_ and arg_494_1.time_ < var_497_4 + var_497_5 then
				local var_497_6 = Color.New(0, 0, 0)

				var_497_6.a = Mathf.Lerp(0, 1, (arg_494_1.time_ - var_497_4) / var_497_5)
				arg_494_1.mask_.color = var_497_6
			end

			if arg_494_1.time_ >= var_497_4 + var_497_5 and arg_494_1.time_ < var_497_4 + var_497_5 + arg_497_0 then
				local var_497_7 = Color.New(0, 0, 0)

				var_497_7.a = 1
				arg_494_1.mask_.color = var_497_7
			end

			local var_497_8 = 2

			if 2 < arg_494_1.time_ and arg_494_1.time_ <= var_497_8 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_9 = 2

			if var_497_8 <= arg_494_1.time_ and arg_494_1.time_ < var_497_8 + var_497_9 then
				local var_497_10 = Color.New(0, 0, 0)

				var_497_10.a = Mathf.Lerp(1, 0, (arg_494_1.time_ - var_497_8) / var_497_9)
				arg_494_1.mask_.color = var_497_10
			end

			if arg_494_1.time_ >= var_497_8 + var_497_9 and arg_494_1.time_ < var_497_8 + var_497_9 + arg_497_0 then
				local var_497_11 = Color.New(0, 0, 0)

				arg_494_1.mask_.enabled = false
				var_497_11.a = 0
				arg_494_1.mask_.color = var_497_11
			end

			local var_497_12 = arg_494_1.actors_["404001ui_story"].transform

			if 2 < arg_494_1.time_ and arg_494_1.time_ <= 2 + arg_497_0 then
				arg_494_1.var_.moveOldPos404001ui_story = var_497_12.localPosition
			end

			local var_497_13 = 0.001

			if 2 <= arg_494_1.time_ and arg_494_1.time_ < 2 + var_497_13 then
				var_497_12.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_494_1.time_ - 2) / var_497_13)
				var_497_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_12.position).x, (manager.ui.mainCamera.transform.position - var_497_12.position).y, (manager.ui.mainCamera.transform.position - var_497_12.position).z)
				var_497_12.localEulerAngles.z = 0
				var_497_12.localEulerAngles.x = 0
				var_497_12.localEulerAngles = var_497_12.localEulerAngles
			end

			if arg_494_1.time_ >= 2 + var_497_13 and arg_494_1.time_ < 2 + var_497_13 + arg_497_0 then
				var_497_12.localPosition = Vector3.New(0, 100, 0)
				var_497_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_12.position).x, (manager.ui.mainCamera.transform.position - var_497_12.position).y, (manager.ui.mainCamera.transform.position - var_497_12.position).z)
				var_497_12.localEulerAngles.z = 0
				var_497_12.localEulerAngles.x = 0
				var_497_12.localEulerAngles = var_497_12.localEulerAngles
			end

			local var_497_14 = arg_494_1.actors_["1085ui_story"].transform

			if 2 < arg_494_1.time_ and arg_494_1.time_ <= 2 + arg_497_0 then
				arg_494_1.var_.moveOldPos1085ui_story = var_497_14.localPosition
			end

			local var_497_15 = 0.001

			if 2 <= arg_494_1.time_ and arg_494_1.time_ < 2 + var_497_15 then
				var_497_14.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_494_1.time_ - 2) / var_497_15)
				var_497_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_14.position).x, (manager.ui.mainCamera.transform.position - var_497_14.position).y, (manager.ui.mainCamera.transform.position - var_497_14.position).z)
				var_497_14.localEulerAngles.z = 0
				var_497_14.localEulerAngles.x = 0
				var_497_14.localEulerAngles = var_497_14.localEulerAngles
			end

			if arg_494_1.time_ >= 2 + var_497_15 and arg_494_1.time_ < 2 + var_497_15 + arg_497_0 then
				var_497_14.localPosition = Vector3.New(0, 100, 0)
				var_497_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_14.position).x, (manager.ui.mainCamera.transform.position - var_497_14.position).y, (manager.ui.mainCamera.transform.position - var_497_14.position).z)
				var_497_14.localEulerAngles.z = 0
				var_497_14.localEulerAngles.x = 0
				var_497_14.localEulerAngles = var_497_14.localEulerAngles
			end

			local var_497_16 = arg_494_1.actors_["404001ui_story"].transform

			if 3.9 < arg_494_1.time_ and arg_494_1.time_ <= 3.9 + arg_497_0 then
				arg_494_1.var_.moveOldPos404001ui_story = var_497_16.localPosition
			end

			local var_497_17 = 0.001

			if 3.9 <= arg_494_1.time_ and arg_494_1.time_ < 3.9 + var_497_17 then
				var_497_16.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_494_1.time_ - 3.9) / var_497_17)
				var_497_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_16.position).x, (manager.ui.mainCamera.transform.position - var_497_16.position).y, (manager.ui.mainCamera.transform.position - var_497_16.position).z)
				var_497_16.localEulerAngles.z = 0
				var_497_16.localEulerAngles.x = 0
				var_497_16.localEulerAngles = var_497_16.localEulerAngles
			end

			if arg_494_1.time_ >= 3.9 + var_497_17 and arg_494_1.time_ < 3.9 + var_497_17 + arg_497_0 then
				var_497_16.localPosition = Vector3.New(0, -1.55, -5.5)
				var_497_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_497_16.position).x, (manager.ui.mainCamera.transform.position - var_497_16.position).y, (manager.ui.mainCamera.transform.position - var_497_16.position).z)
				var_497_16.localEulerAngles.z = 0
				var_497_16.localEulerAngles.x = 0
				var_497_16.localEulerAngles = var_497_16.localEulerAngles
			end

			local var_497_18 = arg_494_1.actors_["404001ui_story"]

			if 3.9 < arg_494_1.time_ and arg_494_1.time_ <= 3.9 + arg_497_0 and not isNil(var_497_18) and arg_494_1.var_.characterEffect404001ui_story == nil then
				arg_494_1.var_.characterEffect404001ui_story = var_497_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_19 = 0.200000002980232

			if 3.9 <= arg_494_1.time_ and arg_494_1.time_ < 3.9 + var_497_19 and not isNil(var_497_18) then
				if arg_494_1.var_.characterEffect404001ui_story and not isNil(var_497_18) then
					arg_494_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= 3.9 + var_497_19 and arg_494_1.time_ < 3.9 + var_497_19 + arg_497_0 and not isNil(var_497_18) and arg_494_1.var_.characterEffect404001ui_story then
				arg_494_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 3.9 < arg_494_1.time_ and arg_494_1.time_ <= 3.9 + arg_497_0 then
				arg_494_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 3.9 < arg_494_1.time_ and arg_494_1.time_ <= 3.9 + arg_497_0 then
				arg_494_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 3.93400000184774 < arg_494_1.time_ and arg_494_1.time_ <= 3.93400000184774 + arg_497_0 then
				arg_494_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_497_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_494_1.bgmTxt_.text ~= var_497_24 and arg_494_1.bgmTxt_.text ~= "" then
						if arg_494_1.bgmTxt2_.text ~= "" then
							arg_494_1.bgmTxt_.text = arg_494_1.bgmTxt2_.text
						end

						arg_494_1.bgmTxt2_.text = var_497_24

						arg_494_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_494_1.bgmTxt_.text = var_497_24
						arg_494_1.bgmTxt2_.text = var_497_24
					end

					if arg_494_1.bgmTimer then
						arg_494_1.bgmTimer:Stop()

						arg_494_1.bgmTimer = nil
					end

					if arg_494_1.settingData.show_music_name == 1 then
						arg_494_1.musicController:SetSelectedState("show")
						arg_494_1.musicAnimator_:Play("open", 0, 0)

						if arg_494_1.settingData.music_time ~= 0 then
							arg_494_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_494_1.settingData.music_time), function()
								if arg_494_1 == nil or isNil(arg_494_1.bgmTxt_) then
									return
								end

								arg_494_1.musicController:SetSelectedState("hide")
								arg_494_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_494_1.time_ and arg_494_1.time_ <= 1.53333333333333 + arg_497_0 then
				arg_494_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_494_1.frameCnt_ <= 1 then
				arg_494_1.dialog_:SetActive(false)
			end

			local var_497_26 = 4
			local var_497_27 = 0.25

			if 4 < arg_494_1.time_ and arg_494_1.time_ <= var_497_26 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0

				arg_494_1.dialog_:SetActive(true)

				arg_494_1.dialogCg_.alpha = 0

				local var_497_28 = LeanTween.value(arg_494_1.dialog_, 0, 1, 0.3)

				var_497_28:setOnUpdate(LuaHelper.FloatAction(function(arg_499_0)
					arg_494_1.dialogCg_.alpha = arg_499_0
				end))
				var_497_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_494_1.dialog_)
					var_497_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_494_1.duration_ = arg_494_1.duration_ + 0.3

				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_29 = arg_494_1:GetWordFromCfg(420051118)
				local var_497_30 = arg_494_1:FormatText(var_497_29.content)

				arg_494_1.text_.text = var_497_30

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_32 = 10 <= 0 and var_497_27 or var_497_27 * (utf8.len(var_497_30) / 10)

				if (10 <= 0 and var_497_27 or var_497_27 * (utf8.len(var_497_30) / 10)) > 0 and var_497_27 < var_497_32 then
					arg_494_1.talkMaxDuration = var_497_32
					var_497_26 = var_497_26 + 0.3

					if var_497_32 + var_497_26 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_32 + var_497_26
					end
				end

				arg_494_1.text_.text = var_497_30
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051118", "story_v_out_420051.awb") ~= 0 then
					local var_497_33 = manager.audio:GetVoiceLength("story_v_out_420051", "420051118", "story_v_out_420051.awb") / 1000

					if var_497_33 + var_497_26 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_33 + var_497_26
					end

					if var_497_29.prefab_name ~= "" and arg_494_1.actors_[var_497_29.prefab_name] ~= nil then
						local var_497_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_29.prefab_name].transform, "story_v_out_420051", "420051118", "story_v_out_420051.awb")

						arg_494_1:RecordAudio("420051118", var_497_34)
						arg_494_1:RecordAudio("420051118", var_497_34)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_420051", "420051118", "story_v_out_420051.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_420051", "420051118", "story_v_out_420051.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_35 = var_497_26 + 0.3
			local var_497_36 = math.max(var_497_27, arg_494_1.talkMaxDuration)

			if var_497_26 + 0.3 <= arg_494_1.time_ and arg_494_1.time_ < var_497_35 + var_497_36 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_35) / var_497_36

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_35 + var_497_36 and arg_494_1.time_ < var_497_35 + var_497_36 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play420051119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 420051119
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play420051120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos404001ui_story = arg_501_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["404001ui_story"].transform.position).z)
				arg_501_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["404001ui_story"].transform.localEulerAngles = arg_501_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_501_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["404001ui_story"].transform.position).z)
				arg_501_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["404001ui_story"].transform.localEulerAngles = arg_501_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_504_1 = 0
			local var_504_2 = 1

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_3 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(420051119).content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 40 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 40)

				if (40 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 40)) > 0 and var_504_2 < var_504_5 then
					arg_501_1.talkMaxDuration = var_504_5

					if var_504_5 + var_504_1 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + var_504_1
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_6 = math.max(var_504_2, arg_501_1.talkMaxDuration)

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_6 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_1) / var_504_6

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_1 + var_504_6 and arg_501_1.time_ < var_504_1 + var_504_6 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play420051120 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 420051120
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play420051121(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_508_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_505_1.bgmTxt_.text ~= var_508_2 and arg_505_1.bgmTxt_.text ~= "" then
						if arg_505_1.bgmTxt2_.text ~= "" then
							arg_505_1.bgmTxt_.text = arg_505_1.bgmTxt2_.text
						end

						arg_505_1.bgmTxt2_.text = var_508_2

						arg_505_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_505_1.bgmTxt_.text = var_508_2
						arg_505_1.bgmTxt2_.text = var_508_2
					end

					if arg_505_1.bgmTimer then
						arg_505_1.bgmTimer:Stop()

						arg_505_1.bgmTimer = nil
					end

					if arg_505_1.settingData.show_music_name == 1 then
						arg_505_1.musicController:SetSelectedState("show")
						arg_505_1.musicAnimator_:Play("open", 0, 0)

						if arg_505_1.settingData.music_time ~= 0 then
							arg_505_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_505_1.settingData.music_time), function()
								if arg_505_1 == nil or isNil(arg_505_1.bgmTxt_) then
									return
								end

								arg_505_1.musicController:SetSelectedState("hide")
								arg_505_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_505_1.time_ and arg_505_1.time_ <= 0.333333333333333 + arg_508_0 then
				arg_505_1:AudioAction("play", "music", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_508_5 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if "" ~= "" then
					if arg_505_1.bgmTxt_.text ~= var_508_5 and arg_505_1.bgmTxt_.text ~= "" then
						if arg_505_1.bgmTxt2_.text ~= "" then
							arg_505_1.bgmTxt_.text = arg_505_1.bgmTxt2_.text
						end

						arg_505_1.bgmTxt2_.text = var_508_5

						arg_505_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_505_1.bgmTxt_.text = var_508_5
						arg_505_1.bgmTxt2_.text = var_508_5
					end

					if arg_505_1.bgmTimer then
						arg_505_1.bgmTimer:Stop()

						arg_505_1.bgmTimer = nil
					end

					if arg_505_1.settingData.show_music_name == 1 then
						arg_505_1.musicController:SetSelectedState("show")
						arg_505_1.musicAnimator_:Play("open", 0, 0)

						if arg_505_1.settingData.music_time ~= 0 then
							arg_505_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_505_1.settingData.music_time), function()
								if arg_505_1 == nil or isNil(arg_505_1.bgmTxt_) then
									return
								end

								arg_505_1.musicController:SetSelectedState("hide")
								arg_505_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_508_6 = 0
			local var_508_7 = 0.575

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_8 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(420051120).content)

				arg_505_1.text_.text = var_508_8

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_10 = 23 <= 0 and var_508_7 or var_508_7 * (utf8.len(var_508_8) / 23)

				if (23 <= 0 and var_508_7 or var_508_7 * (utf8.len(var_508_8) / 23)) > 0 and var_508_7 < var_508_10 then
					arg_505_1.talkMaxDuration = var_508_10

					if var_508_10 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_10 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_8
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_11 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_11 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_11

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_11 and arg_505_1.time_ < var_508_6 + var_508_11 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play420051121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 420051121
		arg_511_1.duration_ = 5.03

		local var_511_0 = {
			zh = 3.666,
			ja = 5.033
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play420051122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos404001ui_story = arg_511_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["404001ui_story"].transform.position).z)
				arg_511_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["404001ui_story"].transform.localEulerAngles = arg_511_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_511_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["404001ui_story"].transform.position).z)
				arg_511_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["404001ui_story"].transform.localEulerAngles = arg_511_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_514_1 = arg_511_1.actors_["404001ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect404001ui_story == nil then
				arg_511_1.var_.characterEffect404001ui_story = var_514_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_2 and not isNil(var_514_1) then
				if arg_511_1.var_.characterEffect404001ui_story and not isNil(var_514_1) then
					arg_511_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_2 and arg_511_1.time_ < 0 + var_514_2 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect404001ui_story then
				arg_511_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_514_4 = 0
			local var_514_5 = 0.4

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_6 = arg_511_1:GetWordFromCfg(420051121)
				local var_514_7 = arg_511_1:FormatText(var_514_6.content)

				arg_511_1.text_.text = var_514_7

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_9 = 16 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 16)

				if (16 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 16)) > 0 and var_514_5 < var_514_9 then
					arg_511_1.talkMaxDuration = var_514_9

					if var_514_9 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_9 + var_514_4
					end
				end

				arg_511_1.text_.text = var_514_7
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051121", "story_v_out_420051.awb") ~= 0 then
					local var_514_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051121", "story_v_out_420051.awb") / 1000

					if var_514_10 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_10 + var_514_4
					end

					if var_514_6.prefab_name ~= "" and arg_511_1.actors_[var_514_6.prefab_name] ~= nil then
						local var_514_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_6.prefab_name].transform, "story_v_out_420051", "420051121", "story_v_out_420051.awb")

						arg_511_1:RecordAudio("420051121", var_514_11)
						arg_511_1:RecordAudio("420051121", var_514_11)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_420051", "420051121", "story_v_out_420051.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_420051", "420051121", "story_v_out_420051.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_12 = math.max(var_514_5, arg_511_1.talkMaxDuration)

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_12 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_4) / var_514_12

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_4 + var_514_12 and arg_511_1.time_ < var_514_4 + var_514_12 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play420051122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 420051122
		arg_515_1.duration_ = 3.63

		local var_515_0 = {
			zh = 2.5,
			ja = 3.633
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play420051123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos404001ui_story = arg_515_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["404001ui_story"].transform.position).z)
				arg_515_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["404001ui_story"].transform.localEulerAngles = arg_515_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_515_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["404001ui_story"].transform.position).z)
				arg_515_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["404001ui_story"].transform.localEulerAngles = arg_515_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1085ui_story"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1085ui_story = var_518_1.localPosition
			end

			local var_518_2 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 then
				var_518_1.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_515_1.time_ - 0) / var_518_2)
				var_518_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_1.position).x, (manager.ui.mainCamera.transform.position - var_518_1.position).y, (manager.ui.mainCamera.transform.position - var_518_1.position).z)
				var_518_1.localEulerAngles.z = 0
				var_518_1.localEulerAngles.x = 0
				var_518_1.localEulerAngles = var_518_1.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 then
				var_518_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_518_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_1.position).x, (manager.ui.mainCamera.transform.position - var_518_1.position).y, (manager.ui.mainCamera.transform.position - var_518_1.position).z)
				var_518_1.localEulerAngles.z = 0
				var_518_1.localEulerAngles.x = 0
				var_518_1.localEulerAngles = var_518_1.localEulerAngles
			end

			local var_518_3 = arg_515_1.actors_["1085ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_3) and arg_515_1.var_.characterEffect1085ui_story == nil then
				arg_515_1.var_.characterEffect1085ui_story = var_518_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_4 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 and not isNil(var_518_3) then
				if arg_515_1.var_.characterEffect1085ui_story and not isNil(var_518_3) then
					arg_515_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 and not isNil(var_518_3) and arg_515_1.var_.characterEffect1085ui_story then
				arg_515_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_518_6 = arg_515_1.actors_["404001ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_6) and arg_515_1.var_.characterEffect404001ui_story == nil then
				arg_515_1.var_.characterEffect404001ui_story = var_518_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_7 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 and not isNil(var_518_6) then
				if arg_515_1.var_.characterEffect404001ui_story and not isNil(var_518_6) then
					arg_515_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_515_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_7)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 and not isNil(var_518_6) and arg_515_1.var_.characterEffect404001ui_story then
				arg_515_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_515_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_518_8 = 0
			local var_518_9 = 0.275

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_8 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_10 = arg_515_1:GetWordFromCfg(420051122)
				local var_518_11 = arg_515_1:FormatText(var_518_10.content)

				arg_515_1.text_.text = var_518_11

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_13 = 11 <= 0 and var_518_9 or var_518_9 * (utf8.len(var_518_11) / 11)

				if (11 <= 0 and var_518_9 or var_518_9 * (utf8.len(var_518_11) / 11)) > 0 and var_518_9 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_8 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_8
					end
				end

				arg_515_1.text_.text = var_518_11
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051122", "story_v_out_420051.awb") ~= 0 then
					local var_518_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051122", "story_v_out_420051.awb") / 1000

					if var_518_14 + var_518_8 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_14 + var_518_8
					end

					if var_518_10.prefab_name ~= "" and arg_515_1.actors_[var_518_10.prefab_name] ~= nil then
						local var_518_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_10.prefab_name].transform, "story_v_out_420051", "420051122", "story_v_out_420051.awb")

						arg_515_1:RecordAudio("420051122", var_518_15)
						arg_515_1:RecordAudio("420051122", var_518_15)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_420051", "420051122", "story_v_out_420051.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_420051", "420051122", "story_v_out_420051.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_16 = math.max(var_518_9, arg_515_1.talkMaxDuration)

			if var_518_8 <= arg_515_1.time_ and arg_515_1.time_ < var_518_8 + var_518_16 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_8) / var_518_16

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_8 + var_518_16 and arg_515_1.time_ < var_518_8 + var_518_16 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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

		arg_515_1:InitPlayNodeList()
	end,
	Play420051123 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 420051123
		arg_519_1.duration_ = 1.87

		local var_519_0 = {
			zh = 1.1,
			ja = 1.866
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play420051124(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["404001ui_story"]) and arg_519_1.var_.characterEffect404001ui_story == nil then
				arg_519_1.var_.characterEffect404001ui_story = arg_519_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_0 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["404001ui_story"]) then
				if arg_519_1.var_.characterEffect404001ui_story and not isNil(arg_519_1.actors_["404001ui_story"]) then
					arg_519_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["404001ui_story"]) and arg_519_1.var_.characterEffect404001ui_story then
				arg_519_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_522_2 = arg_519_1.actors_["1085ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.characterEffect1085ui_story == nil then
				arg_519_1.var_.characterEffect1085ui_story = var_522_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_3 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_3 and not isNil(var_522_2) then
				if arg_519_1.var_.characterEffect1085ui_story and not isNil(var_522_2) then
					arg_519_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_3)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_3 and arg_519_1.time_ < 0 + var_522_3 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.characterEffect1085ui_story then
				arg_519_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_522_4 = 0
			local var_522_5 = 0.125

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_6 = arg_519_1:GetWordFromCfg(420051123)
				local var_522_7 = arg_519_1:FormatText(var_522_6.content)

				arg_519_1.text_.text = var_522_7

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_9 = 5 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 5)

				if (5 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 5)) > 0 and var_522_5 < var_522_9 then
					arg_519_1.talkMaxDuration = var_522_9

					if var_522_9 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_9 + var_522_4
					end
				end

				arg_519_1.text_.text = var_522_7
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051123", "story_v_out_420051.awb") ~= 0 then
					local var_522_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051123", "story_v_out_420051.awb") / 1000

					if var_522_10 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_10 + var_522_4
					end

					if var_522_6.prefab_name ~= "" and arg_519_1.actors_[var_522_6.prefab_name] ~= nil then
						local var_522_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_6.prefab_name].transform, "story_v_out_420051", "420051123", "story_v_out_420051.awb")

						arg_519_1:RecordAudio("420051123", var_522_11)
						arg_519_1:RecordAudio("420051123", var_522_11)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_420051", "420051123", "story_v_out_420051.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_420051", "420051123", "story_v_out_420051.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_12 = math.max(var_522_5, arg_519_1.talkMaxDuration)

			if var_522_4 <= arg_519_1.time_ and arg_519_1.time_ < var_522_4 + var_522_12 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_4) / var_522_12

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_4 + var_522_12 and arg_519_1.time_ < var_522_4 + var_522_12 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play420051124 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 420051124
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play420051125(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["404001ui_story"]) and arg_523_1.var_.characterEffect404001ui_story == nil then
				arg_523_1.var_.characterEffect404001ui_story = arg_523_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["404001ui_story"]) then
				if arg_523_1.var_.characterEffect404001ui_story and not isNil(arg_523_1.actors_["404001ui_story"]) then
					arg_523_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_523_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["404001ui_story"]) and arg_523_1.var_.characterEffect404001ui_story then
				arg_523_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_523_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 1.55

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(420051124).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 62 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 62)

				if (62 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 62)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play420051125 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 420051125
		arg_527_1.duration_ = 5.4

		local var_527_0 = {
			zh = 4.933,
			ja = 5.4
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play420051126(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["1085ui_story"]) and arg_527_1.var_.characterEffect1085ui_story == nil then
				arg_527_1.var_.characterEffect1085ui_story = arg_527_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["1085ui_story"]) then
				if arg_527_1.var_.characterEffect1085ui_story and not isNil(arg_527_1.actors_["1085ui_story"]) then
					arg_527_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["1085ui_story"]) and arg_527_1.var_.characterEffect1085ui_story then
				arg_527_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_530_2 = 0
			local var_530_3 = 0.3

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_2 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_4 = arg_527_1:GetWordFromCfg(420051125)
				local var_530_5 = arg_527_1:FormatText(var_530_4.content)

				arg_527_1.text_.text = var_530_5

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_7 = 12 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 12)

				if (12 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 12)) > 0 and var_530_3 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_2
					end
				end

				arg_527_1.text_.text = var_530_5
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051125", "story_v_out_420051.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051125", "story_v_out_420051.awb") / 1000

					if var_530_8 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_2
					end

					if var_530_4.prefab_name ~= "" and arg_527_1.actors_[var_530_4.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_4.prefab_name].transform, "story_v_out_420051", "420051125", "story_v_out_420051.awb")

						arg_527_1:RecordAudio("420051125", var_530_9)
						arg_527_1:RecordAudio("420051125", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_420051", "420051125", "story_v_out_420051.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_420051", "420051125", "story_v_out_420051.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_3, arg_527_1.talkMaxDuration)

			if var_530_2 <= arg_527_1.time_ and arg_527_1.time_ < var_530_2 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_2) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_2 + var_530_10 and arg_527_1.time_ < var_530_2 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play420051126 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 420051126
		arg_531_1.duration_ = 4.87

		local var_531_0 = {
			zh = 2.7,
			ja = 4.866
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play420051127(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["404001ui_story"]) and arg_531_1.var_.characterEffect404001ui_story == nil then
				arg_531_1.var_.characterEffect404001ui_story = arg_531_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["404001ui_story"]) then
				if arg_531_1.var_.characterEffect404001ui_story and not isNil(arg_531_1.actors_["404001ui_story"]) then
					arg_531_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["404001ui_story"]) and arg_531_1.var_.characterEffect404001ui_story then
				arg_531_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_534_2 = arg_531_1.actors_["1085ui_story"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_2) and arg_531_1.var_.characterEffect1085ui_story == nil then
				arg_531_1.var_.characterEffect1085ui_story = var_534_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_3 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_3 and not isNil(var_534_2) then
				if arg_531_1.var_.characterEffect1085ui_story and not isNil(var_534_2) then
					arg_531_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_3)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_3 and arg_531_1.time_ < 0 + var_534_3 + arg_534_0 and not isNil(var_534_2) and arg_531_1.var_.characterEffect1085ui_story then
				arg_531_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_534_4 = 0
			local var_534_5 = 0.225

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_4 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_6 = arg_531_1:GetWordFromCfg(420051126)
				local var_534_7 = arg_531_1:FormatText(var_534_6.content)

				arg_531_1.text_.text = var_534_7

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_9 = 9 <= 0 and var_534_5 or var_534_5 * (utf8.len(var_534_7) / 9)

				if (9 <= 0 and var_534_5 or var_534_5 * (utf8.len(var_534_7) / 9)) > 0 and var_534_5 < var_534_9 then
					arg_531_1.talkMaxDuration = var_534_9

					if var_534_9 + var_534_4 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_9 + var_534_4
					end
				end

				arg_531_1.text_.text = var_534_7
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051126", "story_v_out_420051.awb") ~= 0 then
					local var_534_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051126", "story_v_out_420051.awb") / 1000

					if var_534_10 + var_534_4 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_10 + var_534_4
					end

					if var_534_6.prefab_name ~= "" and arg_531_1.actors_[var_534_6.prefab_name] ~= nil then
						local var_534_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_6.prefab_name].transform, "story_v_out_420051", "420051126", "story_v_out_420051.awb")

						arg_531_1:RecordAudio("420051126", var_534_11)
						arg_531_1:RecordAudio("420051126", var_534_11)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_420051", "420051126", "story_v_out_420051.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_420051", "420051126", "story_v_out_420051.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_12 = math.max(var_534_5, arg_531_1.talkMaxDuration)

			if var_534_4 <= arg_531_1.time_ and arg_531_1.time_ < var_534_4 + var_534_12 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_4) / var_534_12

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_4 + var_534_12 and arg_531_1.time_ < var_534_4 + var_534_12 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play420051127 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 420051127
		arg_535_1.duration_ = 6.83

		local var_535_0 = {
			zh = 6.033,
			ja = 6.833
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play420051128(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.675

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_1 = arg_535_1:GetWordFromCfg(420051127)
				local var_538_2 = arg_535_1:FormatText(var_538_1.content)

				arg_535_1.text_.text = var_538_2

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 27 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 27)

				if (27 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 27)) > 0 and var_538_0 < var_538_4 then
					arg_535_1.talkMaxDuration = var_538_4

					if var_538_4 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_4 + 0
					end
				end

				arg_535_1.text_.text = var_538_2
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051127", "story_v_out_420051.awb") ~= 0 then
					local var_538_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051127", "story_v_out_420051.awb") / 1000

					if var_538_5 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + 0
					end

					if var_538_1.prefab_name ~= "" and arg_535_1.actors_[var_538_1.prefab_name] ~= nil then
						local var_538_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_1.prefab_name].transform, "story_v_out_420051", "420051127", "story_v_out_420051.awb")

						arg_535_1:RecordAudio("420051127", var_538_6)
						arg_535_1:RecordAudio("420051127", var_538_6)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_420051", "420051127", "story_v_out_420051.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_420051", "420051127", "story_v_out_420051.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play420051128 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 420051128
		arg_539_1.duration_ = 4.1

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play420051129(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0.666666666666667 < arg_539_1.time_ and arg_539_1.time_ <= 0.666666666666667 + arg_542_0 then
				local var_542_0 = arg_539_1.bgs_.STwhite

				arg_539_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_542_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_542_1 = var_542_0:GetComponent("SpriteRenderer")

				if var_542_1 and var_542_1.sprite then
					local var_542_2 = 2 * (var_542_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_542_0.transform.localScale = Vector3.New(var_542_2 / var_542_1.sprite.bounds.size.y < var_542_2 * manager.ui.mainCameraCom_.aspect / var_542_1.sprite.bounds.size.x and var_542_2 * manager.ui.mainCameraCom_.aspect / var_542_1.sprite.bounds.size.x or var_542_2 / var_542_1.sprite.bounds.size.y, var_542_2 / var_542_1.sprite.bounds.size.y < var_542_2 * manager.ui.mainCameraCom_.aspect / var_542_1.sprite.bounds.size.x and var_542_2 * manager.ui.mainCameraCom_.aspect / var_542_1.sprite.bounds.size.x or var_542_2 / var_542_1.sprite.bounds.size.y, 0)
				end

				for iter_542_0, iter_542_1 in pairs(arg_539_1.bgs_) do
					if iter_542_0 ~= "STwhite" then
						iter_542_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_542_3 = 0

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_3 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_4 = 0.666666666666667

			if var_542_3 <= arg_539_1.time_ and arg_539_1.time_ < var_542_3 + var_542_4 then
				local var_542_5 = Color.New(0, 0, 0)

				var_542_5.a = Mathf.Lerp(0, 1, (arg_539_1.time_ - var_542_3) / var_542_4)
				arg_539_1.mask_.color = var_542_5
			end

			if arg_539_1.time_ >= var_542_3 + var_542_4 and arg_539_1.time_ < var_542_3 + var_542_4 + arg_542_0 then
				local var_542_6 = Color.New(0, 0, 0)

				var_542_6.a = 1
				arg_539_1.mask_.color = var_542_6
			end

			local var_542_7 = 0.666666666666667

			if 0.666666666666667 < arg_539_1.time_ and arg_539_1.time_ <= var_542_7 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_8 = 2

			if var_542_7 <= arg_539_1.time_ and arg_539_1.time_ < var_542_7 + var_542_8 then
				local var_542_9 = Color.New(0, 0, 0)

				var_542_9.a = Mathf.Lerp(1, 0, (arg_539_1.time_ - var_542_7) / var_542_8)
				arg_539_1.mask_.color = var_542_9
			end

			if arg_539_1.time_ >= var_542_7 + var_542_8 and arg_539_1.time_ < var_542_7 + var_542_8 + arg_542_0 then
				local var_542_10 = Color.New(0, 0, 0)

				arg_539_1.mask_.enabled = false
				var_542_10.a = 0
				arg_539_1.mask_.color = var_542_10
			end

			if 0.666666666666667 < arg_539_1.time_ and arg_539_1.time_ <= 0.666666666666667 + arg_542_0 then
				arg_539_1.cswbg_:SetActive(true)

				local var_542_11 = arg_539_1.cswt_:GetComponent("RectTransform")

				arg_539_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_542_11.offsetMin = Vector2.New(0, 0)
				var_542_11.offsetMax = Vector2.New(0, 130)
				arg_539_1.cswt_.text = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(419145).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.cswt_)

				arg_539_1.cswt_.fontSize = 120
				arg_539_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_539_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_539_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_542_12 = arg_539_1.actors_["1085ui_story"].transform

			if 0.666666666666667 < arg_539_1.time_ and arg_539_1.time_ <= 0.666666666666667 + arg_542_0 then
				arg_539_1.var_.moveOldPos1085ui_story = var_542_12.localPosition
			end

			local var_542_13 = 0.001

			if 0.666666666666667 <= arg_539_1.time_ and arg_539_1.time_ < 0.666666666666667 + var_542_13 then
				var_542_12.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_539_1.time_ - 0.666666666666667) / var_542_13)
				var_542_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_12.position).x, (manager.ui.mainCamera.transform.position - var_542_12.position).y, (manager.ui.mainCamera.transform.position - var_542_12.position).z)
				var_542_12.localEulerAngles.z = 0
				var_542_12.localEulerAngles.x = 0
				var_542_12.localEulerAngles = var_542_12.localEulerAngles
			end

			if arg_539_1.time_ >= 0.666666666666667 + var_542_13 and arg_539_1.time_ < 0.666666666666667 + var_542_13 + arg_542_0 then
				var_542_12.localPosition = Vector3.New(0, 100, 0)
				var_542_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_12.position).x, (manager.ui.mainCamera.transform.position - var_542_12.position).y, (manager.ui.mainCamera.transform.position - var_542_12.position).z)
				var_542_12.localEulerAngles.z = 0
				var_542_12.localEulerAngles.x = 0
				var_542_12.localEulerAngles = var_542_12.localEulerAngles
			end

			local var_542_14 = arg_539_1.actors_["404001ui_story"].transform

			if 0.666666666666667 < arg_539_1.time_ and arg_539_1.time_ <= 0.666666666666667 + arg_542_0 then
				arg_539_1.var_.moveOldPos404001ui_story = var_542_14.localPosition
			end

			local var_542_15 = 0.001

			if 0.666666666666667 <= arg_539_1.time_ and arg_539_1.time_ < 0.666666666666667 + var_542_15 then
				var_542_14.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_539_1.time_ - 0.666666666666667) / var_542_15)
				var_542_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_14.position).x, (manager.ui.mainCamera.transform.position - var_542_14.position).y, (manager.ui.mainCamera.transform.position - var_542_14.position).z)
				var_542_14.localEulerAngles.z = 0
				var_542_14.localEulerAngles.x = 0
				var_542_14.localEulerAngles = var_542_14.localEulerAngles
			end

			if arg_539_1.time_ >= 0.666666666666667 + var_542_15 and arg_539_1.time_ < 0.666666666666667 + var_542_15 + arg_542_0 then
				var_542_14.localPosition = Vector3.New(0, 100, 0)
				var_542_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_14.position).x, (manager.ui.mainCamera.transform.position - var_542_14.position).y, (manager.ui.mainCamera.transform.position - var_542_14.position).z)
				var_542_14.localEulerAngles.z = 0
				var_542_14.localEulerAngles.x = 0
				var_542_14.localEulerAngles = var_542_14.localEulerAngles
			end

			if 0.666666666666667 < arg_539_1.time_ and arg_539_1.time_ <= 0.666666666666667 + arg_542_0 then
				arg_539_1.fswbg_:SetActive(true)
				arg_539_1.dialog_:SetActive(false)

				arg_539_1.fswtw_.percent = 0
				arg_539_1.fswt_.text = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(420051128).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.fswt_)

				arg_539_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_539_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_539_1.fswtw_:SetDirty()

				arg_539_1.typewritterCharCountI18N = 0

				SetActive(arg_539_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_539_1:ShowNextGo(false)
			end

			local var_542_16 = 2.66666666666667

			if 2.66666666666667 < arg_539_1.time_ and arg_539_1.time_ <= var_542_16 + arg_542_0 then
				arg_539_1.var_.oldValueTypewriter = arg_539_1.fswtw_.percent

				SetActive(arg_539_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_539_1:ShowNextGo(false)
			end

			local var_542_17 = 4
			local var_542_18 = 0.266666666666667
			local var_542_19, var_542_20 = arg_539_1:GetPercentByPara(arg_539_1:FormatText(arg_539_1:GetWordFromCfg(420051128).content), 1)

			if var_542_16 < arg_539_1.time_ and arg_539_1.time_ <= var_542_16 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0

				local var_542_21 = var_542_17 <= 0 and var_542_18 or var_542_18 * ((var_542_20 - arg_539_1.typewritterCharCountI18N) / var_542_17)

				if (var_542_17 <= 0 and var_542_18 or var_542_18 * ((var_542_20 - arg_539_1.typewritterCharCountI18N) / var_542_17)) > 0 and var_542_18 < var_542_21 then
					arg_539_1.talkMaxDuration = var_542_21

					if var_542_21 + var_542_16 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_21 + var_542_16
					end
				end
			end

			local var_542_22 = math.max(0.266666666666667, arg_539_1.talkMaxDuration)

			if var_542_16 <= arg_539_1.time_ and arg_539_1.time_ < var_542_16 + var_542_22 then
				arg_539_1.fswtw_.percent = Mathf.Lerp(arg_539_1.var_.oldValueTypewriter, var_542_19, (arg_539_1.time_ - var_542_16) / var_542_22)
				arg_539_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_539_1.fswtw_:SetDirty()
			end

			if arg_539_1.time_ >= var_542_16 + var_542_22 and arg_539_1.time_ < var_542_16 + var_542_22 + arg_542_0 then
				arg_539_1.fswtw_.percent = var_542_19

				arg_539_1.fswtw_:SetDirty()
				arg_539_1:ShowNextGo(true)

				arg_539_1.typewritterCharCountI18N = var_542_20
			end

			if 0.666666666666666 < arg_539_1.time_ and arg_539_1.time_ <= 0.666666666666666 + arg_542_0 then
				local var_542_23 = arg_539_1.fswbg_.transform:Find("textbox/adapt/content") or arg_539_1.fswbg_.transform:Find("textbox/content")
				local var_542_24 = arg_539_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_542_25 = var_542_23:GetComponent("RectTransform")

				var_542_23:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_542_25.offsetMin = Vector2.New(0, -70)
				var_542_25.offsetMax = Vector2.New(0, 0)
			end

			local var_542_26 = 1.66666666666667
			local var_542_27 = manager.audio:GetVoiceLength("story_v_out_420051", "420051128", "story_v_out_420051.awb") / 1000

			if var_542_27 > 0 and 2.4 < var_542_27 and var_542_27 + var_542_26 > arg_539_1.duration_ then
				arg_539_1.duration_ = var_542_27 + var_542_26
			end

			if var_542_26 < arg_539_1.time_ and arg_539_1.time_ <= var_542_26 + arg_542_0 then
				arg_539_1:AudioAction("play", "voice", "story_v_out_420051", "420051128", "story_v_out_420051.awb")
			end

			if 0.05 < arg_539_1.time_ and arg_539_1.time_ <= 0.05 + arg_542_0 then
				arg_539_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play420051129 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 420051129
		arg_543_1.duration_ = 1.22

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play420051130(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.fswbg_:SetActive(true)
				arg_543_1.dialog_:SetActive(false)

				arg_543_1.fswtw_.percent = 0
				arg_543_1.fswt_.text = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(420051129).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.fswt_)

				arg_543_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_543_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_543_1.fswtw_:SetDirty()

				arg_543_1.typewritterCharCountI18N = 0

				SetActive(arg_543_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_543_1:ShowNextGo(false)
			end

			local var_546_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.var_.oldValueTypewriter = arg_543_1.fswtw_.percent

				SetActive(arg_543_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_543_1:ShowNextGo(false)
			end

			local var_546_1 = 18
			local var_546_2 = 1.2
			local var_546_3, var_546_4 = arg_543_1:GetPercentByPara(arg_543_1:FormatText(arg_543_1:GetWordFromCfg(420051129).content), 1)

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				local var_546_5 = var_546_1 <= 0 and var_546_2 or var_546_2 * ((var_546_4 - arg_543_1.typewritterCharCountI18N) / var_546_1)

				if (var_546_1 <= 0 and var_546_2 or var_546_2 * ((var_546_4 - arg_543_1.typewritterCharCountI18N) / var_546_1)) > 0 and var_546_2 < var_546_5 then
					arg_543_1.talkMaxDuration = var_546_5

					if var_546_5 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_5 + var_546_0
					end
				end
			end

			local var_546_6 = math.max(1.2, arg_543_1.talkMaxDuration)

			if var_546_0 <= arg_543_1.time_ and arg_543_1.time_ < var_546_0 + var_546_6 then
				arg_543_1.fswtw_.percent = Mathf.Lerp(arg_543_1.var_.oldValueTypewriter, var_546_3, (arg_543_1.time_ - var_546_0) / var_546_6)
				arg_543_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_543_1.fswtw_:SetDirty()
			end

			if arg_543_1.time_ >= var_546_0 + var_546_6 and arg_543_1.time_ < var_546_0 + var_546_6 + arg_546_0 then
				arg_543_1.fswtw_.percent = var_546_3

				arg_543_1.fswtw_:SetDirty()
				arg_543_1:ShowNextGo(true)

				arg_543_1.typewritterCharCountI18N = var_546_4
			end

			if 0.216666666666 < arg_543_1.time_ and arg_543_1.time_ <= 0.216666666666 + arg_546_0 then
				arg_543_1:AudioAction("play", "effect", "se_story_side_1042", "se_story_1042_doorbell", "")
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play420051130 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 420051130
		arg_547_1.duration_ = 9

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play420051131(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_0 = 2

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 then
				local var_550_1 = Color.New(0, 0, 0)

				var_550_1.a = Mathf.Lerp(0, 1, (arg_547_1.time_ - 0) / var_550_0)
				arg_547_1.mask_.color = var_550_1
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 then
				local var_550_2 = Color.New(0, 0, 0)

				var_550_2.a = 1
				arg_547_1.mask_.color = var_550_2
			end

			local var_550_3 = 2

			if 2 < arg_547_1.time_ and arg_547_1.time_ <= var_550_3 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_4 = 2

			if var_550_3 <= arg_547_1.time_ and arg_547_1.time_ < var_550_3 + var_550_4 then
				local var_550_5 = Color.New(0, 0, 0)

				var_550_5.a = Mathf.Lerp(1, 0, (arg_547_1.time_ - var_550_3) / var_550_4)
				arg_547_1.mask_.color = var_550_5
			end

			if arg_547_1.time_ >= var_550_3 + var_550_4 and arg_547_1.time_ < var_550_3 + var_550_4 + arg_550_0 then
				local var_550_6 = Color.New(0, 0, 0)

				arg_547_1.mask_.enabled = false
				var_550_6.a = 0
				arg_547_1.mask_.color = var_550_6
			end

			if 2 < arg_547_1.time_ and arg_547_1.time_ <= 2 + arg_550_0 then
				local var_550_7 = arg_547_1.bgs_.ST0505

				arg_547_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_550_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_550_8 = var_550_7:GetComponent("SpriteRenderer")

				if var_550_8 and var_550_8.sprite then
					local var_550_9 = 2 * (var_550_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_550_7.transform.localScale = Vector3.New(var_550_9 / var_550_8.sprite.bounds.size.y < var_550_9 * manager.ui.mainCameraCom_.aspect / var_550_8.sprite.bounds.size.x and var_550_9 * manager.ui.mainCameraCom_.aspect / var_550_8.sprite.bounds.size.x or var_550_9 / var_550_8.sprite.bounds.size.y, var_550_9 / var_550_8.sprite.bounds.size.y < var_550_9 * manager.ui.mainCameraCom_.aspect / var_550_8.sprite.bounds.size.x and var_550_9 * manager.ui.mainCameraCom_.aspect / var_550_8.sprite.bounds.size.x or var_550_9 / var_550_8.sprite.bounds.size.y, 0)
				end

				for iter_550_0, iter_550_1 in pairs(arg_547_1.bgs_) do
					if iter_550_0 ~= "ST0505" then
						iter_550_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.93333333333333 < arg_547_1.time_ and arg_547_1.time_ <= 1.93333333333333 + arg_550_0 then
				arg_547_1.fswbg_:SetActive(false)
				arg_547_1.dialog_:SetActive(false)
				SetActive(arg_547_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_547_1:ShowNextGo(false)
			end

			if 1.93333333333333 < arg_547_1.time_ and arg_547_1.time_ <= 1.93333333333333 + arg_550_0 then
				arg_547_1.cswbg_:SetActive(false)
			end

			local var_550_10 = 4
			local var_550_11 = 1.025

			if 4 < arg_547_1.time_ and arg_547_1.time_ <= var_550_10 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_12 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(420051130).content)

				arg_547_1.text_.text = var_550_12

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_14 = 41 <= 0 and var_550_11 or var_550_11 * (utf8.len(var_550_12) / 41)

				if (41 <= 0 and var_550_11 or var_550_11 * (utf8.len(var_550_12) / 41)) > 0 and var_550_11 < var_550_14 then
					arg_547_1.talkMaxDuration = var_550_14

					if var_550_14 + var_550_10 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_14 + var_550_10
					end
				end

				arg_547_1.text_.text = var_550_12
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_15 = math.max(var_550_11, arg_547_1.talkMaxDuration)

			if var_550_10 <= arg_547_1.time_ and arg_547_1.time_ < var_550_10 + var_550_15 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_10) / var_550_15

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_10 + var_550_15 and arg_547_1.time_ < var_550_10 + var_550_15 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play420051131 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 420051131
		arg_551_1.duration_ = 2.3

		local var_551_0 = {
			zh = 1.8,
			ja = 2.3
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play420051132(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 1.025

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1085")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_1 = arg_551_1:GetWordFromCfg(420051131)
				local var_554_2 = arg_551_1:FormatText(var_554_1.content)

				arg_551_1.text_.text = var_554_2

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_4 = 10 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 10)

				if (10 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 10)) > 0 and var_554_0 < var_554_4 then
					arg_551_1.talkMaxDuration = var_554_4

					if var_554_4 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_4 + 0
					end
				end

				arg_551_1.text_.text = var_554_2
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051131", "story_v_out_420051.awb") ~= 0 then
					local var_554_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051131", "story_v_out_420051.awb") / 1000

					if var_554_5 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + 0
					end

					if var_554_1.prefab_name ~= "" and arg_551_1.actors_[var_554_1.prefab_name] ~= nil then
						local var_554_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_1.prefab_name].transform, "story_v_out_420051", "420051131", "story_v_out_420051.awb")

						arg_551_1:RecordAudio("420051131", var_554_6)
						arg_551_1:RecordAudio("420051131", var_554_6)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_420051", "420051131", "story_v_out_420051.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_420051", "420051131", "story_v_out_420051.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_7 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_7 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_7

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_7 and arg_551_1.time_ < 0 + var_554_7 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play420051132 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 420051132
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play420051133(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0.133333333333333 < arg_555_1.time_ and arg_555_1.time_ <= 0.133333333333333 + arg_558_0 then
				arg_555_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_footsteps", "")
			end

			local var_558_1 = 0
			local var_558_2 = 0.75

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_3 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(420051132).content)

				arg_555_1.text_.text = var_558_3

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_5 = 30 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_3) / 30)

				if (30 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_3) / 30)) > 0 and var_558_2 < var_558_5 then
					arg_555_1.talkMaxDuration = var_558_5

					if var_558_5 + var_558_1 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_5 + var_558_1
					end
				end

				arg_555_1.text_.text = var_558_3
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_6 = math.max(var_558_2, arg_555_1.talkMaxDuration)

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_6 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_1) / var_558_6

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_1 + var_558_6 and arg_555_1.time_ < var_558_1 + var_558_6 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play420051133 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 420051133
		arg_559_1.duration_ = 5.1

		local var_559_0 = {
			zh = 3.466,
			ja = 5.1
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play420051134(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.35

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_1 = arg_559_1:GetWordFromCfg(420051133)
				local var_562_2 = arg_559_1:FormatText(var_562_1.content)

				arg_559_1.text_.text = var_562_2

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 14 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 14)

				if (14 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 14)) > 0 and var_562_0 < var_562_4 then
					arg_559_1.talkMaxDuration = var_562_4

					if var_562_4 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_4 + 0
					end
				end

				arg_559_1.text_.text = var_562_2
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051133", "story_v_out_420051.awb") ~= 0 then
					local var_562_5 = manager.audio:GetVoiceLength("story_v_out_420051", "420051133", "story_v_out_420051.awb") / 1000

					if var_562_5 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + 0
					end

					if var_562_1.prefab_name ~= "" and arg_559_1.actors_[var_562_1.prefab_name] ~= nil then
						local var_562_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_1.prefab_name].transform, "story_v_out_420051", "420051133", "story_v_out_420051.awb")

						arg_559_1:RecordAudio("420051133", var_562_6)
						arg_559_1:RecordAudio("420051133", var_562_6)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_420051", "420051133", "story_v_out_420051.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_420051", "420051133", "story_v_out_420051.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_7 and arg_559_1.time_ < 0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play420051134 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 420051134
		arg_563_1.duration_ = 2

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play420051135(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.var_.moveOldPos404001ui_story = arg_563_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_566_0 = 0.001

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 then
				arg_563_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_563_1.time_ - 0) / var_566_0)
				arg_563_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_563_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["404001ui_story"].transform.position).z)
				arg_563_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_563_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_563_1.actors_["404001ui_story"].transform.localEulerAngles = arg_563_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 then
				arg_563_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_563_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_563_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["404001ui_story"].transform.position).z)
				arg_563_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_563_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_563_1.actors_["404001ui_story"].transform.localEulerAngles = arg_563_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_566_1 = arg_563_1.actors_["404001ui_story"]

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(var_566_1) and arg_563_1.var_.characterEffect404001ui_story == nil then
				arg_563_1.var_.characterEffect404001ui_story = var_566_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_2 and not isNil(var_566_1) then
				if arg_563_1.var_.characterEffect404001ui_story and not isNil(var_566_1) then
					arg_563_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= 0 + var_566_2 and arg_563_1.time_ < 0 + var_566_2 + arg_566_0 and not isNil(var_566_1) and arg_563_1.var_.characterEffect404001ui_story then
				arg_563_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_566_4 = "1042ui_story"

			if arg_563_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_566_5 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_563_1.stage_.transform)

				var_566_5.name = var_566_4
				var_566_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_563_1.actors_[var_566_4] = var_566_5

				local var_566_6 = var_566_5:GetComponentInChildren(typeof(CharacterEffect))

				var_566_6.enabled = true

				local var_566_7 = GameObjectTools.GetOrAddComponent(var_566_5, typeof(DynamicBoneHelper))

				if var_566_7 then
					var_566_7:EnableDynamicBone(false)
				end

				arg_563_1:ShowWeapon(var_566_6.transform, false)

				arg_563_1.var_[var_566_4 .. "Animator"] = var_566_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_563_1.var_[var_566_4 .. "Animator"].applyRootMotion = true
				arg_563_1.var_[var_566_4 .. "LipSync"] = var_566_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_566_8 = arg_563_1.actors_["1042ui_story"]

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(var_566_8) and arg_563_1.var_.characterEffect1042ui_story == nil then
				arg_563_1.var_.characterEffect1042ui_story = var_566_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_9 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_9 and not isNil(var_566_8) then
				if arg_563_1.var_.characterEffect1042ui_story and not isNil(var_566_8) then
					arg_563_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_563_1.time_ - 0) / var_566_9)
				end
			end

			if arg_563_1.time_ >= 0 + var_566_9 and arg_563_1.time_ < 0 + var_566_9 + arg_566_0 and not isNil(var_566_8) and arg_563_1.var_.characterEffect1042ui_story then
				arg_563_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_566_10 = 0
			local var_566_11 = 0.15

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_10 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_12 = arg_563_1:GetWordFromCfg(420051134)
				local var_566_13 = arg_563_1:FormatText(var_566_12.content)

				arg_563_1.text_.text = var_566_13

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_15 = 6 <= 0 and var_566_11 or var_566_11 * (utf8.len(var_566_13) / 6)

				if (6 <= 0 and var_566_11 or var_566_11 * (utf8.len(var_566_13) / 6)) > 0 and var_566_11 < var_566_15 then
					arg_563_1.talkMaxDuration = var_566_15

					if var_566_15 + var_566_10 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_15 + var_566_10
					end
				end

				arg_563_1.text_.text = var_566_13
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051134", "story_v_out_420051.awb") ~= 0 then
					local var_566_16 = manager.audio:GetVoiceLength("story_v_out_420051", "420051134", "story_v_out_420051.awb") / 1000

					if var_566_16 + var_566_10 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_16 + var_566_10
					end

					if var_566_12.prefab_name ~= "" and arg_563_1.actors_[var_566_12.prefab_name] ~= nil then
						local var_566_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_12.prefab_name].transform, "story_v_out_420051", "420051134", "story_v_out_420051.awb")

						arg_563_1:RecordAudio("420051134", var_566_17)
						arg_563_1:RecordAudio("420051134", var_566_17)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_420051", "420051134", "story_v_out_420051.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_420051", "420051134", "story_v_out_420051.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_18 = math.max(var_566_11, arg_563_1.talkMaxDuration)

			if var_566_10 <= arg_563_1.time_ and arg_563_1.time_ < var_566_10 + var_566_18 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_10) / var_566_18

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_10 + var_566_18 and arg_563_1.time_ < var_566_10 + var_566_18 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_563_1:InitPlayNodeList()
	end,
	Play420051135 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 420051135
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play420051136(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.var_.moveOldPos404001ui_story = arg_567_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_570_0 = 0.001

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 then
				arg_567_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_567_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_567_1.time_ - 0) / var_570_0)
				arg_567_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_567_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["404001ui_story"].transform.position).z)
				arg_567_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_567_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_567_1.actors_["404001ui_story"].transform.localEulerAngles = arg_567_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 then
				arg_567_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_567_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_567_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["404001ui_story"].transform.position).z)
				arg_567_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_567_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_567_1.actors_["404001ui_story"].transform.localEulerAngles = arg_567_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_570_1 = 0
			local var_570_2 = 1.175

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_3 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(420051135).content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 47 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 47)

				if (47 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 47)) > 0 and var_570_2 < var_570_5 then
					arg_567_1.talkMaxDuration = var_570_5

					if var_570_5 + var_570_1 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + var_570_1
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_6 = math.max(var_570_2, arg_567_1.talkMaxDuration)

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_6 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_1) / var_570_6

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_1 + var_570_6 and arg_567_1.time_ < var_570_1 + var_570_6 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_567_1:InitPlayNodeList()
	end,
	Play420051136 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 420051136
		arg_571_1.duration_ = 9.1

		local var_571_0 = {
			zh = 9.099999999999,
			ja = 8.765999999999
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play420051137(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 1.999999999999 < arg_571_1.time_ and arg_571_1.time_ <= 1.999999999999 + arg_574_0 then
				local var_574_0 = arg_571_1.bgs_.ST61

				arg_571_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_574_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_574_1 = var_574_0:GetComponent("SpriteRenderer")

				if var_574_1 and var_574_1.sprite then
					local var_574_2 = 2 * (var_574_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_574_0.transform.localScale = Vector3.New(var_574_2 / var_574_1.sprite.bounds.size.y < var_574_2 * manager.ui.mainCameraCom_.aspect / var_574_1.sprite.bounds.size.x and var_574_2 * manager.ui.mainCameraCom_.aspect / var_574_1.sprite.bounds.size.x or var_574_2 / var_574_1.sprite.bounds.size.y, var_574_2 / var_574_1.sprite.bounds.size.y < var_574_2 * manager.ui.mainCameraCom_.aspect / var_574_1.sprite.bounds.size.x and var_574_2 * manager.ui.mainCameraCom_.aspect / var_574_1.sprite.bounds.size.x or var_574_2 / var_574_1.sprite.bounds.size.y, 0)
				end

				for iter_574_0, iter_574_1 in pairs(arg_571_1.bgs_) do
					if iter_574_0 ~= "ST61" then
						iter_574_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_574_3 = 3.999999999999

			if 3.999999999999 < arg_571_1.time_ and arg_571_1.time_ <= var_574_3 + arg_574_0 then
				arg_571_1.allBtn_.enabled = false
			end

			if arg_571_1.time_ >= var_574_3 + 0.3 and arg_571_1.time_ < var_574_3 + 0.3 + arg_574_0 then
				arg_571_1.allBtn_.enabled = true
			end

			local var_574_4 = 0

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_4 + arg_574_0 then
				arg_571_1.mask_.enabled = true
				arg_571_1.mask_.raycastTarget = true

				arg_571_1:SetGaussion(false)
			end

			local var_574_5 = 2

			if var_574_4 <= arg_571_1.time_ and arg_571_1.time_ < var_574_4 + var_574_5 then
				local var_574_6 = Color.New(0, 0, 0)

				var_574_6.a = Mathf.Lerp(0, 1, (arg_571_1.time_ - var_574_4) / var_574_5)
				arg_571_1.mask_.color = var_574_6
			end

			if arg_571_1.time_ >= var_574_4 + var_574_5 and arg_571_1.time_ < var_574_4 + var_574_5 + arg_574_0 then
				local var_574_7 = Color.New(0, 0, 0)

				var_574_7.a = 1
				arg_571_1.mask_.color = var_574_7
			end

			local var_574_8 = 2

			if 2 < arg_571_1.time_ and arg_571_1.time_ <= var_574_8 + arg_574_0 then
				arg_571_1.mask_.enabled = true
				arg_571_1.mask_.raycastTarget = true

				arg_571_1:SetGaussion(false)
			end

			local var_574_9 = 2

			if var_574_8 <= arg_571_1.time_ and arg_571_1.time_ < var_574_8 + var_574_9 then
				local var_574_10 = Color.New(0, 0, 0)

				var_574_10.a = Mathf.Lerp(1, 0, (arg_571_1.time_ - var_574_8) / var_574_9)
				arg_571_1.mask_.color = var_574_10
			end

			if arg_571_1.time_ >= var_574_8 + var_574_9 and arg_571_1.time_ < var_574_8 + var_574_9 + arg_574_0 then
				local var_574_11 = Color.New(0, 0, 0)

				arg_571_1.mask_.enabled = false
				var_574_11.a = 0
				arg_571_1.mask_.color = var_574_11
			end

			local var_574_12 = arg_571_1.actors_["1085ui_story"].transform

			if 3.9 < arg_571_1.time_ and arg_571_1.time_ <= 3.9 + arg_574_0 then
				arg_571_1.var_.moveOldPos1085ui_story = var_574_12.localPosition
			end

			local var_574_13 = 0.001

			if 3.9 <= arg_571_1.time_ and arg_571_1.time_ < 3.9 + var_574_13 then
				var_574_12.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_571_1.time_ - 3.9) / var_574_13)
				var_574_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_574_12.position).x, (manager.ui.mainCamera.transform.position - var_574_12.position).y, (manager.ui.mainCamera.transform.position - var_574_12.position).z)
				var_574_12.localEulerAngles.z = 0
				var_574_12.localEulerAngles.x = 0
				var_574_12.localEulerAngles = var_574_12.localEulerAngles
			end

			if arg_571_1.time_ >= 3.9 + var_574_13 and arg_571_1.time_ < 3.9 + var_574_13 + arg_574_0 then
				var_574_12.localPosition = Vector3.New(0, -1.01, -5.83)
				var_574_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_574_12.position).x, (manager.ui.mainCamera.transform.position - var_574_12.position).y, (manager.ui.mainCamera.transform.position - var_574_12.position).z)
				var_574_12.localEulerAngles.z = 0
				var_574_12.localEulerAngles.x = 0
				var_574_12.localEulerAngles = var_574_12.localEulerAngles
			end

			local var_574_14 = arg_571_1.actors_["1085ui_story"]

			if 3.9 < arg_571_1.time_ and arg_571_1.time_ <= 3.9 + arg_574_0 and not isNil(var_574_14) and arg_571_1.var_.characterEffect1085ui_story == nil then
				arg_571_1.var_.characterEffect1085ui_story = var_574_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_15 = 0.200000002980232

			if 3.9 <= arg_571_1.time_ and arg_571_1.time_ < 3.9 + var_574_15 and not isNil(var_574_14) then
				if arg_571_1.var_.characterEffect1085ui_story and not isNil(var_574_14) then
					arg_571_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 3.9 + var_574_15 and arg_571_1.time_ < 3.9 + var_574_15 + arg_574_0 and not isNil(var_574_14) and arg_571_1.var_.characterEffect1085ui_story then
				arg_571_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.9 < arg_571_1.time_ and arg_571_1.time_ <= 3.9 + arg_574_0 then
				arg_571_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 3.9 < arg_571_1.time_ and arg_571_1.time_ <= 3.9 + arg_574_0 then
				arg_571_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if arg_571_1.frameCnt_ <= 1 then
				arg_571_1.dialog_:SetActive(false)
			end

			local var_574_17 = 3.999999999999
			local var_574_18 = 0.375

			if 3.999999999999 < arg_571_1.time_ and arg_571_1.time_ <= var_574_17 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0

				arg_571_1.dialog_:SetActive(true)

				arg_571_1.dialogCg_.alpha = 0

				local var_574_19 = LeanTween.value(arg_571_1.dialog_, 0, 1, 0.3)

				var_574_19:setOnUpdate(LuaHelper.FloatAction(function(arg_575_0)
					arg_571_1.dialogCg_.alpha = arg_575_0
				end))
				var_574_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_571_1.dialog_)
					var_574_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_571_1.duration_ = arg_571_1.duration_ + 0.3

				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_20 = arg_571_1:GetWordFromCfg(420051136)
				local var_574_21 = arg_571_1:FormatText(var_574_20.content)

				arg_571_1.text_.text = var_574_21

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_23 = 15 <= 0 and var_574_18 or var_574_18 * (utf8.len(var_574_21) / 15)

				if (15 <= 0 and var_574_18 or var_574_18 * (utf8.len(var_574_21) / 15)) > 0 and var_574_18 < var_574_23 then
					arg_571_1.talkMaxDuration = var_574_23
					var_574_17 = var_574_17 + 0.3

					if var_574_23 + var_574_17 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_23 + var_574_17
					end
				end

				arg_571_1.text_.text = var_574_21
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051136", "story_v_out_420051.awb") ~= 0 then
					local var_574_24 = manager.audio:GetVoiceLength("story_v_out_420051", "420051136", "story_v_out_420051.awb") / 1000

					if var_574_24 + var_574_17 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_24 + var_574_17
					end

					if var_574_20.prefab_name ~= "" and arg_571_1.actors_[var_574_20.prefab_name] ~= nil then
						local var_574_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_20.prefab_name].transform, "story_v_out_420051", "420051136", "story_v_out_420051.awb")

						arg_571_1:RecordAudio("420051136", var_574_25)
						arg_571_1:RecordAudio("420051136", var_574_25)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_420051", "420051136", "story_v_out_420051.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_420051", "420051136", "story_v_out_420051.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_26 = var_574_17 + 0.3
			local var_574_27 = math.max(var_574_18, arg_571_1.talkMaxDuration)

			if var_574_17 + 0.3 <= arg_571_1.time_ and arg_571_1.time_ < var_574_26 + var_574_27 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_26) / var_574_27

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_26 + var_574_27 and arg_571_1.time_ < var_574_26 + var_574_27 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play420051137 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 420051137
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play420051138(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1085ui_story"]) and arg_577_1.var_.characterEffect1085ui_story == nil then
				arg_577_1.var_.characterEffect1085ui_story = arg_577_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_0 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1085ui_story"]) then
				if arg_577_1.var_.characterEffect1085ui_story and not isNil(arg_577_1.actors_["1085ui_story"]) then
					arg_577_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_577_1.time_ - 0) / var_580_0)
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1085ui_story"]) and arg_577_1.var_.characterEffect1085ui_story then
				arg_577_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_580_1 = 0
			local var_580_2 = 0.625

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_3 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(420051137).content)

				arg_577_1.text_.text = var_580_3

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_5 = 25 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 25)

				if (25 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 25)) > 0 and var_580_2 < var_580_5 then
					arg_577_1.talkMaxDuration = var_580_5

					if var_580_5 + var_580_1 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_5 + var_580_1
					end
				end

				arg_577_1.text_.text = var_580_3
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_6 = math.max(var_580_2, arg_577_1.talkMaxDuration)

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_6 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_1) / var_580_6

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_1 + var_580_6 and arg_577_1.time_ < var_580_1 + var_580_6 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play420051138 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 420051138
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play420051139(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos1085ui_story = arg_581_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_584_0 = 0.001

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 then
				arg_581_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_581_1.time_ - 0) / var_584_0)
				arg_581_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1085ui_story"].transform.position).z)
				arg_581_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1085ui_story"].transform.localEulerAngles = arg_581_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 then
				arg_581_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_581_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1085ui_story"].transform.position).z)
				arg_581_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1085ui_story"].transform.localEulerAngles = arg_581_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_584_1 = 0
			local var_584_2 = 0.175

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_3 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(420051138).content)

				arg_581_1.text_.text = var_584_3

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_5 = 7 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_3) / 7)

				if (7 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_3) / 7)) > 0 and var_584_2 < var_584_5 then
					arg_581_1.talkMaxDuration = var_584_5

					if var_584_5 + var_584_1 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_5 + var_584_1
					end
				end

				arg_581_1.text_.text = var_584_3
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_6 = math.max(var_584_2, arg_581_1.talkMaxDuration)

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_6 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_1) / var_584_6

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_1 + var_584_6 and arg_581_1.time_ < var_584_1 + var_584_6 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
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

		arg_581_1:InitPlayNodeList()
	end,
	Play420051139 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 420051139
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play420051140(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 1.45

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(420051139).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 58 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 58)

				if (58 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 58)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play420051140 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 420051140
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play420051141(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.7

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(420051140).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 28 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 28)

				if (28 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 28)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play420051141 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 420051141
		arg_593_1.duration_ = 8

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play420051142(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 1 < arg_593_1.time_ and arg_593_1.time_ <= 1 + arg_596_0 then
				local var_596_0 = arg_593_1.bgs_.L16f

				arg_593_1.bgs_.L16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_596_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_596_1 = var_596_0:GetComponent("SpriteRenderer")

				if var_596_1 and var_596_1.sprite then
					local var_596_2 = 2 * (var_596_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_596_0.transform.localScale = Vector3.New(var_596_2 / var_596_1.sprite.bounds.size.y < var_596_2 * manager.ui.mainCameraCom_.aspect / var_596_1.sprite.bounds.size.x and var_596_2 * manager.ui.mainCameraCom_.aspect / var_596_1.sprite.bounds.size.x or var_596_2 / var_596_1.sprite.bounds.size.y, var_596_2 / var_596_1.sprite.bounds.size.y < var_596_2 * manager.ui.mainCameraCom_.aspect / var_596_1.sprite.bounds.size.x and var_596_2 * manager.ui.mainCameraCom_.aspect / var_596_1.sprite.bounds.size.x or var_596_2 / var_596_1.sprite.bounds.size.y, 0)
				end

				for iter_596_0, iter_596_1 in pairs(arg_593_1.bgs_) do
					if iter_596_0 ~= "L16f" then
						iter_596_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_596_3 = 3

			if 3 < arg_593_1.time_ and arg_593_1.time_ <= var_596_3 + arg_596_0 then
				arg_593_1.allBtn_.enabled = false
			end

			if arg_593_1.time_ >= var_596_3 + 0.3 and arg_593_1.time_ < var_596_3 + 0.3 + arg_596_0 then
				arg_593_1.allBtn_.enabled = true
			end

			local var_596_4 = 0

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1.mask_.enabled = true
				arg_593_1.mask_.raycastTarget = true

				arg_593_1:SetGaussion(false)
			end

			local var_596_5 = 1

			if var_596_4 <= arg_593_1.time_ and arg_593_1.time_ < var_596_4 + var_596_5 then
				local var_596_6 = Color.New(0, 0, 0)

				var_596_6.a = Mathf.Lerp(0, 1, (arg_593_1.time_ - var_596_4) / var_596_5)
				arg_593_1.mask_.color = var_596_6
			end

			if arg_593_1.time_ >= var_596_4 + var_596_5 and arg_593_1.time_ < var_596_4 + var_596_5 + arg_596_0 then
				local var_596_7 = Color.New(0, 0, 0)

				var_596_7.a = 1
				arg_593_1.mask_.color = var_596_7
			end

			local var_596_8 = 1

			if 1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_8 + arg_596_0 then
				arg_593_1.mask_.enabled = true
				arg_593_1.mask_.raycastTarget = true

				arg_593_1:SetGaussion(false)
			end

			local var_596_9 = 2

			if var_596_8 <= arg_593_1.time_ and arg_593_1.time_ < var_596_8 + var_596_9 then
				local var_596_10 = Color.New(0, 0, 0)

				var_596_10.a = Mathf.Lerp(1, 0, (arg_593_1.time_ - var_596_8) / var_596_9)
				arg_593_1.mask_.color = var_596_10
			end

			if arg_593_1.time_ >= var_596_8 + var_596_9 and arg_593_1.time_ < var_596_8 + var_596_9 + arg_596_0 then
				local var_596_11 = Color.New(0, 0, 0)

				arg_593_1.mask_.enabled = false
				var_596_11.a = 0
				arg_593_1.mask_.color = var_596_11
			end

			if arg_593_1.frameCnt_ <= 1 then
				arg_593_1.dialog_:SetActive(false)
			end

			local var_596_12 = 3
			local var_596_13 = 0.55

			if 3 < arg_593_1.time_ and arg_593_1.time_ <= var_596_12 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0

				arg_593_1.dialog_:SetActive(true)

				arg_593_1.dialogCg_.alpha = 0

				local var_596_14 = LeanTween.value(arg_593_1.dialog_, 0, 1, 0.3)

				var_596_14:setOnUpdate(LuaHelper.FloatAction(function(arg_597_0)
					arg_593_1.dialogCg_.alpha = arg_597_0
				end))
				var_596_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_593_1.dialog_)
					var_596_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_593_1.duration_ = arg_593_1.duration_ + 0.3

				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_15 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(420051141).content)

				arg_593_1.text_.text = var_596_15

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_17 = 22 <= 0 and var_596_13 or var_596_13 * (utf8.len(var_596_15) / 22)

				if (22 <= 0 and var_596_13 or var_596_13 * (utf8.len(var_596_15) / 22)) > 0 and var_596_13 < var_596_17 then
					arg_593_1.talkMaxDuration = var_596_17
					var_596_12 = var_596_12 + 0.3

					if var_596_17 + var_596_12 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_17 + var_596_12
					end
				end

				arg_593_1.text_.text = var_596_15
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_18 = var_596_12 + 0.3
			local var_596_19 = math.max(var_596_13, arg_593_1.talkMaxDuration)

			if var_596_12 + 0.3 <= arg_593_1.time_ and arg_593_1.time_ < var_596_18 + var_596_19 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_18) / var_596_19

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_18 + var_596_19 and arg_593_1.time_ < var_596_18 + var_596_19 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play420051142 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 420051142
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play420051143(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0.55

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, false)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_1 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(420051142).content)

				arg_599_1.text_.text = var_602_1

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_3 = 22 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 22)

				if (22 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 22)) > 0 and var_602_0 < var_602_3 then
					arg_599_1.talkMaxDuration = var_602_3

					if var_602_3 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_3 + 0
					end
				end

				arg_599_1.text_.text = var_602_1
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_4 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_4 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_4

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_4 and arg_599_1.time_ < 0 + var_602_4 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play420051143 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 420051143
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play420051144(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0.45

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_1 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(420051143).content)

				arg_603_1.text_.text = var_606_1

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_3 = 18 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_1) / 18)

				if (18 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_1) / 18)) > 0 and var_606_0 < var_606_3 then
					arg_603_1.talkMaxDuration = var_606_3

					if var_606_3 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_3 + 0
					end
				end

				arg_603_1.text_.text = var_606_1
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_4 = math.max(var_606_0, arg_603_1.talkMaxDuration)

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_4 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - 0) / var_606_4

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= 0 + var_606_4 and arg_603_1.time_ < 0 + var_606_4 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play420051144 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 420051144
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
			arg_607_1.auto_ = false
		end

		function arg_607_1.playNext_(arg_609_0)
			arg_607_1.onStoryFinished_()
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.125

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_1 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(420051144).content)

				arg_607_1.text_.text = var_610_1

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_3 = 5 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 5)

				if (5 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 5)) > 0 and var_610_0 < var_610_3 then
					arg_607_1.talkMaxDuration = var_610_3

					if var_610_3 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_3 + 0
					end
				end

				arg_607_1.text_.text = var_610_1
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_4 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_4 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_4

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_4 and arg_607_1.time_ < 0 + var_610_4 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST0503",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L16f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/ST0504a"
	},
	voices = {
		"story_v_out_420051.awb"
	}
}
