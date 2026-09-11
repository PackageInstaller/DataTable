return {
	Play112251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112251001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_0 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_0 then
				local var_4_1 = Color.New(1, 1, 1)

				var_4_1.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - 0) / var_4_0)
				arg_1_1.mask_.color = var_4_1
			end

			if arg_1_1.time_ >= 0 + var_4_0 and arg_1_1.time_ < 0 + var_4_0 + arg_4_0 then
				local var_4_2 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_2.a = 0
				arg_1_1.mask_.color = var_4_2
			end

			local var_4_3 = "H02"

			if arg_1_1.bgs_.H02 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.H02

				arg_1_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_8 = "1148ui_story"

			if arg_1_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1148ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, 100, 0)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = "1039ui_story"

			if arg_1_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_4_15 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_1_1.stage_.transform)

				var_4_15.name = var_4_14
				var_4_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_14] = var_4_15

				local var_4_16 = var_4_15:GetComponentInChildren(typeof(CharacterEffect))

				var_4_16.enabled = true

				local var_4_17 = GameObjectTools.GetOrAddComponent(var_4_15, typeof(DynamicBoneHelper))

				if var_4_17 then
					var_4_17:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_16.transform, false)

				arg_1_1.var_[var_4_14 .. "Animator"] = var_4_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_14 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_14 .. "LipSync"] = var_4_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_18 = arg_1_1.actors_["1039ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1039ui_story = var_4_18.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1039ui_story" .. "Animator"].transform, false)
			end

			local var_4_19 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_19)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_19 and arg_1_1.time_ < 0 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(0, 100, 0)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_27 = 2
			local var_4_28 = 1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112251001).content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 57 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 57)

				if (57 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 57)) > 0 and var_4_28 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_27 = var_4_27 + 0.3

					if var_4_32 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_27 + 0.3
			local var_4_34 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play112251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 112251002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play112251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(112251002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 6 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 6)

				if (6 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 6)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play112251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 112251003
		arg_13_1.duration_ = 6

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play112251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = false

				arg_13_1:SetGaussion(false)
			end

			local var_16_0 = 0.5

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				local var_16_1 = Color.New(1, 1, 1)

				var_16_1.a = Mathf.Lerp(0, 1, (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.mask_.color = var_16_1
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				local var_16_2 = Color.New(1, 1, 1)

				var_16_2.a = 1
				arg_13_1.mask_.color = var_16_2
			end

			local var_16_3 = 0.5

			if 0.5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = false

				arg_13_1:SetGaussion(false)
			end

			local var_16_4 = 0.5

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_4 then
				local var_16_5 = Color.New(1, 1, 1)

				var_16_5.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_3) / var_16_4)
				arg_13_1.mask_.color = var_16_5
			end

			if arg_13_1.time_ >= var_16_3 + var_16_4 and arg_13_1.time_ < var_16_3 + var_16_4 + arg_16_0 then
				local var_16_6 = Color.New(1, 1, 1)

				arg_13_1.mask_.enabled = false
				var_16_6.a = 0
				arg_13_1.mask_.color = var_16_6
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_7 = 1
			local var_16_8 = 1

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_9 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_9:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(112251003).content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 45 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_10) / 45)

				if (45 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_10) / 45)) > 0 and var_16_8 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12
					var_16_7 = var_16_7 + 0.3

					if var_16_12 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = var_16_7 + 0.3
			local var_16_14 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_13) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_13 + var_16_14 and arg_13_1.time_ < var_16_13 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play112251004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112251004
		arg_19_1.duration_ = 10.53

		local var_19_0 = {
			ja = 8.3,
			ko = 9.366,
			zh = 9,
			en = 10.533
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play112251005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1081ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1081ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1081ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1081ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1081ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1081ui_story = var_22_3.localPosition

				arg_19_1:ShowWeapon(arg_19_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1081ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1081ui_story == nil then
				arg_19_1.var_.characterEffect1081ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1081ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1081ui_story then
				arg_19_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_22_8 = 0
			local var_22_9 = 1

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:GetWordFromCfg(112251004)
				local var_22_11 = arg_19_1:FormatText(var_22_10.content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_13 = 47 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 47)

				if (47 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 47)) > 0 and var_22_9 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251004", "story_v_out_112251.awb") ~= 0 then
					local var_22_14 = manager.audio:GetVoiceLength("story_v_out_112251", "112251004", "story_v_out_112251.awb") / 1000

					if var_22_14 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_8
					end

					if var_22_10.prefab_name ~= "" and arg_19_1.actors_[var_22_10.prefab_name] ~= nil then
						local var_22_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_10.prefab_name].transform, "story_v_out_112251", "112251004", "story_v_out_112251.awb")

						arg_19_1:RecordAudio("112251004", var_22_15)
						arg_19_1:RecordAudio("112251004", var_22_15)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112251", "112251004", "story_v_out_112251.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112251", "112251004", "story_v_out_112251.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_16 = math.max(var_22_9, arg_19_1.talkMaxDuration)

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_16 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_8) / var_22_16

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_8 + var_22_16 and arg_19_1.time_ < var_22_8 + var_22_16 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play112251005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112251005
		arg_23_1.duration_ = 8.17

		local var_23_0 = {
			ja = 7.1,
			ko = 6.233,
			zh = 7.333,
			en = 8.166
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play112251006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1081ui_story"]) and arg_23_1.var_.characterEffect1081ui_story == nil then
				arg_23_1.var_.characterEffect1081ui_story = arg_23_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1081ui_story"]) then
				if arg_23_1.var_.characterEffect1081ui_story and not isNil(arg_23_1.actors_["1081ui_story"]) then
					arg_23_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1081ui_story"]) and arg_23_1.var_.characterEffect1081ui_story then
				arg_23_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_26_1 = 0
			local var_26_2 = 1

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(112251005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_6 = 33 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_4) / 33)

				if (33 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_4) / 33)) > 0 and var_26_2 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_1
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251005", "story_v_out_112251.awb") ~= 0 then
					local var_26_7 = manager.audio:GetVoiceLength("story_v_out_112251", "112251005", "story_v_out_112251.awb") / 1000

					if var_26_7 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_1
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_112251", "112251005", "story_v_out_112251.awb")

						arg_23_1:RecordAudio("112251005", var_26_8)
						arg_23_1:RecordAudio("112251005", var_26_8)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_112251", "112251005", "story_v_out_112251.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_112251", "112251005", "story_v_out_112251.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_9 = math.max(var_26_2, arg_23_1.talkMaxDuration)

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_9 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_1) / var_26_9

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_1 + var_26_9 and arg_23_1.time_ < var_26_1 + var_26_9 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play112251006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112251006
		arg_27_1.duration_ = 5.3

		local var_27_0 = {
			ja = 5.3,
			ko = 4.766,
			zh = 3.1,
			en = 3.4
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play112251007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 1

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:GetWordFromCfg(112251006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 16 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 16)

				if (16 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 16)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251006", "story_v_out_112251.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251006", "story_v_out_112251.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_112251", "112251006", "story_v_out_112251.awb")

						arg_27_1:RecordAudio("112251006", var_30_6)
						arg_27_1:RecordAudio("112251006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112251", "112251006", "story_v_out_112251.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112251", "112251006", "story_v_out_112251.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play112251007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112251007
		arg_31_1.duration_ = 12.47

		local var_31_0 = {
			ja = 12.466,
			ko = 9.566,
			zh = 7.433,
			en = 11.166
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play112251008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1081ui_story"]) and arg_31_1.var_.characterEffect1081ui_story == nil then
				arg_31_1.var_.characterEffect1081ui_story = arg_31_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1081ui_story"]) then
				if arg_31_1.var_.characterEffect1081ui_story and not isNil(arg_31_1.actors_["1081ui_story"]) then
					arg_31_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1081ui_story"]) and arg_31_1.var_.characterEffect1081ui_story then
				arg_31_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action475")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_34_2 = 0
			local var_34_3 = 1

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_4 = arg_31_1:GetWordFromCfg(112251007)
				local var_34_5 = arg_31_1:FormatText(var_34_4.content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 37 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 37)

				if (37 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 37)) > 0 and var_34_3 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251007", "story_v_out_112251.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251007", "story_v_out_112251.awb") / 1000

					if var_34_8 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_2
					end

					if var_34_4.prefab_name ~= "" and arg_31_1.actors_[var_34_4.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_4.prefab_name].transform, "story_v_out_112251", "112251007", "story_v_out_112251.awb")

						arg_31_1:RecordAudio("112251007", var_34_9)
						arg_31_1:RecordAudio("112251007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112251", "112251007", "story_v_out_112251.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112251", "112251007", "story_v_out_112251.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_10 and arg_31_1.time_ < var_34_2 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play112251008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112251008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play112251009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1081ui_story = arg_35_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1081ui_story"].transform.position).z)
				arg_35_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1081ui_story"].transform.localEulerAngles = arg_35_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1081ui_story"].transform.position).z)
				arg_35_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1081ui_story"].transform.localEulerAngles = arg_35_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_38_1 = 0
			local var_38_2 = 1

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(112251008).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 51 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 51)

				if (51 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 51)) > 0 and var_38_2 < var_38_5 then
					arg_35_1.talkMaxDuration = var_38_5

					if var_38_5 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_6 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_6 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_6

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_6 and arg_35_1.time_ < var_38_1 + var_38_6 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play112251009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112251009
		arg_39_1.duration_ = 0.03

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"

			SetActive(arg_39_1.choicesGo_, true)

			for iter_40_0, iter_40_1 in ipairs(arg_39_1.choices_) do
				SetActive(iter_40_1.go, iter_40_0 <= 2)
			end

			arg_39_1.choices_[1].txt.text = arg_39_1:FormatText(StoryChoiceCfg[133].name)
			arg_39_1.choices_[2].txt.text = arg_39_1:FormatText(StoryChoiceCfg[134].name)
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play112251010(arg_39_1)
			end

			if arg_41_0 == 2 then
				arg_39_0:Play112251013(arg_39_1)
			end

			arg_39_1:RecordChoiceLog(112251009, 133, 134)
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			return
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play112251010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112251010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play112251011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(112251010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 32 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 32)

				if (32 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 32)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play112251011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112251011
		arg_47_1.duration_ = 4.8

		local var_47_0 = {
			ja = 4.8,
			ko = 2.6,
			zh = 3,
			en = 3.5
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play112251012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1148ui_story = arg_47_1.actors_["1148ui_story"].transform.localPosition

				arg_47_1:ShowWeapon(arg_47_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1148ui_story"].transform.position).z)
				arg_47_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1148ui_story"].transform.localEulerAngles = arg_47_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_47_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1148ui_story"].transform.position).z)
				arg_47_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1148ui_story"].transform.localEulerAngles = arg_47_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1148ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1148ui_story == nil then
				arg_47_1.var_.characterEffect1148ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1148ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1148ui_story then
				arg_47_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_50_4 = 0
			local var_50_5 = 1

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(112251011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 10 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 10)

				if (10 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 10)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251011", "story_v_out_112251.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_112251", "112251011", "story_v_out_112251.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_112251", "112251011", "story_v_out_112251.awb")

						arg_47_1:RecordAudio("112251011", var_50_11)
						arg_47_1:RecordAudio("112251011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112251", "112251011", "story_v_out_112251.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112251", "112251011", "story_v_out_112251.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play112251012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112251012
		arg_51_1.duration_ = 8.4

		local var_51_0 = {
			ja = 6.266,
			ko = 5.333,
			zh = 4.333,
			en = 8.4
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play112251016(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1148ui_story = arg_51_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1148ui_story"].transform.position).z)
				arg_51_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1148ui_story"].transform.localEulerAngles = arg_51_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1148ui_story"].transform.position).z)
				arg_51_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1148ui_story"].transform.localEulerAngles = arg_51_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_54_1 = 0
			local var_54_2 = 1

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(112251012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 22 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 22)

				if (22 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 22)) > 0 and var_54_2 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251012", "story_v_out_112251.awb") ~= 0 then
					local var_54_7 = manager.audio:GetVoiceLength("story_v_out_112251", "112251012", "story_v_out_112251.awb") / 1000

					if var_54_7 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_1
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_112251", "112251012", "story_v_out_112251.awb")

						arg_51_1:RecordAudio("112251012", var_54_8)
						arg_51_1:RecordAudio("112251012", var_54_8)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112251", "112251012", "story_v_out_112251.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112251", "112251012", "story_v_out_112251.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_9 and arg_51_1.time_ < var_54_1 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play112251016 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112251016
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play112251017(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(112251016).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 28 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 28)

				if (28 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 28)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play112251017 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112251017
		arg_59_1.duration_ = 3.87

		local var_59_0 = {
			ja = 3.866,
			ko = 2.033,
			zh = 2.233,
			en = 2.2
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play112251018(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:GetWordFromCfg(112251017)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 5 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 5)

				if (5 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 5)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251017", "story_v_out_112251.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251017", "story_v_out_112251.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_112251", "112251017", "story_v_out_112251.awb")

						arg_59_1:RecordAudio("112251017", var_62_6)
						arg_59_1:RecordAudio("112251017", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112251", "112251017", "story_v_out_112251.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112251", "112251017", "story_v_out_112251.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play112251018 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112251018
		arg_63_1.duration_ = 2.4

		local var_63_0 = {
			ja = 2.4,
			ko = 1.6,
			zh = 1.666,
			en = 2.166
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play112251019(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(112251018)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 4 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 4)

				if (4 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 4)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251018", "story_v_out_112251.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251018", "story_v_out_112251.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_112251", "112251018", "story_v_out_112251.awb")

						arg_63_1:RecordAudio("112251018", var_66_6)
						arg_63_1:RecordAudio("112251018", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112251", "112251018", "story_v_out_112251.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112251", "112251018", "story_v_out_112251.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play112251019 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112251019
		arg_67_1.duration_ = 5.63

		local var_67_0 = {
			ja = 5.633,
			ko = 2.233,
			zh = 2.7,
			en = 3.8
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play112251020(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(112251019)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 9 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 9)

				if (9 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 9)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251019", "story_v_out_112251.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251019", "story_v_out_112251.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_112251", "112251019", "story_v_out_112251.awb")

						arg_67_1:RecordAudio("112251019", var_70_6)
						arg_67_1:RecordAudio("112251019", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112251", "112251019", "story_v_out_112251.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112251", "112251019", "story_v_out_112251.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play112251020 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112251020
		arg_71_1.duration_ = 5.47

		local var_71_0 = {
			ja = 5.466,
			ko = 4.333,
			zh = 3.133,
			en = 4.233
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
				arg_71_0:Play112251021(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1039ui_story = arg_71_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1039ui_story"].transform.position).z)
				arg_71_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1039ui_story"].transform.localEulerAngles = arg_71_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_71_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1039ui_story"].transform.position).z)
				arg_71_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1039ui_story"].transform.localEulerAngles = arg_71_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1039ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1039ui_story == nil then
				arg_71_1.var_.characterEffect1039ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1039ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1039ui_story then
				arg_71_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_74_4 = 0
			local var_74_5 = 1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(112251020)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 12 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 12)

				if (12 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 12)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251020", "story_v_out_112251.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_112251", "112251020", "story_v_out_112251.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_112251", "112251020", "story_v_out_112251.awb")

						arg_71_1:RecordAudio("112251020", var_74_11)
						arg_71_1:RecordAudio("112251020", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112251", "112251020", "story_v_out_112251.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112251", "112251020", "story_v_out_112251.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play112251021 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112251021
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play112251022(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1039ui_story"]) and arg_75_1.var_.characterEffect1039ui_story == nil then
				arg_75_1.var_.characterEffect1039ui_story = arg_75_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1039ui_story"]) then
				if arg_75_1.var_.characterEffect1039ui_story and not isNil(arg_75_1.actors_["1039ui_story"]) then
					arg_75_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1039ui_story"]) and arg_75_1.var_.characterEffect1039ui_story then
				arg_75_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 1

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(112251021).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 6 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 6)

				if (6 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 6)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play112251022 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 112251022
		arg_79_1.duration_ = 10.2

		local var_79_0 = {
			ja = 10.2,
			ko = 6.5,
			zh = 6.066,
			en = 8.133
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play112251023(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1039ui_story"]) and arg_79_1.var_.characterEffect1039ui_story == nil then
				arg_79_1.var_.characterEffect1039ui_story = arg_79_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1039ui_story"]) then
				if arg_79_1.var_.characterEffect1039ui_story and not isNil(arg_79_1.actors_["1039ui_story"]) then
					arg_79_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1039ui_story"]) and arg_79_1.var_.characterEffect1039ui_story then
				arg_79_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action465")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_82_2 = 0
			local var_82_3 = 1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(112251022)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 30 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 30)

				if (30 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 30)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251022", "story_v_out_112251.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251022", "story_v_out_112251.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_112251", "112251022", "story_v_out_112251.awb")

						arg_79_1:RecordAudio("112251022", var_82_9)
						arg_79_1:RecordAudio("112251022", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_112251", "112251022", "story_v_out_112251.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_112251", "112251022", "story_v_out_112251.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play112251023 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 112251023
		arg_83_1.duration_ = 19.23

		local var_83_0 = {
			ja = 19.233,
			ko = 13.833,
			zh = 14.3,
			en = 9.366
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play112251024(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_86_0 = 0
			local var_86_1 = 1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(112251023)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 53 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 53)

				if (53 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 53)) > 0 and var_86_1 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251023", "story_v_out_112251.awb") ~= 0 then
					local var_86_6 = manager.audio:GetVoiceLength("story_v_out_112251", "112251023", "story_v_out_112251.awb") / 1000

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end

					if var_86_2.prefab_name ~= "" and arg_83_1.actors_[var_86_2.prefab_name] ~= nil then
						local var_86_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_2.prefab_name].transform, "story_v_out_112251", "112251023", "story_v_out_112251.awb")

						arg_83_1:RecordAudio("112251023", var_86_7)
						arg_83_1:RecordAudio("112251023", var_86_7)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_112251", "112251023", "story_v_out_112251.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_112251", "112251023", "story_v_out_112251.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play112251024 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 112251024
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play112251025(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1039ui_story = arg_87_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1039ui_story"].transform.position).z)
				arg_87_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1039ui_story"].transform.localEulerAngles = arg_87_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1039ui_story"].transform.position).z)
				arg_87_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1039ui_story"].transform.localEulerAngles = arg_87_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_90_1 = 0
			local var_90_2 = 1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(112251024).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 55 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 55)

				if (55 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 55)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play112251025 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 112251025
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play112251026(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
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

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(112251025).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 43 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 43)

				if (43 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 43)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play112251026 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 112251026
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play112251027(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(112251026).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 11 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 11)

				if (11 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 11)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play112251027 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 112251027
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play112251028(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(112251027).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 28 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 28)

				if (28 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 28)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play112251028 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 112251028
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play112251029(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(112251028).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 17 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 17)

				if (17 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 17)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play112251029 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 112251029
		arg_107_1.duration_ = 2.83

		local var_107_0 = {
			ja = 2,
			ko = 2.833,
			zh = 2.8,
			en = 2.4
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
				arg_107_0:Play112251030(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1148ui_story = arg_107_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1148ui_story"].transform.position).z)
				arg_107_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1148ui_story"].transform.localEulerAngles = arg_107_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_107_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1148ui_story"].transform.position).z)
				arg_107_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1148ui_story"].transform.localEulerAngles = arg_107_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1148ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1148ui_story == nil then
				arg_107_1.var_.characterEffect1148ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1148ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1148ui_story then
				arg_107_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_110_4 = 0
			local var_110_5 = 1

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(112251029)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 6 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 6)

				if (6 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 6)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251029", "story_v_out_112251.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_112251", "112251029", "story_v_out_112251.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_112251", "112251029", "story_v_out_112251.awb")

						arg_107_1:RecordAudio("112251029", var_110_11)
						arg_107_1:RecordAudio("112251029", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_112251", "112251029", "story_v_out_112251.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_112251", "112251029", "story_v_out_112251.awb")
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

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play112251030 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 112251030
		arg_111_1.duration_ = 4.63

		local var_111_0 = {
			ja = 4.1,
			ko = 4.333,
			zh = 4.133,
			en = 4.633
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
				arg_111_0:Play112251031(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1148ui_story = arg_111_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).z)
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles = arg_111_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1148ui_story"].transform.position).z)
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1148ui_story"].transform.localEulerAngles = arg_111_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_114_1 = "1027ui_story"

			if arg_111_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_114_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_111_1.stage_.transform)

				var_114_2.name = var_114_1
				var_114_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_[var_114_1] = var_114_2

				local var_114_3 = var_114_2:GetComponentInChildren(typeof(CharacterEffect))

				var_114_3.enabled = true

				local var_114_4 = GameObjectTools.GetOrAddComponent(var_114_2, typeof(DynamicBoneHelper))

				if var_114_4 then
					var_114_4:EnableDynamicBone(false)
				end

				arg_111_1:ShowWeapon(var_114_3.transform, false)

				arg_111_1.var_[var_114_1 .. "Animator"] = var_114_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_111_1.var_[var_114_1 .. "Animator"].applyRootMotion = true
				arg_111_1.var_[var_114_1 .. "LipSync"] = var_114_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_114_5 = arg_111_1.actors_["1027ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1027ui_story = var_114_5.localPosition

				arg_111_1:ShowWeapon(arg_111_1.var_["1027ui_story" .. "Animator"].transform, false)
			end

			local var_114_6 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 then
				var_114_5.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_111_1.time_ - 0) / var_114_6)
				var_114_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_5.position).x, (manager.ui.mainCamera.transform.position - var_114_5.position).y, (manager.ui.mainCamera.transform.position - var_114_5.position).z)
				var_114_5.localEulerAngles.z = 0
				var_114_5.localEulerAngles.x = 0
				var_114_5.localEulerAngles = var_114_5.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 then
				var_114_5.localPosition = Vector3.New(0, -0.81, -5.8)
				var_114_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_5.position).x, (manager.ui.mainCamera.transform.position - var_114_5.position).y, (manager.ui.mainCamera.transform.position - var_114_5.position).z)
				var_114_5.localEulerAngles.z = 0
				var_114_5.localEulerAngles.x = 0
				var_114_5.localEulerAngles = var_114_5.localEulerAngles
			end

			local var_114_7 = arg_111_1.actors_["1027ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.characterEffect1027ui_story == nil then
				arg_111_1.var_.characterEffect1027ui_story = var_114_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_8 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_8 and not isNil(var_114_7) then
				if arg_111_1.var_.characterEffect1027ui_story and not isNil(var_114_7) then
					arg_111_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_8 and arg_111_1.time_ < 0 + var_114_8 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.characterEffect1027ui_story then
				arg_111_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_114_10 = 0
			local var_114_11 = 1

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_12 = arg_111_1:GetWordFromCfg(112251030)
				local var_114_13 = arg_111_1:FormatText(var_114_12.content)

				arg_111_1.text_.text = var_114_13

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 16 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 16)

				if (16 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 16)) > 0 and var_114_11 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_10
					end
				end

				arg_111_1.text_.text = var_114_13
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251030", "story_v_out_112251.awb") ~= 0 then
					local var_114_16 = manager.audio:GetVoiceLength("story_v_out_112251", "112251030", "story_v_out_112251.awb") / 1000

					if var_114_16 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_10
					end

					if var_114_12.prefab_name ~= "" and arg_111_1.actors_[var_114_12.prefab_name] ~= nil then
						local var_114_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_12.prefab_name].transform, "story_v_out_112251", "112251030", "story_v_out_112251.awb")

						arg_111_1:RecordAudio("112251030", var_114_17)
						arg_111_1:RecordAudio("112251030", var_114_17)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_112251", "112251030", "story_v_out_112251.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_112251", "112251030", "story_v_out_112251.awb")
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play112251031 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 112251031
		arg_115_1.duration_ = 5.9

		local var_115_0 = {
			ja = 5.3,
			ko = 4.6,
			zh = 4.666,
			en = 5.9
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play112251032(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1027ui_story = arg_115_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1027ui_story"].transform.position).z)
				arg_115_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1027ui_story"].transform.localEulerAngles = arg_115_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1027ui_story"].transform.position).z)
				arg_115_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1027ui_story"].transform.localEulerAngles = arg_115_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_118_1 = "1084ui_story"

			if arg_115_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_118_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_115_1.stage_.transform)

				var_118_2.name = var_118_1
				var_118_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_[var_118_1] = var_118_2

				local var_118_3 = var_118_2:GetComponentInChildren(typeof(CharacterEffect))

				var_118_3.enabled = true

				local var_118_4 = GameObjectTools.GetOrAddComponent(var_118_2, typeof(DynamicBoneHelper))

				if var_118_4 then
					var_118_4:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_3.transform, false)

				arg_115_1.var_[var_118_1 .. "Animator"] = var_118_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_[var_118_1 .. "Animator"].applyRootMotion = true
				arg_115_1.var_[var_118_1 .. "LipSync"] = var_118_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_5 = arg_115_1.actors_["1084ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_5.localPosition

				arg_115_1:ShowWeapon(arg_115_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_118_6 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_115_1.time_ - 0) / var_118_6)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, -0.97, -6)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			local var_118_7 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_8 and not isNil(var_118_7) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_7) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_8 and arg_115_1.time_ < 0 + var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_118_10 = 0
			local var_118_11 = 1

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_12 = arg_115_1:GetWordFromCfg(112251031)
				local var_118_13 = arg_115_1:FormatText(var_118_12.content)

				arg_115_1.text_.text = var_118_13

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_15 = 22 <= 0 and var_118_11 or var_118_11 * (utf8.len(var_118_13) / 22)

				if (22 <= 0 and var_118_11 or var_118_11 * (utf8.len(var_118_13) / 22)) > 0 and var_118_11 < var_118_15 then
					arg_115_1.talkMaxDuration = var_118_15

					if var_118_15 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_10
					end
				end

				arg_115_1.text_.text = var_118_13
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251031", "story_v_out_112251.awb") ~= 0 then
					local var_118_16 = manager.audio:GetVoiceLength("story_v_out_112251", "112251031", "story_v_out_112251.awb") / 1000

					if var_118_16 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_10
					end

					if var_118_12.prefab_name ~= "" and arg_115_1.actors_[var_118_12.prefab_name] ~= nil then
						local var_118_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_12.prefab_name].transform, "story_v_out_112251", "112251031", "story_v_out_112251.awb")

						arg_115_1:RecordAudio("112251031", var_118_17)
						arg_115_1:RecordAudio("112251031", var_118_17)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_112251", "112251031", "story_v_out_112251.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_112251", "112251031", "story_v_out_112251.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_18 = math.max(var_118_11, arg_115_1.talkMaxDuration)

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_18 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_10) / var_118_18

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_10 + var_118_18 and arg_115_1.time_ < var_118_10 + var_118_18 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play112251032 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 112251032
		arg_119_1.duration_ = 4.7

		local var_119_0 = {
			ja = 4.6,
			ko = 4.7,
			zh = 3.7,
			en = 3.066
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
				arg_119_0:Play112251033(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1084ui_story = arg_119_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).z)
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles = arg_119_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).z)
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles = arg_119_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1039ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1039ui_story = var_122_1.localPosition
			end

			local var_122_2 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 then
				var_122_1.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_119_1.time_ - 0) / var_122_2)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 then
				var_122_1.localPosition = Vector3.New(0, -1.01, -5.9)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles
			end

			local var_122_3 = arg_119_1.actors_["1039ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.characterEffect1039ui_story == nil then
				arg_119_1.var_.characterEffect1039ui_story = var_122_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_4 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 and not isNil(var_122_3) then
				if arg_119_1.var_.characterEffect1039ui_story and not isNil(var_122_3) then
					arg_119_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.characterEffect1039ui_story then
				arg_119_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_122_6 = 0
			local var_122_7 = 1

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(112251032)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 18 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 18)

				if (18 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 18)) > 0 and var_122_7 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251032", "story_v_out_112251.awb") ~= 0 then
					local var_122_12 = manager.audio:GetVoiceLength("story_v_out_112251", "112251032", "story_v_out_112251.awb") / 1000

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end

					if var_122_8.prefab_name ~= "" and arg_119_1.actors_[var_122_8.prefab_name] ~= nil then
						local var_122_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_8.prefab_name].transform, "story_v_out_112251", "112251032", "story_v_out_112251.awb")

						arg_119_1:RecordAudio("112251032", var_122_13)
						arg_119_1:RecordAudio("112251032", var_122_13)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_112251", "112251032", "story_v_out_112251.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_112251", "112251032", "story_v_out_112251.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play112251033 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 112251033
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play112251034(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1039ui_story = arg_123_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1039ui_story"].transform.position).z)
				arg_123_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1039ui_story"].transform.localEulerAngles = arg_123_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1039ui_story"].transform.position).z)
				arg_123_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1039ui_story"].transform.localEulerAngles = arg_123_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_126_1 = 0
			local var_126_2 = 1

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(112251033).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 23 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 23)

				if (23 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 23)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play112251034 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 112251034
		arg_127_1.duration_ = 7.03

		local var_127_0 = {
			ja = 6.3,
			ko = 4.766,
			zh = 5.666,
			en = 7.033
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
				arg_127_0:Play112251035(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1081ui_story = arg_127_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1081ui_story"].transform.position).z)
				arg_127_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1081ui_story"].transform.localEulerAngles = arg_127_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_127_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1081ui_story"].transform.position).z)
				arg_127_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1081ui_story"].transform.localEulerAngles = arg_127_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1081ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1081ui_story == nil then
				arg_127_1.var_.characterEffect1081ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1081ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1081ui_story then
				arg_127_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_130_4 = 0
			local var_130_5 = 1

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(112251034)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 27 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 27)

				if (27 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 27)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251034", "story_v_out_112251.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_112251", "112251034", "story_v_out_112251.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_112251", "112251034", "story_v_out_112251.awb")

						arg_127_1:RecordAudio("112251034", var_130_11)
						arg_127_1:RecordAudio("112251034", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_112251", "112251034", "story_v_out_112251.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_112251", "112251034", "story_v_out_112251.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play112251035 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 112251035
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play112251036(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1081ui_story"]) and arg_131_1.var_.characterEffect1081ui_story == nil then
				arg_131_1.var_.characterEffect1081ui_story = arg_131_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1081ui_story"]) then
				if arg_131_1.var_.characterEffect1081ui_story and not isNil(arg_131_1.actors_["1081ui_story"]) then
					arg_131_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1081ui_story"]) and arg_131_1.var_.characterEffect1081ui_story then
				arg_131_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(112251035).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 9 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 9)

				if (9 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 9)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play112251036 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 112251036
		arg_135_1.duration_ = 7.3

		local var_135_0 = {
			ja = 7.3,
			ko = 5.966,
			zh = 4.4,
			en = 5.966
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
				arg_135_0:Play112251037(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1081ui_story"]) and arg_135_1.var_.characterEffect1081ui_story == nil then
				arg_135_1.var_.characterEffect1081ui_story = arg_135_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1081ui_story"]) then
				if arg_135_1.var_.characterEffect1081ui_story and not isNil(arg_135_1.actors_["1081ui_story"]) then
					arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1081ui_story"]) and arg_135_1.var_.characterEffect1081ui_story then
				arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_138_2 = 0
			local var_138_3 = 1

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:GetWordFromCfg(112251036)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 25 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 25)

				if (25 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 25)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251036", "story_v_out_112251.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251036", "story_v_out_112251.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_112251", "112251036", "story_v_out_112251.awb")

						arg_135_1:RecordAudio("112251036", var_138_9)
						arg_135_1:RecordAudio("112251036", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_112251", "112251036", "story_v_out_112251.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_112251", "112251036", "story_v_out_112251.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play112251037 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 112251037
		arg_139_1.duration_ = 11.3

		local var_139_0 = {
			ja = 11.3,
			ko = 8.066,
			zh = 8.866,
			en = 10
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play112251038(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_142_0 = 0
			local var_142_1 = 1

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(112251037)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 45 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 45)

				if (45 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 45)) > 0 and var_142_1 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251037", "story_v_out_112251.awb") ~= 0 then
					local var_142_6 = manager.audio:GetVoiceLength("story_v_out_112251", "112251037", "story_v_out_112251.awb") / 1000

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end

					if var_142_2.prefab_name ~= "" and arg_139_1.actors_[var_142_2.prefab_name] ~= nil then
						local var_142_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_2.prefab_name].transform, "story_v_out_112251", "112251037", "story_v_out_112251.awb")

						arg_139_1:RecordAudio("112251037", var_142_7)
						arg_139_1:RecordAudio("112251037", var_142_7)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_112251", "112251037", "story_v_out_112251.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_112251", "112251037", "story_v_out_112251.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play112251038 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 112251038
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play112251039(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1081ui_story"]) and arg_143_1.var_.characterEffect1081ui_story == nil then
				arg_143_1.var_.characterEffect1081ui_story = arg_143_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1081ui_story"]) then
				if arg_143_1.var_.characterEffect1081ui_story and not isNil(arg_143_1.actors_["1081ui_story"]) then
					arg_143_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1081ui_story"]) and arg_143_1.var_.characterEffect1081ui_story then
				arg_143_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 1

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(112251038).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 26 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 26)

				if (26 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 26)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play112251039 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 112251039
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play112251040(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1081ui_story = arg_147_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).z)
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles = arg_147_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1081ui_story"].transform.position).z)
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1081ui_story"].transform.localEulerAngles = arg_147_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_150_1 = 0
			local var_150_2 = 1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(112251039).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 28 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 28)

				if (28 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 28)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play112251040 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 112251040
		arg_151_1.duration_ = 5.47

		local var_151_0 = {
			ja = 4.1,
			ko = 3.7,
			zh = 4.266,
			en = 5.466
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play112251041(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:GetWordFromCfg(112251040)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 15 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 15)

				if (15 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 15)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251040", "story_v_out_112251.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251040", "story_v_out_112251.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_112251", "112251040", "story_v_out_112251.awb")

						arg_151_1:RecordAudio("112251040", var_154_6)
						arg_151_1:RecordAudio("112251040", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_112251", "112251040", "story_v_out_112251.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_112251", "112251040", "story_v_out_112251.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play112251041 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 112251041
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play112251042(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(112251041).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 37 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 37)

				if (37 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 37)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play112251042 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 112251042
		arg_159_1.duration_ = 6

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play112251043(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_0 = 0.5

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				local var_162_1 = Color.New(1, 1, 1)

				var_162_1.a = Mathf.Lerp(0, 1, (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.mask_.color = var_162_1
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				local var_162_2 = Color.New(1, 1, 1)

				var_162_2.a = 1
				arg_159_1.mask_.color = var_162_2
			end

			local var_162_3 = 0.5

			if 0.5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_4 = 0.5

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_4 then
				local var_162_5 = Color.New(1, 1, 1)

				var_162_5.a = Mathf.Lerp(1, 0, (arg_159_1.time_ - var_162_3) / var_162_4)
				arg_159_1.mask_.color = var_162_5
			end

			if arg_159_1.time_ >= var_162_3 + var_162_4 and arg_159_1.time_ < var_162_3 + var_162_4 + arg_162_0 then
				local var_162_6 = Color.New(1, 1, 1)

				arg_159_1.mask_.enabled = false
				var_162_6.a = 0
				arg_159_1.mask_.color = var_162_6
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_7 = 1
			local var_162_8 = 1

			if 1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_9 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_9:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(112251042).content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 43 <= 0 and var_162_8 or var_162_8 * (utf8.len(var_162_10) / 43)

				if (43 <= 0 and var_162_8 or var_162_8 * (utf8.len(var_162_10) / 43)) > 0 and var_162_8 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12
					var_162_7 = var_162_7 + 0.3

					if var_162_12 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = var_162_7 + 0.3
			local var_162_14 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 + 0.3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_13 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_13) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_13 + var_162_14 and arg_159_1.time_ < var_162_13 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play112251043 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 112251043
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play112251044(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(112251043).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 23 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 23)

				if (23 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 23)) > 0 and var_168_0 < var_168_3 then
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
	Play112251044 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 112251044
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play112251045(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1148ui_story = arg_169_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1148ui_story"].transform.position).z)
				arg_169_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1148ui_story"].transform.localEulerAngles = arg_169_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_169_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1148ui_story"].transform.position).z)
				arg_169_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1148ui_story"].transform.localEulerAngles = arg_169_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_172_1 = 0
			local var_172_2 = 1

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(112251044).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 35 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 35)

				if (35 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 35)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play112251045 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 112251045
		arg_173_1.duration_ = 7.5

		local var_173_0 = {
			ja = 7.5,
			ko = 5.166,
			zh = 5.433,
			en = 5.3
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
				arg_173_0:Play112251046(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(112251045)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 18 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 18)

				if (18 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 18)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251045", "story_v_out_112251.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251045", "story_v_out_112251.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_112251", "112251045", "story_v_out_112251.awb")

						arg_173_1:RecordAudio("112251045", var_176_6)
						arg_173_1:RecordAudio("112251045", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_112251", "112251045", "story_v_out_112251.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_112251", "112251045", "story_v_out_112251.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play112251046 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 112251046
		arg_177_1.duration_ = 5.8

		local var_177_0 = {
			ja = 5.8,
			ko = 4.733,
			zh = 5.5,
			en = 4.9
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
				arg_177_0:Play112251047(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:GetWordFromCfg(112251046)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 16 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 16)

				if (16 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 16)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251046", "story_v_out_112251.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251046", "story_v_out_112251.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_112251", "112251046", "story_v_out_112251.awb")

						arg_177_1:RecordAudio("112251046", var_180_6)
						arg_177_1:RecordAudio("112251046", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_112251", "112251046", "story_v_out_112251.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_112251", "112251046", "story_v_out_112251.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play112251047 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 112251047
		arg_181_1.duration_ = 19.3

		local var_181_0 = {
			ja = 9.966,
			ko = 11.033,
			zh = 14.933,
			en = 19.3
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
				arg_181_0:Play112251048(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1148ui_story"]) and arg_181_1.var_.characterEffect1148ui_story == nil then
				arg_181_1.var_.characterEffect1148ui_story = arg_181_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1148ui_story"]) then
				if arg_181_1.var_.characterEffect1148ui_story and not isNil(arg_181_1.actors_["1148ui_story"]) then
					arg_181_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1148ui_story"]) and arg_181_1.var_.characterEffect1148ui_story then
				arg_181_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_184_2 = 0
			local var_184_3 = 1

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(112251047)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 62 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 62)

				if (62 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 62)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251047", "story_v_out_112251.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251047", "story_v_out_112251.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_out_112251", "112251047", "story_v_out_112251.awb")

						arg_181_1:RecordAudio("112251047", var_184_9)
						arg_181_1:RecordAudio("112251047", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_112251", "112251047", "story_v_out_112251.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_112251", "112251047", "story_v_out_112251.awb")
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
	Play112251048 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 112251048
		arg_185_1.duration_ = 5.87

		local var_185_0 = {
			ja = 3.433,
			ko = 4.4,
			zh = 2.966,
			en = 5.866
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
				arg_185_0:Play112251049(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1148ui_story"]) and arg_185_1.var_.characterEffect1148ui_story == nil then
				arg_185_1.var_.characterEffect1148ui_story = arg_185_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1148ui_story"]) then
				if arg_185_1.var_.characterEffect1148ui_story and not isNil(arg_185_1.actors_["1148ui_story"]) then
					arg_185_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1148ui_story"]) and arg_185_1.var_.characterEffect1148ui_story then
				arg_185_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0
			local var_188_2 = 1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(112251048)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 12 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_4) / 12)

				if (12 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_4) / 12)) > 0 and var_188_2 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251048", "story_v_out_112251.awb") ~= 0 then
					local var_188_7 = manager.audio:GetVoiceLength("story_v_out_112251", "112251048", "story_v_out_112251.awb") / 1000

					if var_188_7 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_1
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_112251", "112251048", "story_v_out_112251.awb")

						arg_185_1:RecordAudio("112251048", var_188_8)
						arg_185_1:RecordAudio("112251048", var_188_8)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_112251", "112251048", "story_v_out_112251.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_112251", "112251048", "story_v_out_112251.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_9 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_9 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_9

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_9 and arg_185_1.time_ < var_188_1 + var_188_9 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play112251049 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 112251049
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play112251050(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1148ui_story = arg_189_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1148ui_story"].transform.position).z)
				arg_189_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1148ui_story"].transform.localEulerAngles = arg_189_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1148ui_story"].transform.position).z)
				arg_189_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1148ui_story"].transform.localEulerAngles = arg_189_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_192_1 = 0
			local var_192_2 = 1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(112251049).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 31 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 31)

				if (31 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 31)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play112251050 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 112251050
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play112251051(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
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

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(112251050).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 14)

				if (14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 14)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play112251051 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 112251051
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play112251052(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1027ui_story = arg_197_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1027ui_story"].transform.position).z)
				arg_197_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1027ui_story"].transform.localEulerAngles = arg_197_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_197_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1027ui_story"].transform.position).z)
				arg_197_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1027ui_story"].transform.localEulerAngles = arg_197_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_200_1 = 0
			local var_200_2 = 1

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(112251051).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 40 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 40)

				if (40 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 40)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_6 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_6 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_6

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_6 and arg_197_1.time_ < var_200_1 + var_200_6 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play112251052 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 112251052
		arg_201_1.duration_ = 8.6

		local var_201_0 = {
			ja = 5.6,
			ko = 8.366,
			zh = 8.6,
			en = 6.733
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play112251053(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_204_0 = 0
			local var_204_1 = 1

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_2 = arg_201_1:GetWordFromCfg(112251052)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 33 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 33)

				if (33 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 33)) > 0 and var_204_1 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251052", "story_v_out_112251.awb") ~= 0 then
					local var_204_6 = manager.audio:GetVoiceLength("story_v_out_112251", "112251052", "story_v_out_112251.awb") / 1000

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end

					if var_204_2.prefab_name ~= "" and arg_201_1.actors_[var_204_2.prefab_name] ~= nil then
						local var_204_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_2.prefab_name].transform, "story_v_out_112251", "112251052", "story_v_out_112251.awb")

						arg_201_1:RecordAudio("112251052", var_204_7)
						arg_201_1:RecordAudio("112251052", var_204_7)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_112251", "112251052", "story_v_out_112251.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_112251", "112251052", "story_v_out_112251.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play112251053 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 112251053
		arg_205_1.duration_ = 12.77

		local var_205_0 = {
			ja = 12.766,
			ko = 11.366,
			zh = 10.5,
			en = 10.466
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play112251054(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1027ui_story"]) and arg_205_1.var_.characterEffect1027ui_story == nil then
				arg_205_1.var_.characterEffect1027ui_story = arg_205_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1027ui_story"]) then
				if arg_205_1.var_.characterEffect1027ui_story and not isNil(arg_205_1.actors_["1027ui_story"]) then
					arg_205_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1027ui_story"]) and arg_205_1.var_.characterEffect1027ui_story then
				arg_205_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action464")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_208_2 = 0
			local var_208_3 = 1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(112251053)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 48 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 48)

				if (48 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 48)) > 0 and var_208_3 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251053", "story_v_out_112251.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251053", "story_v_out_112251.awb") / 1000

					if var_208_8 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_2
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_out_112251", "112251053", "story_v_out_112251.awb")

						arg_205_1:RecordAudio("112251053", var_208_9)
						arg_205_1:RecordAudio("112251053", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_112251", "112251053", "story_v_out_112251.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_112251", "112251053", "story_v_out_112251.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_10 and arg_205_1.time_ < var_208_2 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play112251054 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 112251054
		arg_209_1.duration_ = 14.4

		local var_209_0 = {
			ja = 14.4,
			ko = 10.5,
			zh = 10.266,
			en = 12.7
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play112251055(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1027ui_story"]) and arg_209_1.var_.characterEffect1027ui_story == nil then
				arg_209_1.var_.characterEffect1027ui_story = arg_209_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1027ui_story"]) then
				if arg_209_1.var_.characterEffect1027ui_story and not isNil(arg_209_1.actors_["1027ui_story"]) then
					arg_209_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1027ui_story"]) and arg_209_1.var_.characterEffect1027ui_story then
				arg_209_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 1

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(112251054)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 44 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 44)

				if (44 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 44)) > 0 and var_212_2 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251054", "story_v_out_112251.awb") ~= 0 then
					local var_212_7 = manager.audio:GetVoiceLength("story_v_out_112251", "112251054", "story_v_out_112251.awb") / 1000

					if var_212_7 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_1
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_112251", "112251054", "story_v_out_112251.awb")

						arg_209_1:RecordAudio("112251054", var_212_8)
						arg_209_1:RecordAudio("112251054", var_212_8)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_112251", "112251054", "story_v_out_112251.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_112251", "112251054", "story_v_out_112251.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_9 and arg_209_1.time_ < var_212_1 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play112251055 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 112251055
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play112251056(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action443")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_216_0 = 0
			local var_216_1 = 1

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(112251055).content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 11 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_2) / 11)

				if (11 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_2) / 11)) > 0 and var_216_1 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_5 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_5 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_5

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_5 and arg_213_1.time_ < var_216_0 + var_216_5 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play112251056 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 112251056
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play112251057(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1027ui_story = arg_217_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).z)
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles = arg_217_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).z)
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles = arg_217_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_220_1 = 0
			local var_220_2 = 1

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(112251056).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 15 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 15)

				if (15 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 15)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play112251057 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 112251057
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play112251058(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1084ui_story = arg_221_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1084ui_story"].transform.position).z)
				arg_221_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1084ui_story"].transform.localEulerAngles = arg_221_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_221_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1084ui_story"].transform.position).z)
				arg_221_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1084ui_story"].transform.localEulerAngles = arg_221_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_224_1 = 0
			local var_224_2 = 1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(112251057).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 58 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 58)

				if (58 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 58)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play112251058 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 112251058
		arg_225_1.duration_ = 11.27

		local var_225_0 = {
			ja = 11.266,
			ko = 8.566,
			zh = 8.833,
			en = 7.466
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
				arg_225_0:Play112251059(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1084ui_story"]) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = arg_225_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1084ui_story"]) then
				if arg_225_1.var_.characterEffect1084ui_story and not isNil(arg_225_1.actors_["1084ui_story"]) then
					arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1084ui_story"]) and arg_225_1.var_.characterEffect1084ui_story then
				arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action476")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_228_2 = 0
			local var_228_3 = 1

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(112251058)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 41 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 41)

				if (41 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 41)) > 0 and var_228_3 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251058", "story_v_out_112251.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251058", "story_v_out_112251.awb") / 1000

					if var_228_8 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_2
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_out_112251", "112251058", "story_v_out_112251.awb")

						arg_225_1:RecordAudio("112251058", var_228_9)
						arg_225_1:RecordAudio("112251058", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_112251", "112251058", "story_v_out_112251.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_112251", "112251058", "story_v_out_112251.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_10 and arg_225_1.time_ < var_228_2 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play112251059 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 112251059
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play112251060(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1084ui_story = arg_229_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1084ui_story"].transform.position).z)
				arg_229_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1084ui_story"].transform.localEulerAngles = arg_229_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1084ui_story"].transform.position).z)
				arg_229_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1084ui_story"].transform.localEulerAngles = arg_229_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_232_1 = 0
			local var_232_2 = 1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(112251059).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 25 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 25)

				if (25 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 25)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play112251060 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 112251060
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play112251061(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(112251060).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 12 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 12)

				if (12 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 12)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play112251061 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 112251061
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play112251062(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(112251061).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 25 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 25)

				if (25 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 25)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play112251062 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 112251062
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play112251063(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1039ui_story = arg_241_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1039ui_story"].transform.position).z)
				arg_241_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1039ui_story"].transform.localEulerAngles = arg_241_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_241_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1039ui_story"].transform.position).z)
				arg_241_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1039ui_story"].transform.localEulerAngles = arg_241_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_244_1 = 0
			local var_244_2 = 1

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(112251062).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 66 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 66)

				if (66 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 66)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play112251063 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 112251063
		arg_245_1.duration_ = 11.67

		local var_245_0 = {
			ja = 11.666,
			ko = 7.033,
			zh = 8.566,
			en = 7.733
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play112251064(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1039ui_story"]) and arg_245_1.var_.characterEffect1039ui_story == nil then
				arg_245_1.var_.characterEffect1039ui_story = arg_245_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1039ui_story"]) then
				if arg_245_1.var_.characterEffect1039ui_story and not isNil(arg_245_1.actors_["1039ui_story"]) then
					arg_245_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1039ui_story"]) and arg_245_1.var_.characterEffect1039ui_story then
				arg_245_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_248_2 = 0
			local var_248_3 = 1

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(112251063)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 36 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 36)

				if (36 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 36)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251063", "story_v_out_112251.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251063", "story_v_out_112251.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_out_112251", "112251063", "story_v_out_112251.awb")

						arg_245_1:RecordAudio("112251063", var_248_9)
						arg_245_1:RecordAudio("112251063", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_112251", "112251063", "story_v_out_112251.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_112251", "112251063", "story_v_out_112251.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play112251064 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 112251064
		arg_249_1.duration_ = 12.47

		local var_249_0 = {
			ja = 12.466,
			ko = 6.7,
			zh = 4.7,
			en = 6.933
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play112251065(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action465")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_252_0 = 0
			local var_252_1 = 1

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(112251064)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 21 <= 0 and var_252_1 or var_252_1 * (utf8.len(var_252_3) / 21)

				if (21 <= 0 and var_252_1 or var_252_1 * (utf8.len(var_252_3) / 21)) > 0 and var_252_1 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251064", "story_v_out_112251.awb") ~= 0 then
					local var_252_6 = manager.audio:GetVoiceLength("story_v_out_112251", "112251064", "story_v_out_112251.awb") / 1000

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end

					if var_252_2.prefab_name ~= "" and arg_249_1.actors_[var_252_2.prefab_name] ~= nil then
						local var_252_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_2.prefab_name].transform, "story_v_out_112251", "112251064", "story_v_out_112251.awb")

						arg_249_1:RecordAudio("112251064", var_252_7)
						arg_249_1:RecordAudio("112251064", var_252_7)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_112251", "112251064", "story_v_out_112251.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_112251", "112251064", "story_v_out_112251.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play112251065 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 112251065
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play112251066(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1039ui_story"]) and arg_253_1.var_.characterEffect1039ui_story == nil then
				arg_253_1.var_.characterEffect1039ui_story = arg_253_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1039ui_story"]) then
				if arg_253_1.var_.characterEffect1039ui_story and not isNil(arg_253_1.actors_["1039ui_story"]) then
					arg_253_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1039ui_story"]) and arg_253_1.var_.characterEffect1039ui_story then
				arg_253_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 1

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(112251065).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 25 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 25)

				if (25 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 25)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play112251066 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 112251066
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play112251067(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1039ui_story = arg_257_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).z)
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles = arg_257_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).z)
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles = arg_257_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_260_1 = 0
			local var_260_2 = 1

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(112251066).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 13 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 13)

				if (13 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 13)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play112251067 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 112251067
		arg_261_1.duration_ = 10.7

		local var_261_0 = {
			ja = 8.133,
			ko = 10.2,
			zh = 8.2,
			en = 10.7
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play112251068(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1081ui_story = arg_261_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).z)
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles = arg_261_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_261_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).z)
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles = arg_261_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1081ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1081ui_story == nil then
				arg_261_1.var_.characterEffect1081ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1081ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1081ui_story then
				arg_261_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_264_4 = 0
			local var_264_5 = 1

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(112251067)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 38 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 38)

				if (38 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 38)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251067", "story_v_out_112251.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_112251", "112251067", "story_v_out_112251.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_112251", "112251067", "story_v_out_112251.awb")

						arg_261_1:RecordAudio("112251067", var_264_11)
						arg_261_1:RecordAudio("112251067", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_112251", "112251067", "story_v_out_112251.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_112251", "112251067", "story_v_out_112251.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play112251068 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 112251068
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play112251069(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1081ui_story"]) and arg_265_1.var_.characterEffect1081ui_story == nil then
				arg_265_1.var_.characterEffect1081ui_story = arg_265_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1081ui_story"]) then
				if arg_265_1.var_.characterEffect1081ui_story and not isNil(arg_265_1.actors_["1081ui_story"]) then
					arg_265_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1081ui_story"]) and arg_265_1.var_.characterEffect1081ui_story then
				arg_265_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 1

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(112251068).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 60 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 60)

				if (60 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 60)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play112251069 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 112251069
		arg_269_1.duration_ = 6.1

		local var_269_0 = {
			ja = 6.1,
			ko = 4.333,
			zh = 4.666,
			en = 4.333
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play112251070(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1081ui_story"]) and arg_269_1.var_.characterEffect1081ui_story == nil then
				arg_269_1.var_.characterEffect1081ui_story = arg_269_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1081ui_story"]) then
				if arg_269_1.var_.characterEffect1081ui_story and not isNil(arg_269_1.actors_["1081ui_story"]) then
					arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1081ui_story"]) and arg_269_1.var_.characterEffect1081ui_story then
				arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_272_2 = 0
			local var_272_3 = 1

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:GetWordFromCfg(112251069)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 14 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 14)

				if (14 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 14)) > 0 and var_272_3 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251069", "story_v_out_112251.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251069", "story_v_out_112251.awb") / 1000

					if var_272_8 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_2
					end

					if var_272_4.prefab_name ~= "" and arg_269_1.actors_[var_272_4.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_4.prefab_name].transform, "story_v_out_112251", "112251069", "story_v_out_112251.awb")

						arg_269_1:RecordAudio("112251069", var_272_9)
						arg_269_1:RecordAudio("112251069", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_112251", "112251069", "story_v_out_112251.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_112251", "112251069", "story_v_out_112251.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_10 and arg_269_1.time_ < var_272_2 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play112251070 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 112251070
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play112251071(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1081ui_story"]) and arg_273_1.var_.characterEffect1081ui_story == nil then
				arg_273_1.var_.characterEffect1081ui_story = arg_273_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1081ui_story"]) then
				if arg_273_1.var_.characterEffect1081ui_story and not isNil(arg_273_1.actors_["1081ui_story"]) then
					arg_273_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1081ui_story"]) and arg_273_1.var_.characterEffect1081ui_story then
				arg_273_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 1

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(112251070).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 35 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 35)

				if (35 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 35)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play112251071 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 112251071
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play112251072(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action447")
			end

			local var_280_0 = 0
			local var_280_1 = 1

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(112251071).content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 14 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_2) / 14)

				if (14 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_2) / 14)) > 0 and var_280_1 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_5 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_5 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_5

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_5 and arg_277_1.time_ < var_280_0 + var_280_5 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play112251072 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 112251072
		arg_281_1.duration_ = 9.17

		local var_281_0 = {
			ja = 9.166,
			ko = 7.1,
			zh = 7.933,
			en = 6.7
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
				arg_281_0:Play112251073(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1081ui_story"]) and arg_281_1.var_.characterEffect1081ui_story == nil then
				arg_281_1.var_.characterEffect1081ui_story = arg_281_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1081ui_story"]) then
				if arg_281_1.var_.characterEffect1081ui_story and not isNil(arg_281_1.actors_["1081ui_story"]) then
					arg_281_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1081ui_story"]) and arg_281_1.var_.characterEffect1081ui_story then
				arg_281_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action445")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_284_2 = 0
			local var_284_3 = 1

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_4 = arg_281_1:GetWordFromCfg(112251072)
				local var_284_5 = arg_281_1:FormatText(var_284_4.content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 33 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 33)

				if (33 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 33)) > 0 and var_284_3 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251072", "story_v_out_112251.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_112251", "112251072", "story_v_out_112251.awb") / 1000

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end

					if var_284_4.prefab_name ~= "" and arg_281_1.actors_[var_284_4.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_4.prefab_name].transform, "story_v_out_112251", "112251072", "story_v_out_112251.awb")

						arg_281_1:RecordAudio("112251072", var_284_9)
						arg_281_1:RecordAudio("112251072", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_112251", "112251072", "story_v_out_112251.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_112251", "112251072", "story_v_out_112251.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play112251073 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 112251073
		arg_285_1.duration_ = 14.6

		local var_285_0 = {
			ja = 14.6,
			ko = 9.933,
			zh = 13.166,
			en = 11.766
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play112251074(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1081ui_story"]) and arg_285_1.var_.characterEffect1081ui_story == nil then
				arg_285_1.var_.characterEffect1081ui_story = arg_285_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1081ui_story"]) then
				if arg_285_1.var_.characterEffect1081ui_story and not isNil(arg_285_1.actors_["1081ui_story"]) then
					arg_285_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1081ui_story"]) and arg_285_1.var_.characterEffect1081ui_story then
				arg_285_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 1

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(112251073)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_6 = 50 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_4) / 50)

				if (50 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_4) / 50)) > 0 and var_288_2 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251073", "story_v_out_112251.awb") ~= 0 then
					local var_288_7 = manager.audio:GetVoiceLength("story_v_out_112251", "112251073", "story_v_out_112251.awb") / 1000

					if var_288_7 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_1
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_112251", "112251073", "story_v_out_112251.awb")

						arg_285_1:RecordAudio("112251073", var_288_8)
						arg_285_1:RecordAudio("112251073", var_288_8)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_112251", "112251073", "story_v_out_112251.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_112251", "112251073", "story_v_out_112251.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_9 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_9 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_9

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_9 and arg_285_1.time_ < var_288_1 + var_288_9 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play112251074 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 112251074
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play112251075(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(112251074).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 21 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 21)

				if (21 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 21)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play112251075 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 112251075
		arg_293_1.duration_ = 8.5

		local var_293_0 = {
			ja = 8.5,
			ko = 5.5,
			zh = 5.5,
			en = 6.666
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play112251076(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_1 = arg_293_1:GetWordFromCfg(112251075)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 25 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 25)

				if (25 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 25)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251075", "story_v_out_112251.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251075", "story_v_out_112251.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_112251", "112251075", "story_v_out_112251.awb")

						arg_293_1:RecordAudio("112251075", var_296_6)
						arg_293_1:RecordAudio("112251075", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_112251", "112251075", "story_v_out_112251.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_112251", "112251075", "story_v_out_112251.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play112251076 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 112251076
		arg_297_1.duration_ = 11.3

		local var_297_0 = {
			ja = 10.133,
			ko = 8.533,
			zh = 9.8,
			en = 11.3
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play112251077(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1081ui_story = arg_297_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1081ui_story"].transform.position).z)
				arg_297_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1081ui_story"].transform.localEulerAngles = arg_297_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1081ui_story"].transform.position).z)
				arg_297_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1081ui_story"].transform.localEulerAngles = arg_297_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_300_1 = 0
			local var_300_2 = 1

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(112251076)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_6 = 50 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_4) / 50)

				if (50 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_4) / 50)) > 0 and var_300_2 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251076", "story_v_out_112251.awb") ~= 0 then
					local var_300_7 = manager.audio:GetVoiceLength("story_v_out_112251", "112251076", "story_v_out_112251.awb") / 1000

					if var_300_7 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_1
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_112251", "112251076", "story_v_out_112251.awb")

						arg_297_1:RecordAudio("112251076", var_300_8)
						arg_297_1:RecordAudio("112251076", var_300_8)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_112251", "112251076", "story_v_out_112251.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_112251", "112251076", "story_v_out_112251.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_9 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_9 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_9

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_9 and arg_297_1.time_ < var_300_1 + var_300_9 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play112251077 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 112251077
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play112251078(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 1

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(112251077).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 16 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 16)

				if (16 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 16)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play112251078 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 112251078
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play112251079(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
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

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(112251078).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 34 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 34)

				if (34 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 34)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play112251079 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 112251079
		arg_309_1.duration_ = 5.3

		local var_309_0 = {
			ja = 5.3,
			ko = 3.633,
			zh = 3.266,
			en = 4.666
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
				arg_309_0:Play112251080(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1148ui_story = arg_309_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1148ui_story"].transform.position).z)
				arg_309_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1148ui_story"].transform.localEulerAngles = arg_309_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_309_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1148ui_story"].transform.position).z)
				arg_309_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1148ui_story"].transform.localEulerAngles = arg_309_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1148ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1148ui_story == nil then
				arg_309_1.var_.characterEffect1148ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1148ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1148ui_story then
				arg_309_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_312_4 = 0
			local var_312_5 = 1

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(112251079)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 12 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 12)

				if (12 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 12)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251079", "story_v_out_112251.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_112251", "112251079", "story_v_out_112251.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_112251", "112251079", "story_v_out_112251.awb")

						arg_309_1:RecordAudio("112251079", var_312_11)
						arg_309_1:RecordAudio("112251079", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_112251", "112251079", "story_v_out_112251.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_112251", "112251079", "story_v_out_112251.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play112251080 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 112251080
		arg_313_1.duration_ = 3.67

		local var_313_0 = {
			ja = 3.666,
			ko = 3.6,
			zh = 2.933,
			en = 2.833
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
				arg_313_0:Play112251081(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1148ui_story = arg_313_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1148ui_story"].transform.position).z)
				arg_313_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1148ui_story"].transform.localEulerAngles = arg_313_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1148ui_story"].transform.position).z)
				arg_313_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1148ui_story"].transform.localEulerAngles = arg_313_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1084ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1084ui_story = var_316_1.localPosition
			end

			local var_316_2 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 then
				var_316_1.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_313_1.time_ - 0) / var_316_2)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 then
				var_316_1.localPosition = Vector3.New(0, -0.97, -6)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			local var_316_3 = arg_313_1.actors_["1084ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = var_316_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_4 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 and not isNil(var_316_3) then
				if arg_313_1.var_.characterEffect1084ui_story and not isNil(var_316_3) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_316_6 = 0
			local var_316_7 = 1

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_8 = arg_313_1:GetWordFromCfg(112251080)
				local var_316_9 = arg_313_1:FormatText(var_316_8.content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 10 <= 0 and var_316_7 or var_316_7 * (utf8.len(var_316_9) / 10)

				if (10 <= 0 and var_316_7 or var_316_7 * (utf8.len(var_316_9) / 10)) > 0 and var_316_7 < var_316_11 then
					arg_313_1.talkMaxDuration = var_316_11

					if var_316_11 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251080", "story_v_out_112251.awb") ~= 0 then
					local var_316_12 = manager.audio:GetVoiceLength("story_v_out_112251", "112251080", "story_v_out_112251.awb") / 1000

					if var_316_12 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_6
					end

					if var_316_8.prefab_name ~= "" and arg_313_1.actors_[var_316_8.prefab_name] ~= nil then
						local var_316_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_8.prefab_name].transform, "story_v_out_112251", "112251080", "story_v_out_112251.awb")

						arg_313_1:RecordAudio("112251080", var_316_13)
						arg_313_1:RecordAudio("112251080", var_316_13)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_112251", "112251080", "story_v_out_112251.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_112251", "112251080", "story_v_out_112251.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_14 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_14 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_14

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_14 and arg_313_1.time_ < var_316_6 + var_316_14 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play112251081 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 112251081
		arg_317_1.duration_ = 17.4

		local var_317_0 = {
			ja = 17.4,
			ko = 10.533,
			zh = 9.3,
			en = 12.4
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play112251082(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1084ui_story = arg_317_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1084ui_story"].transform.position).z)
				arg_317_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1084ui_story"].transform.localEulerAngles = arg_317_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1084ui_story"].transform.position).z)
				arg_317_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1084ui_story"].transform.localEulerAngles = arg_317_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1027ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1027ui_story = var_320_1.localPosition
			end

			local var_320_2 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 then
				var_320_1.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_317_1.time_ - 0) / var_320_2)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 then
				var_320_1.localPosition = Vector3.New(0, -0.81, -5.8)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			local var_320_3 = arg_317_1.actors_["1027ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_3) and arg_317_1.var_.characterEffect1027ui_story == nil then
				arg_317_1.var_.characterEffect1027ui_story = var_320_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_4 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 and not isNil(var_320_3) then
				if arg_317_1.var_.characterEffect1027ui_story and not isNil(var_320_3) then
					arg_317_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 and not isNil(var_320_3) and arg_317_1.var_.characterEffect1027ui_story then
				arg_317_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_320_6 = 0
			local var_320_7 = 1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_8 = arg_317_1:GetWordFromCfg(112251081)
				local var_320_9 = arg_317_1:FormatText(var_320_8.content)

				arg_317_1.text_.text = var_320_9

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 38 <= 0 and var_320_7 or var_320_7 * (utf8.len(var_320_9) / 38)

				if (38 <= 0 and var_320_7 or var_320_7 * (utf8.len(var_320_9) / 38)) > 0 and var_320_7 < var_320_11 then
					arg_317_1.talkMaxDuration = var_320_11

					if var_320_11 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_9
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251081", "story_v_out_112251.awb") ~= 0 then
					local var_320_12 = manager.audio:GetVoiceLength("story_v_out_112251", "112251081", "story_v_out_112251.awb") / 1000

					if var_320_12 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_6
					end

					if var_320_8.prefab_name ~= "" and arg_317_1.actors_[var_320_8.prefab_name] ~= nil then
						local var_320_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_8.prefab_name].transform, "story_v_out_112251", "112251081", "story_v_out_112251.awb")

						arg_317_1:RecordAudio("112251081", var_320_13)
						arg_317_1:RecordAudio("112251081", var_320_13)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_112251", "112251081", "story_v_out_112251.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_112251", "112251081", "story_v_out_112251.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play112251082 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 112251082
		arg_321_1.duration_ = 8.3

		local var_321_0 = {
			ja = 8.3,
			ko = 5.166,
			zh = 4.966,
			en = 6.966
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play112251083(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1027ui_story = arg_321_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1027ui_story"].transform.position).z)
				arg_321_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1027ui_story"].transform.localEulerAngles = arg_321_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1027ui_story"].transform.position).z)
				arg_321_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1027ui_story"].transform.localEulerAngles = arg_321_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1039ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1039ui_story = var_324_1.localPosition
			end

			local var_324_2 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 then
				var_324_1.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_321_1.time_ - 0) / var_324_2)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 then
				var_324_1.localPosition = Vector3.New(0, -1.01, -5.9)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			local var_324_3 = arg_321_1.actors_["1039ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1039ui_story == nil then
				arg_321_1.var_.characterEffect1039ui_story = var_324_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_4 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 and not isNil(var_324_3) then
				if arg_321_1.var_.characterEffect1039ui_story and not isNil(var_324_3) then
					arg_321_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1039ui_story then
				arg_321_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_324_6 = 0
			local var_324_7 = 1

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_8 = arg_321_1:GetWordFromCfg(112251082)
				local var_324_9 = arg_321_1:FormatText(var_324_8.content)

				arg_321_1.text_.text = var_324_9

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 19 <= 0 and var_324_7 or var_324_7 * (utf8.len(var_324_9) / 19)

				if (19 <= 0 and var_324_7 or var_324_7 * (utf8.len(var_324_9) / 19)) > 0 and var_324_7 < var_324_11 then
					arg_321_1.talkMaxDuration = var_324_11

					if var_324_11 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_9
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251082", "story_v_out_112251.awb") ~= 0 then
					local var_324_12 = manager.audio:GetVoiceLength("story_v_out_112251", "112251082", "story_v_out_112251.awb") / 1000

					if var_324_12 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_12 + var_324_6
					end

					if var_324_8.prefab_name ~= "" and arg_321_1.actors_[var_324_8.prefab_name] ~= nil then
						local var_324_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_8.prefab_name].transform, "story_v_out_112251", "112251082", "story_v_out_112251.awb")

						arg_321_1:RecordAudio("112251082", var_324_13)
						arg_321_1:RecordAudio("112251082", var_324_13)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_112251", "112251082", "story_v_out_112251.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_112251", "112251082", "story_v_out_112251.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play112251083 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 112251083
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play112251084(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1039ui_story = arg_325_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1039ui_story"].transform.position).z)
				arg_325_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1039ui_story"].transform.localEulerAngles = arg_325_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1039ui_story"].transform.position).z)
				arg_325_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1039ui_story"].transform.localEulerAngles = arg_325_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_328_1 = 0
			local var_328_2 = 1

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(112251083).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 42 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 42)

				if (42 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 42)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play112251084 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 112251084
		arg_329_1.duration_ = 7.33

		local var_329_0 = {
			ja = 7.333,
			ko = 3.9,
			zh = 5.866,
			en = 7.333
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play112251085(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1081ui_story = arg_329_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).z)
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles = arg_329_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_329_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).z)
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles = arg_329_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1081ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1081ui_story == nil then
				arg_329_1.var_.characterEffect1081ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1081ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1081ui_story then
				arg_329_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_332_4 = 0
			local var_332_5 = 1

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(112251084)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 21 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 21)

				if (21 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 21)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251084", "story_v_out_112251.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_out_112251", "112251084", "story_v_out_112251.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_out_112251", "112251084", "story_v_out_112251.awb")

						arg_329_1:RecordAudio("112251084", var_332_11)
						arg_329_1:RecordAudio("112251084", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_112251", "112251084", "story_v_out_112251.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_112251", "112251084", "story_v_out_112251.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play112251085 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 112251085
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play112251086(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1081ui_story = arg_333_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).z)
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles = arg_333_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_333_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).z)
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles = arg_333_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_336_1 = 0
			local var_336_2 = 1

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(112251085).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 57 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 57)

				if (57 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 57)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play112251086 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 112251086
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play112251087(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(112251086).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 23 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 23)

				if (23 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 23)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play112251087 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 112251087
		arg_341_1.duration_ = 6

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play112251088(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_0 = 0.5

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				local var_344_1 = Color.New(1, 1, 1)

				var_344_1.a = Mathf.Lerp(0, 1, (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.mask_.color = var_344_1
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				local var_344_2 = Color.New(1, 1, 1)

				var_344_2.a = 1
				arg_341_1.mask_.color = var_344_2
			end

			local var_344_3 = 0.5

			if 0.5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_4 = 0.5

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_4 then
				local var_344_5 = Color.New(1, 1, 1)

				var_344_5.a = Mathf.Lerp(1, 0, (arg_341_1.time_ - var_344_3) / var_344_4)
				arg_341_1.mask_.color = var_344_5
			end

			if arg_341_1.time_ >= var_344_3 + var_344_4 and arg_341_1.time_ < var_344_3 + var_344_4 + arg_344_0 then
				local var_344_6 = Color.New(1, 1, 1)

				arg_341_1.mask_.enabled = false
				var_344_6.a = 0
				arg_341_1.mask_.color = var_344_6
			end

			local var_344_7 = "SA0301"

			if arg_341_1.bgs_.SA0301 == nil then
				local var_344_8 = Object.Instantiate(arg_341_1.paintGo_)

				var_344_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_344_7)
				var_344_8.name = var_344_7
				var_344_8.transform.parent = arg_341_1.stage_.transform
				var_344_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.bgs_[var_344_7] = var_344_8
			end

			if 0.5 < arg_341_1.time_ and arg_341_1.time_ <= 0.5 + arg_344_0 then
				local var_344_9 = arg_341_1.bgs_.SA0301

				arg_341_1.bgs_.SA0301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_344_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_344_10 = var_344_9:GetComponent("SpriteRenderer")

				if var_344_10 and var_344_10.sprite then
					local var_344_11 = 2 * (var_344_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_344_9.transform.localScale = Vector3.New(var_344_11 / var_344_10.sprite.bounds.size.y < var_344_11 * manager.ui.mainCameraCom_.aspect / var_344_10.sprite.bounds.size.x and var_344_11 * manager.ui.mainCameraCom_.aspect / var_344_10.sprite.bounds.size.x or var_344_11 / var_344_10.sprite.bounds.size.y, var_344_11 / var_344_10.sprite.bounds.size.y < var_344_11 * manager.ui.mainCameraCom_.aspect / var_344_10.sprite.bounds.size.x and var_344_11 * manager.ui.mainCameraCom_.aspect / var_344_10.sprite.bounds.size.x or var_344_11 / var_344_10.sprite.bounds.size.y, 0)
				end

				for iter_344_0, iter_344_1 in pairs(arg_341_1.bgs_) do
					if iter_344_0 ~= "SA0301" then
						iter_344_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_341_1.frameCnt_ <= 1 then
				arg_341_1.dialog_:SetActive(false)
			end

			local var_344_12 = 1
			local var_344_13 = 1

			if 1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_12 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				arg_341_1.dialog_:SetActive(true)

				arg_341_1.dialogCg_.alpha = 0

				local var_344_14 = LeanTween.value(arg_341_1.dialog_, 0, 1, 0.3)

				var_344_14:setOnUpdate(LuaHelper.FloatAction(function(arg_345_0)
					arg_341_1.dialogCg_.alpha = arg_345_0
				end))
				var_344_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_341_1.dialog_)
					var_344_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_341_1.duration_ = arg_341_1.duration_ + 0.3

				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_15 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(112251087).content)

				arg_341_1.text_.text = var_344_15

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_17 = 36 <= 0 and var_344_13 or var_344_13 * (utf8.len(var_344_15) / 36)

				if (36 <= 0 and var_344_13 or var_344_13 * (utf8.len(var_344_15) / 36)) > 0 and var_344_13 < var_344_17 then
					arg_341_1.talkMaxDuration = var_344_17
					var_344_12 = var_344_12 + 0.3

					if var_344_17 + var_344_12 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_17 + var_344_12
					end
				end

				arg_341_1.text_.text = var_344_15
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_18 = var_344_12 + 0.3
			local var_344_19 = math.max(var_344_13, arg_341_1.talkMaxDuration)

			if var_344_12 + 0.3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_18 + var_344_19 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_18) / var_344_19

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_18 + var_344_19 and arg_341_1.time_ < var_344_18 + var_344_19 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play112251088 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 112251088
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play112251089(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 1

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(112251088).content)

				arg_347_1.text_.text = var_350_1

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_3 = 50 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 50)

				if (50 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 50)) > 0 and var_350_0 < var_350_3 then
					arg_347_1.talkMaxDuration = var_350_3

					if var_350_3 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_3 + 0
					end
				end

				arg_347_1.text_.text = var_350_1
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_4 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_4

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play112251089 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 112251089
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play112251090(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 1

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(112251089).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 29 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 29)

				if (29 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 29)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play112251090 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 112251090
		arg_355_1.duration_ = 2.8

		local var_355_0 = {
			ja = 2.8,
			ko = 2.133,
			zh = 2.4,
			en = 1.4
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play112251091(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:GetWordFromCfg(112251090)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 9 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 9)

				if (9 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 9)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251090", "story_v_out_112251.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251090", "story_v_out_112251.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_112251", "112251090", "story_v_out_112251.awb")

						arg_355_1:RecordAudio("112251090", var_358_6)
						arg_355_1:RecordAudio("112251090", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_112251", "112251090", "story_v_out_112251.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_112251", "112251090", "story_v_out_112251.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play112251091 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 112251091
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play112251092(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(112251091).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 26 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 26)

				if (26 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 26)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play112251092 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 112251092
		arg_363_1.duration_ = 7.33

		local var_363_0 = {
			ja = 6.6,
			ko = 6.066,
			zh = 7.333,
			en = 4.7
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play112251093(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(112251092)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 35 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 35)

				if (35 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 35)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251092", "story_v_out_112251.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251092", "story_v_out_112251.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_112251", "112251092", "story_v_out_112251.awb")

						arg_363_1:RecordAudio("112251092", var_366_6)
						arg_363_1:RecordAudio("112251092", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_112251", "112251092", "story_v_out_112251.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_112251", "112251092", "story_v_out_112251.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play112251093 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 112251093
		arg_367_1.duration_ = 11.13

		local var_367_0 = {
			ja = 11.133,
			ko = 7.833,
			zh = 7.4,
			en = 5.3
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play112251094(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_1 = arg_367_1:GetWordFromCfg(112251093)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 41 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 41)

				if (41 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 41)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251093", "story_v_out_112251.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251093", "story_v_out_112251.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_out_112251", "112251093", "story_v_out_112251.awb")

						arg_367_1:RecordAudio("112251093", var_370_6)
						arg_367_1:RecordAudio("112251093", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_112251", "112251093", "story_v_out_112251.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_112251", "112251093", "story_v_out_112251.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play112251094 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 112251094
		arg_371_1.duration_ = 8.03

		local var_371_0 = {
			ja = 8.033,
			ko = 5.066,
			zh = 5.633,
			en = 6.8
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play112251095(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:GetWordFromCfg(112251094)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 28 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 28)

				if (28 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 28)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251094", "story_v_out_112251.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_112251", "112251094", "story_v_out_112251.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_112251", "112251094", "story_v_out_112251.awb")

						arg_371_1:RecordAudio("112251094", var_374_6)
						arg_371_1:RecordAudio("112251094", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_112251", "112251094", "story_v_out_112251.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_112251", "112251094", "story_v_out_112251.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play112251095 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 112251095
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play112251096(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 1

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(112251095).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 74 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 74)

				if (74 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 74)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play112251096 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 112251096
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play112251097(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 1

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(112251096).content)

				arg_379_1.text_.text = var_382_1

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_3 = 20 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 20)

				if (20 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 20)) > 0 and var_382_0 < var_382_3 then
					arg_379_1.talkMaxDuration = var_382_3

					if var_382_3 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_3 + 0
					end
				end

				arg_379_1.text_.text = var_382_1
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_4 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_4

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play112251097 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 112251097
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play112251098(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(112251097).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 7 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 7)

				if (7 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 7)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play112251098 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 112251098
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play112251099(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(112251098).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 56 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 56)

				if (56 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 56)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play112251099 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 112251099
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
			arg_391_1.auto_ = false
		end

		function arg_391_1.playNext_(arg_393_0)
			arg_391_1.onStoryFinished_()
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 1

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(112251099).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 22 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 22)

				if (22 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 22)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play112251013 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 112251013
		arg_395_1.duration_ = 3.77

		local var_395_0 = {
			ja = 3.766,
			ko = 2.366,
			zh = 2.966,
			en = 2.966
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play112251014(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1148ui_story = arg_395_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1148ui_story"].transform.position).z)
				arg_395_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1148ui_story"].transform.localEulerAngles = arg_395_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_395_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1148ui_story"].transform.position).z)
				arg_395_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1148ui_story"].transform.localEulerAngles = arg_395_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_398_1 = "1148ui_story"

			if arg_395_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_398_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_395_1.stage_.transform)

				var_398_2.name = var_398_1
				var_398_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.actors_[var_398_1] = var_398_2

				local var_398_3 = var_398_2:GetComponentInChildren(typeof(CharacterEffect))

				var_398_3.enabled = true

				local var_398_4 = GameObjectTools.GetOrAddComponent(var_398_2, typeof(DynamicBoneHelper))

				if var_398_4 then
					var_398_4:EnableDynamicBone(false)
				end

				arg_395_1:ShowWeapon(var_398_3.transform, false)

				arg_395_1.var_[var_398_1 .. "Animator"] = var_398_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_395_1.var_[var_398_1 .. "Animator"].applyRootMotion = true
				arg_395_1.var_[var_398_1 .. "LipSync"] = var_398_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_398_5 = arg_395_1.actors_["1148ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_5) and arg_395_1.var_.characterEffect1148ui_story == nil then
				arg_395_1.var_.characterEffect1148ui_story = var_398_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_6 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_6 and not isNil(var_398_5) then
				if arg_395_1.var_.characterEffect1148ui_story and not isNil(var_398_5) then
					arg_395_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_6 and arg_395_1.time_ < 0 + var_398_6 + arg_398_0 and not isNil(var_398_5) and arg_395_1.var_.characterEffect1148ui_story then
				arg_395_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_398_8 = "1148ui_story"

			if arg_395_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_398_9 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_395_1.stage_.transform)

				var_398_9.name = var_398_8
				var_398_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.actors_[var_398_8] = var_398_9

				local var_398_10 = var_398_9:GetComponentInChildren(typeof(CharacterEffect))

				var_398_10.enabled = true

				local var_398_11 = GameObjectTools.GetOrAddComponent(var_398_9, typeof(DynamicBoneHelper))

				if var_398_11 then
					var_398_11:EnableDynamicBone(false)
				end

				arg_395_1:ShowWeapon(var_398_10.transform, false)

				arg_395_1.var_[var_398_8 .. "Animator"] = var_398_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_395_1.var_[var_398_8 .. "Animator"].applyRootMotion = true
				arg_395_1.var_[var_398_8 .. "LipSync"] = var_398_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_398_12 = 0
			local var_398_13 = 1

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_12 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_14 = arg_395_1:GetWordFromCfg(112251013)
				local var_398_15 = arg_395_1:FormatText(var_398_14.content)

				arg_395_1.text_.text = var_398_15

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_17 = 6 <= 0 and var_398_13 or var_398_13 * (utf8.len(var_398_15) / 6)

				if (6 <= 0 and var_398_13 or var_398_13 * (utf8.len(var_398_15) / 6)) > 0 and var_398_13 < var_398_17 then
					arg_395_1.talkMaxDuration = var_398_17

					if var_398_17 + var_398_12 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_17 + var_398_12
					end
				end

				arg_395_1.text_.text = var_398_15
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251013", "story_v_out_112251.awb") ~= 0 then
					local var_398_18 = manager.audio:GetVoiceLength("story_v_out_112251", "112251013", "story_v_out_112251.awb") / 1000

					if var_398_18 + var_398_12 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_18 + var_398_12
					end

					if var_398_14.prefab_name ~= "" and arg_395_1.actors_[var_398_14.prefab_name] ~= nil then
						local var_398_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_14.prefab_name].transform, "story_v_out_112251", "112251013", "story_v_out_112251.awb")

						arg_395_1:RecordAudio("112251013", var_398_19)
						arg_395_1:RecordAudio("112251013", var_398_19)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_112251", "112251013", "story_v_out_112251.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_112251", "112251013", "story_v_out_112251.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_20 = math.max(var_398_13, arg_395_1.talkMaxDuration)

			if var_398_12 <= arg_395_1.time_ and arg_395_1.time_ < var_398_12 + var_398_20 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_12) / var_398_20

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_12 + var_398_20 and arg_395_1.time_ < var_398_12 + var_398_20 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play112251014 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 112251014
		arg_399_1.duration_ = 4.2

		local var_399_0 = {
			ja = 2.6,
			ko = 4.2,
			zh = 3.9,
			en = 3.333
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play112251015(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1148ui_story = arg_399_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1148ui_story"].transform.position).z)
				arg_399_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1148ui_story"].transform.localEulerAngles = arg_399_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_399_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1148ui_story"].transform.position).z)
				arg_399_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1148ui_story"].transform.localEulerAngles = arg_399_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_402_1 = arg_399_1.actors_["1039ui_story"].transform

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1039ui_story = var_402_1.localPosition

				arg_399_1:ShowWeapon(arg_399_1.var_["1039ui_story" .. "Animator"].transform, false)
			end

			local var_402_2 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 then
				var_402_1.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_399_1.time_ - 0) / var_402_2)
				var_402_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_1.position).x, (manager.ui.mainCamera.transform.position - var_402_1.position).y, (manager.ui.mainCamera.transform.position - var_402_1.position).z)
				var_402_1.localEulerAngles.z = 0
				var_402_1.localEulerAngles.x = 0
				var_402_1.localEulerAngles = var_402_1.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 then
				var_402_1.localPosition = Vector3.New(0, -1.01, -5.9)
				var_402_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_1.position).x, (manager.ui.mainCamera.transform.position - var_402_1.position).y, (manager.ui.mainCamera.transform.position - var_402_1.position).z)
				var_402_1.localEulerAngles.z = 0
				var_402_1.localEulerAngles.x = 0
				var_402_1.localEulerAngles = var_402_1.localEulerAngles
			end

			local var_402_3 = arg_399_1.actors_["1039ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_3) and arg_399_1.var_.characterEffect1039ui_story == nil then
				arg_399_1.var_.characterEffect1039ui_story = var_402_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_4 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 and not isNil(var_402_3) then
				if arg_399_1.var_.characterEffect1039ui_story and not isNil(var_402_3) then
					arg_399_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 and not isNil(var_402_3) and arg_399_1.var_.characterEffect1039ui_story then
				arg_399_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_402_6 = 0
			local var_402_7 = 1

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_8 = arg_399_1:GetWordFromCfg(112251014)
				local var_402_9 = arg_399_1:FormatText(var_402_8.content)

				arg_399_1.text_.text = var_402_9

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_11 = 14 <= 0 and var_402_7 or var_402_7 * (utf8.len(var_402_9) / 14)

				if (14 <= 0 and var_402_7 or var_402_7 * (utf8.len(var_402_9) / 14)) > 0 and var_402_7 < var_402_11 then
					arg_399_1.talkMaxDuration = var_402_11

					if var_402_11 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_11 + var_402_6
					end
				end

				arg_399_1.text_.text = var_402_9
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112251", "112251014", "story_v_out_112251.awb") ~= 0 then
					local var_402_12 = manager.audio:GetVoiceLength("story_v_out_112251", "112251014", "story_v_out_112251.awb") / 1000

					if var_402_12 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_12 + var_402_6
					end

					if var_402_8.prefab_name ~= "" and arg_399_1.actors_[var_402_8.prefab_name] ~= nil then
						local var_402_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_8.prefab_name].transform, "story_v_out_112251", "112251014", "story_v_out_112251.awb")

						arg_399_1:RecordAudio("112251014", var_402_13)
						arg_399_1:RecordAudio("112251014", var_402_13)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_112251", "112251014", "story_v_out_112251.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_112251", "112251014", "story_v_out_112251.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_14 = math.max(var_402_7, arg_399_1.talkMaxDuration)

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_14 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_6) / var_402_14

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_6 + var_402_14 and arg_399_1.time_ < var_402_6 + var_402_14 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play112251015 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 112251015
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play112251016(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1039ui_story = arg_403_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1039ui_story"].transform.position).z)
				arg_403_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1039ui_story"].transform.localEulerAngles = arg_403_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1039ui_story"].transform.position).z)
				arg_403_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1039ui_story"].transform.localEulerAngles = arg_403_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_406_1 = 0
			local var_406_2 = 1

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(112251015).content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 11 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 11)

				if (11 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 11)) > 0 and var_406_2 < var_406_5 then
					arg_403_1.talkMaxDuration = var_406_5

					if var_406_5 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + var_406_1
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_6 = math.max(var_406_2, arg_403_1.talkMaxDuration)

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_6 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_1) / var_406_6

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_1 + var_406_6 and arg_403_1.time_ < var_406_1 + var_406_6 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02",
		"TextureConfig/Background/SA0301"
	},
	voices = {
		"story_v_out_112251.awb"
	}
}
